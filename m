Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF3924B09B6
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 10:40:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238881AbiBJJkP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 04:40:15 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238864AbiBJJkM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 04:40:12 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 869F91082;
        Thu, 10 Feb 2022 01:40:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1644486013; x=1676022013;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=q3nlBXbKxEqS2YPT2px6oWdIwVgVM9ccW/OwlhuSNGk=;
  b=2brscfF5E3a/I5KdfUkqkpPXQsrvmwm2ERqt1wQTL11tBvdt6hYUBoe5
   +VITgqipqMqQUY/QBbOX2zduNyGpSG/bu4eT6VUtgKUL/Tv8F4YiFJ7x3
   8efiOgQIpnUBNJyPnceHC+zKTYYjQzLJxnBknSQorOwa+qsZT6Qc01kjm
   31qc0eMszKzcx1+FHY/+jwzj85dr9u5n6wnL/2KS4kZmeLsO1gGfK7Psr
   90XsEsidwNGqh/JuOQrJJJBUkgW4XphjuLP6lpWrXYTldlipm7cPDukUx
   cD8luHhnLP2qbXcIR7NKrrse965TUPEkU5kjuVY8hCLTbBrdRnPpQ5wAR
   g==;
IronPort-SDR: pyfk0XOg/HZiB2IHvVljsBeLCxX0oX4bzDjx+FBTkglAKaP3zHi6szZ6YrZAdKRiZvBd3MQzMA
 BfVV+qybHSZIyHt4FaccjaikX9vPFFepFcDOt/lAbRMmY0aQEzp4UrzjuXYhf5qh8FtV4LZexX
 J3DGGdds76cPZiImJj0ucebZUOH6t3MTx0AA/Qoy0PtCqACP4RR4xIwoJ2oj66xZFf6mK+s72o
 CecRgqoiK290FffoOfTCa/qhyCbXuBBzM1ovQsyV0bP102ikMn5QbAKACeijEbKx5UQpYqCOxi
 sSI3sfOl7QOb7mZ2PcioFfXS
X-IronPort-AV: E=Sophos;i="5.88,358,1635231600"; 
   d="scan'208";a="85284371"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 10 Feb 2022 02:40:12 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Thu, 10 Feb 2022 02:40:11 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17 via Frontend Transport; Thu, 10 Feb 2022 02:40:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m7QfbTamH+HjPODucsFz2DbO2QqV+F/N/9bmZTKVL8+MxFnK221ammVv296FcfyZsLN3dAOS8PvdZlbFQkOHvoPUiJvJGxEOKgzcoOFqEO4vazNgHmm4AelHFTTIq3mC+F34Y/LJob1IQ4t5rnzGK7DRixSWQgU6MxMT0K/vLWaUQsupXjkBwdf8CYRpS1qOtCuZwyFTTKOtRmqQQhprv/cx3mtR++GbDwWklqnTdKwxXZE44PztCFPounwHlljkAcuxeXsnz3+yYud9/2fcNnTxYfEsa6ilqwTvIl2IVnRHM0CyMFOh7F9cFnfhGAnOKyOgcaq6WDIocd52jBOf1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IggY/zi+nGgtnAjLfysrP/y+QJbWsgtLhvgk7QzRBLA=;
 b=jJJZBwj3RbRZozL22GwqF9vUitbSmGavd9xDV+yCIjwDo/z+j24cFTppIkXDjeMBJ5p/TrsbeRokv2MOI4aIwC39iLs8g4agjYSWK4YNJXOw5seKqfU+8cGGQVTQNT4LhulAYOYtgsPT8Owq+RSCXsSOOhk1sRBLYZ3N31gOyAgiB6w4ucW5f/xzWwvcHCe4zHFUcwkhFdF4+QIiGM+DQC8OlMgN/58JZyVh9WmqJ9mTlYV6dom6aXwUUWtzMczKka3KIVNf0oB+XGkzM1rxOG3bqhtmNUQUr+CNE3suxvmO7t7DZba/Ak8ZKkPf3Ln+spXKJIzi++4it7VDiYy+uA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IggY/zi+nGgtnAjLfysrP/y+QJbWsgtLhvgk7QzRBLA=;
 b=IMWdLZsKJ+jDHir3wPMZ7PTW3xy4CkE94vEhtJMHLhwWOGckdcDjB61NEzJCb1SfuiArjSVYP+745NWWkGXDj4olxftsJJhhxpU7S0G/oz+QijIQZgl4g/pSm94hBaNYXC3GStjG0CbukkggVklRNEvbym6GsxAGQ4rt8AttbMM=
