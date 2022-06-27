Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BB0555B542
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Jun 2022 04:32:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231874AbiF0CbM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Jun 2022 22:31:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231823AbiF0CbK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jun 2022 22:31:10 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2102.outbound.protection.outlook.com [40.107.117.102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 563AB2BE9;
        Sun, 26 Jun 2022 19:31:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b4uOsmj0owQo0vlC/+jD9M+TjIQzCsvnXym7VhUMxrpqTPcTjSpQa/C903D9ycrVQxIESSCLvfHaADLN8+OUBEZnTRKe/l6CZKmcpksEipU4ARxoe9J2F3nrdNcgkyg/DKAFWf50iGkRwNsyeVcGM8jpmSC6IqjCSuxx4DWtEK9RaTndfqZl8nLOE5tFdkDXU9+8Koaq4FHZQzCL6xb1yj9pLFUB9+PROZXd/0+B7d8aofOjZacbXrlhkb7AvIJjzv0qje/hui3RFDKN2+XSo3TJJzI/bEpnaI+a5Xn30wNRlvmkIyOQHrbqxepW+6dl+R3TOcqRAWpwufONvbJ6rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bjtGt3P9IiZhc88Y2ixBSc0D43aFObjcv7+yjS39Pps=;
 b=WQSklkqVcFlzSDw1raRtIR3G9/za240ZZnTABhh+rWP0oiLP8XamVNi77wx+PaU6Lbxiq0m1YKsjYDqoOnKefoub+bKozcsNOaUYDBr7fgEzZe1WJsM5toOHbcY/ZgCNMCI7bYNdAR8C2vGMcTQf+7oV8pnveRvbBC1oXzPQQC4LDNvCwVLeMNSz8VlJGqHxlTe1EoVvFWTtZpAZI1Sz8pWp/4KSxrxibMnW1ACxJeRtp6+n37khUx2kmIqiku8nJGLg6kSGuZPcUDvbbJkv7Zz/0uXyt1qGJlHuA46TLET8Imu7nQ29tUaMv4KLXJJz1SFqcl4nGLkb0xcidjiD5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bjtGt3P9IiZhc88Y2ixBSc0D43aFObjcv7+yjS39Pps=;
 b=Soyq0WIGDJdeyjaoHYPgO9OeZBFSXmZNcz08TsPMtKl1wXQt3jUk/k5VFbB7htSenTfuL4DhLbFSbc3DWqrKmD5ZL1QiK8WcTW3CNPipcK583b2Cy+c/Zhe6SvKfH9RtvU6grDG37wJRM63uS+Kcu8k+cAMbRMbpVYkx3FdpZ3wKkmPFw4rsK8Q7+aGBdKCDkivFgeoBWtwB6nszHd8RRTS7AHxtO58zAY+EA8pOH5Jx59MYGAUMbshFdYZC4+QQcKVOiDaS6zZXd9u4eGKV7lOxZpaVbhwUCmbXxn/gQErtVFn3DnKUCESTerjKgDnb4QpI31qd07CAwVqKpylo6w==
Received: from HK0PR06MB3202.apcprd06.prod.outlook.com (2603:1096:203:87::17)
 by TYZPR06MB4528.apcprd06.prod.outlook.com (2603:1096:400:71::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.15; Mon, 27 Jun
 2022 02:31:02 +0000
Received: from HK0PR06MB3202.apcprd06.prod.outlook.com
 ([fe80::46d:a7a:f047:e9bf]) by HK0PR06MB3202.apcprd06.prod.outlook.com
 ([fe80::46d:a7a:f047:e9bf%5]) with mapi id 15.20.5373.018; Mon, 27 Jun 2022
 02:31:02 +0000
From:   Neal Liu <neal_liu@aspeedtech.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Felipe Balbi <balbi@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Roger Quadros <roger.quadros@nokia.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Matthew Wilcox <willy@infradead.org>,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
        Cai Huoqing <cai.huoqing@linux.dev>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        BMC-SW <BMC-SW@aspeedtech.com>
Subject: RE: [PATCH v2] usb: gadget: f_mass_storage: Make CD-ROM emulation
 works with Windows OS
Thread-Topic: [PATCH v2] usb: gadget: f_mass_storage: Make CD-ROM emulation
 works with Windows OS
Thread-Index: AQHYh3DSTidIVUKmfU2+k/4XOqVQ6a1eHWMAgARu1jA=
Date:   Mon, 27 Jun 2022 02:31:02 +0000
Message-ID: <HK0PR06MB3202E80AE3356AC9910163B580B99@HK0PR06MB3202.apcprd06.prod.outlook.com>
References: <20220624021916.318067-1-neal_liu@aspeedtech.com>
 <YrVdxmleSZDeUp19@kroah.com>
In-Reply-To: <YrVdxmleSZDeUp19@kroah.com>
Accept-Language: en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 01bf5353-5d82-47da-8b66-08da57e51430
x-ms-traffictypediagnostic: TYZPR06MB4528:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /khDhZtq9vXh/54N1gbI/jgFCiVOjycrm8hCk79KOZZYFjVsq5iEafUZnoI5BdIoJv0NNvQhaCB4k/o1MaAThj00BL+KhRZIGtNW7/x97pbpcZwIonz7xHraFc4+p4RESf0kiSZ34KAn1rNClM8PNKNPg+gM+RTY7CWvTVouyu9RfwO4XI1U9OLlMpRXp2WLUMw8VGx3BcS21HGX5Dt7rI5qic7k1nGlThMTp0oRsei7a1n6JXQbtomz4s10Ol+ANNHPbqK3vqY36kr62KiRNXrOzpmcewGvfma+uLL58GvhheCWfx8cgjxAOqDYpj2mQeL0xsbhaQv2wk9Xm9j5CLyYG/ePUBjXTQWovcRUVhnpC5ShQv3XHM2eXSthaDj2dRuKghHsXXhqZQFLD+AMpzF1O886pSdfZDU8aVRkZOOkUeBiRcsxCu/tKxLRJt1V/ET5DcIu2CejlfnYsZoQTfUVA7UmKqckWkfDcZZdoL7qICo0wdKDeCid2+SBcGGBMWFrhrhzN4SGANLHdXDdiDIpRPt5lYchdOhB0ReBKCcPJMoVm3zT3vkcTZryl4C1g8SzsDYfbXr0Jgzn+9kOjN7H+wToQkD7W0ZkDXfYc9hR1JPFk2wPXURUg1IPoPKtUgH/q8hGLggC8Ow+4QQ7tZGVhAP+F0/0DEdinJbHFv7LUBuvuw1H/zFqVfJLywzTqQf/f+UhILcciVVzs62LAMAeyDtFguRRoi031ahnOWg07BkttobgC4eg7q5ovdOzFc6FIM1SPy5Lz0flQ0+QKlvqDE0tjuMxn3g5wyc29FQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK0PR06MB3202.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(39840400004)(346002)(136003)(376002)(366004)(41300700001)(66556008)(66476007)(66446008)(122000001)(66946007)(54906003)(6916009)(316002)(2906002)(76116006)(38070700005)(38100700002)(7416002)(8936002)(52536014)(478600001)(5660300002)(83380400001)(107886003)(9686003)(86362001)(55016003)(4326008)(33656002)(64756008)(7696005)(71200400001)(26005)(186003)(8676002)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?4FfyZeZ5fboI6nbUeFbfwhp4Y9CZqGMZIPmopNT1Fz3vrRJGt+4l4e4sNjzm?=
 =?us-ascii?Q?tNBU+PgrqtzPutpG2cR0S6/B6fNuSR72ZS1mWfO8IEnqLneXV0dlpBIKWDp6?=
 =?us-ascii?Q?E21czUyGpqTAYdyMziq+FmWtrgCGuynfiI9LCg/niRmRCzOUn7B0zzWAVQHL?=
 =?us-ascii?Q?xsESqxhcLFOsHTavKgWivzxFpJ2rLpTPovvG5hQzUZAojegpZZE8EfIfGiE3?=
 =?us-ascii?Q?YGZruspaR0yoZE/voYcC7ZlH25HbJK9aakpmYVwnphcxLC/DoNCBtd3D5Mxo?=
 =?us-ascii?Q?okCeyxiPGzZJd3xaYNl5Yy9b6PQ29UdKAm3eFTsJQiNCDMrAuYVd16nl4ySH?=
 =?us-ascii?Q?wnMdJoCs8VaWS3iHCCiN6SYELp27p/htJGwkUfkxoGHNW+hsWwDnYehtOpTt?=
 =?us-ascii?Q?levU357j+vKdZcBD60wRTtQFLIb0LuPtRUXMrJh0xus+HMPJ6jY5M0xKQf6U?=
 =?us-ascii?Q?IJKCuQWv36xPNZcMQcbVu4j82k4MMJrXgqTuRGS7qGHYdJ58IwZL7MZtwu9f?=
 =?us-ascii?Q?FKTx8HwIWfafnD7sI0cmT/7BfGzsmeD74nqKtGqZ/Vfxbgw1Uf5wBSyzBGOr?=
 =?us-ascii?Q?zE1kEOOKyBlciXNMlbwXyMIo9GTszVSmcXreYPX+boNJ3igdkJq3VvqXssow?=
 =?us-ascii?Q?4+1q2Td2JV54NHNxyHqIGn7aiRBIz+HgQ+t6ejTtP2XmiX+1hSytgJEAaLRs?=
 =?us-ascii?Q?G4oZoivFUJ5N++oBylS0jHSOQWpBr8QQVg6q7WM9GHRvCESXumKVEUJbCZgg?=
 =?us-ascii?Q?9R9iKnSQRKAc7DsB39yufCyOJFzNcTYg3+C1metDL3sOm5zNbIKX9xVKsn17?=
 =?us-ascii?Q?gHffEjK8RBIlV0aXLrIG3Wv3UXGVdGKZ1W1LKAWTBxiq/qi3uP+rek0joxDk?=
 =?us-ascii?Q?I35+sWQAvu2nzJ1+jX4M0Iv6iroIHHlUOCHYVqpkfbG7LrB6BiAz7UtKxeZL?=
 =?us-ascii?Q?qLoeHLWJBMa0WAp/6ptXDmWeVQAkN44iibTQyFU7JWlxF1EP2u6YAk0ZVVYq?=
 =?us-ascii?Q?nhFLAvp7bLxYuLwJKwa7Vgs054rW07FK9Lw0WES2WPfiWryH8mp3R0vDsT2+?=
 =?us-ascii?Q?+msUtDQq3tcsnwsCcIhLn1hxb5YmlPkmQTqzEmGtGCu0BoH1KF9bgBzoIzJD?=
 =?us-ascii?Q?h9BHNaoNKl+6TJhlj2Bml5U0RzqXPwXdqq3lo8Y4HUKHucdFMq70Vc1FG0R6?=
 =?us-ascii?Q?1BYNcbTeCU0gb59YBdqrTFDtgzhFxPdE8PU1tgJZywOTYWC4EwiFfInwarIc?=
 =?us-ascii?Q?DbWR8T6ud9asXO/y2RBVIEX71oqzm08jbOhn6AtThHjuiJHBEMCwy5HxNLP0?=
 =?us-ascii?Q?QDh3L2nTgvmKUHlMiPCdrMfKhfNSII+GiVkzBDHq3nnwkxo61R5OmZ9m+Aff?=
 =?us-ascii?Q?Ogu7yoTvCY1kkTi02uWj2ac+DP51iyqwWZjRFcLwDB06ag0g+0fYLVJTNTiO?=
 =?us-ascii?Q?V/YD0zn7Q+I059ZIcQYjCG+kR8rs72U2b+nS594F68p7ZNRO39778wB+b34H?=
 =?us-ascii?Q?L1mIXvfayXdCun+pdU6TcS9y1SCkGltQlMLlnALtJr1WmioBUo12F0CdDzGJ?=
 =?us-ascii?Q?HNFU1EHjaLRJkTyKo/giCNwX7x2Db/BL7t1450Xr?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HK0PR06MB3202.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01bf5353-5d82-47da-8b66-08da57e51430
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jun 2022 02:31:02.3574
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LHx1nNIQjy6HDqvTkvfiQ/Ugu6u8ky+DULnultNhTcLfXUFtHlyCkHsvwelEoQRI2q+AEa7qZk2o+GJZUtpXXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB4528
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Fri, Jun 24, 2022 at 10:19:16AM +0800, Neal Liu wrote:
> > Add read TOC with format 1 to support CD-ROM emulation with
>=20
> What is "TOC"?  What is "format 1"?
>=20
> > Windows OS.
>=20
> Which versions of Windows support this?
>=20
> > This patch is tested on Windows OS Server 2019.
>=20
> Does this fix a regression where we used to support this?  Or is this a n=
ew
> feature of Windows?

We used to support this. I should add "Fixes" for the information.

>=20
>=20
> >
> > Signed-off-by: Neal Liu <neal_liu@aspeedtech.com>
> > ---
> >  drivers/usb/gadget/function/f_mass_storage.c | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/usb/gadget/function/f_mass_storage.c
> > b/drivers/usb/gadget/function/f_mass_storage.c
> > index 3a77bca0ebe1..9edf76c22605 100644
> > --- a/drivers/usb/gadget/function/f_mass_storage.c
> > +++ b/drivers/usb/gadget/function/f_mass_storage.c
> > @@ -1209,7 +1209,8 @@ static int do_read_toc(struct fsg_common
> > *common, struct fsg_buffhd *bh)
> >
> >  	switch (format) {
> >  	case 0:
> > -		/* Formatted TOC */
> > +	case 1:
> > +		/* Formatted TOC, Session info */
> >  		len =3D 4 + 2*8;		/* 4 byte header + 2 descriptors */
> >  		memset(buf, 0, len);
> >  		buf[1] =3D len - 2;	/* TOC Length excludes length field */
> > @@ -1250,7 +1251,7 @@ static int do_read_toc(struct fsg_common
> *common, struct fsg_buffhd *bh)
> >  		return len;
> >
> >  	default:
> > -		/* Multi-session, PMA, ATIP, CD-TEXT not supported/required */
> > +		/* PMA, ATIP, CD-TEXT not supported/required */
>=20
> So case 1 is "multi-session"?  Please document this properly.
>=20

Okay, I'll revise it properly.

