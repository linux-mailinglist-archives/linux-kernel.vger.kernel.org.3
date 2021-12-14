Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46620473D08
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 07:14:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230359AbhLNGOU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 01:14:20 -0500
Received: from mail-eopbgr10067.outbound.protection.outlook.com ([40.107.1.67]:12600
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230334AbhLNGOU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 01:14:20 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fnJ+gqjA1xNCOqTH7NMZfxwmRaUhhFfrhQC8XKgG6DM/bO2GmfDKEC5u1T0lsjgSRtp4iBN+tZemLoQQpzA9zR2d3NsCupCDWc6cQZUGdx1RYeOkrY92MTy2fgjm2zwt1UTxiOvYz1qatIM4l2ODP3Lv6jpHz4/IetxGLCmGbtJYDUhf1NzJxuVJelxrCCzxFnxkUaC6YnQ1vXIH1Cp8kFdhQQdXJH6c7Ylin+wZUP4SVPewKU+Dfdq5P9Gdpm0QRyLpsdxsioMJZ8EK5F5FV1iLMkNXG/vlo58MTlZ9ZoDHkhPoh6grKtZt7eGXEGbGaOoQ15gofJwuzssEfVXiJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ACaAp7hN52uM82rTpZWHM1+HWo8O3G6ryi7wdHLWEi4=;
 b=LLT3FOcEIl7dd0dyoKhir6nm4Vw7mZan91VKjaJ+ojAGGGun71bwZJt5iNlpEpF7zaIlUaDr6/mi1DuUrg4r9jkdg4cflP/fex8agY2q9E0SRJE8ZasfQ0U8PEx75wzwv/FWHR0+/it8Qc72VroYw6M+6mKRi/rfqMEntZi6H4OpZR/Zt82lwhGSYTHL6Jf+/LPzHQyznHarRwGjb0UDDaXM0k9PQxK3LKy9/fCHu2INgjcT3/ejjbDCkb6xqy+aF9MVlIw9A3tt+2af799EwG5Yy5f0c3MF4i3ghviioEZD5ywqyXjW4lTkdzBXkuCnz4dKyHKhpFv7wKfeV8rvSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ACaAp7hN52uM82rTpZWHM1+HWo8O3G6ryi7wdHLWEi4=;
 b=HeKwAUshMlGv6nCkYJ3Ty93q/q2kZ4DWuU/Ea5vwX49hclyUlgaEGuRp7+IF5O8wyLkyBY2yLnjlXOqEajkoFIUXC3p3EeJLUuiQNtbAYSZnTEFylOjP/YKyA+u4f65FFFdtA6tQAl4yGzJfLbKfpsqSuru1VBf2FO62po8fu9M=
Received: from AS8PR04MB8946.eurprd04.prod.outlook.com (2603:10a6:20b:42d::18)
 by AS8PR04MB9048.eurprd04.prod.outlook.com (2603:10a6:20b:443::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.14; Tue, 14 Dec
 2021 06:14:15 +0000
Received: from AS8PR04MB8946.eurprd04.prod.outlook.com
 ([fe80::60be:d568:a436:894b]) by AS8PR04MB8946.eurprd04.prod.outlook.com
 ([fe80::60be:d568:a436:894b%7]) with mapi id 15.20.4778.014; Tue, 14 Dec 2021
 06:14:15 +0000
From:   Leo Li <leoyang.li@nxp.com>
To:     Shawn Guo <shawnguo@kernel.org>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Z.Q. Hou" <zhiqiang.hou@nxp.com>
Subject: RE: [PATCH v2 05/10] arm64: dts: lx2160a: update PCIe nodes to match
 rev2 silicon
Thread-Topic: [PATCH v2 05/10] arm64: dts: lx2160a: update PCIe nodes to match
 rev2 silicon
Thread-Index: AQHX6KEth0HDASXH80KCgfcGBfWjt6wxiL4AgAAJCEA=
Date:   Tue, 14 Dec 2021 06:14:14 +0000
Message-ID: <AS8PR04MB8946759AAABD8760BA9A227C8F759@AS8PR04MB8946.eurprd04.prod.outlook.com>
References: <20211203235446.8266-1-leoyang.li@nxp.com>
 <20211203235446.8266-6-leoyang.li@nxp.com> <20211214053945.GF10916@dragon>
In-Reply-To: <20211214053945.GF10916@dragon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 15263d72-00a3-4520-2734-08d9bec8f44e
x-ms-traffictypediagnostic: AS8PR04MB9048:EE_
x-microsoft-antispam-prvs: <AS8PR04MB90489B7B1509D445C6B9BB9A8F759@AS8PR04MB9048.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1xY/bSdI2aTCCNMr+ZEqX9VqE0m/VPRUZJ/MxRJag6j5h31H4Eij9U8frQfpj4lRPJ3DKdbbhl6StQR7NIA9in6hZYEZ17mxprOtzGHXCBmWVQnS0+SCCwTsUpaanL0ytQA4arWxA0d4nA80T2JUhH8by3mcB0ZFnHvxbZct7Q3SJECuyDXNcreOVstqtQ2/vWR3d3IHnWYiJLDwbvTya0jiyzyvdh5aHAsH2tzFnltcg5HzQJ6mdb/2M9Nrq1G5iww5o0NYJKJT2ITmbVUBuTAfCxtth8hhRzRyrqfzG6xb82W7fwDin3gmJf1npdpy0FYk8vLvujlR3U4HOXpyAotdvNek07mRXLNsplS/YRXXPzJKrFzCuGTIzqRjO84oddYrGS+z5wR4GCy1uq1AWSi7qMMlVwXb7geqLe6Vrrs/HJ2zfLOHfgI8GEcSGbzqmvMKnKeOv1Vg2VCWOpPqSaYF2gOvZnN2z61ogDAGGLEFnnLUlvWljqzhZw2sFfCesyrI3RoLUcgUAu/2bzb5Fx8JXMpKHlLZ39Jdcr3Tum7/nASSxeBN9+h+n+dDwnLVQoM2O0Rp9iwnJ/P+ZeCGpSCSg3HzY+igEQVCSw8s93q6XoptdhNicaMtrv4nWHlGqUiQwocI7T6AZpY/g4QtiLUCDlQ8GBwFimO6sJv/JS60wMWfgbZYNh+X+KBVzMdoB9b4IDllyB80WUNdvfBvHQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8946.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(53546011)(86362001)(15650500001)(7696005)(2906002)(316002)(33656002)(54906003)(6506007)(38100700002)(83380400001)(4326008)(9686003)(122000001)(26005)(30864003)(6916009)(52536014)(76116006)(66946007)(66446008)(38070700005)(64756008)(66476007)(66556008)(8676002)(8936002)(55016003)(5660300002)(508600001)(71200400001)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?CCvKfsXIOHKi8TXuFGkoO24lR2fIz3G423wjuxVj6U5G6VaNby/4ogPSvQde?=
 =?us-ascii?Q?ZeB4FqGxHbkPJ0wIA3Hi3fV8kdidwH3exQEAxQRSnpYFbziRUAb9qC9PMdjY?=
 =?us-ascii?Q?1Y4GbTXYAFVEmSg4FAuCsDrf0jqWz4r0I/PzzZ1pMVRVx0EVOoLJ2E4j5dtH?=
 =?us-ascii?Q?tdpJ3rFSsfAtKEiJhgWVt6nMxaU1/bZ8AVTPGSxnpQX8o14ScwlxBfhYOQfv?=
 =?us-ascii?Q?FodBovzyrOXKhvYupFVEsKVaKXYbjZGNQegz5gjJxE2M4TAN9u4Ku6DhDsEM?=
 =?us-ascii?Q?sp2ZNOP6BqUfkCgkV2IbAaMrlTNgCGWXVUM8x2LmqpGOQDiYLmE8rnM3xdRr?=
 =?us-ascii?Q?cuLL2EjQjOMQBpgjw5aB5WjIf69rA5zU3+IR6b2vsIpCnRtmQlL3sAKwtCBS?=
 =?us-ascii?Q?jq1G8JFrImRdjePwpbsuHQu0qsaHJd6iiqe1ycTMzQfF/JGqkU2/rg6tp4Xi?=
 =?us-ascii?Q?gM7Nl7zHyP6LLVgc4F8t+oqzzbVyuTLwtoqS+duWyieoWvmK0Nc+CJRWZo8U?=
 =?us-ascii?Q?Sm2GifpNgpnfQkfPrX9MZL+OIJHn3cm9xhr+H+TK+YlYU6SZ+JP/gDHoppo3?=
 =?us-ascii?Q?R8sf3sY4RI7iPGgZuZvaBNfLOKuHO9753G83ZYhHHVLQ7nZVuJMH75bnIeCQ?=
 =?us-ascii?Q?ReecBtuNwI11i8laDxGmQCb7bWyPin8iXAqIAbICNVioyIrTz2VxdjSLHDlE?=
 =?us-ascii?Q?R6p9MwaicQQFIcXnrGznyqyk2BiIKJOb27WGHlsBcN6rPUFDxMXHoDeVv/5m?=
 =?us-ascii?Q?7qyOdeSHBHya41M4PatyyBr5ZlwlE7JUg3B67BtvWZ5BbTr5u6eMRti7uZvo?=
 =?us-ascii?Q?8Ao3/a0vac24J4YaNEZXa+WJcT0uo75ouCSNdg7SyNa1KZyC8YKqawdFfM3L?=
 =?us-ascii?Q?wEh++j2pSQYFGQJnYTQvmAgsXBLDkhnoY34H9kQp7exiokcKNu7NBFrOATGR?=
 =?us-ascii?Q?aSoMz0nXNi9I8uL6CHORh3J+tCkhfW9Vq537rXUpKauPITX1ZHkr+mydImi5?=
 =?us-ascii?Q?qEwkJGWCeN97ugXyvMnqWv/YWCwsBgOWewHBpEnqhEuKMRW8rOZGyww30ILy?=
 =?us-ascii?Q?Jzauv47rc9BA1gLYR4NxETimwl0BjC1ZLQZY1wViKEPG/S+ftfTFadtS7Fc2?=
 =?us-ascii?Q?yuELUO1kPKIXrRFRDP19t/ZMzEfz9445eX1NP0GwGBzwRbi58Q64zSLO4Fc4?=
 =?us-ascii?Q?DGch+uqPdOl8w/vRSEQFAUTTh3OG9l23q7yqAyAFwnGvYmvXUXm1rIVMG5x+?=
 =?us-ascii?Q?y2ye/jgSUT1Fb8xH8SX3gKiK/X088BBVfDcbxqpjl1pBtUbiUKO2ke32rr5f?=
 =?us-ascii?Q?PLHPqrL9F4/L7vH5SA1HKa6R2PPqKP/iNtDmKUxSk+yx4GdpElI8SbYMHPp+?=
 =?us-ascii?Q?zCh00Kp4l/jduCBVjZ2g+hpbiWkVE+FfxA4Ww406SywuUfhDjvoiCva2yuxp?=
 =?us-ascii?Q?oTYZ9M2c8ELp9tFrqhpH0hFfx6CXhvqy59VmPYLhoZiG08dW+YUYCuFeMZ6s?=
 =?us-ascii?Q?Dhim76ug3Cahqz9T0Y10OJOzSPCzMKKZJqDjVOgkR7zeJdhzaY7QrH38Wvh2?=
 =?us-ascii?Q?N0raXkPR0l29a8djh2NWhVjWgcnfOybiW6LomP1OHEYbAEAvAcVqwoyo2SbL?=
 =?us-ascii?Q?Tg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8946.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15263d72-00a3-4520-2734-08d9bec8f44e
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Dec 2021 06:14:14.9771
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kI5kcnE4O53EAgzGR6bUHuyVWKj0ChlTt+/2xs3QIlWqbWmsDoZGCJAyfdtOoGgfg4Ypxovb/BkkNB3AhWGVlw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9048
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Shawn Guo <shawnguo@kernel.org>
> Sent: Tuesday, December 14, 2021 1:40 PM
> To: Leo Li <leoyang.li@nxp.com>
> Cc: linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org; Z=
.Q.
> Hou <zhiqiang.hou@nxp.com>
> Subject: Re: [PATCH v2 05/10] arm64: dts: lx2160a: update PCIe nodes to
> match rev2 silicon
>=20
> On Fri, Dec 03, 2021 at 05:54:41PM -0600, Li Yang wrote:
> > The original dts was created based on the non-production rev1 silicon
> > which was only used for evaluation.  Update the PCIe nodes to align
> > with the different controller used in production rev2 silicon.
> >
> > Signed-off-by: Li Yang <leoyang.li@nxp.com>
> > Reviewed-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> > ---
> >  .../arm64/boot/dts/freescale/fsl-lx2160a.dtsi | 96
> > +++++++++----------
> >  1 file changed, 48 insertions(+), 48 deletions(-)
> >
> > diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
> > b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
> > index fcde09f36018..de680521e1d1 100644
> > --- a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
> > +++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
> > @@ -1088,10 +1088,10 @@ sata3: sata@3230000 {
> >  		};
> >
> >  		pcie1: pcie@3400000 {
> > -			compatible =3D "fsl,lx2160a-pcie";
>=20
> Drop lx2160a specific compatible for lx2160a SoC?

The lx2160a compatible was defined with the rev1.  We will need to create a=
 new rev2 compatible if we want to keep the soc specific compatible.

>=20
> Shawn
>=20
> > -			reg =3D <0x00 0x03400000 0x0 0x00100000>, /*
> controller registers */
> > -			      <0x80 0x00000000 0x0 0x00002000>; /*
> configuration space */
> > -			reg-names =3D "csr_axi_slave", "config_axi_slave";
> > +			compatible =3D "fsl,ls2088a-pcie";
> > +			reg =3D <0x00 0x03400000 0x0 0x00100000   /* controller
> registers */
> > +			       0x80 0x00000000 0x0 0x00002000>; /*
> configuration space */
> > +			reg-names =3D "regs", "config";
> >  			interrupts =3D <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>,
> /* AER interrupt */
> >  				     <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>, /*
> PME interrupt */
> >  				     <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>; /*
> controller interrupt
> > */ @@ -1100,26 +1100,26 @@ pcie1: pcie@3400000 {
> >  			#size-cells =3D <2>;
> >  			device_type =3D "pci";
> >  			dma-coherent;
> > -			apio-wins =3D <8>;
> > -			ppio-wins =3D <8>;
> > +			num-viewport =3D <8>;
> >  			bus-range =3D <0x0 0xff>;
> > -			ranges =3D <0x82000000 0x0 0x40000000 0x80
> 0x40000000 0x0 0x40000000>; /* non-prefetchable memory */
> > +			ranges =3D <0x81000000 0x0 0x00000000 0x80
> 0x00010000 0x0 0x00010000
> > +				  0x82000000 0x0 0x40000000 0x80 0x40000000
> 0x0 0x40000000>; /*
> > +non-prefetchable memory */
> >  			msi-parent =3D <&its>;
> > +			iommu-map =3D <0 &smmu 0 1>; /* This is fixed-up by
> u-boot */
> >  			#interrupt-cells =3D <1>;
> >  			interrupt-map-mask =3D <0 0 0 7>;
> >  			interrupt-map =3D <0000 0 0 1 &gic 0 0 GIC_SPI 109
> IRQ_TYPE_LEVEL_HIGH>,
> >  					<0000 0 0 2 &gic 0 0 GIC_SPI 110
> IRQ_TYPE_LEVEL_HIGH>,
> >  					<0000 0 0 3 &gic 0 0 GIC_SPI 111
> IRQ_TYPE_LEVEL_HIGH>,
> >  					<0000 0 0 4 &gic 0 0 GIC_SPI 112
> IRQ_TYPE_LEVEL_HIGH>;
> > -			iommu-map =3D <0 &smmu 0 1>; /* Fixed-up by
> bootloader */
> >  			status =3D "disabled";
> >  		};
> >
> >  		pcie2: pcie@3500000 {
> > -			compatible =3D "fsl,lx2160a-pcie";
> > -			reg =3D <0x00 0x03500000 0x0 0x00100000>, /*
> controller registers */
> > -			      <0x88 0x00000000 0x0 0x00002000>; /*
> configuration space */
> > -			reg-names =3D "csr_axi_slave", "config_axi_slave";
> > +			compatible =3D "fsl,ls2088a-pcie";
> > +			reg =3D <0x00 0x03500000 0x0 0x00100000   /* controller
> registers */
> > +			       0x88 0x00000000 0x0 0x00002000>; /*
> configuration space */
> > +			reg-names =3D "regs", "config";
> >  			interrupts =3D <GIC_SPI 113 IRQ_TYPE_LEVEL_HIGH>,
> /* AER interrupt */
> >  				     <GIC_SPI 113 IRQ_TYPE_LEVEL_HIGH>, /*
> PME interrupt */
> >  				     <GIC_SPI 113 IRQ_TYPE_LEVEL_HIGH>; /*
> controller interrupt
> > */ @@ -1128,26 +1128,26 @@ pcie2: pcie@3500000 {
> >  			#size-cells =3D <2>;
> >  			device_type =3D "pci";
> >  			dma-coherent;
> > -			apio-wins =3D <8>;
> > -			ppio-wins =3D <8>;
> > +			num-viewport =3D <8>;
> >  			bus-range =3D <0x0 0xff>;
> > -			ranges =3D <0x82000000 0x0 0x40000000 0x88
> 0x40000000 0x0 0x40000000>; /* non-prefetchable memory */
> > +			ranges =3D <0x81000000 0x0 0x00000000 0x88
> 0x00010000 0x0 0x00010000
> > +				  0x82000000 0x0 0x40000000 0x88 0x40000000
> 0x0 0x40000000>; /*
> > +non-prefetchable memory */
> >  			msi-parent =3D <&its>;
> > +			iommu-map =3D <0 &smmu 0 1>; /* This is fixed-up by
> u-boot */
> >  			#interrupt-cells =3D <1>;
> >  			interrupt-map-mask =3D <0 0 0 7>;
> >  			interrupt-map =3D <0000 0 0 1 &gic 0 0 GIC_SPI 114
> IRQ_TYPE_LEVEL_HIGH>,
> >  					<0000 0 0 2 &gic 0 0 GIC_SPI 115
> IRQ_TYPE_LEVEL_HIGH>,
> >  					<0000 0 0 3 &gic 0 0 GIC_SPI 116
> IRQ_TYPE_LEVEL_HIGH>,
> >  					<0000 0 0 4 &gic 0 0 GIC_SPI 117
> IRQ_TYPE_LEVEL_HIGH>;
> > -			iommu-map =3D <0 &smmu 0 1>; /* Fixed-up by
> bootloader */
> >  			status =3D "disabled";
> >  		};
> >
> >  		pcie3: pcie@3600000 {
> > -			compatible =3D "fsl,lx2160a-pcie";
> > -			reg =3D <0x00 0x03600000 0x0 0x00100000>, /*
> controller registers */
> > -			      <0x90 0x00000000 0x0 0x00002000>; /*
> configuration space */
> > -			reg-names =3D "csr_axi_slave", "config_axi_slave";
> > +			compatible =3D "fsl,ls2088a-pcie";
> > +			reg =3D <0x00 0x03600000 0x0 0x00100000   /* controller
> registers */
> > +			       0x90 0x00000000 0x0 0x00002000>; /*
> configuration space */
> > +			reg-names =3D "regs", "config";
> >  			interrupts =3D <GIC_SPI 118 IRQ_TYPE_LEVEL_HIGH>,
> /* AER interrupt */
> >  				     <GIC_SPI 118 IRQ_TYPE_LEVEL_HIGH>, /*
> PME interrupt */
> >  				     <GIC_SPI 118 IRQ_TYPE_LEVEL_HIGH>; /*
> controller interrupt
> > */ @@ -1156,26 +1156,26 @@ pcie3: pcie@3600000 {
> >  			#size-cells =3D <2>;
> >  			device_type =3D "pci";
> >  			dma-coherent;
> > -			apio-wins =3D <256>;
> > -			ppio-wins =3D <24>;
> > +			num-viewport =3D <256>;
> >  			bus-range =3D <0x0 0xff>;
> > -			ranges =3D <0x82000000 0x0 0x40000000 0x90
> 0x40000000 0x0 0x40000000>; /* non-prefetchable memory */
> > +			ranges =3D <0x81000000 0x0 0x00000000 0x90
> 0x00010000 0x0 0x00010000
> > +				  0x82000000 0x0 0x40000000 0x90 0x40000000
> 0x0 0x40000000>; /*
> > +non-prefetchable memory */
> >  			msi-parent =3D <&its>;
> > +			iommu-map =3D <0 &smmu 0 1>; /* This is fixed-up by
> u-boot */
> >  			#interrupt-cells =3D <1>;
> >  			interrupt-map-mask =3D <0 0 0 7>;
> >  			interrupt-map =3D <0000 0 0 1 &gic 0 0 GIC_SPI 119
> IRQ_TYPE_LEVEL_HIGH>,
> >  					<0000 0 0 2 &gic 0 0 GIC_SPI 120
> IRQ_TYPE_LEVEL_HIGH>,
> >  					<0000 0 0 3 &gic 0 0 GIC_SPI 121
> IRQ_TYPE_LEVEL_HIGH>,
> >  					<0000 0 0 4 &gic 0 0 GIC_SPI 122
> IRQ_TYPE_LEVEL_HIGH>;
> > -			iommu-map =3D <0 &smmu 0 1>; /* Fixed-up by
> bootloader */
> >  			status =3D "disabled";
> >  		};
> >
> >  		pcie4: pcie@3700000 {
> > -			compatible =3D "fsl,lx2160a-pcie";
> > -			reg =3D <0x00 0x03700000 0x0 0x00100000>, /*
> controller registers */
> > -			      <0x98 0x00000000 0x0 0x00002000>; /*
> configuration space */
> > -			reg-names =3D "csr_axi_slave", "config_axi_slave";
> > +			compatible =3D "fsl,ls2088a-pcie";
> > +			reg =3D <0x00 0x03700000 0x0 0x00100000   /* controller
> registers */
> > +			       0x98 0x00000000 0x0 0x00002000>; /*
> configuration space */
> > +			reg-names =3D "regs", "config";
> >  			interrupts =3D <GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>,
> /* AER interrupt */
> >  				     <GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>, /*
> PME interrupt */
> >  				     <GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>; /*
> controller interrupt
> > */ @@ -1184,26 +1184,26 @@ pcie4: pcie@3700000 {
> >  			#size-cells =3D <2>;
> >  			device_type =3D "pci";
> >  			dma-coherent;
> > -			apio-wins =3D <8>;
> > -			ppio-wins =3D <8>;
> > +			num-viewport =3D <8>;
> >  			bus-range =3D <0x0 0xff>;
> > -			ranges =3D <0x82000000 0x0 0x40000000 0x98
> 0x40000000 0x0 0x40000000>; /* non-prefetchable memory */
> > +			ranges =3D <0x81000000 0x0 0x00000000 0x98
> 0x00010000 0x0 0x00010000
> > +				  0x82000000 0x0 0x40000000 0x98 0x40000000
> 0x0 0x40000000>; /*
> > +non-prefetchable memory */
> >  			msi-parent =3D <&its>;
> > +			iommu-map =3D <0 &smmu 0 1>; /* This is fixed-up by
> u-boot */
> >  			#interrupt-cells =3D <1>;
> >  			interrupt-map-mask =3D <0 0 0 7>;
> >  			interrupt-map =3D <0000 0 0 1 &gic 0 0 GIC_SPI 124
> IRQ_TYPE_LEVEL_HIGH>,
> >  					<0000 0 0 2 &gic 0 0 GIC_SPI 125
> IRQ_TYPE_LEVEL_HIGH>,
> >  					<0000 0 0 3 &gic 0 0 GIC_SPI 126
> IRQ_TYPE_LEVEL_HIGH>,
> >  					<0000 0 0 4 &gic 0 0 GIC_SPI 127
> IRQ_TYPE_LEVEL_HIGH>;
> > -			iommu-map =3D <0 &smmu 0 1>; /* Fixed-up by
> bootloader */
> >  			status =3D "disabled";
> >  		};
> >
> >  		pcie5: pcie@3800000 {
> > -			compatible =3D "fsl,lx2160a-pcie";
> > -			reg =3D <0x00 0x03800000 0x0 0x00100000>, /*
> controller registers */
> > -			      <0xa0 0x00000000 0x0 0x00002000>; /*
> configuration space */
> > -			reg-names =3D "csr_axi_slave", "config_axi_slave";
> > +			compatible =3D "fsl,ls2088a-pcie";
> > +			reg =3D <0x00 0x03800000 0x0 0x00100000   /* controller
> registers */
> > +			       0xa0 0x00000000 0x0 0x00002000>; /*
> configuration space */
> > +			reg-names =3D "regs", "config";
> >  			interrupts =3D <GIC_SPI 128 IRQ_TYPE_LEVEL_HIGH>,
> /* AER interrupt */
> >  				     <GIC_SPI 128 IRQ_TYPE_LEVEL_HIGH>, /*
> PME interrupt */
> >  				     <GIC_SPI 128 IRQ_TYPE_LEVEL_HIGH>; /*
> controller interrupt
> > */ @@ -1212,26 +1212,26 @@ pcie5: pcie@3800000 {
> >  			#size-cells =3D <2>;
> >  			device_type =3D "pci";
> >  			dma-coherent;
> > -			apio-wins =3D <256>;
> > -			ppio-wins =3D <24>;
> > +			num-viewport =3D <256>;
> >  			bus-range =3D <0x0 0xff>;
> > -			ranges =3D <0x82000000 0x0 0x40000000 0xa0
> 0x40000000 0x0 0x40000000>; /* non-prefetchable memory */
> > +			ranges =3D <0x81000000 0x0 0x00000000 0xa0
> 0x00010000 0x0 0x00010000
> > +				  0x82000000 0x0 0x40000000 0xa0 0x40000000
> 0x0 0x40000000>; /*
> > +non-prefetchable memory */
> >  			msi-parent =3D <&its>;
> > +			iommu-map =3D <0 &smmu 0 1>; /* This is fixed-up by
> u-boot */
> >  			#interrupt-cells =3D <1>;
> >  			interrupt-map-mask =3D <0 0 0 7>;
> >  			interrupt-map =3D <0000 0 0 1 &gic 0 0 GIC_SPI 129
> IRQ_TYPE_LEVEL_HIGH>,
> >  					<0000 0 0 2 &gic 0 0 GIC_SPI 130
> IRQ_TYPE_LEVEL_HIGH>,
> >  					<0000 0 0 3 &gic 0 0 GIC_SPI 131
> IRQ_TYPE_LEVEL_HIGH>,
> >  					<0000 0 0 4 &gic 0 0 GIC_SPI 132
> IRQ_TYPE_LEVEL_HIGH>;
> > -			iommu-map =3D <0 &smmu 0 1>; /* Fixed-up by
> bootloader */
> >  			status =3D "disabled";
> >  		};
> >
> >  		pcie6: pcie@3900000 {
> > -			compatible =3D "fsl,lx2160a-pcie";
> > -			reg =3D <0x00 0x03900000 0x0 0x00100000>, /*
> controller registers */
> > -			      <0xa8 0x00000000 0x0 0x00002000>; /*
> configuration space */
> > -			reg-names =3D "csr_axi_slave", "config_axi_slave";
> > +			compatible =3D "fsl,ls2088a-pcie";
> > +			reg =3D <0x00 0x03900000 0x0 0x00100000   /* controller
> registers */
> > +			       0xa8 0x00000000 0x0 0x00002000>; /*
> configuration space */
> > +			reg-names =3D "regs", "config";
> >  			interrupts =3D <GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>,
> /* AER interrupt */
> >  				     <GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>, /*
> PME interrupt */
> >  				     <GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>; /*
> controller interrupt
> > */ @@ -1240,18 +1240,18 @@ pcie6: pcie@3900000 {
> >  			#size-cells =3D <2>;
> >  			device_type =3D "pci";
> >  			dma-coherent;
> > -			apio-wins =3D <8>;
> > -			ppio-wins =3D <8>;
> > +			num-viewport =3D <8>;
> >  			bus-range =3D <0x0 0xff>;
> > -			ranges =3D <0x82000000 0x0 0x40000000 0xa8
> 0x40000000 0x0 0x40000000>; /* non-prefetchable memory */
> > +			ranges =3D <0x81000000 0x0 0x00000000 0xa8
> 0x00010000 0x0 0x00010000
> > +				  0x82000000 0x0 0x40000000 0xa8 0x40000000
> 0x0 0x40000000>; /*
> > +non-prefetchable memory */
> >  			msi-parent =3D <&its>;
> > +			iommu-map =3D <0 &smmu 0 1>; /* This is fixed-up by
> u-boot */
> >  			#interrupt-cells =3D <1>;
> >  			interrupt-map-mask =3D <0 0 0 7>;
> >  			interrupt-map =3D <0000 0 0 1 &gic 0 0 GIC_SPI 104
> IRQ_TYPE_LEVEL_HIGH>,
> >  					<0000 0 0 2 &gic 0 0 GIC_SPI 105
> IRQ_TYPE_LEVEL_HIGH>,
> >  					<0000 0 0 3 &gic 0 0 GIC_SPI 106
> IRQ_TYPE_LEVEL_HIGH>,
> >  					<0000 0 0 4 &gic 0 0 GIC_SPI 107
> IRQ_TYPE_LEVEL_HIGH>;
> > -			iommu-map =3D <0 &smmu 0 1>; /* Fixed-up by
> bootloader */
> >  			status =3D "disabled";
> >  		};
> >
> > --
> > 2.25.1
> >
