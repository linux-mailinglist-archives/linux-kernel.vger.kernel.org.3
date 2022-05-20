Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32BDF52E51C
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 08:36:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345903AbiETGfh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 02:35:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244487AbiETGfd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 02:35:33 -0400
Received: from esa19.fujitsucc.c3s2.iphmx.com (esa19.fujitsucc.c3s2.iphmx.com [216.71.158.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D7B314CA10
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 23:35:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1653028533; x=1684564533;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=+9niHwPIRae1VLQDsCWCPN/1XhEDLQzvhvMBqjqH7fY=;
  b=GP2Utlte6z3vapquzJ52TRLp+8aZnqAyaplrvhuA4HUd4VLACqw6fTql
   evExLmmnLI30982aoCphZIV0g8jP9/g9oToI381QVWHVvtBoTaO5fJuT2
   p6p3dGl0Rbs2IO6/n/9wC/oE4aTbmlICFN1G/ea5kdVr1fF/CiAIIWGGQ
   FYtjzj0qVGBMivbA0Qql3bhTe8Za4FCvdwTf+DlaxzhWKQcO4jC8YGk2t
   kf7YjMdZl3DBmCHNZ4BKPueLizOwWivPVkXFye4YSbiP3aO22ysyFdCyI
   K6n/IMdDFZOYJdfEcs9jp7c9BKYRTjkfW9f4bQ5s/R1Pdk2fmSqMtLpG3
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10352"; a="55932607"
X-IronPort-AV: E=Sophos;i="5.91,238,1647270000"; 
   d="scan'208";a="55932607"
Received: from mail-os0jpn01lp2108.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.108])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2022 15:35:25 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GFyUUQbtbnuxrey47IJImv0nSORN+n9KL6XXXaAuMSHyQTSj7ivBJogiS3H9Vo9jEZ+A15b4i4AeTW5KOyF4Acr1UQe6KuJlGsD27COw2xj7zZFC5fNQ7XOF0iN0qHOKwnosZlV6Ixa2G/WA0qVRlnWKKNcoFC2Kx8f6LjBY2/dEviEUlJHg7VJoVltQnxgITYeMNMbVpqQuY4nCifCJ1crBIlVDLbXPUVjFoeDZFpz8BS9JhrlsUtmi7e4nA78WG+Q6WVNepMLYcqiP00ANReFPGJZyFnYyxZklUpVFoXSZr5/B3DIBsdWmyCZnbZmkdftsBEiRlWxYzlJBcojZjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+9niHwPIRae1VLQDsCWCPN/1XhEDLQzvhvMBqjqH7fY=;
 b=FXylqlYvh1Uoh3r4Z/Nj71ijFDxLsuimAKvc3sifyS+T8qsoKwfSjmhvL/ubsYNldqqw0zJucFdSYIBlsav4YVTsKQu60jocFCINAW1VW89eofi0M9KZT9m/fl54K/416ViUP/IBrDOcxiqYy8OdF0MdgDkrE023wlEV3CH0czlrBnnDb18Yh+hrH6T2CIXjzgPPu8BT9FyGh3IwHJorgl2J/YkjYOCp2qpbTfq4MwustQU3CpKEkMLo1rElPZrtIwjCJBE/Kjkbabfg6+tmZVGXSAD/cIbnQP1g0yjS881Frn4OAYZK7orzpk5PAsTklWc3VAMGkd1WwN4c794sPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+9niHwPIRae1VLQDsCWCPN/1XhEDLQzvhvMBqjqH7fY=;
 b=ZSqVz/1t6ntMMmAsRPuSMBbSe9X2fx0dbQM7247rHzrCip2mmjxQmZoUmkKoFODPRP6Uq+xKiLb04h26FqCsXalbn9w6wigAaQeT2BtmuyJ82ea6Ngj6xtqBox62nfu5yCtH7Vu5clfhjkmGsih3/Ddjl5OBLuB/g/H28TIwU7k=
