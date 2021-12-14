Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72FB9473D12
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 07:16:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230410AbhLNGQh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 01:16:37 -0500
Received: from mail-am6eur05on2057.outbound.protection.outlook.com ([40.107.22.57]:50720
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229630AbhLNGQg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 01:16:36 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aMnPQcideax1D6WCfp5DVYg3zon9RdzSKsrBANIqS2orLtIhWHYnVsYflYAv5MxYZwdHcVkO+1TFeec7KdCFTSsWKzdpZ3jlAxeM9k1f88o5INlrnkXKKu4eQRkQzQ8rj+sPjFs3kcSneWcH1UcaV7wIxvQmSO05vK4XN9INmPegytwiKLFwiK8VMeLJMovjbJ4dG3DJ4bNwLlBRksSfE8QFVV1GNlYchHa2rwTJGT6/AX5m2D7G72e7OLpxCh1JSGYmzhlJJCJt1A62r9mgFUpdzq36Perq//32FLGA1XxI6MRZOrUX0XXQJhMQ+DwVmIitSao7pwTr6AM2QPb6Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zeZ2/LTCoVEjtd5X4KFneffFPo17pHYmUAz38fsX7EA=;
 b=oWH/hYwGNCYc2RvoyqMTgFqQCr76czHOmql1E/q9OOuG5oJhiMafay9EOwTbR9UVrqkrsGew+0RwFsaJALFoDT8lXX5S5cvyUqCJXwX3YwudGwqjeamnROboGKkidJKatusmlXRjsw/o6e/H6ZGvHJcX4gfDLuF1BFx+rDB+EREHRYYBlzduylSOfy0L9CsUKUXWCkKnixcVLxZf3Bz3JM4bpdZPjbxgq55fH6meY9TNoscuANbXfk8R4R87zJgErE6XG1X+xf/9aYTj+rrtM5NmZ4y8UhQUyY3FnG7eG3q/ICqMC/ecQjqONw7AsdI71eK+JoAgBLj4VkP6Ga/Yiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zeZ2/LTCoVEjtd5X4KFneffFPo17pHYmUAz38fsX7EA=;
 b=KdDpGHX/ziyIgQx4MZgfYpbB2wNDCErpudValTndYGdzUu1jxfEvfyxZKLmOPyj+MyuYXhc/U0+PRjNBe7H8A29qSWl9D7pTmOBtfY3zObeOWt+S62VxQhCwU3xOS4aE7SHsgzFB/f7e+OR2A+KUjUvvm95pW7mSALCtRYetPJI=
Received: from AS8PR04MB8946.eurprd04.prod.outlook.com (2603:10a6:20b:42d::18)
 by AS8PR04MB9206.eurprd04.prod.outlook.com (2603:10a6:20b:44d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.17; Tue, 14 Dec
 2021 06:16:34 +0000
Received: from AS8PR04MB8946.eurprd04.prod.outlook.com
 ([fe80::60be:d568:a436:894b]) by AS8PR04MB8946.eurprd04.prod.outlook.com
 ([fe80::60be:d568:a436:894b%7]) with mapi id 15.20.4778.014; Tue, 14 Dec 2021
 06:16:34 +0000
From:   Leo Li <leoyang.li@nxp.com>
To:     Shawn Guo <shawnguo@kernel.org>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Biwen Li <biwen.li@nxp.com>
Subject: RE: [PATCH v2 2/8] arm64: dts: ls1028a: add ftm_alarm1 node to be
 used as wakeup source
Thread-Topic: [PATCH v2 2/8] arm64: dts: ls1028a: add ftm_alarm1 node to be
 used as wakeup source
Thread-Index: AQHX6KRQDmQ7ZD1sNkCrw1lrB/2GzKwxipGAgAAH/iA=
Date:   Tue, 14 Dec 2021 06:16:34 +0000
Message-ID: <AS8PR04MB89463CB1B95BD7C4333BE7DC8F759@AS8PR04MB8946.eurprd04.prod.outlook.com>
References: <20211204001718.8511-1-leoyang.li@nxp.com>
 <20211204001718.8511-3-leoyang.li@nxp.com> <20211214054619.GI10916@dragon>
In-Reply-To: <20211214054619.GI10916@dragon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d0f672d0-2895-40f0-a287-08d9bec9477d
x-ms-traffictypediagnostic: AS8PR04MB9206:EE_
x-microsoft-antispam-prvs: <AS8PR04MB920657BF8D90D7C61525D3DF8F759@AS8PR04MB9206.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Q52ni68zJrM21KcSGLLPJ+in0BzlSCQ5XIGCpQci9RVB/iXLUXRQiVzHtFw+Nq3giSwwND6EtuBCOdehCsPAj5XmjuJT7A8Q99C5A9CKHPkDLiBnTqTkibkaf8r7UtL7sk/0L79Y58Z5Ino/dq5vFgU5L6uT8nQ+jZY8mLfBMw7XzVqvJMQ42RN7/0INXVmP9H/Wt53aKWpviNfidgFcvOVTg6gHiEvtyurR2wePwuTY42REhPlNowy7/km90dsDRvqZkO0PA/AtI/VBAqtNpydTtgxmqnrUD4VaVKpN7cc8epZ8Blf8VzZYT+HcVjYbCObi2gaD4LRanMG4geHES4wysjc61bDvZekWaWDdBQIeQh0jZonAkqbZwAPhGUpuHJ+npmn7iRhcrsT7YLCbjKq4m5vziRwZ11DYjxi6bha9Lz1J3i1WG/ru6jFWXURe078X/sKTSWnIS7jlBvZKhFWMLnMHuPwvWNymvRadZFLbDFxPEr2MpwGtrxYBuPGR04RUYzvp3fpmnW8GysJsv1avRBQk8ITCs6jyoX2eoVHHx+HR7ymGzJV/hUmcgqy7kmT3XPQ3MhkpvDLCKN+OoGNP81HoysFSnuQZAPK4HsMyZEz/pRG3W/DU8J1HErTW4XCrfX5Elnk9llYt3UNSsDhAD6hHs2dFCmlfkFDzxKJgxphESWXh5gXTSFEyMejvy35NlLBJEcQcVHxh/d+Lvw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8946.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(2906002)(5660300002)(316002)(6916009)(71200400001)(66556008)(186003)(86362001)(55016003)(66946007)(54906003)(8676002)(52536014)(7696005)(26005)(66476007)(38100700002)(53546011)(6506007)(64756008)(4326008)(8936002)(9686003)(122000001)(76116006)(33656002)(83380400001)(508600001)(38070700005)(66446008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ypByKiFV2GjyXXKDKKJoNrp4BDsCt4WelarnxQATSmeXzsHyulWgYy/jhvdQ?=
 =?us-ascii?Q?DRuhTINlWSYkjgrJaCM0aJ5PTMPWFJOQgK3BzUIONitXvLAxPm4DmEady3v0?=
 =?us-ascii?Q?AXglxaWSpC07C4rJC4G6J3WhKHQ5Go4e01SeuBD+PDztNwERRHfh57NGVdUx?=
 =?us-ascii?Q?tdvoe8BsxivJdpRUSsDHbVuFBHQEPNalNNmCRz4pIWHG111gSabeG4+VPRJH?=
 =?us-ascii?Q?e+PZx2mxAKKrREHSMTHtRiAAe5J9KsOm1UHHSe7O8DSv+16uWbtO0E5Symga?=
 =?us-ascii?Q?FrdDhgZ5RYk0hkqdbTX3ppqPHjgOzlpY+Lqa2b1IFwzidj8kkwIYFZcmqOSG?=
 =?us-ascii?Q?Jq+jtm9e2IDBiWBahkUDqO4JnSMEJM7DK1208ekjoOjqNaI3290RGYEFBOgw?=
 =?us-ascii?Q?0SvGllDftI5FNdF7DHfOt1FNGko9syM5bsLDDIXnZq1zx5IihAN2KhmXMGEv?=
 =?us-ascii?Q?blPX35kWWqHIFPDxL9o3c1cDIuRfQPxDwNsEVCxfUGUCeFToarRvlgRUpDpF?=
 =?us-ascii?Q?6l1bDY7H4e1nDuHd3SCBdzxQ4t+Y7ZrKGj2EIJSAKEaNEIi66pdbsLPjMYdS?=
 =?us-ascii?Q?TDXi3edxFhAxTIz8r9gYB1hovrztHgooFiXm1IGhrAAq7Jorl9sonCtiaqR3?=
 =?us-ascii?Q?hBYBXwyr0CQBTL+cq9nNU9tEvb7UWNYWcvdYrSoeHBJnvC1VOu0407aIIeBM?=
 =?us-ascii?Q?ZIZq3aNJcrLGLPzphXO2+BsiNZparSmKD9SbACBHiQg+Ao3Jl31O5Y0wDczW?=
 =?us-ascii?Q?tF/MpXcrO1+co4oWg33J1mp0gL+MPIS3OBRMcuRzblMgBNGtq3NY+MGDuzno?=
 =?us-ascii?Q?Dt42iNkhM4CeeoXU5SkUnDnfquB0ZhU14qgSgHFQsiFzJHzue9L7L5gGkqM+?=
 =?us-ascii?Q?bmeo2L/XhoZifyNPcif6w0bbbUqxnHkrKSw2RdvbSGCsLg+um5mAQDrr66Oc?=
 =?us-ascii?Q?sn0O3TSv9yF9/7NK6RioIxRqr/bnIoOFLhR/QBnohOJWPSjpyJpWOyX1p4md?=
 =?us-ascii?Q?PBIWJFNady/ClBPx9UgqrChhy4nQXA+ovXvuTRKMSfy6P78f775lvIP4gPSk?=
 =?us-ascii?Q?t9dk75vyatUMoIMBga2dq9TrNA8kaz1Vzlm11Do6+d3piYoj/+4AQXUe1jm4?=
 =?us-ascii?Q?q0T3IMvEIRot1tji25HFnGBA9spbNLeOWKJBncP6B2v61EnhRHANKT/rh2Gs?=
 =?us-ascii?Q?XumG2vKz5ZppsNaqOETZp6hdYsGSmmpYqU12YgR/ePtIf4fHkxsaBimz3pEX?=
 =?us-ascii?Q?yRun3raoNMzq/QInGTPGpJPqcD7Kt8LuwZ5rikaQtcYDwPorQwb92yTOFI6g?=
 =?us-ascii?Q?/ymwhZDaA5nfFFMlje5tFvrSJooX0QYtdkKqik6It/VM1bHwOW1DV9Gzn7jC?=
 =?us-ascii?Q?4H3U+G7ik1uKAg04eWOmFZkDWTPO4uPYGbDRta4OKUSjf9nzcTIrtX8Wt/bX?=
 =?us-ascii?Q?E8FvhEg8/BcUhtMzKJQgW14J54jG165mE2czLIAiUuswHrBLo80BH4CTIyqi?=
 =?us-ascii?Q?DfyKxAb6+effA3O2DkUQZrQqdm1FmXc6OiQzNKzfzytwOFFYQz64HJCrq4ms?=
 =?us-ascii?Q?RF1td71VyI+rIgLhC35CgEbJZo5T+PSUdjX1VRhwjXcimzPVX1D17B+HzDGQ?=
 =?us-ascii?Q?KHDFrtZke+K7yonjpL/vSWs=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8946.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0f672d0-2895-40f0-a287-08d9bec9477d
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Dec 2021 06:16:34.6068
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dWmtI1IBc536zqIzPweShaIHyZEuzuicMt9qavjQJzsaiMmLT3iMcQQaP/PMNmRwHNysjxyr/IFEMDPwH+DLTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9206
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Shawn Guo <shawnguo@kernel.org>
> Sent: Tuesday, December 14, 2021 1:46 PM
> To: Leo Li <leoyang.li@nxp.com>
> Cc: linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org;
> Biwen Li <biwen.li@nxp.com>
> Subject: Re: [PATCH v2 2/8] arm64: dts: ls1028a: add ftm_alarm1 node to b=
e
> used as wakeup source
>=20
> On Fri, Dec 03, 2021 at 06:17:12PM -0600, Li Yang wrote:
> > From: Biwen Li <biwen.li@nxp.com>
> >
> > Add flextimer2 based ftm_alarm1 node and enable it to be the default
> > rtc wakeup source for rdb and qds boards instead of the original
> > flextimer1 based ftm_alarm0.  The ftm_alarm0 node hence is disabled by
> default.
>=20
> What's wrong with using ftm_alarm0?

Not 100% sure, but probably because we need to use flextimer1 as PWM.

Biwen,  Can you comment?

>=20
> Shawn
>=20
> >
> > Signed-off-by: Biwen Li <biwen.li@nxp.com>
> > Signed-off-by: Li Yang <leoyang.li@nxp.com>
> > ---
> >  arch/arm64/boot/dts/freescale/fsl-ls1028a-qds.dts | 6 +++++-
> > arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts | 6 +++++-
> >  arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi    | 9 +++++++++
> >  3 files changed, 19 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a-qds.dts
> > b/arch/arm64/boot/dts/freescale/fsl-ls1028a-qds.dts
> > index 6e2a1da662fb..00d5b81bdef3 100644
> > --- a/arch/arm64/boot/dts/freescale/fsl-ls1028a-qds.dts
> > +++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a-qds.dts
> > @@ -25,7 +25,7 @@ aliases {
> >  		serial1 =3D &duart1;
> >  		mmc0 =3D &esdhc;
> >  		mmc1 =3D &esdhc1;
> > -		rtc1 =3D &ftm_alarm0;
> > +		rtc1 =3D &ftm_alarm1;
> >  	};
> >
> >  	chosen {
> > @@ -234,6 +234,10 @@ mt35xu02g0: flash@0 {
> >  	};
> >  };
> >
> > +&ftm_alarm1 {
> > +	status =3D "okay";
> > +};
> > +
> >  &i2c0 {
> >  	status =3D "okay";
> >
> > diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts
> > b/arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts
> > index 7719f44bcaed..41900d351a92 100644
> > --- a/arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts
> > +++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts
> > @@ -21,7 +21,7 @@ aliases {
> >  		serial1 =3D &duart1;
> >  		mmc0 =3D &esdhc;
> >  		mmc1 =3D &esdhc1;
> > -		rtc1 =3D &ftm_alarm0;
> > +		rtc1 =3D &ftm_alarm1;
> >  	};
> >
> >  	chosen {
> > @@ -132,6 +132,10 @@ mt35xu02g0: flash@0 {
> >  	};
> >  };
> >
> > +&ftm_alarm1 {
> > +	status =3D "okay";
> > +};
> > +
> >  &i2c0 {
> >  	status =3D "okay";
> >
> > diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
> > b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
> > index 9efcaf68578c..ef9d17df2afa 100644
> > --- a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
> > +++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
> > @@ -1198,6 +1198,15 @@ ftm_alarm0: timer@2800000 {
> >  			reg =3D <0x0 0x2800000 0x0 0x10000>;
> >  			fsl,rcpm-wakeup =3D <&rcpm 0x0 0x0 0x0 0x0 0x4000
> 0x0 0x0>;
> >  			interrupts =3D <GIC_SPI 44 IRQ_TYPE_LEVEL_HIGH>;
> > +			status =3D "disabled";
> > +		};
> > +
> > +		ftm_alarm1: timer@2810000 {
> > +			compatible =3D "fsl,ls1028a-ftm-alarm";
> > +			reg =3D <0x0 0x2810000 0x0 0x10000>;
> > +			fsl,rcpm-wakeup =3D <&rcpm 0x0 0x0 0x0 0x0 0x4000
> 0x0 0x0>;
> > +			interrupts =3D <GIC_SPI 45 IRQ_TYPE_LEVEL_HIGH>;
> > +			status =3D "disabled";
> >  		};
> >  	};
> >
> > --
> > 2.25.1
> >
