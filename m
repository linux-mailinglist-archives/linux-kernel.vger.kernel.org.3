Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99C2D50B75C
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 14:31:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1447556AbiDVMei (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 08:34:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1447543AbiDVMeg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 08:34:36 -0400
X-Greylist: delayed 63 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 22 Apr 2022 05:31:43 PDT
Received: from esa4.fujitsucc.c3s2.iphmx.com (esa4.fujitsucc.c3s2.iphmx.com [68.232.151.214])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 883FA517EA
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 05:31:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1650630704; x=1682166704;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=0R/RnTiXEPlu15Zcrq0fL+oBkbHt/08mhMj1KSaPRTg=;
  b=F9/piRnesV4+1lYWqpmHj8N9hRAw1tLOmgXu0IKOlj00kE3mWCC9eOQz
   Gig3406kpdFEmKDiqqeXguYTrezfO7NRiJD7t7p80WuQFj4sq9zy+2UgT
   IPDJ8yHeUd/AEdwoyDs1SyAXLug0tPwzPB9V0dTYEIK3zGWwdX226cO9G
   5m/ftlh/ySgN8NqZbj6wysLHQuPQWZvhMk66/JBFK5bPIvrJOtU5/oMrL
   Cy6xpK/n6FfUpB0uJ+2xgJRkiW7jkAfqYgSMz3gXr3Pb0oCgK/wg+eVap
   WBSjTZr9miPPJj2SNDZZaU/DN1QGPDNde2elt4abVqWUCjAi3BC+cmsxK
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10324"; a="62347800"
X-IronPort-AV: E=Sophos;i="5.90,281,1643641200"; 
   d="scan'208";a="62347800"
Received: from mail-os0jpn01lp2105.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.105])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2022 21:30:35 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PHpxEFNCcKwZfkssR1hflQASGnZTI56tv+jjQD1P0xUjyYqg/aAIOKGZf3IQHHeYFpwrdJ5An1qPDbkanhKeMWVR6T+Bt0C2sJmwmXOrrp73B2hIHHaoV559Eobza26nUL9d36bo1zrfFwWEt8vj90/2e56ye3e1qxDMSwFJufwuag6/jVxXKpiufCJ/Bp0AmuKMkktQh4H9hmIM3ERH5p42yPebRNjkBuSQAn8rZQs3ur93Ih3fzHre9iRNlrclSb418PkOrqpK+kZY4YGfVedOZ86ohsHfx3A2Q0Y8JnTlLXdwZJNGLDDqn/0MO0QWtcrlk//le/t8oRtnjqRPuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FaLFoZAY5LCmAsBAxQcOlIUpokEbkLNrMk+O9WE8ItY=;
 b=oO9mqre5K6kkAztMVkVAfgsTlDoIZjZaYuH2BTumjpRho8RiIDlkWM3rs+RV8JmQE8tuEAlfGSAEKDVNB4luLjfc39jiYpz4TvNv2m9h9t5Lvi0MC7yM00bvvg+z3DFh9KwmUYtt9LwAxCHsWUDy1UpXZDHrpgZV47LjqVkWJhuXET83xHYCejUwiuBv5OkFkTJCi3XoHB5apem2l8MFD1hzsla6ieFaBHTTzFVCRt4m0KW59wfip/r0l4Vl0bCrLe1Ym4vG2fafECsQAS7wPQS+GaSVGnTt6SzjWsuVuIWe/g7fSOheVGcFT2gJbSunBGHmkBrLKuod5Rl/Td9GPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FaLFoZAY5LCmAsBAxQcOlIUpokEbkLNrMk+O9WE8ItY=;
 b=jeLm7/wmJEvflmKJHx5XzOlLZRQ1rAbYGN7KEdkZDpI1nlfFGgSgAculFrlYfyTBIEIz9g66VVsp8GswEOhRXNR6MdNvJ0UruNP3qgz+HknIsLwggzVoV49tgb9/MAKR8vC1PXfpbmmsjdJlnaz+lMQeFRFO0cIk7lmWmA4IuUM=
