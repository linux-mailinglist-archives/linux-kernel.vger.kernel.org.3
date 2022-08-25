Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1FA15A1C0A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 00:14:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244321AbiHYWOW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 18:14:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237937AbiHYWOS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 18:14:18 -0400
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75D23C3F71;
        Thu, 25 Aug 2022 15:14:17 -0700 (PDT)
Received: from pps.filterd (m0150242.ppops.net [127.0.0.1])
        by mx0a-002e3701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27PKqSEm012147;
        Thu, 25 Aug 2022 22:13:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pps0720;
 bh=dyn6Hq+vUGuIQfGQGWJWTpR6H2+NiyyU8OW/CtzA1ik=;
 b=V87htTYqvpWYn1HyZV5fKSLy0XSzI7WSKT+VYGuLy1YgLG1STEmYbVUnAhl2fwKWtxfg
 Lr0ijw91vIS+2Yx9tkH5HL9/UcZY0mPuNx8oq46GFFT/v/Qwf0qYs7YcXJW4eUmgr5fv
 DogRcqGEbywjFokx0dielzep4rVOaxh7SBvLw5F7qJe7QStXCBBZGUm4sZkyWMlzPZOn
 3FCNKgK2NcPo/xzvoXW3wrOwAPX0JS3Wvnv5fIqII0BlFz6Q/0dbST51SbeUxOHPRTAn
 TmCpU4VLOKs8+WJQXaPNyfENTDvXuv4z1pr/k7I/yt1lmT26/keUA/UXKfxPLZNKypMw mQ== 
Received: from p1lg14880.it.hpe.com (p1lg14880.it.hpe.com [16.230.97.201])
        by mx0a-002e3701.pphosted.com (PPS) with ESMTPS id 3j6ggc0ues-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 25 Aug 2022 22:13:19 +0000
Received: from p1wg14924.americas.hpqcorp.net (unknown [10.119.18.113])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by p1lg14880.it.hpe.com (Postfix) with ESMTPS id 4D8978000B9;
        Thu, 25 Aug 2022 22:13:18 +0000 (UTC)
Received: from p1wg14928.americas.hpqcorp.net (10.119.18.116) by
 p1wg14924.americas.hpqcorp.net (10.119.18.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Thu, 25 Aug 2022 10:13:15 -1200
Received: from P1WG14918.americas.hpqcorp.net (16.230.19.121) by
 p1wg14928.americas.hpqcorp.net (10.119.18.116) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.15
 via Frontend Transport; Thu, 25 Aug 2022 10:13:15 -1200
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (192.58.206.38)
 by edge.it.hpe.com (16.230.19.121) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Thu, 25 Aug 2022 22:13:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TvgrJdrg0iSvIc1Nm1d0/U+t3k+ALzGHv4Ct1yOM/5wDVViG8NgIvws93n/nGd4LfU1CriaqaKoBNTvUlnzCwXJxct2keyqj0tvX0jQUUh1ZQS9obJMCaLRKmd02tyenDOvrIASbgAf6QuTieGfv5UPy+dXzHtRwxa5UV23177CamfTdlKpTJ3h85zB5ebh6x9DeiUz2aB4ux3oJGjLcCxhGlPZg9VZHqlJO+ihBvOOggKeVF1mVLsGkJyymUaC/6pxyx3kBNdHJLlTGs8WaCsCK7Rxaf4aQ8LUHsSG3YDJdzXQj8wH/GWbvnjjXVIz48N+AXxHjYx76wJG/rdVIAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dyn6Hq+vUGuIQfGQGWJWTpR6H2+NiyyU8OW/CtzA1ik=;
 b=W2lkQJn9kOHpwu4btrZ56dcxmSJUcR97BfmYM8eCxUTd0MTp1eUFzGUWddnOH+YPE00VTgzD9qZfBTas93U+/zCRl8Ov/gIyM3e3QSoq/Uy+VSoyaWnUpw2ezULi9yF6JIZ+dPHrBOIYOw74sPYBRt55RnhCuTT1JJCjKMA6PfniEAF6xXKVOkj8bzcCaDL9pghOVEbODtgxHs59zLmvgpquoXzDlNDFIxcrOpZ8ZyTNzxCPp8XoHTheZdOu5Gg2rJScGzBseVXLqsPuuyVWEy84PpvzRAD3zG7WceOBGABh5sfTx27On23k8mdFdrkwcI+LU80h0TzmbY36KcgkDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:303:1c4::18)
 by PH0PR84MB1835.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:510:162::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.11; Thu, 25 Aug
 2022 22:13:06 +0000
