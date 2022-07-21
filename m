Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A081057C69E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 10:41:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232558AbiGUIlF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 04:41:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232375AbiGUIks (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 04:40:48 -0400
X-Greylist: delayed 64 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 21 Jul 2022 01:40:46 PDT
Received: from esa12.fujitsucc.c3s2.iphmx.com (esa12.fujitsucc.c3s2.iphmx.com [216.71.156.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BA5925EA;
        Thu, 21 Jul 2022 01:40:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1658392846; x=1689928846;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Hb6Gj02c4bhgHpncY0Zff1tIm5CXOKd8/GYsDgfbPxI=;
  b=T77DcD2mUNUgEmsDHHwwhq/FzP9pBBNpIsCT2DeBnF4eUWvsHREIPk3h
   3yLKinr85puRBolVMR6mn7gD2MS4VWQbrC8ALydtU5ZTCz0XC6s3G4T5G
   GntkW7cF33oJfYoewfImTqffqDprEBq3mrBoV3xpS1IWH0QZfNjGLpvjd
   5x6JxAWjHlx9SL/QtK8AV7GQ2gkR/TepD/DF3UWRHCYHNvZy/2xPxdY4A
   GGqXHlGqyAnee/hjjufqozJFqi8jXN9CJrjz7gfOBjMqlXmA1TaYY4Ye3
   Aix7HugtTJlXPiwZbSVvCh272RZjx2f4vAlnqAg4sACsDt3BCZHVRtlll
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10414"; a="61056905"
X-IronPort-AV: E=Sophos;i="5.92,289,1650898800"; 
   d="scan'208";a="61056905"
Received: from mail-tycjpn01lp2175.outbound.protection.outlook.com (HELO JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.175])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2022 17:39:39 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UcQ/V+ClOlmv4ZiAOAaxpy8nzYLQFpMA7Zdb2zL0WiPE72q3oGLfbCIC+0uYHNxejIDv/I6QJNi5R24/r7OUpWL9+asTJw7s5RXKMQQpLSEyFO1LEz4rowXX7br23rrwG/QyeHffpkS4v4Fqpa+U3PdDQ6jIjlLDPMPrWkmcxYMdhTkd2XNvOjRh7aFYOpnevy5vlO4KwhIrDsGcYPTTAYlo/NyAT6h0LAaA95iwQb71SvWcJJBJkvVgtdvkSxutNFq/+0c2gPJAUyMYfzZG6UdOQf5L6HqQG8DbBH9P28s0YOy0eGIpOau1+OPIhRBO8SVj5sYBLl92LKbYe/PMEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hb6Gj02c4bhgHpncY0Zff1tIm5CXOKd8/GYsDgfbPxI=;
 b=HFh+LYBMyG/9jMmkBOza0xptROw2a/a6XS6N2cYV7kNp/YK7C7qvaJcywge/AH0jtAPHbdnSxfOHSdJjH75+4zwzG4ySMhI1jpQTavo9RNEA18EBAN8ASfM7QecjxRPEID8owCZ1IQAPjqSmIZaXnDfMkEOm8SM1eIqJFozxx83VMUlbAi82cmC9ex1zW3qW9AK33Co7fA8V/UY0MfZlkmFNenYS9snbSg58kYXu7VerLa9IPurKN9H/ShXYmWVcdZwrS6QZ62gCY+64rHPsWUcRw9RG21FaAoWtjatkMC4eMk7CnGZBEjlEsG58FzMjYQjv34g3jAiHJhajK1okXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OSZPR01MB7050.jpnprd01.prod.outlook.com (2603:1096:604:13e::5)
 by TYCPR01MB7728.jpnprd01.prod.outlook.com (2603:1096:400:181::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.15; Thu, 21 Jul
 2022 08:39:35 +0000
Received: from OSZPR01MB7050.jpnprd01.prod.outlook.com
 ([fe80::bc95:3b28:928b:a4bc]) by OSZPR01MB7050.jpnprd01.prod.outlook.com
 ([fe80::bc95:3b28:928b:a4bc%3]) with mapi id 15.20.5458.019; Thu, 21 Jul 2022
 08:39:35 +0000
From:   "hasegawa-hitomi@fujitsu.com" <hasegawa-hitomi@fujitsu.com>
To:     Arnd Bergmann <arnd@arndb.de>
CC:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Julien Thierry <julien.thierry@arm.com>,
        "Sudip Mukherjee (Codethink)" <sudipm.mukherjee@gmail.com>
Subject: Re: build failure of next-20220720 due to undefined calls in modpost
Thread-Topic: build failure of next-20220720 due to undefined calls in modpost
Thread-Index: AQHYnE1dd+KVlfKULE6wNPOICRDUwa2HbDSAgAEUuIk=
Date:   Thu, 21 Jul 2022 08:39:35 +0000
Message-ID: <OSZPR01MB7050E847636FD3BDDD7E87FEEB919@OSZPR01MB7050.jpnprd01.prod.outlook.com>
References: <YtgfF/jyk6WyVLZn@debian>
 <CAK8P3a3-K+hfjsCnF9cK=f_nP0sq7NVWpiiaZL5PfoFKUDHLAQ@mail.gmail.com>
In-Reply-To: <CAK8P3a3-K+hfjsCnF9cK=f_nP0sq7NVWpiiaZL5PfoFKUDHLAQ@mail.gmail.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Enabled=True;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SetDate=2022-07-21T08:39:35.083Z;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Name=FUJITSU-RESTRICTED;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ContentBits=0;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Method=Standard;
suggested_attachment_session_id: 70583bf3-d5d7-c0a5-c49b-4de25ed3fa7e
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d5b9e240-d2e3-4c46-de71-08da6af48a7e
x-ms-traffictypediagnostic: TYCPR01MB7728:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vPONIZv7hzWSOvkVxvlSTK8zGlHeiCDUhkgOpXezRnt+DuQP8alNnYVcWMfy5abnSdfuXHnyR3dv7oFHRf2DsrT2Vh26BlSd/Z7EjZr3pDZbhd/TbpflY7KeyOMtjs4AyRIvHm6Z/czyYtW3bfof5DNOQ5E7n/r/9NuCXuvOwfeuIpNDUbDoNlUDIcwd1GQxGPz1XgFccsBzE7bT+GzJcQZQtQtPih8uwCJH22rXsDfuI/1AHnsz9Uh7GN2JeBg9MKqIVKUsSKplFUlnWDIsGJ6pTMRpXiTY5Z5IcIMy2hoSJdJhsokA2H337VsGaB0GCExetPZsSxclO18KyeEOPck6qW+tcvvuabPmSy5KSOudQZkCFcznpnBUC9Uh7ZdqK6eZTpwy5IQXI/b2PNJVYqbumXEV/wZW4jyTZS65bHm5EnTP7dkPW+BKQeVOF+b0OpmtlqzyPWmeDd7dcHhFqevtVG7vGUQYSCkx1hi0NVJcoEiFvBMcpzJ5ilei7nWuL8RkoVvTBVvOFWZ5GOEqsqeLQ9OCmkv3AGjqjspHZfYyAp+mnObFk2lIfFkHZtWGJPx+VJmbsISyXlZsVd3hy+R8FpSUYWi6vpfdbVT1AECZNzY2zz3z3/5oaB+G4Dvf4f6GFerm9nq/ksgYp4gwa8ZPXYnWoA4vFVY+CtFqkWcYAuIBt/wnbFd2026kfmlxi2QNtbSqy473BP76cMeiXKtLE14RYyVPZ3mO1DN+H2XZs2QQPn+SA5ES9YL+O7eI9vZNadXHM8JhdTQ/VfafHf1X1nUmXHxZh6Gdk6lNqaA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZPR01MB7050.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(136003)(39860400002)(346002)(376002)(396003)(66476007)(52536014)(66446008)(5660300002)(76116006)(8936002)(66946007)(9686003)(4326008)(66556008)(55016003)(2906002)(8676002)(558084003)(86362001)(82960400001)(33656002)(54906003)(38100700002)(64756008)(478600001)(41300700001)(122000001)(85182001)(186003)(38070700005)(316002)(26005)(7696005)(6916009)(6506007)(91956017)(71200400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?UGtiMFhVQ29ZNlNJYnhGU3RvQkJnTHA5ZTM2NU9rUTNWL1dvSmEzM2la?=
 =?iso-2022-jp?B?L3pIUSswL0F3YTlNWk9kclFWcldYQ3hEVk43SG96a1ZqT1BqRjFsOG9R?=
 =?iso-2022-jp?B?aE5EcGNxYTZxS0tLeUVuWWpwWWErSlZBVkFmWmR2TGVtWE9heFJnUXF4?=
 =?iso-2022-jp?B?eVVxd1l2RGJzVTRTRFFRNUt2dWhFOWhrT21ldEhPRmN0TXVMM0hkTjMv?=
 =?iso-2022-jp?B?SFpXNmZtMitmZEN0R2ozUlFHN251T2NCL05hbFFHb2RqekdvQzNJSXky?=
 =?iso-2022-jp?B?UllQUWxMVW5VbTl5aURySTZDSUk4a3o1N2FPQ3FRbHFES3ZFUlREUW1W?=
 =?iso-2022-jp?B?ZEZ2RHNJajBJVnM3cU4wSTdQUFBFa1JGQWF0REtmVnJBSm9Db0VjSE95?=
 =?iso-2022-jp?B?NkVOOFdoTW85bnNlMFEyTVUzTFBGV2FtblRKVzZwam1HaTBtWFdSY3Js?=
 =?iso-2022-jp?B?dXVVQXhIZUQ3dW8yUGo4ancxMzVmd0FrMnVoMTN2eDh6VFFhTFlrazVU?=
 =?iso-2022-jp?B?NXU4L1ZuL2FDSG5pMngzZ2Urb1dCdlVqVjB1cERNRGhDSE12RFppMFRn?=
 =?iso-2022-jp?B?MEpkUFBoRWVpSjhCTWhCeFdjZ1RtQUFwWDE3Rnlscm85eCt0NFZpVXFR?=
 =?iso-2022-jp?B?R2RHODhtdkw2amRjZG1tRExrYldMaVJvS3VIeGhzSDZNWWxuTVAvNlpC?=
 =?iso-2022-jp?B?UHdZOW8xWWVaTFc1ekZVS1JONnhvWTI0SUZCZmRsQkdNUU5Hc3g1NElW?=
 =?iso-2022-jp?B?cTBrZGRySXRpZytkWTR3eEd2bWdRRXZHRjJ3b1R5S2thL0hleTN4T0x2?=
 =?iso-2022-jp?B?dG9WUmd0TVJkSjRvT0szZXhhVm5hMitRY1R0RnVZeHVNdjdZY0Q1SU9Y?=
 =?iso-2022-jp?B?SDJ5VlNEcE9wM3ZrTnI2bWhCWmdhbmNmRGc2ekxHRXZ0VndDZnd0ZjVn?=
 =?iso-2022-jp?B?dlBVWW9LajdtRkVpd3hkZzNMRWQxYUJxVllHMVdheW9LVFF0M3Q4VFRN?=
 =?iso-2022-jp?B?cVc2MnR6dkJkMFVkZG1TTnJiWmlrM2xQVTg0d0hSWmJ5THdzTWFMaWxo?=
 =?iso-2022-jp?B?QW5wSWV0aiswY1JHajliOENLZU9ST3BHTGtzRm9YLzc2ZFI4YUkzb05V?=
 =?iso-2022-jp?B?U1YraiszMFg0NjI3alRGZWtkOTZ3WXNhdU9NOVhwYnk4Qmk5eHFmeWZl?=
 =?iso-2022-jp?B?MndCR3FRWFhEbnJEVXR4RmE1NGZReit4aENHVDNITFcrOHNYV1RoTXhm?=
 =?iso-2022-jp?B?Mk1PMHRqWExoR0NtTGlySy8xd1Q4UVhvU1BwQklua01QVzFDajFoTFJq?=
 =?iso-2022-jp?B?bUZnaWR2SndacjY3L2dLeFNJRFR5V29NNkJZaS9yOStXakdJcDF6aDdn?=
 =?iso-2022-jp?B?ZjVWNHZ5ZHo1ZlZFZmFQbWZFNEpoT29wSnFHWmZqcDhVVnBUR2cyMERx?=
 =?iso-2022-jp?B?bUJyYXh2NUx2NHZqZTlHcHBIL3JtT0lDN00zMGtyTXloZHV3RWpJSWUy?=
 =?iso-2022-jp?B?bEVpTndRQjRkYi9hL1grTTBYZm5OVmFiUUExdEd5RnRYK2tkWTRaUlR6?=
 =?iso-2022-jp?B?ZmJDYW40UVR3VDh3c2d5NXpOUWV4NDJzVWkyK2MwVXJONnVaNEZlNEIv?=
 =?iso-2022-jp?B?THBrVlVrRU54K2o0R1pCN21HYzBZdURnUjg4d0xjWGJTOWZLUGcrR2Nz?=
 =?iso-2022-jp?B?SFIya2UrKzhuZG1LWWhYTWVkTkdidHRmbzFCdTVYK21MTVVTZDdpQTZs?=
 =?iso-2022-jp?B?YjAweXgyekNGV3h3L1lHYnl3bzczVVdFYVBmUjJiUS9QVTdqQlE5Unda?=
 =?iso-2022-jp?B?c3BxOGx0SkRrOEREYXMvSUxaSHRFdERqRjVON3NnWXVpNStNZHNsT0E2?=
 =?iso-2022-jp?B?ZU9EdnBVZEZNeFk1YmFGVkRLUXp4TG5zQ0lldlZPRkpldzZtRHptdXhU?=
 =?iso-2022-jp?B?WFd5MHI2eUViUE0xTEplUitSUWR4UjhVVmsyMTVHZko5OTBjZjF4Q2pP?=
 =?iso-2022-jp?B?aUZ6YkNEZUpJWVdHVnVWZWVRbE81dDNDUWlOazk5ek8xcmNjZG1tc3lW?=
 =?iso-2022-jp?B?Z3AzUWIrbUR1d1B0elFQKzZxOGZINEYwUyt2OTF2MmhiN3J3a21WTFNE?=
 =?iso-2022-jp?B?YmZBMTNNQWRmUjJ6azFGSWI0a3czTDlIbTNYc1h1djluRUhSditFM0lr?=
 =?iso-2022-jp?B?ZFZ0c0VoMzFzN3ppb3FTUU1vYk5McTJLa3UxNGNONktIdm0vdFZ4MEdR?=
 =?iso-2022-jp?B?ZmVMTHBxUGJNT01lbFgvRVVxbWRRUStyNll4eDFuZ2p2ZW1GWEhQU0pH?=
 =?iso-2022-jp?B?bGxkUUJGQ0d0Ykl3bC9EdGZWb2xyQ3g0NXc9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB7050.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5b9e240-d2e3-4c46-de71-08da6af48a7e
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jul 2022 08:39:35.4168
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: goOhI52g921tKU+1Y0fe1hcDMPJkBipFEJZyEjCXrNY6bcHJVhY3vqz9mz4BzCR2ai04qvoeAKtvqkLlOgD/NheI4kB0MmnkfLpDBvjv1rI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB7728
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,=0A=
=0A=
I intended to set that to bool, but it seems that I made a mistake somewher=
e.=0A=
Thank you for fixing it.=0A=
=0A=
Thank you.=0A=
Hitomi Hasegawa=
