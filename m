Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16D4A4B0E0F
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 14:03:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241902AbiBJNCe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 08:02:34 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241887AbiBJNCd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 08:02:33 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33DEB1015;
        Thu, 10 Feb 2022 05:02:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1644498151; x=1676034151;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=G3SBA2kkQJegcHrGhbyJt1kqYj7yJlav6b2lirki/+Q=;
  b=bflPwtL5sKHBgmK/HrO1OIheUICyk1I9w4+KZ7wrzhrWCXJaK3K76Ffm
   o5bMvm/fcs6L0IurzUMfxB4cehFvT+mxFP89IsbzCUtkItd4Mu8Hk8mJ7
   6XhjqnAg/KPE85YVXoti6hbRC0fZ11coGBfa2p9lyWu6XAHxsfemKDqDr
   DHgTzVnqDnV4FvC0oAizkWe+iyWYsPAKyLpF/PHjuXc0k3rPIVR50WiUk
   Pij5J1t77svT2Xbi3hmO/vVLh5/O24q1ofT8ZcNe8MaEwhY4rrHLzPkJV
   zUUWmdrEbZDYXNpbvP3nlNrge9zYHtCU0p6hzX1AOyVc8eb3gF9QKf9FD
   Q==;
IronPort-SDR: x3PTsmut0un4bpuO+6TSfPIqzUQuObxMq9W2lrsFJY+07xvnCYyE9iRyxKSUXn8rHKnVkRdcn/
 YMCq7/r54C8nVB2JlzsG4dSGUu/q6lDkC7WCw2lXSOPTrtfxag1oDkPwPU3gGB+aXJOGv9SGmC
 3cLkYPb7ypDwqQQjte3eBfWZDLPfWvYzBjd0CsVar6ASWcSl2r5Hf8Xctv+yKgrSycBMT3KE1K
 mJ/9Jze2OvcJycz+SmgeT2o+bDc70AJpeu6dkeJbl/+iGI2tjGSfxm1awCn+057PzP120YXGEe
 5udW/8kqPnv6QeFweEWgK3bS
X-IronPort-AV: E=Sophos;i="5.88,358,1635231600"; 
   d="scan'208";a="145529939"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 10 Feb 2022 06:02:29 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Thu, 10 Feb 2022 06:02:28 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17 via Frontend Transport; Thu, 10 Feb 2022 06:02:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZGG0eUgtpOPr4zVEvKg8tsRg6cw0gIbUOJNw60n23IGbr0VH7ScKqJOhw1dlMJ35qJVhEi9jxyNOJsllH5NGqdVz73pNANKs7rYdtJvSB6INku+Xl3hImMFEdhdMm7iURmX3IZuK+xWvVd9QAbFY0D3eI420ehCKI/CtHRugrg3eL/O/c7YxPtlvnIlhuZu5TorEnpd+XqlrlFRw0AwZVqVfe0Uf2ppSenq1+5bZgRUFrxsR+MRcKYBkOxS+4wDg79S5VICW9l7PJdaQns6EHLn+6DU+0amVkWCefMGzFDcoFOBV5xiiEuCECC+xAxU1I9kb3eMbb9oOl3mhCIp1YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6hTWJXdNcug+LoX8v2svy20LW/Azf4JRIEUMECWSQf8=;
 b=K7OnXxNFbmKN3X6XY229grJNIpe7I6uR9z2/1ZM0ucdbRvIefCGhemaef4K7TTB6TJzkVVsEJBxFK0fDaDB/GwQYMqQkUyTSRxnfZ5nIIaE56wjrK6tzE8mZTvBhoixXDca2ByeHCwkBS7uI7+23fIxN8AQG0XwzkgX4SgMtZhxJrE0jVmqYR3c0AgeSxxxAQkz6P0PyxSQjF6Zc36Ky0NCUPQo9u2cKhT/eOQOoA+G9iF6s+b6SRMWBoHI5evj0fXH3eIPC3SCmMl8uGk3i0DtLATqTYZG2f8LtQxUf4GXMJkuxZw1WmLiqfItzhxJNB6djRQPOSMwEOGQs3Ch0VA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6hTWJXdNcug+LoX8v2svy20LW/Azf4JRIEUMECWSQf8=;
 b=okpN3Y2J+8pb/qomHFF2xRf0YnbQa4jd685zGcPySsNr3akbfJRu4x67VWVSazeJBkQ1J9dh4pieO3yB8NdlA9Z5wWIt7VBx8C2SQW2agZAtcmO6g2ZUZDyddvMMRWPO7G7LDg66ck8Rpn5HXQWAEKB0Y5F+aPAlGGDdQDbZqSY=