Received: from OSBPR01MB2037.jpnprd01.prod.outlook.com (2603:1096:603:25::17)
 by OS3PR01MB7064.jpnprd01.prod.outlook.com (2603:1096:604:129::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.13; Fri, 22 Apr
 2022 12:30:31 +0000
Received: from OSBPR01MB2037.jpnprd01.prod.outlook.com
 ([fe80::382e:99b:f0f9:b18c]) by OSBPR01MB2037.jpnprd01.prod.outlook.com
 ([fe80::382e:99b:f0f9:b18c%6]) with mapi id 15.20.5186.015; Fri, 22 Apr 2022
 12:30:31 +0000
From:   "tarumizu.kohei@fujitsu.com" <tarumizu.kohei@fujitsu.com>
To:     'Greg KH' <gregkh@linuxfoundation.org>
CC:     "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "fenghua.yu@intel.com" <fenghua.yu@intel.com>,
        "reinette.chatre@intel.com" <reinette.chatre@intel.com>
Subject: RE: [PATCH v3 1/9] drivers: base: Add hardware prefetch control core
 driver
Thread-Topic: [PATCH v3 1/9] drivers: base: Add hardware prefetch control core
 driver
Thread-Index: AQHYVGMLEHjgMDmteU6Jl0/t5EKiYKz55peAgAH2WaA=
Date:   Fri, 22 Apr 2022 12:30:30 +0000
Message-ID: <OSBPR01MB20374588A6B57209D707CA2F80F79@OSBPR01MB2037.jpnprd01.prod.outlook.com>
References: <20220420030223.689259-1-tarumizu.kohei@fujitsu.com>
 <20220420030223.689259-2-tarumizu.kohei@fujitsu.com>
 <YmD3UX6aTvUXlYF5@kroah.com>
In-Reply-To: <YmD3UX6aTvUXlYF5@kroah.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3553f975-342e-4c60-03ac-08da245be3d1
x-ms-traffictypediagnostic: OS3PR01MB7064:EE_
x-microsoft-antispam-prvs: <OS3PR01MB70645FEDD7BB7D0063A2C9F680F79@OS3PR01MB7064.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sJOiVQRegcQiUAn1v0+AtylOlh63azx1GiKdFuLhJhi7HnL1XEbIdPdd6R5j7fj6VjnTk/bSp5oAtR1shtQrm+hSm6omVCLKb9fzejiXU7VjQtxTn9E3DxIQcTFrTgd09d2sjC+v35d38NDf9ZpS7LvxtmclPF9vDNrTN+Xxkqcv5lpAkzjqhy9/lJDy8n7LRcquuBKOER4EZsTyifomNH5n6jPAzRgz4pEcSzcj/mQik8miPgZJDuLYvbXOYjnFqKfdr2tbt5uSndNHJzrGJE5zUkEA1u6R0wygqjDk6F/9dcqx73wY1RiLU7wwsknRJdVo2vAbqwRJmhDJePYDVirG0QTXNhq5LWV/VLIZBxOnGUWVE1CC5O+G4sL5EMY/L0XHgBdsSYZ2+7ffNjMRa1j09lqiQ5xmQEjL6lGT03nYNUVLh4buxhpwEM88hD04krjrB+JrOL/ESkEeDozrt2AKM9Mto9j6GWNJodiZRILlkbhvKb9BXVjelO4SchuB9/q/19oOWHZT/0wSlZ0h1r5ArH/4bIyaTlEdiJhcAkhuVvW1QqXhb/qr3EXfOo9J5SJYIdKhcqev5qJLI7LehUDcuUEaN+L9MeJ9dYAalF+Ol196frKEbAbLbJv9fM6hnVL1D+BNhUE3SHSsI9BTzTRVf30t0bEq4FowXh3V8r6k9hF3LbqF++qs2Cf4On1p3XIYdH0zvDp5afZS/QAtUw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSBPR01MB2037.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(8936002)(8676002)(66476007)(85182001)(6916009)(66556008)(66446008)(508600001)(82960400001)(7416002)(316002)(86362001)(122000001)(54906003)(52536014)(9686003)(64756008)(33656002)(76116006)(71200400001)(66946007)(4326008)(2906002)(186003)(38100700002)(5660300002)(38070700005)(6506007)(55016003)(4744005)(7696005)(26005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?cHNvdnhHbTA5NUN2V1ltaE9sQjd0ck8yYXl0R1JaVWI0L2RscXBscnBa?=
 =?iso-2022-jp?B?Mzh0T1Y0bnNnN3UrcUVxSGRzY25Rc3prWmplanZxUy9zUDhMRkhoUnRU?=
 =?iso-2022-jp?B?c2s1c0F3VGtUeDdhNkw2QksxTG8yTTRia3pUL2ZjbjRGOGV5T2FvVnhO?=
 =?iso-2022-jp?B?Y2REbVRRRmhQV2wzUGVMMkR4WnYwMTVTdjc3VmNtSk1MNnExckVTUG52?=
 =?iso-2022-jp?B?L0hxdzhKaFBIdmRtcjZVeVRRWHJ1dTBlSHB6cUZDTUk2NUppaVZVa3RS?=
 =?iso-2022-jp?B?c1ArMU1CTTJNQk5DRW42M0dmdC84NUdlQ2doSlR5QzZhMERmZ2o5RlVN?=
 =?iso-2022-jp?B?NTJVOWJQZVg4Y1dzZXZtYVM2YzJMdkdGMVNvaWp1R3RZVkZRcUhXQnls?=
 =?iso-2022-jp?B?bUJpS0NDTDVUZnlUVnlGY0h0RFRzSTB6NkpuOVozTkY5TGE1dERHNC93?=
 =?iso-2022-jp?B?WHhSUHlua09RaVJWbktDNnc3UkRzWW8xUFRISTdFbkg1Q1ZrTWJCcXZp?=
 =?iso-2022-jp?B?UFlINWZlTTB4QmMvR3NMajdoY01UTm1kS2drRC9pSFNvUHVyazhlOUZ2?=
 =?iso-2022-jp?B?QkVzeEJub3BDOFVDOWRxaWR1QlBiNmU3dmRiTThqMmFTY0VCUld5NGdj?=
 =?iso-2022-jp?B?WFR1TEJrL0hRbmtNQlA2RndiR21jZkh2eHVTTERhQW1NbTBHUDNadFRq?=
 =?iso-2022-jp?B?bkJwTm1PT0RSMWg0Zi80eDdvVnV0Rkt1ZGZ5V3pGTTc0WGE4ZHBYQUlN?=
 =?iso-2022-jp?B?T2NCRnZ6MThCRjJydUJKaW9GcE5ERzRIWjE3NUpWYzQzRzdmeWFFNkdV?=
 =?iso-2022-jp?B?QzAzNy8yWG1iZTYvWjh6OEFXOVB5ZlZaVkdvVU9LZmxxc1VXTmYzUXJQ?=
 =?iso-2022-jp?B?M0h3SHZWanJVYWdhVkNaaGNpWEpzVjBnM1BCdURvR2dIUnBtNzFVb3Vw?=
 =?iso-2022-jp?B?THRNN2NtOFdrNEk5dHBHRmVidElQUG5nMDBUcU00YjZSY2ptRndXTWpx?=
 =?iso-2022-jp?B?dzlMOTFnSzBMSmVoNUdEQjhxNXdURWNSRlROSTBOWlRPSWFNMFB3YzRD?=
 =?iso-2022-jp?B?eU85bGVIeVdmdnZrelJlTSs5R0k3dHNjM1RPSXdHZDA2Tytxemx6UEo2?=
 =?iso-2022-jp?B?d1QxOGszRHNEdUdxbWVZQ1RCVlczZ083MEFoZGhZTDNkUnJ2L2JEUmZr?=
 =?iso-2022-jp?B?U1pkcXBBRjdURVpDY1JVKzJBRWhsRWkvRlgrajBUZHgwSjRrekZvTHR3?=
 =?iso-2022-jp?B?VlJIZlduSEFIL3czWDZoVEV0RW0xNTNDOTBVQ0hNUUkzZklzOGxNbEhs?=
 =?iso-2022-jp?B?QlMrVGdIaWZlc01VSU1OUkdWeE1vbnRMRW9OQVBqMk5WU2FWWkVJQk41?=
 =?iso-2022-jp?B?MGRzWFRTUXFSYVpSRVBwZ1dCNVMxY0ZpRXFKUUM0aTV0YXFCQ0ErT3BC?=
 =?iso-2022-jp?B?cks3VlE1K00xQ3U4VXV5RDFMVHJ4RkdlY0hyajNRVDVNQU5zT1RUMXd3?=
 =?iso-2022-jp?B?Zm9UU0s0Qmt0aXZWWUl1RkdNQ2grTlFZcnhNL0M2SkFmUDRjYXFMZmV3?=
 =?iso-2022-jp?B?enJYcTdXakRYOGJHd3ZlQ0R4aE5jN1VMUkFwd1NWQ2ZZQ2FpYUFiQTN2?=
 =?iso-2022-jp?B?bkI1WDgxdGEyQnk4R1Y4NGtNb052TDlSbzdLRHRNc0JEc1o1Z2JhOU14?=
 =?iso-2022-jp?B?UGQvN3d0UktCVTNRZG5rcTZ1VkRQR0RlalY3QTZpMktURndreVdwYUNL?=
 =?iso-2022-jp?B?bEtDb3JsdzY0SWk3OHZ1QTUrUTkvNVRXZUdtcmh3cXhhcDFTOXdiRUkr?=
 =?iso-2022-jp?B?bjFjd2tiVGFDaE82eVpBNlUzSXdoSGU0SjhXbndJaEF5TW95YUZNWnJD?=
 =?iso-2022-jp?B?M1paQmI4b2dXNzhCRnhSd01PMmYyMnIzYkU4MlB4enc2cmFvVDNQTVMz?=
 =?iso-2022-jp?B?V01mS05YVnd4Ty9YbVcvYUNrd1huUTZkb3ViZTZPYTVCd1Z6VEtHM3JC?=
 =?iso-2022-jp?B?QWFGOGdpcXFtTlFpTW5wRVVhbWhERTZnVFZOVE9QZGxvSjh5ck9tVE43?=
 =?iso-2022-jp?B?Z29lWU5rM1FBejFCT1pjcWZBUWdkZmNPT25PQU1JTDZPRGRMMXFyRjd4?=
 =?iso-2022-jp?B?dExQWHlTeGYzOHVsZmtxNjhJeGVaSmNING55bkQyNXhhRFZzTlU0RzVV?=
 =?iso-2022-jp?B?TUVBUmdMUVBVNlN3R1dvUHFaR1BZelpCMFdVc2N2T1RSdzM4Y2RxVkx3?=
 =?iso-2022-jp?B?T3gvcnMwS2VXQUtGWkhFZldVZUVqYTBUNXFRUmduclVTdXpCbUg5ZGlM?=
 =?iso-2022-jp?B?QkExbXVtaFp1dlZBbEJCa2JnajVMNHNHVHhLMStVTEc1VFhtMmNSK0lL?=
 =?iso-2022-jp?B?aDNvRFg3MEpJbUNFNGI4M0Q4eDF4Q0VCQnNrY0xEVHhQaTV1NWwyZFRh?=
 =?iso-2022-jp?B?b0QzT2dlR1dKajRkc0U2Z1JIWi9rMHRGcG5zN2tYb1NydjlaYVI4WHdw?=
 =?iso-2022-jp?B?bThlbnNXTWdxWDkwV3U2djFSaSs4RnAzNWNHSkpCcDByTUlCQzNQcjcx?=
 =?iso-2022-jp?B?bmdldXVCMD0=?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB2037.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3553f975-342e-4c60-03ac-08da245be3d1
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Apr 2022 12:30:30.8627
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Yhbc26IjJPToRNW81Pnv1ps+K9dOZAGqPysObEnAfRiSaONT+CTtbzN3Y6LvXk36K2IiR/o/PujmHhp1dfXMyxQOWooICaNlUdADfcp1kOY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB7064
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the comment.

> Thanks to Thomas for pointing this change out to me.
>=20
> Why did you not use get_maintainer.pl on your patch?  You are adding file=
s here
> that you want _me_ to maintain for the next 25+ years, yet not asking for=
 my
> review?  That's not nice, and for that reason alone I would not accept th=
is change.

I apologize for my mistake. I did not specify some patch files when I
executed get_maintainer.pl. I would like to use it correctly when I
send the next version patch.

> Also, this is very hardware-specific, which is not a good thing for code =
in
> drivers/base/  See the mess we have in the topology driver core code for
> examples of that mess :(

I would like to try to remove hardware-specific code from core code,
or move to other place.