Received: from OSBPR01MB2037.jpnprd01.prod.outlook.com (2603:1096:603:25::17)
 by OSAPR01MB1572.jpnprd01.prod.outlook.com (2603:1096:603:32::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.14; Fri, 20 May
 2022 06:35:21 +0000
Received: from OSBPR01MB2037.jpnprd01.prod.outlook.com
 ([fe80::a041:7644:4eca:ec8]) by OSBPR01MB2037.jpnprd01.prod.outlook.com
 ([fe80::a041:7644:4eca:ec8%7]) with mapi id 15.20.5273.015; Fri, 20 May 2022
 06:35:21 +0000
From:   "tarumizu.kohei@fujitsu.com" <tarumizu.kohei@fujitsu.com>
To:     'Greg KH' <gregkh@linuxfoundation.org>
CC:     "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "mchehab+huawei@kernel.org" <mchehab+huawei@kernel.org>,
        "eugenis@google.com" <eugenis@google.com>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "pcc@google.com" <pcc@google.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "marcos@orca.pet" <marcos@orca.pet>,
        "conor.dooley@microchip.com" <conor.dooley@microchip.com>,
        "nicolas.ferre@microchip.com" <nicolas.ferre@microchip.com>,
        "marcan@marcan.st" <marcan@marcan.st>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH v4 7/8] x86: Add Kconfig/Makefile to build hardware
 prefetch control driver
Thread-Topic: [PATCH v4 7/8] x86: Add Kconfig/Makefile to build hardware
 prefetch control driver
Thread-Index: AQHYaoDsEbDM2XkZO0CnazvYZZezea0kMD8AgAMg6qA=
Date:   Fri, 20 May 2022 06:35:21 +0000
Message-ID: <OSBPR01MB20373DA0C4D33C63933273DE80D39@OSBPR01MB2037.jpnprd01.prod.outlook.com>
References: <20220518063032.2377351-1-tarumizu.kohei@fujitsu.com>
 <20220518063032.2377351-8-tarumizu.kohei@fujitsu.com>
 <YoSVpAlKA2wF41o3@kroah.com>