Received: from CO1PR11MB4865.namprd11.prod.outlook.com (2603:10b6:303:9c::9)
 by BN6PR11MB1506.namprd11.prod.outlook.com (2603:10b6:405:a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Thu, 10 Feb
 2022 13:02:22 +0000
Received: from CO1PR11MB4865.namprd11.prod.outlook.com
 ([fe80::25bd:b3c9:a714:cdce]) by CO1PR11MB4865.namprd11.prod.outlook.com
 ([fe80::25bd:b3c9:a714:cdce%6]) with mapi id 15.20.4975.011; Thu, 10 Feb 2022
 13:02:22 +0000
From:   <Kavyasree.Kotagiri@microchip.com>
To:     <michael@walle.cc>, <Tudor.Ambarus@microchip.com>
CC:     <Manohar.Puri@microchip.com>, <Nicolas.Ferre@microchip.com>,
        <UNGLinuxDriver@microchip.com>, <alexandre.belloni@bootlin.com>,
        <arnd@arndb.de>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <olof@lixom.net>,
        <robh+dt@kernel.org>, <soc@kernel.org>,
        <Tudor.Ambarus@microchip.com>
Subject: RE: [PATCH v4] ARM: dts: add DT for lan966 SoC and 2-port board
 pcb8291
Thread-Topic: [PATCH v4] ARM: dts: add DT for lan966 SoC and 2-port board
 pcb8291
Thread-Index: AQHYHaYU1qtS5sG/10aA2sqGSWL+96yLJtgAgAGTrACAAAahIA==
Date:   Thu, 10 Feb 2022 13:02:22 +0000
Message-ID: <CO1PR11MB4865B76B9B26EE938E3E67CE922F9@CO1PR11MB4865.namprd11.prod.outlook.com>
References: <42662481-51a4-2a4b-e39b-d3b8401cbb2c@microchip.com>
 <20220210123704.477826-1-michael@walle.cc>
In-Reply-To: <20220210123704.477826-1-michael@walle.cc>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9a5bbf5c-42da-4c0c-fd12-08d9ec9593fc
x-ms-traffictypediagnostic: BN6PR11MB1506:EE_
x-microsoft-antispam-prvs: <BN6PR11MB1506AB59879F5544711D2E89922F9@BN6PR11MB1506.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5a2Bg9jokmZgXmLRNajOI0WpHYA0Z9cRA4uBItKf7fL6FfZLfLuAhH2RqnBJ+cKknjjy2awVd035VTaEBZUsC7IiFX8hGSeJThsFsnzXe1qE/BrUfbDyKA91VaSuoaHob268sJN1jooH0loE14sU/boX7l7ao/NVZduwescAh1pwMjQHRgCDDktwUmjcvKLr1SdGgLGN5ItZQMUn58KyasQ+B3yfHHe1wum+XEcJgka1R/MPDLTxqHqgIEruBqLtA2ZMCnD/8P0wHUmaoT1cXlYl+JlRLVXkCUo5qaYRsag3TyvutC9lED7sTFmZa6bRcfePIqwO1cB7F+gjYlri1IeOmPeZVX4ARJxZfiQ+HqAICwlaZE163Zrd9pSDdc2Nuu5kG7EAEwQDU1AWwMFBugQ+hMZ/uwYXz+u8h3Wv7Jevhmk3LI94Paa3rueDsjvKxiVpND27ZZwuXd3pgl39hkdCGdmC4qjZ2r5g8DV/2fM1JFKwn8NMwBcjdgG7WswhRH6nHC6pLKoDbaH1hlClWrTPjusyTkKlNBPm2g/qO47STd6ZdSI9TuFDNan7imuZQ3IxPqZSOoAm88LAkNf1z1PO/jkbGa1QrO1Bm0qzDcsAcNzMpiQwVJTtGxqg7yBFFVGO3bAYnvyJfVnofB99WF3Vi3awwKJaT1KLbjLvAl94cX+I2ZBKFkIYnDzFKqIGf/VjIqXbU7Pt4Lqck29VjA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4865.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(38070700005)(33656002)(8936002)(8676002)(64756008)(7696005)(4326008)(508600001)(66446008)(66476007)(66556008)(6506007)(66946007)(76116006)(5660300002)(122000001)(86362001)(110136005)(6636002)(71200400001)(55016003)(2906002)(54906003)(186003)(26005)(316002)(52536014)(9686003)(107886003)(38100700002)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?NHNyP3WQFs+WFtvebKfRkGbNXoSr9YzOu8vbm+BnyAMAa9q4TojNZl3BpJzS?=
 =?us-ascii?Q?MOj/xTxoZ6OMMq1F/hRaNyrT0+q6Vi+V8jPBbxhkdTZNLzqGsAma+fb8wDlr?=
 =?us-ascii?Q?W9LLfdtWa62Xxsl5SHf/Rge9lPBitwjqxaHgXo+tJR/IhO0znf/o9OOjwU9Y?=
 =?us-ascii?Q?UpBFlIpQyx65ycVi9jwFkTzASXKCfGlfNon6MWbpit0dHpH8LXAhjobKWK9H?=
 =?us-ascii?Q?HyHwfSOSvUckXU3A4FTnlRBjto3vel2jLG2DrFB9dyS7cdvLLPttJ1bA1Ww7?=
 =?us-ascii?Q?wTdmPqA7Dm1+E14W4xJGiZ/a97igXI84VY5f4n/00GIDpX5Vyb2Wf92/0xAu?=
 =?us-ascii?Q?3HmShlcNjlqBE/wI1tU8NWQpwlil1LcxTIgORwfRRVw3R+BUftE6W/W5qTZw?=
 =?us-ascii?Q?2uUU4kfIuipc4yZm5xfzL9DSzBCHenqTW+KZ5/DseQ+zsw59t41HXeObycsM?=
 =?us-ascii?Q?NDnh8rcrrtM+337Q/z7Hzv5IQWt5zZM44taBR+/JyDBeIiTaoLnByswMEI4s?=
 =?us-ascii?Q?ax/Tr1JwBFSxJRJ6pXftQTHcfQky3gRv/vG9No47dSOj1bm1Zw6UnnCi+Sv/?=
 =?us-ascii?Q?r6fGQP6wKByJD6UI7bDLGHq+/6wLwTUHunPY31V3QXI1A7I+Gig/iQfP3BqP?=
 =?us-ascii?Q?XckVqwSpgo+pWIgmfvdNQDjB44oqYwCa/ae8SxNcywVftz7cx8AT1sT1xrhz?=
 =?us-ascii?Q?+J8AhnmK48yRuOlbiiQfszW/dNm7XNL3Saiyd94VC4PUlcbzTx0zJkJKXzJ8?=
 =?us-ascii?Q?4nVkifAIFpCD1aGQS8NrokwOdhcVQ2W6mS7wMmAhvULP6DuOSXI9LFK+tssU?=
 =?us-ascii?Q?jindrKC0XYYWNKHR7rxRQ75GKCFqCX76q8NDs3A0y+3itcQ/y+LDT4TpoMYr?=
 =?us-ascii?Q?3myDN/78V+yywLZ+QMtDCWnCM3R7bcUmqy6D83LegksE/LXRsI8OeL+hvrn2?=
 =?us-ascii?Q?mpu5AsML1000mmj4YV4WCOlfYKx9Dwly49en8Qnhk2UTLaUD/j/wT2KrkHH9?=
 =?us-ascii?Q?9Whq+doTlQnQT4fcsrc3fc+hNDQrnib4PsRDEwU0iS/K5E4Dt81Lcu495IEI?=
 =?us-ascii?Q?aR/KuwgmIryWPSe6tizMEKaSEiyzvJ9ingH5z+Eyb7lDUh9sYJb6x8BQcd8B?=
 =?us-ascii?Q?dbvLNd6v6jnN88sltVIO5QuqjmFYiscusarz3//DdOQBADRU3Opv6uTIfn7F?=
 =?us-ascii?Q?F0dwfi8WvDbiQw7G11QztAnsIrg1pNZ7p7WYno9JnnWCEW8Ctb4Az/1b+icb?=
 =?us-ascii?Q?j+E/Q0dTcWGlgVsLI6N7tNm4Kda604J8bQ+kuyR95NQMBNCYBDjV67acHX+v?=
 =?us-ascii?Q?hxUp9t/adDsqvSQoJEimNeKOTO8PHNbn7F24yInBGXNEJANhu7SRCTKhU4Vt?=
 =?us-ascii?Q?r7oJl3g1iFL4ZjFXAxxi1JsdjG/zMVcgeaufZYg4JVNrtN9Dy/zUXjwAg+p5?=
 =?us-ascii?Q?Jick2WWeJHVm5cAi477Rle/Dk9b7QpUbT/gXQ38Qzra1ghJ2nW/bvkpV0jpQ?=
 =?us-ascii?Q?5jJibL35jyW//kQUSG2L7LpFZbxe9g0QqlKMi5yf/Ta0UJL8fbswJ8cAneYk?=
 =?us-ascii?Q?Y6CxL7DeZZ79geQodo1LSJ/i8rt+5ijmQys3ITnz1MGaanfHI1EmGXvefFiV?=
 =?us-ascii?Q?FP7XNLdhS6S+MrwAvInjT6BbEjrZDZdrQH8aDmBIsDsRw1Gv3flGDiSG38Dt?=
 =?us-ascii?Q?fHJlTMuD4sn66278H2y792kWOkCRuINOAGzx5k9OmXURntFD?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4865.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a5bbf5c-42da-4c0c-fd12-08d9ec9593fc
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2022 13:02:22.4717
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: G4BBw10Jk/4nF2VwWqWxiiZudhYrmZrrdmzWmPblpZaECSgiyjUHbdZvRgKMcvd54lxiOjMSK/oSIzUcHmtgOA9269l1D+UmqrXKL+0TyAhUj3LJz236KJ5ZW0c+h2UV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1506
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> EXTERNAL EMAIL: Do not click links or open attachments unless you know th=
e
> content is safe
>=20
> Hi,
>=20
> >  arch/arm/boot/dts/Makefile            |   2 +
> >  arch/arm/boot/dts/lan966x.dtsi        | 237 ++++++++++++++++++++++++++
> >  arch/arm/boot/dts/lan966x_pcb8291.dts |  61 +++++++
>=20
> Please rename this to lan966x-pcb8921.dts. All (most?) of the device
> tree files use the dash as a seperator between the SoC and the board.
>=20
Ok, I will change in my v6.=20
Please have a look at my v5 patch where I already addressed all the node na=
ming changes.
=20
> > diff --git a/arch/arm/boot/dts/lan966x.dtsi
> b/arch/arm/boot/dts/lan966x.dtsi
> > new file mode 100644
> > index 000000000000..91ee9e0684f4
> > --- /dev/null
> > +++ b/arch/arm/boot/dts/lan966x.dtsi
> > @@ -0,0 +1,237 @@
> > +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> > +/*
> > + * lan966x.dtsi - Device Tree Include file for Microchip LAN966 family=
 SoC
> > + *
> > + * Copyright (C) 2021 Microchip Technology, Inc. and its subsidiaries
> > + *
> > + * Author: Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>
> > + *
> > + */
> > +
> > +#include <dt-bindings/interrupt-controller/irq.h>
> > +#include <dt-bindings/interrupt-controller/arm-gic.h>
> > +#include <dt-bindings/mfd/atmel-flexcom.h>
> > +#include <dt-bindings/dma/at91.h>
> > +#include <dt-bindings/gpio/gpio.h>
> > +#include <dt-bindings/clock/microchip,lan966x.h>
> > +
> > +/ {
> > +     model =3D "Microchip LAN966 family SoC";
> > +     compatible =3D "microchip,lan966";
>=20
> Undocumented compatible string. I see that the actual board
> is documented in
>   Documentation/devicetree/bindings/arm/atmel-at91.yaml
>=20
> But as Arnd mentioned, this doesn't really make sense here
> as you have to override it in the actual board dts anyway.
>=20
> > +     interrupt-parent =3D <&gic>;
> > +     #address-cells =3D <1>;
> > +     #size-cells =3D <1>;
> > +
> > +     cpus {
> > +             #address-cells =3D <1>;
> > +             #size-cells =3D <0>;
> > +
> > +             cpu@0 {
> > +                     device_type =3D "cpu";
> > +                     compatible =3D "arm,cortex-a7";
> > +                     clock-frequency =3D <600000000>;
> > +                     reg =3D <0x0>;
> > +             };
> > +     };
> > +
> > +     clocks {
> > +             sys_clk: sys_clk {
> > +                     compatible =3D "fixed-clock";
> > +                     #clock-cells =3D <0>;
> > +                     clock-frequency =3D <162500000>;
> > +             };
> > +
> > +             cpu_clk: cpu_clk {
> > +                     compatible =3D "fixed-clock";
> > +                     #clock-cells =3D <0>;
> > +                     clock-frequency =3D <600000000>;
> > +             };
> > +
> > +             ddr_clk: ddr_clk {
> > +                     compatible =3D "fixed-clock";
> > +                     #clock-cells =3D <0>;
> > +                     clock-frequency =3D <300000000>;
> > +             };
> > +
> > +             nic_clk: nic_clk {
> > +                     compatible =3D "fixed-clock";
> > +                     #clock-cells =3D <0>;
> > +                     clock-frequency =3D <200000000>;
> > +             };
> > +     };
> > +
> > +     clks: clock-controller@e00c00a8 {
> > +             compatible =3D "microchip,lan966x-gck";
> > +             #clock-cells =3D <1>;
> > +             clocks =3D <&cpu_clk>, <&ddr_clk>, <&sys_clk>;
> > +             clock-names =3D "cpu", "ddr", "sys";
> > +             reg =3D <0xe00c00a8 0x38>;
> > +     };
> > +
> > +     timer {
> > +             compatible =3D "arm,armv7-timer";
> > +             interrupt-parent =3D <&gic>;
> > +             interrupts =3D <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(8) |
> IRQ_TYPE_LEVEL_LOW)>,
> > +                          <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(8) |
> IRQ_TYPE_LEVEL_LOW)>,
> > +                          <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(8) |
> IRQ_TYPE_LEVEL_LOW)>,
> > +                          <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(8) |
> IRQ_TYPE_LEVEL_LOW)>;
> > +             clock-frequency =3D <37500000>;
> > +             arm,cpu-registers-not-fw-configured;
> > +     };
> > +
> > +     soc {
> > +             compatible =3D "simple-bus";
> > +             #address-cells =3D <1>;
> > +             #size-cells =3D <1>;
> > +             ranges;
> > +
> > +             flx0: flexcom@e0040000 {
> > +                     compatible =3D "atmel,sama5d2-flexcom";
>=20
> Are these expected to be exactly the same between the lan966x and the
> sama5d2 or do you need something like
>=20
> compatible =3D "microchip,lan966x-flexcom", "atmel,sama5d2-flexcom";
>=20
> for the case when you need to make SoC specific settings/workarounds?
>=20
> > +                     reg =3D <0xe0040000 0x100>;
> > +                     clocks =3D <&clks GCK_ID_FLEXCOM0>;
> > +                     #address-cells =3D <1>;
> > +                     #size-cells =3D <1>;
> > +                     ranges =3D <0x0 0xe0040000 0x800>;
> > +                     status =3D "disabled";
> > +             };
> > +
> > +             flx1: flexcom@e0044000 {
> > +                     compatible =3D "atmel,sama5d2-flexcom";
> > +                     reg =3D <0xe0044000 0x100>;
> > +                     clocks =3D <&clks GCK_ID_FLEXCOM1>;
> > +                     #address-cells =3D <1>;
> > +                     #size-cells =3D <1>;
> > +                     ranges =3D <0x0 0xe0044000 0x800>;
> > +                     status =3D "disabled";
> > +             };
> > +
> > +             trng: trng@e0048000 {
>=20
> Tudor already mentioned this..
>=20
> > +                     compatible =3D "atmel,at91sam9g45-trng";
> > +                     reg =3D <0xe0048000 0x100>;
> > +                     clocks =3D <&nic_clk>;
> > +             };
> > +
> > +             aes: aes@e004c000 {
>=20
> .. and this ..
>=20
> > +                     compatible =3D "atmel,at91sam9g46-aes";
> > +                     reg =3D <0xe004c000 0x100>;
> > +                     interrupts =3D <GIC_SPI 53 IRQ_TYPE_LEVEL_HIGH>;
> > +                     dmas =3D <&dma0 AT91_XDMAC_DT_PERID(13)>,
> > +                            <&dma0 AT91_XDMAC_DT_PERID(12)>;
> > +                     dma-names =3D "rx", "tx";
> > +                     clocks =3D <&nic_clk>;
> > +                     clock-names =3D "aes_clk";
> > +             };
> > +
> > +             flx2: flexcom@e0060000 {
> > +                     compatible =3D "atmel,sama5d2-flexcom";
> > +                     reg =3D <0xe0060000 0x100>;
> > +                     clocks =3D <&clks GCK_ID_FLEXCOM2>;
> > +                     #address-cells =3D <1>;
> > +                     #size-cells =3D <1>;
> > +                     ranges =3D <0x0 0xe0060000 0x800>;
> > +                     status =3D "disabled";
> > +             };
> > +
> > +             flx3: flexcom@e0064000 {
> > +                     compatible =3D "atmel,sama5d2-flexcom";
> > +                     reg =3D <0xe0064000 0x100>;
> > +                     clocks =3D <&clks GCK_ID_FLEXCOM3>;
> > +                     #address-cells =3D <1>;
> > +                     #size-cells =3D <1>;
> > +                     ranges =3D <0x0 0xe0064000 0x800>;
> > +                     status =3D "disabled";
> > +
> > +                     usart3: serial@200 {
> > +                             compatible =3D "atmel,at91sam9260-usart";
> > +                             reg =3D <0x200 0x200>;
> > +                             interrupts =3D <GIC_SPI 51 IRQ_TYPE_LEVEL=
_HIGH>;
> > +                             clocks =3D <&nic_clk>;
> > +                             clock-names =3D "usart";
> > +                             atmel,fifo-size =3D <32>;
> > +                             status =3D "disabled";
> > +                     };
> > +             };
> > +
> > +             dma0: dma-controller@e0068000 {
> > +                     compatible =3D "microchip,sama7g5-dma";
> > +                     reg =3D <0xe0068000 0x1000>;
> > +                     interrupts =3D <GIC_SPI 47 IRQ_TYPE_LEVEL_HIGH>;
> > +                     #dma-cells =3D <1>;
> > +                     clocks =3D <&nic_clk>;
> > +                     clock-names =3D "dma_clk";
> > +             };
> > +
> > +             sha: sha@e006c000 {
>=20
> .. and this one.
>=20
> > +                     compatible =3D "atmel,at91sam9g46-sha";
> > +                     reg =3D <0xe006c000 0xec>;
> > +                     interrupts =3D <GIC_SPI 57 IRQ_TYPE_LEVEL_HIGH>;
> > +                     dmas =3D <&dma0 AT91_XDMAC_DT_PERID(14)>;
> > +                     dma-names =3D "tx";
> > +                     clocks =3D <&nic_clk>;
> > +                     clock-names =3D "sha_clk";
> > +             };
> > +
> > +             flx4: flexcom@e0070000 {
> > +                     compatible =3D "atmel,sama5d2-flexcom";
> > +                     reg =3D <0xe0070000 0x100>;
> > +                     clocks =3D <&clks GCK_ID_FLEXCOM4>;
> > +                     #address-cells =3D <1>;
> > +                     #size-cells =3D <1>;
> > +                     ranges =3D <0x0 0xe0070000 0x800>;
> > +                     status =3D "disabled";
> > +             };
> > +
> > +             timer0: timer@e008c000 {
> > +                     compatible =3D "snps,dw-apb-timer";
> > +                     reg =3D <0xe008c000 0x400>;
> > +                     clocks =3D <&nic_clk>;
> > +                     clock-names =3D "timer";
> > +                     interrupts =3D <GIC_SPI 39 IRQ_TYPE_LEVEL_HIGH>;
> > +             };
> > +
> > +             watchdog: watchdog@e0090000 {
> > +                     compatible =3D "snps,dw-wdt";
> > +                     reg =3D <0xe0090000 0x1000>;
> > +                     interrupts =3D <GIC_SPI 38 IRQ_TYPE_LEVEL_HIGH>;
> > +                     clocks =3D <&nic_clk>;
> > +             };
> > +
> > +             can0: can@e081c000 {
> > +                     compatible =3D "bosch,m_can";
> > +                     reg =3D <0xe081c000 0xfc>, <0x00100000 0x4000>;
> > +                     reg-names =3D "m_can", "message_ram";
> > +                     interrupts =3D <GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>,
> > +                                  <GIC_SPI 73 IRQ_TYPE_LEVEL_HIGH>;
> > +                     interrupt-names =3D "int0", "int1";
> > +                     clocks =3D <&clks GCK_ID_MCAN0>, <&clks GCK_ID_MC=
AN0>;
> > +                     clock-names =3D "hclk", "cclk";
> > +                     assigned-clocks =3D <&clks GCK_ID_MCAN0>;
> > +                     assigned-clock-rates =3D <40000000>;
> > +                     bosch,mram-cfg =3D <0x0 0 0 64 0 0 32 32>;
> > +                     status =3D "disabled";
> > +             };
> > +
> > +             gpio: pinctrl@e2004064 {
> > +                     compatible =3D "microchip,lan966x-pinctrl";
> > +                     reg =3D <0xe2004064 0xb4>,
> > +                         <0xe2010024 0x138>;
> > +                     gpio-controller;
> > +                     #gpio-cells =3D <2>;
> > +                     gpio-ranges =3D <&gpio 0 0 78>;
> > +                     interrupt-controller;
> > +                     interrupts =3D <GIC_SPI 17 IRQ_TYPE_LEVEL_HIGH>;
> > +                     #interrupt-cells =3D <2>;
> > +             };
> > +
> > +             gic: interrupt-controller@e8c11000 {
> > +                     compatible =3D "arm,gic-400", "arm,cortex-a7-gic"=
;
> > +                     #interrupt-cells =3D <3>;
> > +                     interrupts =3D <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
> > +                     interrupt-controller;
> > +                     reg =3D <0xe8c11000 0x1000>,
> > +                           <0xe8c12000 0x2000>,
> > +                           <0xe8c14000 0x2000>,
> > +                           <0xe8c16000 0x2000>;
> > +             };
> > +     };
> > +};
>=20
> Overall most of the referenced bindings lack a proper yaml version :/
>=20
> -michael
