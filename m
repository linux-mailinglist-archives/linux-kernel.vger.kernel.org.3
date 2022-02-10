Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA3DD4B0CCD
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 12:53:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241194AbiBJLwj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 06:52:39 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241174AbiBJLwg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 06:52:36 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B877FEA;
        Thu, 10 Feb 2022 03:52:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1644493958; x=1676029958;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=nC6fSRDSX3GOayo5gYjjelcoegWd+iybzAZEeq7FWYo=;
  b=uoVtIuY1ovvLTgMv9jGWelq8bu9W2WbBhxV7VIbh+iae2sR+vOLvY1Pu
   q4a1DJe1kWBKegF+nEC5eMX8FuG/JwxhrwRgKNBMqjEDYSR10Lng/Vbln
   /fnk5tdHIR7nRGXzA2wYSDlMvKYcOnx4J+cxUBZGF9sfyNbS9l3rcUw4e
   b4haraBzYfsD21RfX27DFZtFAlpo/239DKpD3/CHh/2VG9N/E4xQiyQu6
   n6ni3o3XtyyLaUK6dsAusym5G/FwQFEZlrXKZKHyX97hHwZdA14C76f8d
   EZaQvhum0QCnCOFDUqMbxJ51X2ID1B34LWz/J2vqbv8IB+WxH3LhiFDZq
   A==;
IronPort-SDR: KYWzTr0kSH+AxlRzvUhV4bR/Uq3pRWl/O52w8OhQ6tVltKY+1Qh+RtWv1vdV6eeU7LQSc/E952
 slOuoxxg6YYiimAszPermMafAVftMqU1pyirP9GTB3rsh/OFaLPtpuURT79YgFeCFj9Zzdl7kU
 Rlm12aJccWJqyJJpuqLhZ/t/HLAjttg71rvB8WPYkhdDE9hAWdfYjyP3R1usDEbBxwGt8v9hvG
 SrphNAP+FDiVOcbHPDwsVo6vzqcQJ19L/S/fh8R26wfYDmd2gQ+EjtTLwst3aZTm1+3DcKwz+j
 TQqTV0aM8WoyJzdx6x0XiR81
X-IronPort-AV: E=Sophos;i="5.88,358,1635231600"; 
   d="scan'208";a="152603008"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 10 Feb 2022 04:52:37 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Thu, 10 Feb 2022 04:52:37 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17 via Frontend Transport; Thu, 10 Feb 2022 04:52:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hLwLs8SUTdZNQF7zcAjU+1xNuRH5RaBpNHlMvKv6JI7e2w7T/yxvmEi/X3La10ac4do5cGHynMFAf7dn8lcKZouxv55KjNihYNNaHyMhIooUGTi/Zh3vlZhtOiQ8lXyYSAFlv8Ae3HWiw+dm7psKWSkp3iJ/e6Moze3FwY8yz/VMzBHb+jDJeTBD8cezG8hsRukd5URVmQwwOO2x0DWihVcHxdo0TDACQQLg9G6ELiw6Z95HAOu6vDilpSELVbv/hWSuqOzRvpybNPWQ/aaA4XQ8IZpWGUMuBNYJ0b50Uqzi3tCczGk2PjXgW86iZWlWMtpDcdc+ePmec2kfW3Ddhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OADz52g3Fh3QPv+6+5nbbkcSzAFfSijy0HOOgFAigeg=;
 b=d/6lRmu056Wa+JlOT5GH9cbSSVL97wDxxJkNSrL/3T4KVffkemRjEaiguvDA9fC8azo6qsy0D/JQXtjXiegcEhWvbPnJ+QpSh1RbljELlT5L+CWRH95wnOUad3laSQtb9IC3PMOsXp2unZvwM0se4zeyST9Iut8NH+T5H2gHv+BwVcaLqaatGqeR0HCYoVhU7R36NtQ8Bdc79EuOhIzf/u3lc6QY0VZjl6wyJ58ZR2kWqf90gatS3sjZOp54SgDFeeoLsY0zgDCkIYv5dylJpQPFrQGSo4ynALasm1BC9ACGkJBkuXVZaGXpTPF+csVVwNGzPWzFoON4e+oFQSJ7fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OADz52g3Fh3QPv+6+5nbbkcSzAFfSijy0HOOgFAigeg=;
 b=O2LY4wMlpEyjpy1o7nem1MDopDfbcndaBa6x9N44eESw2LrLrr20Gz3HGZKDHcrA1DsU7CGyXJ6hShD9DjQECTakYaHJtE34YtxVEYbeAkmOli3lO1kRWnHYBmMIKtowdhijEHsBmaeKWbL3Rw68+fVjIUYfU62PSGSMA0jtXkU=