Received: from CO1PR11MB4865.namprd11.prod.outlook.com (2603:10b6:303:9c::9)
 by SA2PR11MB4987.namprd11.prod.outlook.com (2603:10b6:806:113::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.14; Thu, 10 Feb
 2022 09:40:05 +0000
Received: from CO1PR11MB4865.namprd11.prod.outlook.com
 ([fe80::25bd:b3c9:a714:cdce]) by CO1PR11MB4865.namprd11.prod.outlook.com
 ([fe80::25bd:b3c9:a714:cdce%6]) with mapi id 15.20.4975.011; Thu, 10 Feb 2022
 09:40:05 +0000
From:   <Kavyasree.Kotagiri@microchip.com>
To:     <michael@walle.cc>
CC:     <Manohar.Puri@microchip.com>, <UNGLinuxDriver@microchip.com>,
        <alexandre.belloni@bootlin.com>, <arnd@arndb.de>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <Nicolas.Ferre@microchip.com>,
        <olof@lixom.net>, <robh+dt@kernel.org>, <soc@kernel.org>
Subject: RE: [PATCH v4] ARM: dts: add DT for lan966 SoC and 2-port board
 pcb8291
Thread-Topic: [PATCH v4] ARM: dts: add DT for lan966 SoC and 2-port board
 pcb8291
Thread-Index: AQHYHaYU1qtS5sG/10aA2sqGSWL+96yLj0MAgAD4oLA=
Date:   Thu, 10 Feb 2022 09:40:05 +0000
Message-ID: <CO1PR11MB486534A2987684CC7402CE06922F9@CO1PR11MB4865.namprd11.prod.outlook.com>
References: <20220209111318.21112-1-kavyasree.kotagiri@microchip.com>
 <20220209184600.1230365-1-michael@walle.cc>
In-Reply-To: <20220209184600.1230365-1-michael@walle.cc>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4fa00c7d-b342-4bed-f0fd-08d9ec79517f
x-ms-traffictypediagnostic: SA2PR11MB4987:EE_
x-microsoft-antispam-prvs: <SA2PR11MB49875AED746D6E093EF0137D922F9@SA2PR11MB4987.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: siXa9Juh1YF+kIFlJ8NhcXBybX+dCCQcf2Z2sZvg8JdgskUSrSnUHvzU/33F1k+NZhpvQYi/iU9Z2ILHLQ2yqp4qq29O4f9tZNXyusdHehWMm0A47957dGS1zuqfmWnWyfsJ6kQvM6MOhJj/BzDIshlkws3F4Bg4P7KNuF30cg2SmRFY2KHALYU2tmjNCr1btUSDLbTy6eUEcy7OK4fr1Ff5mJZIufu+rDxnIdd+jk9HrfeugucsIDWXYsqQ23gsPpgUiNBc4Cyvpo1Huxz5sn1tKqXWi53/YUaiw+IWHOdl+M/Ua9NDjjqTcoFsY9tVf0M38hU29MzMdGogqCY0FLlvjTZglO4HgRAzppIEgxuYIKDOrJaUajyI2Ts4IU7gEAnB6WLuoyIpAPS/yeRcKShD+gwoBmBemXhJNGEl42NxuhTfAu/HG7XfpA6DFvI11PktITFXbIvUVZw8guEWmggQHlqYaMtcqxzZ8MCeuqlH/LzNU/Vl7zkkaDDj6O8BlQyZLBUqZ16Vcdm7RBFU/efitnMvSo8PTfKhOy9qfvPgBjcuy1p/+revTB/BMbYl0niWKun/lXz+NdmUx9j1DuTazB3G3s8PkxVGUlnA4ZHbpascOrUT0hdE9Msjk5DjphnujQxh4HeIfAWHE5Rp2oJBcYlxpdL/T3Hl64uMmd4FCmGq/SX8GslEIfHYPsAc+s4dGTd0nSa29hCDTZE1Qg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4865.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(55016003)(66946007)(54906003)(508600001)(33656002)(66446008)(6916009)(76116006)(71200400001)(7696005)(6506007)(8676002)(5660300002)(9686003)(316002)(64756008)(66556008)(8936002)(66476007)(86362001)(38070700005)(26005)(83380400001)(52536014)(38100700002)(186003)(4326008)(122000001)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?8TP9MitqaQdyqPxxQXdMSTZ4lInbKhKejrUekkQJ+OexVDMkXm9rpqHwVxmq?=
 =?us-ascii?Q?jBSxBayMuSdwjyKqFsWz5Xr4pU3xk9BiuY5lVdbW7of8nWxLoDCze2S2h0yI?=
 =?us-ascii?Q?ibvI7/4h8Ho5q+9oGy1SAon/OIgFjak61M4FrhUtpnBPMHjP8eA/QXUhLcKO?=
 =?us-ascii?Q?HHk5IzB/Sh+8O9yA0tWZFjiH+Q+VHyNaqgwEY6dewf/jm+3QQQ/5kgec01vv?=
 =?us-ascii?Q?mXbqjbdLBpD13iNqvnC+OyRmqeo6JXSoEXIlxiJ297Hl5NgiLK5EUpENtje0?=
 =?us-ascii?Q?ZKOav7CV/c2+UaAGz+HTU5Jk0zxLK6tp8L6JdsZ2QRSEcGckQ+cZ5+MA6H2z?=
 =?us-ascii?Q?ritv9/LnpjiiGYyM/YPG87keiPnqBTYywY14hge3odPPDkvWYMGSp/CTWz2H?=
 =?us-ascii?Q?JHGR10yNuPvGvvRhxOIO29+6Qcsge4WiSNFfghn7Ro/YlMCEzU8poJP+6eIa?=
 =?us-ascii?Q?v82FQcuEdOUUzlscpGSiJH8rCG1BSypJSudLumYLi0xfXvvyckAMXK1HbsPl?=
 =?us-ascii?Q?D0hGl/6zkJGQKH3LTJ/JC5UHwvkPHsTIiSI6GyDERZf9C4Hurv98c1yZpXRC?=
 =?us-ascii?Q?uaTr2CWduRVhL3ea8agiNe53/BK6E83EiK3kLzwJwByMlEGHgiSguR6kKdua?=
 =?us-ascii?Q?daGAyPQ6wm65TAKhEkGAwohwOrl9XMp4ZVAer+CyIivsHADe+Vj/xiqhMbJ5?=
 =?us-ascii?Q?bUbKcCJ29Iq6Mxe4bzR5Uy3I5pJjtofOslzJyl0dbUVgZ/MLpVNzqZ5B37v8?=
 =?us-ascii?Q?Kc7eCZdhCBZDFAYm5MkW1vRbc659YLHdJ8kKazTdRGhk8h0QVp8IeofPBjpr?=
 =?us-ascii?Q?LGXl/GD8CYStE2LeM2/DIdQC9gvsdeeufpZ/y2d0x6ULSjU1Lxc8a48Brizz?=
 =?us-ascii?Q?2U+QPHNv274xjbwlTDiArn+BT3s3AAfO4jRtF0vf66cUJ4peFhyioV0s7AHb?=
 =?us-ascii?Q?cTg9leAOL1N00zdDVpL5Fnu13PCfSygy6Lw7RHpicY73yDKqcDpFzDYPan9Q?=
 =?us-ascii?Q?KenrlBA3RYCqn0vmBYvuCWExsIJ/awCQa6t02pHtArw2QVvMIVj7bX4vN2cn?=
 =?us-ascii?Q?D0ZgUAxXi8dYclqUejN5SypplKv2lDXo5A+xevgJUWZEtkZyGS2aAfn08zet?=
 =?us-ascii?Q?l0O15OkWD2gaXqANjTnE6EpDXvG1fWuklY0htOIrABogpJvJA41jytno2jJ1?=
 =?us-ascii?Q?oN2jItLEgbR0MLAtbZGZzQofepW/PduDLrfjuMxYgprOLUA8wD/5zHzCBBFW?=
 =?us-ascii?Q?Q5hIUjEBTrTLiLBUahJbcGqRv7mTufK7GDZQqyr9tQczYRGMekPy+u/o8Nvm?=
 =?us-ascii?Q?Uwxjiiq0XGmQxqNjiZgV6DjVPszREAg5hjMHcDjLG7LTES9kvK2CtLxcQaNw?=
 =?us-ascii?Q?PCG5CDaOh+FODiyJlsscAl8kt0bdbqCVC8B1bxqbEwPRbGjFwQCmZyeqYFSC?=
 =?us-ascii?Q?RAp/K/MoWEOre5Jee8/f+aE+nF9ZBLCRprID5Keiy/FyJ5NnmvUG2iH6sH79?=
 =?us-ascii?Q?+51E+1W3wR6Sr5dywunIZLkuThqy1u5BkyzucvQafyvnzD070KaB2A/mQBeE?=
 =?us-ascii?Q?7uun9/9bgZeerQ2CdGQuVv7jCHe3LZp+wEH4TI/gS2SbCr0IL2+4tQD0YBF8?=
 =?us-ascii?Q?QaXOYCBJpj7hYwH6/M1DzKDnkOlwO/yF7WdC/3fqJWQU+E6FxrE3N7vdped+?=
 =?us-ascii?Q?68e/YnK1/mYgR3DFcV6VZszwVO++pTWD5O/L17TQYODD61YM?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4865.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fa00c7d-b342-4bed-f0fd-08d9ec79517f
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2022 09:40:05.1222
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: USdYvumijGVqVKBp/F7bN1jq+OUb2uxHQxJk65b4LCS1xET2IRgNB7LeXWQ2RisrAKTxTDX6JxLoQKWkLL+7oiWuDhqbw9Y6ZApZIloY5xksfeVcvnYrPX93B1fXoO49
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4987
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
> > +     clocks {
> [..]
> > +
> > +             nic_clk: nic_clk {
>=20
> What does nic_clk stand for? If I had to guess, it
> has something to do with network. But..
>=20
NIC clock is the clock used by AXI, AHB fabric and APB bridges which connec=
ts all the peripherals.
It is named so because the AXI fabric is based on NIC400 IP from ARM

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
> > +                     compatible =3D "atmel,at91sam9g45-trng";
> > +                     reg =3D <0xe0048000 0x100>;
> > +                     clocks =3D <&nic_clk>;
>=20
> .. it is used here..
>=20
>=20
> > +             };
> > +
> > +             aes: aes@e004c000 {
> > +                     compatible =3D "atmel,at91sam9g46-aes";
> > +                     reg =3D <0xe004c000 0x100>;
> > +                     interrupts =3D <GIC_SPI 53 IRQ_TYPE_LEVEL_HIGH>;
> > +                     dmas =3D <&dma0 AT91_XDMAC_DT_PERID(13)>,
> > +                            <&dma0 AT91_XDMAC_DT_PERID(12)>;
> > +                     dma-names =3D "rx", "tx";
> > +                     clocks =3D <&nic_clk>;
>=20
> .. and here. and so on.
>=20
> So, is it some kind of internal clock?
>=20
> > +                     interrupts =3D <GIC_SPI 39 IRQ_TYPE_LEVEL_HIGH>;
> > +             };
> > +
> > +             watchdog: watchdog@e0090000 {
> > +                     compatible =3D "snps,dw-wdt";
> > +                     reg =3D <0xe0090000 0x1000>;
> > +                     interrupts =3D <GIC_SPI 38 IRQ_TYPE_LEVEL_HIGH>;
> > +                     clocks =3D <&nic_clk>;
>=20
> Btw. can we disable all nodes by default and enable them
> in the board dts files?
I would like to have only board specific nodes enabled in dts files and res=
t of them in dtsi file

Thanks,
Kavya