Received: from MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::1cc2:4b7b:f4c5:fbb4]) by MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::1cc2:4b7b:f4c5:fbb4%5]) with mapi id 15.20.5525.011; Thu, 25 Aug 2022
 22:13:06 +0000
From:   "Elliott, Robert (Servers)" <elliott@hpe.com>
To:     Russell King <linux@armlinux.org.uk>,
        Alim Akhtar <alim.akhtar@samsung.com>
CC:     'Ard Biesheuvel' <ardb@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        'Alexandre Belloni' <alexandre.belloni@bootlin.com>,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        'Tomer Maimon' <tmaimon77@gmail.com>,
        "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>,
        'Avi Fishman' <avifishman70@gmail.com>,
        'Greg Kroah-Hartman' <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        'Tali Perry' <tali.perry1@gmail.com>,
        'Nancy Yuen' <yuenn@google.com>,
        "'Krzysztof Kozlowski'" <krzysztof.kozlowski@linaro.org>,
        'Alan Stern' <stern@rowland.harvard.edu>,
        'Patrice Chotard' <patrice.chotard@foss.st.com>,
        'Patrick Venture' <venture@google.com>,
        'Vladimir Zapolskiy' <vz@mleia.com>,
        'Claudiu Beznea' <claudiu.beznea@microchip.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        'Benjamin Fair' <benjaminfair@google.com>
Subject: RE: [RFC PATCH] usb: reduce kernel log spam on driver registration
Thread-Topic: [RFC PATCH] usb: reduce kernel log spam on driver registration
Thread-Index: AQHYuKS3H7Y8FhfAj0+FpgHy3KLdkK2/3ZEAgAAM8gCAADMhMA==
Date:   Thu, 25 Aug 2022 22:13:06 +0000
Message-ID: <MW5PR84MB18424F6AAA4C72EB5C448656AB729@MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM>
References: <CGME20220825170354epcas5p28a5f1a4b13507b5c40ca235560a6ba56@epcas5p2.samsung.com>
 <20220825170327.674446-1-ardb@kernel.org>
 <065601d8b8a7$6fee5850$4fcb08f0$@samsung.com>
 <Ywe6/AKzVL/77Fhi@shell.armlinux.org.uk>