Received: from CO1PR11MB4865.namprd11.prod.outlook.com (2603:10b6:303:9c::9)
 by BN8PR11MB3763.namprd11.prod.outlook.com (2603:10b6:408:8e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Thu, 10 Feb
 2022 11:52:23 +0000
Received: from CO1PR11MB4865.namprd11.prod.outlook.com
 ([fe80::25bd:b3c9:a714:cdce]) by CO1PR11MB4865.namprd11.prod.outlook.com
 ([fe80::25bd:b3c9:a714:cdce%6]) with mapi id 15.20.4975.011; Thu, 10 Feb 2022
 11:52:23 +0000
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
Thread-Index: AQHYHaYU1qtS5sG/10aA2sqGSWL+96yLj0MAgAD4oLCAAAQRgIAAFAoQ
Date:   Thu, 10 Feb 2022 11:52:23 +0000
Message-ID: <CO1PR11MB4865E913D083C1D80D4E1F80922F9@CO1PR11MB4865.namprd11.prod.outlook.com>
References: <20220209111318.21112-1-kavyasree.kotagiri@microchip.com>
 <20220209184600.1230365-1-michael@walle.cc>
 <CO1PR11MB486534A2987684CC7402CE06922F9@CO1PR11MB4865.namprd11.prod.outlook.com>
 <97bcfa4417d5f8c41cc6aa1e411c8747@walle.cc>
In-Reply-To: <97bcfa4417d5f8c41cc6aa1e411c8747@walle.cc>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 61a2697f-9616-4980-9410-08d9ec8bcd0a
x-ms-traffictypediagnostic: BN8PR11MB3763:EE_
x-microsoft-antispam-prvs: <BN8PR11MB3763F04E5A2F5BFB7549BAD9922F9@BN8PR11MB3763.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UBZyCWa7QBxvUlXKZ2RKbOMQUHjtL6eDBDIj5RzXtkl6wwq3szowaw2OvwP6yauhrvdYfpDTBJei+vtQ0O/Qow2AiL/fvKGs7fE2YMgev5p2CC6SLnPQb/HPkeQ5M9glqkH4OphqI9IkWOsqu+6EpeEPZLne/nhEGqaZUxz4Pgl2yqFxqGRJjGb5BTCxN5VjQ0gbhRTo0aRJrqanEcpDohYefymvzZMvdXDFqgB2Pc0Xqy9jT9nZMcO3xA8Ci6uAYQ1Vq99J9aEip7lmc/sR2ID40EDcQHMIIfzIMBhJpwGr6btkGKjI+sP6y7+aDRROAeDX0oxCdDrnc2dkPRWatMINHXTOWgb9kXkA9xxuoYH0MpQSrUyV9ZkxZRc5Phw2bmiaTTHyuwUsPRAWNpD6kAUILr8D0I7OUc0TzZr9PzA0gtJ8RUSN6+fETnPu+Wo8mjtmb7yULkegDrix4mULMH9sIETJPkkNYo1n2OFl/3iRrocfMa2jbAeRn/tGolvKr9TIhuGTzTCIBgrVLPnTYKDeaw+1XFegG+A1M+JQ+ncVVABWAFEKD5agirFT31w2XwafUULOsGB/y1/vre9b7OPcbJj0fqufqX8KWQ9KYYxGWqfWgO7BvqASHqfIg4OrfCxE/rHzK8XNCgzXU0ZMxTfkn/KT9WCXwa1y5ACoxSFpl5Oe/ysQUM6c2yuxMbcGROC1kmygfHQ6/RViUEYgag==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4865.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(8936002)(52536014)(83380400001)(38100700002)(316002)(71200400001)(2906002)(9686003)(6506007)(7696005)(5660300002)(38070700005)(66476007)(64756008)(66556008)(66946007)(4326008)(33656002)(54906003)(122000001)(186003)(8676002)(26005)(6916009)(86362001)(508600001)(66446008)(55016003)(76116006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?1EsTmjHOayUQtXZoz8q/AczQhZFbvvsvxKQhY26StMI+eBgwcCSA0YyfN0/w?=
 =?us-ascii?Q?cH7uyWKJJsjdY/2QJ9KkxtYpHodJjpvABBLKWCvZBW4tkUybeS9XOl7Lssy/?=
 =?us-ascii?Q?NA9j2GXT5MQo2ITQ0tBl0Nxy2vJYtBqhC08wG1tB+7HI1cHA4iX1Q13dCwIt?=
 =?us-ascii?Q?tjNdPhxMv5Ny//pyPhzcGrQdTH73o6ql49C+TxAxRSkoLScUYTvWcB3J/UGC?=
 =?us-ascii?Q?h/av/kq1heQjDBGM4A1X3GVbUHziPy4IaWHn54K1AP61ZdEC1B9Z9jTExdVD?=
 =?us-ascii?Q?r+ydT54YlkrxseYJm3S2LNFm1NvTmklIf8g/2unR/SEMMUQq34IWBY9mqsdr?=
 =?us-ascii?Q?fn/3N8jBdk/vVdRDqcdd83jIzK+7o/UlHQtpjmiMvRReFQXKunP7hrr6/+LB?=
 =?us-ascii?Q?+5E2JhoqL9PV0UcQh3ti2gzcEy1rHw+p4c2EEuZYDrRRjYRPGEost+1R9Y9u?=
 =?us-ascii?Q?gXJX9oW/ERigeSIKDsZsF/w6twlZwFSPVkKaHZkntUnC7BEpG9pda3h++vsL?=
 =?us-ascii?Q?jBurHXmtgTkZWWg1M5XW58S1FUIdBztQphWCBJY5yk7ntOZ6UapawU8Zjnbw?=
 =?us-ascii?Q?DloE2EKD7WL+VhZqj5as5AbERLdyCncfDAQckYWfAG7AKAe36A6kuBQBe7XM?=
 =?us-ascii?Q?kYR/QgP6OXjg2ri1R13GVivF49xL4Hv9ycz/zN5VF7OIl2WItXpsSqHUZ1TM?=
 =?us-ascii?Q?QZHQBsIE5nvwFFGOmLWUf4PSaeNaapjx1MBrAjgTWhbLTmtf67c/5wP4FMRy?=
 =?us-ascii?Q?F5+T6RiBd3990u/2IAzHpt2FI5ZIXrhIpYyYniAQGUh0gDrqZDqPo+Ngfmwp?=
 =?us-ascii?Q?vAMS3KBJAclUp1zpu7jedOwV5kzI0zE//3WR8VGi2c9ujnBwn6MbHJcLltCw?=
 =?us-ascii?Q?5BK2i8ydmoYpA50+nOhvh7IkF9zJ1gVFWzVmUhadWE4bt4wL0nwaBzAHpaoX?=
 =?us-ascii?Q?YeJAYbXs5/kpjZecP5rW2Jmjql9yfWnSu8ZK+UeuV7ZAyzW7Uc8nVnS1sDmi?=
 =?us-ascii?Q?ir5C8GjJfUIXVrUERzs3sT4bQrNeMSX1pHyHKhBLZDme5OXdTThdvLuqIhai?=
 =?us-ascii?Q?hJzizVbaumTpx71pbH/XVU2wYLrHglPv7WSDE625ISYKtq1tTM8QuT7Y+6xM?=
 =?us-ascii?Q?RSiif4yLKJNlJa5MBlcASDnxgjmEK9qhx7F/XFyQnCoBaZdUjCTlE98KICXq?=
 =?us-ascii?Q?gIiOMOHaMz6L7/jL1PYXDWytz5w9z4Gb3ZXACCn/04Yp5Y4CVamZvHV78EO1?=
 =?us-ascii?Q?92oQX4ztTMyuQHfcPy4hDYKyex2trgibXQEgwfmT2rUs1NR8ubseGZlo07Xb?=
 =?us-ascii?Q?wCaMZj97aA5ma5YX3X23Hy68qgLIVoPRlaMRwQRBWOM+ByB5LoXBvcK3kGvp?=
 =?us-ascii?Q?jNUWAQp+0QV91tmY2ZyF/ENpktX/QGo34259KfPbQyryIIKuXbIJhGIW9JQ2?=
 =?us-ascii?Q?9v2TgW1BZj9IuQeXQxio2M3yJZSI5F2lDxLLpi0qqC0x8/OBwwpFcdvAIlFp?=
 =?us-ascii?Q?Hi9jSgKmmzY/FIhbAJ+b2RIzWS1mnlbmYQOE39NnHIcCyQcSLOf6T51UP4Ch?=
 =?us-ascii?Q?bYVuTKkJXBvdYlMjMAtulR49z+PbY9xoUetLI7XaYHYD1ejnhqE7VcMksOYn?=
 =?us-ascii?Q?8Mcee/1mkeW6ei1ipaXkc955Xpipd/6jf6DnSN674ddw19MEOnT1Q01s1Fnp?=
 =?us-ascii?Q?uoW2u8WxyniakH3ZVamZ6BwRbPXSssoclZDovGNEOdKsJePu?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4865.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61a2697f-9616-4980-9410-08d9ec8bcd0a
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2022 11:52:23.3330
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pDQRL7ACKzRc85qX1WFbsmSAQvbksnSF9TATfB767+a9uhf1wFxhCq2i/+EWnuGfgePw58rjKAsfmOKrr5kyt2rRlGMuAaR0xNnzUuuoIfl1d3hkBqrLHK4R+XuW28Cl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR11MB3763
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
> Am 2022-02-10 10:40, schrieb Kavyasree.Kotagiri@microchip.com:
> >> EXTERNAL EMAIL: Do not click links or open attachments unless you know
> >> the
> >> content is safe
>=20
> >> > +     clocks {
> >> [..]
> >> > +
> >> > +             nic_clk: nic_clk {
> >>
> >> What does nic_clk stand for? If I had to guess, it
> >> has something to do with network. But..
> >>
> > NIC clock is the clock used by AXI, AHB fabric and APB bridges which
> > connects all the peripherals.
> > It is named so because the AXI fabric is based on NIC400 IP from ARM
>=20
> Ok, thanks for clarification.
>=20
>=20
> >> > +             watchdog: watchdog@e0090000 {
> >> > +                     compatible =3D "snps,dw-wdt";
> >> > +                     reg =3D <0xe0090000 0x1000>;
> >> > +                     interrupts =3D <GIC_SPI 38 IRQ_TYPE_LEVEL_HIGH=
>;
> >> > +                     clocks =3D <&nic_clk>;
> >>
> >> Btw. can we disable all nodes by default and enable them
> >> in the board dts files?
> > I would like to have only board specific nodes enabled in dts files
> > and rest of them in dtsi file
>=20
> And how do you know which ones are board specific? E.g. I would like
> to add our board which is also based on the lan9668. Maybe I don't
> want a watchdog (or whatever node). Of course I could use
>=20
> &watchdog {
>    status =3D "disabled";
> };
>=20
> But IMHO opt-in is better. At least thats what we are doing for
> the layerscape over on arm64.
>=20
Basically, I am disabling only the nodes which have pinctrl settings in dts=
i file
and enable in dts to make sure there are no conflicts on pins on the board.

> -michael
