Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77756473E18
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 09:14:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231769AbhLNIOr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 03:14:47 -0500
Received: from mail-eopbgr80050.outbound.protection.outlook.com ([40.107.8.50]:34110
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229565AbhLNIOq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 03:14:46 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VGjEEpimPLRbbaHD9pDdwFpABoIaGzn7HIzKTc98qUMXL6gvuWCQpWln35YmgIG1CFO5Iv2IRVp77n/7GSiL4K4neXGzd8t/GlBPte2Lx2lFAHRIvNXRQNe2hiVRB+sBIqT2J/3rnhaMc3h9TQ28MKqG26WlYaiVxcbDkNvQOCyXTULR7s0eVrGiOZT1Q3m0q9sfkTX1FQdoDk9qsGiKJ61wYbvJJTODLEuKMEEYcMW5Uiqr01aV3At5JFOm/VPUeNpgtcz6E/VjIQqy5f8QvySycmiYDeBetQt2cuaBxYZsIplEGzYgj03AVSfREvuGSGmd/mQrKoD4SdlBN59bnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x9UAP+2ds0eGNFyubrpm1PdS8SCmBnojUMFX2oUttac=;
 b=cH2ID4jGj3xbJ1GORjvbQKxAND3n4dJldxwvoFSxZZRrtFIycZOI9VRD4VJA5lm2fplfIOnVHD6EOsS4GGnVLQ9Fq2p3VHBm1oCjrxo/3f3vXHRemtP39HC//g5/oWqdxFffA3/2pL/oj1DCMwNgMkPEC5oPJfOfEffUiFsFH79c3zId+MWNKWLUWsh6gtdXBmTVEPyYHkw21tx15tnavCmBjNq+8IjCzwl/+H5CTKnAMz49P6AB8UPadhII5/7spJXhYPlxXqRLcxU97S1cXpoqBDIZAZrbGh/4bnYJBVEn1Z3mzhkQ55hU59E5Epiu7u6ACxN69AjxVBxOW5wg5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x9UAP+2ds0eGNFyubrpm1PdS8SCmBnojUMFX2oUttac=;
 b=lxJVSkV91tjjjm+8gOFtPC2HjRpxzf5nhK1QiMitiiY1ri/X+bFGuRcr/pqn6R9XFN8UZ5vCpjW5vPCt7JtiqdCqj4jnm/9x/xPe/ilw/zAzzZMsTdzwl8dRWnzg/2HC55UYn5mtaEVZhXpSB2EojeEgjWlcifGH7DQzlBRdqLM=
Received: from AS8PR04MB8946.eurprd04.prod.outlook.com (2603:10a6:20b:42d::18)
 by AS8PR04MB8644.eurprd04.prod.outlook.com (2603:10a6:20b:42b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.17; Tue, 14 Dec
 2021 08:14:44 +0000
Received: from AS8PR04MB8946.eurprd04.prod.outlook.com
 ([fe80::60be:d568:a436:894b]) by AS8PR04MB8946.eurprd04.prod.outlook.com
 ([fe80::60be:d568:a436:894b%7]) with mapi id 15.20.4778.014; Tue, 14 Dec 2021
 08:14:44 +0000
From:   Leo Li <leoyang.li@nxp.com>
To:     Shawn Guo <shawnguo@kernel.org>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Alexandru Marginean <alexandru.marginean@nxp.com>,
        Ioana Ciornei <ioana.ciornei@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Jason Liu <jason.hui.liu@nxp.com>,
        Vladimir Oltean <vladimir.oltean@nxp.com>
Subject: RE: [PATCH v2 8/8] arm64: dts: ls1028a-qds: add overlays for various
 serdes protocols
Thread-Topic: [PATCH v2 8/8] arm64: dts: ls1028a-qds: add overlays for various
 serdes protocols
Thread-Index: AQHX6KRRJiIFQ0chz0mhKE+FNdjEzawxpTAAgAAN7mA=
Date:   Tue, 14 Dec 2021 08:14:44 +0000
Message-ID: <AS8PR04MB8946F30662DF917775B64DA98F759@AS8PR04MB8946.eurprd04.prod.outlook.com>
References: <20211204001718.8511-1-leoyang.li@nxp.com>
 <20211204001718.8511-9-leoyang.li@nxp.com> <20211214072139.GA13828@dragon>
In-Reply-To: <20211214072139.GA13828@dragon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bd51d104-403f-45b9-45ed-08d9bed9c991
x-ms-traffictypediagnostic: AS8PR04MB8644:EE_
x-microsoft-antispam-prvs: <AS8PR04MB86449B0A38589FB780C7F9648F759@AS8PR04MB8644.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DOMCrdVkPaKKKKocoqInW8aYfie2Pa/FGI4MyysZzGTnya+JozEZPnQuBUdAcdRYy7SmmfzXitGfX7gBMCcOo+Ebdz9fxWz3iXjsbNmRIq+C4JZJ0UKm3BkDrbdg9PCG5xeRnMyGke6z4/ftANK9QGu0N4dFmfbATt4SP/qoIv771d/eD3sSxvCbzZQGuJwktM6hWkaoldCDfHkvq9yFLCaEMyTyA7Wk5kasejYWnNHb/GoQ/e4bwYIFThxP69PXj5IxWIIEvk8TBig5f9iuu1cJ2yXfbJRhoSae0pz+5kbxXPEdd3zDU24bUqwM1fCUW3LAdZHJzM9HqEvCl9NFLgngNXrL1QsiUFAi7q5RWtdgMrgHWAAXhLMrIU9qnnHIRY2YDyZYGpHepGlLPnq6O5lu05CNPIM01/BeOlREnnEPQMNQ63UAcOSolfx9CZrEYeMTMLxPJFs4H73P2wSAMRe+CFhP/vXOTgtHM/WtflFLZ1YsNII6t8D7PLbFxgmvQ6sehySLLl7b11yHnka4OYEk9aCYXwaOMD0+KfD1Ybzn4utInmtDxWLlJ9Y3EMT69c64ypsosr+o/r6/ND1p18slDATzyhhXNxwrFLgDFV5ta7PlFWwDb9umrKt0G1fN5Oo0JLe5qJhQ0Lu39ZxQxU+6dJZNyJUiuGGqVpMdAmcHSQCxNbZSKCqC+emvsNqnfcDLNgDiuAB4jZIY60GGtA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8946.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(4326008)(86362001)(316002)(2906002)(9686003)(33656002)(5660300002)(52536014)(54906003)(38100700002)(38070700005)(66946007)(122000001)(186003)(55016003)(66556008)(64756008)(66446008)(66476007)(508600001)(76116006)(7696005)(8936002)(26005)(6506007)(71200400001)(8676002)(6916009)(53546011)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?N0flee+BN0AoX5KXSxF9/rXpOGr7+g+6ia3tpLvbouz4/PiUEg2Zdafex9Po?=
 =?us-ascii?Q?/fLMF3PPPi5ndyuSixHEmjslSreCeYu5kK3VgraL0wR3itDBGgy1NixK6kGq?=
 =?us-ascii?Q?vNeaX6u0Q8BbGEsa/gX4vz4qxEMks8urgfi7UQ4YYGuVk+OAatNzx1/Fir3b?=
 =?us-ascii?Q?GMXl+2DFCL4CN7hToLYLWK+HJFWICyQVXvKg5ah/9QZAfx/GZMgUtPI+jCp9?=
 =?us-ascii?Q?z/vKqfkwmtwSpBjGSm/Ka7sJFWhM11EK5XFdHtdPLL07RdIOlsUxbFOR688a?=
 =?us-ascii?Q?T/I1kc6RTwmGV0lCuNhKJwn5hObgYhb8f7TIDY2Xll9OhSNzXG7HjCfNgsKz?=
 =?us-ascii?Q?Kqt20DL1roBlJwrVyJHMIfwNKuTPKaLNywWcVOsaVuGHcy/LjqU9KdAvrmHF?=
 =?us-ascii?Q?/9KCiynru/VMMQ2sF3kLnY4fYz6yoIE4fRqjTb6GiAUt1NgzImXg3OyESUAT?=
 =?us-ascii?Q?bCM4dHwh1/v2vupVJpp2cohH2CnXywhEjNrZ3jEgLtpG3I/Sr5PpC4Wl2afX?=
 =?us-ascii?Q?1ZBJrdqYUrogHEBwZ2ClryEEqD4MZrBIxIZiyzGosZNfzwkWBzKCZ4m0QD5w?=
 =?us-ascii?Q?Y0Jlxyi+ouD85xIwbBrSz2arTnaMNKO/prHmiRLkskqGVuZP8wP1arKsq+uz?=
 =?us-ascii?Q?ZQC5zVQi/wsMWfx4L37kEHRgGyaVfQyNTLAmaOlHHNwCXRISJ8c6DBkOBlVR?=
 =?us-ascii?Q?EsKEckIPV+Muhu/YnjZxYymZo0rD3Z5X7jhVcte1Xbcjd+dw4U9S04x2/vBe?=
 =?us-ascii?Q?6H2vYjd92yuDPEedfer40lGFrtv7fpeTm86F4NEGaAuC923laf97GHaV4pc8?=
 =?us-ascii?Q?xu7/SDxE4bV0IoMinVthihVA9ke7dyziNJELw0PGPo5TPDaqOiY1puTi5IQ/?=
 =?us-ascii?Q?JHW2TAgKY+M47uwkKT5uxcNOKGtp6udJdTSGcKaZProNTsuiElMt8IlPQvS/?=
 =?us-ascii?Q?XRnyM5/oqavzLcc2MqK+mImuz0S6krJfV3sNkBFSWVVPq5hx/ilqWZa/ahxK?=
 =?us-ascii?Q?4SgLx1F62Ypq2asbw99PR4ntjp7txSBVM3+oFefC+TzXnxeTxVHfcB0tLvZW?=
 =?us-ascii?Q?w5PGtYvLBCh9rPAgJiCDHoV7ONbA00JLS6AUTcGQnUfw0P6cwBms9fUsQ50i?=
 =?us-ascii?Q?RRu5suK3tupNMpHPGxyV9JOd7Jn6reJ19TPz4HpJgyaiH3bS7OQ0UZ5GiZTu?=
 =?us-ascii?Q?cj3sgRQ3MQhcIHn/AWuis8HxyM1xEA2+gKCnN4YWiNQSaQfFMoPGE7h8Lu2P?=
 =?us-ascii?Q?n06JwX8NfS0YmUQrji4fVTSjFCbVcMFiM3bdWtayJ3d/Pgowq6u1JJ57jDze?=
 =?us-ascii?Q?TRrNVnlFIBjyHNqGX/SsyIDZ1vNWTUh4S94linBlkYELHmdrTqgBJLfdG0XI?=
 =?us-ascii?Q?OPxJA7YM/acnFov4To++ixb/AI9eGesvY/5Bg9YncDikvcdshgUdJepEVQCf?=
 =?us-ascii?Q?Up8Vm+5KaOakdvGboKDamZs9X4sUQjOJZm+KDJuAW+sJq3GiJl2pKBhwCKyn?=
 =?us-ascii?Q?92LwpzYxwO79yiEaGw9GT+H4IlLEk+073wcRMohyGUYBmDs+Vgkv9hmX6SB9?=
 =?us-ascii?Q?49XtLoRAX0SK+GvgMx5Hwxzia0lHMxxEi4Mx0mHpuIzxhW//XBx3Bak9HZse?=
 =?us-ascii?Q?Zg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8946.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd51d104-403f-45b9-45ed-08d9bed9c991
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Dec 2021 08:14:44.7113
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: x3lqP2oY2z2al0aZTkEL4sdlL6j7M7LeyjKiwE8DfAkeSZqRenJnsMYmVoE5Ac6Z9Ng3QPELcOykOZtjTzsQwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8644
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Shawn Guo <shawnguo@kernel.org>
> Sent: Tuesday, December 14, 2021 3:22 PM
> To: Leo Li <leoyang.li@nxp.com>
> Cc: linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org;
> Alexandru Marginean <alexandru.marginean@nxp.com>; Ioana Ciornei
> <ioana.ciornei@nxp.com>; Aisheng Dong <aisheng.dong@nxp.com>; Jason
> Liu <jason.hui.liu@nxp.com>; Vladimir Oltean <vladimir.oltean@nxp.com>
> Subject: Re: [PATCH v2 8/8] arm64: dts: ls1028a-qds: add overlays for var=
ious
> serdes protocols
>=20
> On Fri, Dec 03, 2021 at 06:17:18PM -0600, Li Yang wrote:
> > From: Alex Marginean <alexandru.marginean@nxp.com>
> >

[snip]

> > diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a-qds-9999.dts
> > b/arch/arm64/boot/dts/freescale/fsl-ls1028a-qds-9999.dts
> > new file mode 100644
> > index 000000000000..1ef743c48e84
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a-qds-9999.dts
> > @@ -0,0 +1,79 @@
> > +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> > +/*
> > + * Device Tree fragment for LS1028A QDS board, serdes 85xx
> > + *
> > + * Copyright 2019-2021 NXP
> > + *
> > + * Requires a LS1028A QDS board without lane B rework.
> > + * Requires a SCH-24801 card in slot 1.
> > + */
> > +
> > +/dts-v1/;
> > +/plugin/;
> > +
> > +/ {
> > +	fragment@0 {
>=20
> Is fragment0 more appropriate maybe, as @unit-address requires a
> corresponding 'reg' property?

Not sure if the overlay framework will use the index information somehow, b=
ut this is how it is demonstrated in the Documentation/devicetree/overlay-n=
otes.rst document.

Regards,
Leo