In-Reply-To: <YoSVpAlKA2wF41o3@kroah.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 86669a69-7fea-49a6-25cb-08da3a2ae9cb
x-ms-traffictypediagnostic: OSAPR01MB1572:EE_
x-microsoft-antispam-prvs: <OSAPR01MB15729563414DAF9970F894FA80D39@OSAPR01MB1572.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: J4vtvEZLs1c1jAkLdkkjyI5WuZkHmMSfjLfCsdpHcxLIUApHb4gV+uFkoqT+xnbrmSkK3cHvv8hrz2ozVx3UI/mUXl/+FXYuMcaqHiUBA4o2HLJw7uODbQFaaQN8KgynA40NgcbnSnf+IoUbm0qIqic/ZR74ay5ud4E1pUvuVmZP2LcOCJcB3h5/PfxLNcfJ4+t1vxeFzcDnZfq1El1BXMTnOVZ76Rk2t87mXw7DrsAuuOuKZ49x2WcsE0NoqmEEesH3N2Gox3XbIRm7Et+Q42hR3bdekcruSj8I05HszP3XrAdM9xit8e1pTN3OMOauIyn+kR5KsRqopdpKwsL+tCvdnnd4SHRIK6rmnbfWKgZ501zH6a1vXE7y9/MMh8uJB3a3EGxlm5AbEltwLqNNR/J4IPmM9lzxh1rBXccCAnN5ImbKukJtERDe2jzSOdrDPH3VvGmD+05WnbPzt19lXV8j8B2sumUwyFLw08aJvrTVpJ8gnPyqcOpLAu+G00DyxV2581G3CeC3Chd9Q99H34biKTeRqEXcWOSX6nuD0Geaea0TJ0w8lniBqYuEFD5uvpPCM1OFp9eWhKcadcGzvJy2DOMHpk7et5mrAkEmXkZ63SIoeEJ5RPbzp1Dh8tn3yBTSuDNb5mCTgmXSc+L2YJ2gfWpvSOlbpdMlV4iOpwrBKKvCEL6a3hbml35vPNR4YF5uLbtCKThNMlerIAooZg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSBPR01MB2037.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66476007)(66556008)(7696005)(8936002)(9686003)(66446008)(85182001)(64756008)(4326008)(76116006)(122000001)(5660300002)(66946007)(186003)(8676002)(558084003)(508600001)(6506007)(26005)(52536014)(38100700002)(38070700005)(71200400001)(6916009)(316002)(54906003)(55016003)(82960400001)(7416002)(33656002)(86362001)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?YmIzLzEydU00K3A1UFkyL2dLS3lPRjlYcjBVN1pGSWxjZ0wxcnJwTW5w?=
 =?iso-2022-jp?B?a01hMzVkMzBzazF4dGNEWkRua2hmaTJ2V1dlSm9XeGF0eTdYK0JMc3Bu?=
 =?iso-2022-jp?B?dGxoajlnNGVRY01sY013dWp5cjR5UzM4YUZoRW5VT2NzWG1aQnFjUVFh?=
 =?iso-2022-jp?B?Lzc4czZtZlRycTBCa1lXRkVyaW85U0ZJS0hndmwvQjUrR0pCc1J1Zm9q?=
 =?iso-2022-jp?B?SU5lWFYxb2ZPMWZMYTByVzhqY0k0UTM4S0wvMWQ4aVRNdGlkUVB2dUc4?=
 =?iso-2022-jp?B?TTNkNkY2SXZ5RDVHdjZKd0Q5MTVpRWZJVU5KQ1VRdGtqM1hNNTRVL0Zo?=
 =?iso-2022-jp?B?eDAxQXJaSERCRksrblgyUlo0Y0lMN1BFMnoxYVh5NlVUam1tSUN0UHZ3?=
 =?iso-2022-jp?B?YVZMbWJpdldQdmZUYTdkZEIydFpGa3NpMzBIZnpkaG1kTWV0dThxVjF6?=
 =?iso-2022-jp?B?eEV6Q051THRiUlY4M08vbDdRVVozRXpEd1hxc015SUViYnlyZWFtbEdT?=
 =?iso-2022-jp?B?VU5Lb0w4b1pkSDdYNXRlR0pHWGxaZ0JwQzNOZm12SWVBY3JCU2ZoM3h2?=
 =?iso-2022-jp?B?UFBaWHZDZHlpSWcvK1h2a3ZqbEIxNjRCWjlMRmZQNjN2UEtLTUlDeElv?=
 =?iso-2022-jp?B?b1RJMlVuc1h2dFRCc0VyejQ5UFUyeC9jYnVmQ2dPVkdOZ2RhaWZQRGJJ?=
 =?iso-2022-jp?B?cjR0UUV6U080VkprYVlVem1jTkpVblZ5WEZ4RWVXdWlHUW1WVGxOY056?=
 =?iso-2022-jp?B?cEZCZW5uOVV1c2tVYVkzampJd0drL2g0VWk4bFdONDlJV2laRk03ZVBO?=
 =?iso-2022-jp?B?Q0o1Y2M1cnhCRzVYY25RelJERlowUXdmb215M2IwSS92dlFZTXlmbnV3?=
 =?iso-2022-jp?B?SmNlTk11bGxRZlNIT1ZIc2k3akM4L25TMXFtNmI4R0dIeEVjMDRtL21m?=
 =?iso-2022-jp?B?K2JaSDNOcE9zMmw2Um9LN25qZWI3b05nd2pEdERPaWoxQnlvU09VK29N?=
 =?iso-2022-jp?B?TmNHTmF0V3hma3gyajMvKzYwTi96QmFmRlB5OFZpYjBCb0h2R0kxc3dy?=
 =?iso-2022-jp?B?OFI5emVYWEJyT2ZLUmFzYnQyS2wvKzZqS2JHYkVyMkZiU0o0aWoyWXFG?=
 =?iso-2022-jp?B?Z1YzT1pqdU5MSUI3cTVkbXFBTmNzLzZjTTllMzRMQWFQRFVGa0RxOFJ0?=
 =?iso-2022-jp?B?aFYxQXFaV1R0MWtoL0VLUzYxMUpaTkJuL1VtckJtVCtNMmEvdlBCbHZz?=
 =?iso-2022-jp?B?ODhMNDVUL0ZLbUFYTUM2STlGcEJmSVh0RDFwMkNSdTc3NGxyVkhQeFd3?=
 =?iso-2022-jp?B?Z05kVk8xTVhJTDBNTXptaGZFY3pTRnNBbG5BWmpCc2dIYWZ0Zk9DM3c2?=
 =?iso-2022-jp?B?ZlVVV3l3YUJGNkZvN1RVOE43ak55bkRYbWN0RlU3SmdkS2dUaHVDWUZE?=
 =?iso-2022-jp?B?VXRqd05lRGQwOUtTQTF1YWlxbDNKZUJoMzY3V3d2VHRMZWZYNGZIa2FY?=
 =?iso-2022-jp?B?VFQxWldlYWcxSDQxbDVoTzQvREJYY2tyTGk4ZUx0SkVPeXphamNEUFpt?=
 =?iso-2022-jp?B?Z1RFR1NnamlVQVBTM09wM200WTc0QkwvWXNMWFNpM29qZmo4eGo4UXEz?=
 =?iso-2022-jp?B?a3htMGdCZVllUU1COXBjcFZOZ3BKb1NmM1B3MGp5RmZ1bXNlM2hWNEM4?=
 =?iso-2022-jp?B?enovWHRVelFHZnlhMzdBc0wvQnZVaDFlQ2hxSld5M25yMTY5em1mcXdZ?=
 =?iso-2022-jp?B?REt6U3lWN01vZ2Y3cVFvbkFSUWVkOUl2M1Z1d041S3A4RXhPbG03SkY1?=
 =?iso-2022-jp?B?ZXVaQzArVlBDV3BUaGl5U3NZRDVqMlZKVHFDOE1RYmwyTmtvZXpmenow?=
 =?iso-2022-jp?B?cEJZYnJsR3N1UjlXbjgxdS9IMDZpTlJyOG9YV1k0MGtzL0MweEYrR1pP?=
 =?iso-2022-jp?B?ME1zU0xLbFI1TTNMQWJLRG9ucUpML3hIRTVuT2IwMXBycHFBNlJRejg2?=
 =?iso-2022-jp?B?OTJ3WWFnZDE3T2JXSjNaaEdTM0tPR0FHMFdNUjZhRUIzU0I4T2lhMDha?=
 =?iso-2022-jp?B?Z2hkYmw2Z0pSZUs5MEd6anI1Rmorc1dxSk94c2xhNVdIeTFnM0F0ZnQw?=
 =?iso-2022-jp?B?OTNCVGNmbXFaTXh0SStTQldXVkZ3ZVQwUi95Z1BvdWFHYk5MNDVQSTgr?=
 =?iso-2022-jp?B?NWF5RDB6Q2g2b3BKNm9IRlhkVXBJbEpIZ3ZHeG9WTndhTTg5WHVDQkZ0?=
 =?iso-2022-jp?B?RE43MnFZMGtYYlhGNVlXTkNGdGd3U3V3SVFYNzRZL1gxWENYbE45N01u?=
 =?iso-2022-jp?B?RUV4VTFtNkRHWGQ1V29zdDVKZ3djem5MVlVOd0hsOGhabGFDVk9WK2pB?=
 =?iso-2022-jp?B?YUtYeFJYeTlMdUhQblNSUDh5MHFSVkszQm15S21zbjF4MXFOOGMvRWlk?=
 =?iso-2022-jp?B?aFFINXdEWCttSTNWNWtQY0p4cFM3QUlPb0w4aEpyVnNHQzRhZHpWOWlw?=
 =?iso-2022-jp?B?cHBNZ1kwakcrZkxUQXI4L1pqaU5BUjNkNWZCOEYyRTlLdWpKQk9PNytX?=
 =?iso-2022-jp?B?OWdUMFd0Zz0=?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB2037.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86669a69-7fea-49a6-25cb-08da3a2ae9cb
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 May 2022 06:35:21.1163
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9BSYB6bbP2JiEc/rsdwRODcS3pqlD20YOQEhnjA34DnT8PpTe2AWgzj73Iww1GaiLrvTY8oHH1Tyk/vdLX3suUtEE56lK/ly5HGVwYE/ENs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB1572
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> You need a lot more text here about what this is, what it does, why you w=
ould want
> it, and the module name it will create.

I add more text in the next version.