In-Reply-To: <Ywe6/AKzVL/77Fhi@shell.armlinux.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5c3e0f22-c215-45a4-494f-08da86e6fc97
x-ms-traffictypediagnostic: PH0PR84MB1835:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Gx2t7wKnqiW7J+smmfQ5Zk5RdDWtongW39nNPc+EHYI6OHyTgejebrIr2r3eD693O2Groh9RWNTgB1DC25cVPUW3Ft/GDHtuG5Yx8KLBXt15PnAMyDEpRMrOSfO77wHA1s6DYRZYS9Vm8gqZBiX2mLEzn1AGQnlFGLAWOt0zM9IXSp30ph0gVoh4bTQuU2Joi/ZfyD+oYxBIfT1br4NtiBedZSkoeF45t2+RUXycr6oX6lCvH48omnCvE6IFq9+5ylK0fnl4K+ZFADoI/69H0m07JLrhxaKHaK11mWd5QtrMXCfdOD8uqTxvsFO4e29mk0XbFfS/sbigL3NFzA0k/iYvcu+5KXmYEhHgHfO7lDXMZsaTmSDw92j0HRGnw4PZM4L3u4QcLqgofMYYQjvetobEf/ym0XcdfOV7dudDxdEcOgyUAkpdqXWkKxm8Rc3wlvDFlEPLwalsLNtidTB/4AGN+l2V7W4vectr94aOMZ7S+jvOaGPRbkb6NWOF5WBS2iPGUEewJeYPoe8HKfP6UQ6GWzqxEn5+a0Cgsv5ZZHc4pedQo7BGtmmmeVT9n2ymQgN3EugH02H+bALW4hlg9V7bzuMyW/0lUi3Ml2L7pJZrTpHHn2lYjcsknuHbb6NHtQelgFEweRGVKK8TrUn8hfCdV9h8oQoFMqRGBk4HEmK25Jtkw3yFgtXoxCcIkqQEt0S/IU8qBbLXwOsWihj0QZ4dqn3os4s3bra2ng4XA/qJS8ZI0t+xEcidIzaYh6OKBhtXmVXCQnS+MVtRxkqnYg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(136003)(376002)(39860400002)(346002)(366004)(396003)(54906003)(38070700005)(122000001)(186003)(83380400001)(7416002)(52536014)(38100700002)(5660300002)(76116006)(4326008)(6506007)(8936002)(26005)(2906002)(66556008)(55016003)(7696005)(41300700001)(33656002)(66946007)(66476007)(66446008)(86362001)(64756008)(53546011)(478600001)(71200400001)(316002)(9686003)(8676002)(82960400001)(110136005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?+J6zIZ5e8V0ITu3Lfu0KEnpKBPKDke5qYZXdhMEhEKBrPCOJmu2NVrsptq1t?=
 =?us-ascii?Q?Oavb6W9dDOD+lOdHJ+RuSZ5bx3PLR84+AeEK5pfyI+RQJSMnj12KZowovpUI?=
 =?us-ascii?Q?UI2ozT76im0Jdy08cjOkn4ZggLxworP/NqqYVvgEzngPUl8Y5CVRM3RnhY+9?=
 =?us-ascii?Q?oBKj4vYmiU478QCgPH61fxoaiCxo2wAbbbfGCENBE40SCe7OQJa0DByPoCOJ?=
 =?us-ascii?Q?la0frzSPHhC6YsNdRV60W4+XbIS/wzCMFiCe4Qh6HFSCd/J0kUNwWuaiEZuc?=
 =?us-ascii?Q?6YRWb2FUsmGYAvSmcqE114/QnTWItHvM9dBY8CbrRtC4G6r0OMXZi0mDe5ID?=
 =?us-ascii?Q?2k16xqY0LQiph+y9EyQgf2cmkGLGfwfmCnTruFCWWtr+N0Et9MyZ/XlTqJOB?=
 =?us-ascii?Q?89zraX+3KfTkoB/jJRfQ6p4uD1zlcyU3RA1CuOy/yvzW+/HSvymqP3m15Cr+?=
 =?us-ascii?Q?rMVEeAhrpsleh9EMlLlKAQK1Xm7Dt4xMQRR5ksfES8SfeBP+s1Ufi1CwrbeV?=
 =?us-ascii?Q?MlYuotlr/uUj8y1i6MkhDcSOLyITW/kLx/ZdEUt8ma5UgKcabIjv48khNQvl?=
 =?us-ascii?Q?JwD8K71GEDMeuVTtPjXFoQ/fMRSqEHig/lS/v5evAQdzIri6bb5aUmIodvSh?=
 =?us-ascii?Q?tkii1nbgW+w/Bt5L4UByyWuutXNklBScevnW+JTJuKgfp/FoxNUam7CpBLu8?=
 =?us-ascii?Q?29kKTBrY2BBXMPbdlx6g3nr2SvpzGd8AJDh3oFqtwdJbq8JV6aNSvk1GgCgB?=
 =?us-ascii?Q?fCNRHoEtsA+OkiF4v0povyMwwf/L6ZQ1VTE7RnoDG2mZbaSY6GNwGcp4dUrw?=
 =?us-ascii?Q?L4c042D0eIR1Tl+vTD8tppb5ohZccBlJXXSt7EnIUb9GdHJLJ53XQ2V8qPcF?=
 =?us-ascii?Q?eXRGQO5tKi4/n7mwGo6gfxsiIk/5Yc8mcQwd1qmenSwKymis7sz4BFh+yI8+?=
 =?us-ascii?Q?htj25mSK5mwr0G68QGxRkijtsbKmAPgMoLhHmrd4XQfcYNe8H4HlPAMkZoDe?=
 =?us-ascii?Q?eitTwifOHnMw5bkeV6+3gSd35CXAuyQXthpDFp/MdyErQ0sAbnHmCWNtc5zd?=
 =?us-ascii?Q?ldMn+iDGh2GNjbz+5gyral6GOVqIPwNupHMKw6hTFyFYcnqqeRJOxeILL9AN?=
 =?us-ascii?Q?/MbkFuYz37dQ9xzbhm1Km0BtYJzHwTDZDWDdhlHRADyqeAjbk2Vd5XWOA42i?=
 =?us-ascii?Q?5z+T8TnJKPjnjxx20JX/p/wHeKuqS8JdiPyAsBV6dBu2wo88a3HWLphTTLB6?=
 =?us-ascii?Q?mylBJuvWOk01UF0ZWSa/77/FLbffdeaZoWX43k2mFO0261LnOMObW7JiaCu7?=
 =?us-ascii?Q?ftGwrXdN3GeeexcD2iiCOb2zkEqUKbCoFlIjlvr80riu50YNw+C3p3CiyDRX?=
 =?us-ascii?Q?+4+3dP/4C39iRzy9fm60JwjByUCUzOxjV/hSIzQAZLMM0l3DgC2OSU5ZHGjt?=
 =?us-ascii?Q?Dug22iFIkXmI1BRUZFG8SGfDV3NkZ5HB5U6R0cKi5QC9C8RkLddnHZm6ULuo?=
 =?us-ascii?Q?sjEWiiRQk1IxMoryRUlBl708ggvd8efWjBWJPlynO81gTNWGFfaL6u87sKcV?=
 =?us-ascii?Q?jBaFedTMfgjWagr+2QE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c3e0f22-c215-45a4-494f-08da86e6fc97
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Aug 2022 22:13:06.4407
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Nx81DY0j7IqY2hp1mtp1rW7+bLH8fDsgm1gQYE5hVDvie9DuM4v6CSZsZbeBhtjZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR84MB1835
X-OriginatorOrg: hpe.com
X-Proofpoint-GUID: 2rA8PH6qeqNu0Iw042Eab3VClDCtQQaq
X-Proofpoint-ORIG-GUID: 2rA8PH6qeqNu0Iw042Eab3VClDCtQQaq
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-25_10,2022-08-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 impostorscore=0
 mlxscore=0 lowpriorityscore=0 suspectscore=0 clxscore=1011 adultscore=0
 priorityscore=1501 spamscore=0 phishscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2208250085
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Russell King <linux@armlinux.org.uk>
> Sent: Thursday, August 25, 2022 1:10 PM
> To: Alim Akhtar <alim.akhtar@samsung.com>
> Subject: Re: [RFC PATCH] usb: reduce kernel log spam on driver registrati=
on
>=20
> On Thu, Aug 25, 2022 at 10:53:44PM +0530, Alim Akhtar wrote:
...
> > Ard:
> > >Drivers are typically supposed to be quiet unless they are actually
> > >probed,  but for some reason, USB host controllers seem to be exempt=20
> > >from this rule, and happily broadcast their existence into the kernel
> > >log at boot even if the hardware in question is nowhere to be found.
> > >
> > >Let's fix that, and remove these pr_info() calls.
> > >
> > How about just change pr_info() to pr_debug() instead?
>=20
> Do the messages serve a useful purpose that the initcall_debug kernel
> parameter (that doesn't require #define DEBUG to be set while compiling
> and thus can be used with any kernel) doesn't provide?

Some code uses "printk(KERN DEBUG" to avoid pr_debug's complexity
when CONFIG_DYNAMIC_DEBUG is enabled (requiring adding strings like
echi_hcd.dyndbg on the kernel command line). You can preserve
the pr_fmt, if any, like this:
	printk(KERN_DEBUG pr_fmt("message\n", args ));

However, I agree with Ard's suggestion to drop these module loading prints
altogether.

These modules do print more lines if they find hardware. Example with
ehci and xhci finding hardware but ohci and uhci not finding hardware:

[   20.568240] calling  ehci_hcd_init+0x0/0xe2 @ 1=20
[   20.568242] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[   20.574810] initcall ehci_hcd_init+0x0/0xe2 returned 0 after 6568 usecs

Patch removes that Driver line.

[   20.574811] calling  ehci_pci_init+0x0/0x69 @ 1
[   20.574813] ehci-pci: EHCI PCI platform driver
[   20.579544] ehci-pci 0000:01:00.4: EHCI Host Controller
[   20.584867] ehci-pci 0000:01:00.4: new USB bus registered, assigned bus =
number 1
[   20.592356] ehci-pci 0000:01:00.4: irq 58, io mem 0xd9b9c000
[   20.604560] ehci-pci 0000:01:00.4: USB 2.0 started, EHCI 1.00
[   20.618684] usb usb1: New USB device strings: Mfr=3D3, Product=3D2, Seri=
alNumber=3D1
[   20.625947] usb usb1: Product: EHCI Host Controller
[   20.630849] usb usb1: Manufacturer: Linux 6.0.0-rc1+ ehci_hcd
[   20.636626] usb usb1: SerialNumber: 0000:01:00.4
[   20.641367] hub 1-0:1.0: USB hub found
[   20.645143] hub 1-0:1.0: 8 ports detected
[   20.649429] initcall ehci_pci_init+0x0/0x69 returned 0 after 74616 usecs

Patch removes that "platform driver" line.

[   20.649433] calling  ohci_hcd_mod_init+0x0/0x7c @ 1
[   20.649435] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[   20.655659] initcall ohci_hcd_mod_init+0x0/0x7c returned 0 after 6223 us=
ecs

Patch removes that Driver line.

[   20.655661] calling  ohci_pci_init+0x0/0x69 @ 1
[   20.655662] ohci-pci: OHCI PCI platform driver
[   20.660155] initcall ohci_pci_init+0x0/0x69 returned 0 after 4492 usecs

Patch removes that Driver line.

[   20.660157] calling  uhci_hcd_init+0x0/0x10a @ 1
[   20.660158] uhci_hcd: USB Universal Host Controller Interface driver
[   20.666589] initcall uhci_hcd_init+0x0/0x10a returned 0 after 6431 usecs

The patch is missing that uhci_hcd driver line.

        printk(KERN_INFO "uhci_hcd: " DRIVER_DESC "%s\n",
                        ignore_oc ? ", overcurrent ignored" : "");

That does sometimes print one of its module parameter values, but I don't k=
now
if that deserves an exception.

[   20.666591] calling  xhci_hcd_init+0x0/0x28 @ 1
[   20.666595] initcall xhci_hcd_init+0x0/0x28 returned 0 after 2 usecs

[   20.666596] calling  xhci_pci_init+0x0/0x4e @ 1
[   20.666711] xhci_hcd 0000:00:14.0: xHCI Host Controller
[   20.672050] xhci_hcd 0000:00:14.0: new USB bus registered, assigned bus =
number 2
[   20.680584] xhci_hcd 0000:00:14.0: hcc params 0x200077c1 hci version 0x1=
00 quirks 0x0000000000009810
[   20.689996] xhci_hcd 0000:00:14.0: xHCI Host Controller
[   20.695319] xhci_hcd 0000:00:14.0: new USB bus registered, assigned bus =
number 3
[   20.702759] xhci_hcd 0000:00:14.0: Host supports USB 3.0 SuperSpeed
[   20.729559] usb usb2: Manufacturer: Linux 6.0.0-rc1+ xhci-hcd
[   20.768845] usb usb3: Manufacturer: Linux 6.0.0-rc1+ xhci-hcd
[   20.787580] initcall xhci_pci_init+0x0/0x4e returned 0 after 120982 usec=
s

The xhci modules already don't have those prints.

The patch is also missing u132_hcd_init:
        printk(KERN_INFO "driver %s\n", hcd_name);



