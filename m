Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39B2847854F
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 07:57:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233534AbhLQG5r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 01:57:47 -0500
Received: from mail-bjbop0210.outbound.protection.partner.outlook.cn ([42.159.33.210]:13154
        "EHLO CN01-BJB-obe.outbound.protection.partner.outlook.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233522AbhLQG5q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 01:57:46 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q+Ypb6SOc6dOhn6mOkz553ytcGIA/Zft7G2povOqlEA68UT9G5gtb0MIdbO91yl84Y3uZsdbpEpSQC6w6LpTib86R7ZyPJY2mlZ7zi2R3+jsqAwiBykyWPJnHzIMpHsruPPINQo/GfAKNOfC7gz0WPgPojGzkKTOUFVxKepKNYf7PdHjjJbkNjUK8Zqkt7Wdp/wCJYlJmVv5W4MjR19+v69FRy/SJo6n3Akbw7dAM2akI3OuO/eKg/IS8x2nk+6rcAEUMhIDH8vBD5R//HgnXhWmHF306btiOqO5p1TZjLw04+UvlEHsIpbcuIknEbnD5uQcvoBQMOhvkL1QLbyMdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5iuz/PsXB1RIcgaKuWtJ+P4QyWg9KYDwlkxBtIly800=;
 b=X2lWfWK7m54yvqK/vuOnz0o5gvFm+qNIxF+I4DwEVd9xQZ87P3719BuIksjsWbl0KK3012x6ibBrjfU4Ke2/l++yYzaAZDf4HHCugdVkF6rGxh3rU6AceKTyi6KIyDGoYjB5Pmr0FDGDoCy3oIIXgtovKookdX6APrpBeJ96z1YJIGrM8Y8tX/o2IZCBuO0PSUiPe68iqZbvSAdQlbyx/9O3zGeSk3TbjfvTRQaIElkmY0qYyT49ch7cTpmunuRhMgKJNkCJUG5Pkukiahusrw1Y/5+MuSsPDFtosR0MZm7tNd5Fx6ZdXw9z/ttzFuf5ZiB0V1L79dV0Gwu8Xc1QAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=armchina.com; dmarc=pass action=none header.from=armchina.com;
 dkim=pass header.d=armchina.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=armchina.partner.onmschina.cn; s=selector1-armchina-partner-onmschina-cn;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5iuz/PsXB1RIcgaKuWtJ+P4QyWg9KYDwlkxBtIly800=;
 b=wgsWiAroCuF9pqvMIHDyJ3uKoA0pc2ePTzhQTGEoK/a4Fjq+UK4JHdpbEqdwPWqrFWyHM8IDxE4VhaXXgQmfeE1WKTdVTsrnaP2N+dqgLTI8Z5Stlj1bkYjncMfWA8XlNPrkGbRaVLNawF/TnNOpJHHU8B2HdwW+vB3PXjgXYJ0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=armchina.com;
Received: from SHXPR01MB0638.CHNPR01.prod.partner.outlook.cn (10.43.109.139)
 by SHXPR01MB0525.CHNPR01.prod.partner.outlook.cn (10.43.109.204) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.16; Fri, 17 Dec
 2021 06:57:42 +0000
Received: from SHXPR01MB0638.CHNPR01.prod.partner.outlook.cn ([10.43.109.139])
 by SHXPR01MB0638.CHNPR01.prod.partner.outlook.cn ([10.43.109.139]) with mapi
 id 15.20.4801.015; Fri, 17 Dec 2021 06:57:42 +0000
From:   Dejia Shang <dejia.shang@armchina.com>
To:     robh@kernel.org
Cc:     devicetree@vger.kernel.org, gregkh@linuxfoundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        dejia.shang@armchina.com, toby.huang@armchina.com
Subject: Re: [PATCH 3/4] dt-bindings: add vendor-prefix and documentation for Zhouyi NPU
Date:   Fri, 17 Dec 2021 14:57:31 +0800
Message-Id: <20211217065731.30928-1-dejia.shang@armchina.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <YbtbWh2dhMhMHMfX@robh.at.kernel.org>
References: <YbtbWh2dhMhMHMfX@robh.at.kernel.org>
Content-Type: text/plain; charset="utf-8"
X-ClientProxiedBy: SHXPR01CA0008.CHNPR01.prod.partner.outlook.cn
 (10.43.110.209) To SHXPR01MB0638.CHNPR01.prod.partner.outlook.cn
 (10.43.109.139)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b679b680-5326-40c8-a813-08d9c12a85cd
X-MS-TrafficTypeDiagnostic: SHXPR01MB0525:
X-Microsoft-Antispam-PRVS: <SHXPR01MB05256DAA554E41BC5FEFDB7F98789@SHXPR01MB0525.CHNPR01.prod.partner.outlook.cn>
Content-Transfer-Encoding: quoted-printable
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: b3N6murVpsBM+OqwioUQEuq5uOGfkNNk4urm7nsGdSGBZjkpYj38kbuk3v6+cmpDzX7jGsj2g0zj2vAn2dsJTXZ15bcR36x5Wu0ovzD9MiauFQ+8l2WUU8zy9kqRNhyrp+G+kqsDGGXLeULyem5Ne2Dd3gAb3T4OmoRU8kjN14wSKvz6l7ByOmhQUIUXdk7MQbD3ZLBQROFYNq8F8Q8BzwLONGizJO/wRjaoYDVcfMQYY/KDxIxl9ORCfMXqpcHNyWXb9mDyy+91mZIdjxguyVW1Rq832pAoFCo7mmey3Ccnh4m3ZtUK8T8ATi3qdE4v2MnOXrCmQ8tVZZ+uxGFqd9c4VBrmJmLVfymKaaXdzT6F+MxVbcOgG4uXGOHfFViRmkce4lTX+CLhL/+CeaJQllr1DC89pznIQ87bJqs3pffFlPs7xpLQG5irDv6KsXbf7H3YRIDzIABIBdxNqhSmQ2whIB8OLG+ZAqgtmzAP4F0pjc5iebRPrBICsAuH+zNMq6utqzMMlQAXoQ8sgqzoLqFRQlplQ64hJxcRBMgiyr3euKBPpS4CQeYhgOCvon/U8FHjwzocRQpMsASmx8ztCVenTYnWP7p6B+uLcY1fX0yJHbvd+0KKvzVeWepkW4ePc3Zz1ZIE7GAQsZhfUyDnMAWbSPKa7SiwLFFciaK0BB3BSYaxQSN35gyU/em8N33ayGlOnJoxu2Is2i5YSgaysg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SHXPR01MB0638.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230001)(366004)(66476007)(83380400001)(36756003)(40180700001)(44832011)(6666004)(66556008)(5660300002)(2616005)(38100700002)(38350700002)(107886003)(86362001)(66946007)(8936002)(1076003)(26005)(6916009)(40160700002)(52116002)(4326008)(508600001)(186003)(2906002)(8676002)(20210929001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Us1/UI6ZnxhfYpQtUz37GHiB8DPugdTNitXx/ilNbEuOQGB/TVxNqBUlxodh?=
 =?us-ascii?Q?YFZJFbcm3E3AID8QMmiWIPF1p3W9NS4D2h4HKeZnp5P/x2ZwWl3Yac04Ypnb?=
 =?us-ascii?Q?ZqOAfb07rs+HXX9YBz5xnAcAeEkugLI43AQOD7BKIZGCqVgdHtt7O+/H7f4R?=
 =?us-ascii?Q?sM6hZOyEUai3H8pSaGKuW8vOtVz/ZmL48jadTueSvuJlDPPE2Hrb1xkgpJKU?=
 =?us-ascii?Q?MJBvaQkKIb7Yg1pFTolR0630hwchsraXCnKccmYhbrinNvINJZmOHwEfxQhu?=
 =?us-ascii?Q?6YxcRfjTercECUNT1L0RDY8dtlITzwkaalh8UCOuESmyE1LmvuS4vpt1sU22?=
 =?us-ascii?Q?vMLC/Rrt5q42FnYacM79I7Gz0ZhyXOBepKHbnnhjq+gjQrNcgwqZyZCCSFte?=
 =?us-ascii?Q?QHm5GWQkOivS7B76mevDi4498TYR0LCkYbdAR0KIH8ZNCQtfPseU8Lqa6bkT?=
 =?us-ascii?Q?NkcixyNWFyKdKGPA9wuTR6RtEFdQ+kdd8wQ+9dQpdd/CGAmgFJhBBwYpJ2wo?=
 =?us-ascii?Q?rtSb6XE/5jXkkfHjB2y+5XKq31OBMbGSSA9wu9wmOeFHk/vjPHDP4t1VFPi+?=
 =?us-ascii?Q?hH2ix0DRO2vsG+eOhe9I9756pSOZ80x7lzTkQpWOgT7LgFNf8dIkgqEFYSuQ?=
 =?us-ascii?Q?7AkRqrK4Orhr/m5RGsTllaKx5ViUasPQtafZgkcWbYQVO4IaHEAoc3CtxYkA?=
 =?us-ascii?Q?cEn2GLWOiKwjDTp3+lUuhc8ekF0VbqIoHgZOn/YThKpnRoq2+fm1lm1kHMST?=
 =?us-ascii?Q?egJAofJuKgeyRyiEIoDBiXvzhXdf6nKd2OCONqa4WMCMrjzVTZ26lzJjlKUt?=
 =?us-ascii?Q?dV8zv3TQxc/ThM0LMsBnWGGd9Gn3lp4iuy0kN4e7cDkj65kwNNPNYkY9yrhd?=
 =?us-ascii?Q?vSdYI8/HJgGqRVCBvemQvXOtnE/NKOYE+eKqV33l19MFRrSb4vUNKkCvdHGX?=
 =?us-ascii?Q?NV94yOUQCd+GBYMNq8zxcFcIa5m+60rfWz+B3CYqTTuyYnlFEF4Vm+wbU7Pn?=
 =?us-ascii?Q?zTSB56n+H/CsYP3YxKLk/xBx1CsCiwb3GKvoa+2Hsjuupi1ig2ofWVLIwqlb?=
 =?us-ascii?Q?wtFr7raCaXpByzdVdBDMk4FGKQ8b/ycoUw1ZYw0jRCmpQ5ZrnFzNiAE2YobL?=
 =?us-ascii?Q?BoEFb5kszYPD3PiySN1PFyNAZWdgC4USZMlDTsXxZnFhBhZYQUb25G8ZXfyU?=
 =?us-ascii?Q?7FBwR7R3w8WeJGObK39AJjX9B+/WTSuH8/C93C3peJVwS0swIXII1rP+DHlD?=
 =?us-ascii?Q?1Vfy2j424ol+GpITUXUJmZSiw9HPjzo+ricvo2qgx00JjaRUl+TLc6sgnZrY?=
 =?us-ascii?Q?IeFWpb7mhanxX7U7CI2YgPd4DIppD9ZRFWxbJy3Tj+nZqVzNIjl270fhoXWB?=
 =?us-ascii?Q?PjOUDNKWZ0OvXN6w9AZNfjrEha9FBQLztuVg4m1Y/BCJ9HIGtO3CWSEBoIz2?=
 =?us-ascii?Q?Z/n0lq2rLb85q73PO/eky87HBjSWT4ZhGzrcWqHNqGYKT0LuHvugVK5HB0nk?=
 =?us-ascii?Q?46dvQ8DS1yQnPAqwOh4m8Z9yxA5JabwIGGbfaA0GjkNO2hA1Mblw21WlJJDd?=
 =?us-ascii?Q?VyMS/ONHPkOmMnioPAOe6XZFCbn3+W508uibaBwuuJIdhvozj+bfm8aE2j8o?=
 =?us-ascii?Q?NQ=3D=3D?=
X-OriginatorOrg: armchina.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b679b680-5326-40c8-a813-08d9c12a85cd
X-MS-Exchange-CrossTenant-AuthSource: SHXPR01MB0638.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2021 06:57:42.8829
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 58b271af-432f-4dad-9dee-571f404bc6a0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BuizOKSKogEt2ZfHDF4D5h848kXglTtA+hTG7WtMb8twXE/4wEEniougBplWzfcbAHWUtlZrgyCSFW2Yoch/rgF9Yus/Dg7nEk0JZrr9eDI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SHXPR01MB0525
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Wed, Dec 15, 2021 at 06:36:08PM +0800, Dejia Shang wrote:
> > To enable this NPU IP in Arm-Linux system, SoC vendors should write
> > devicetree files as documented.
> >
> > Signed-off-by: Dejia Shang <dejia.shang@armchina.com>
> > ---
> >  .../bindings/misc/armchina,zhouyi-npu.yaml    | 57 +++++++++++++++++++
> >  .../devicetree/bindings/vendor-prefixes.yaml  |  2 +
> >  2 files changed, 59 insertions(+)
> >  create mode 100644
> > Documentation/devicetree/bindings/misc/armchina,zhouyi-npu.yaml
> >
> > diff --git
> > a/Documentation/devicetree/bindings/misc/armchina,zhouyi-npu.yaml
> > b/Documentation/devicetree/bindings/misc/armchina,zhouyi-npu.yaml
> > new file mode 100644
> > index 000000000000..d3fdea101114
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/misc/armchina,zhouyi-
> npu.yaml
> > @@ -0,0 +1,57 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause) %YAML 1.2
> > +---
> > +$id: "http://devicetree.org/schemas/misc/armchina,zhouyi-npu.yaml#"
> > +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> > +
> > +title: ArmChina Zhouyi NPU bindings
> > +
> > +maintainers:
> > +  - Dejia Shang <dejia.shang@armchina.com>
> > +
> > +description: |
> > +  Armchina AI accelerator IP - Zhouyi NPU
> > +
> > +properties:
> > +  compatible:
> > +    items:
> > +      - const: armchina,zhouyi-v1
> > +      - const: armchina,zhouyi-v2
> > +      - const: armchina,zhouyi
>
> This says compatible must be a list of all 3 of these.
>
> Where do v1 and v2 come from? We don't do version numbers in DT usually
> unless they correspond to h/w revision registers or h/w documentation. I
> would assume the h/w follows the Arm rXpY form?
>

Yes, the Zhouyi NPU h/w follows the Arm rXpY form but "zhouyi-v1" (z1) and =
"zhouyi-v2" (z2)
represent two generations of Zhouyi. They have different h/w architecture, =
revision registers
and documentation.

I think I can remove "armchina,zhouyi-v1" and "armchina,zhouyi-v2" because =
the driver does not
depend on them to tell the NPU arch.

> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  memory-region:
> > +    maxItems: 2
>
> What is each region?
>
> This requires 2 entries, but the example only has 1.
>

They are reserved regions in DDR and SoC SRAM, and the latter one is option=
al for a SoC.
Should I also add the second one into the example?

> > +
> > +  interrupts:
> > +    maxItems: 1
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - interrupts
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> > +
> > +    reserved-memory {
> > +                #address-cells =3D <2>;
> > +                #size-cells =3D <2>;
> > +                ranges;
> > +
> > +                aipu_ddr_reserved: aipu-shmem@0xA0000000 {
>
> aipu-shmem@a0000000

I will fix that.

>
> > +                        compatible =3D "shared-dma-pool";
> > +                        no-map;
> > +                        reg =3D <0x0 0xA0000000 0x0 0x4000000>;
> > +                };
> > +    };
> > +
> > +    aipu0@0x64000000 {
>
> Drop '0x'

I will fix that.

>
> > +                compatible =3D "armchina,zhouyi";
> > +                reg =3D <0x0 0x64000000 0x0 0x1000>;
> > +                memory-region=3D<&aipu_ddr_reserved>;
> > +                interrupts =3D <0 168 1>;
> > +    };
> > diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml
> > b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> > index 66d6432fd781..4b1865d92455 100644
> > --- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
> > +++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> > @@ -123,6 +123,8 @@ patternProperties:
> >      description: ARM Ltd.
> >    "^armadeus,.*":
> >      description: ARMadeus Systems SARL
> > +  "^armchina,.*":
> > +    description: Arm Technology (China) Co., Ltd.
> >    "^arrow,.*":
> >      description: Arrow Electronics
> >    "^artesyn,.*":
> > --
> > 2.17.1
> >

IMPORTANT NOTICE: The contents of this email and any attachments may be pri=
vileged and confidential. If you are not the intended recipient, please del=
ete the email immediately. It is strictly prohibited to disclose the conten=
ts to any other person, use it for any purpose, or store or copy the inform=
ation in any medium. Thank you. =C2=A9Arm Technology (China) Co., Ltd copyr=
ight and reserve all rights. =E9=87=8D=E8=A6=81=E6=8F=90=E7=A4=BA=EF=BC=9A=
=E6=9C=AC=E9=82=AE=E4=BB=B6=EF=BC=88=E5=8C=85=E6=8B=AC=E4=BB=BB=E4=BD=95=E9=
=99=84=E4=BB=B6=EF=BC=89=E5=8F=AF=E8=83=BD=E5=90=AB=E6=9C=89=E4=B8=93=E4=BE=
=9B=E6=98=8E=E7=A1=AE=E7=9A=84=E4=B8=AA=E4=BA=BA=E6=88=96=E7=9B=AE=E7=9A=84=
=E4=BD=BF=E7=94=A8=E7=9A=84=E6=9C=BA=E5=AF=86=E4=BF=A1=E6=81=AF=EF=BC=8C=E5=
=B9=B6=E5=8F=97=E6=B3=95=E5=BE=8B=E4=BF=9D=E6=8A=A4=E3=80=82=E5=A6=82=E6=9E=
=9C=E6=82=A8=E5=B9=B6=E9=9D=9E=E8=AF=A5=E6=94=B6=E4=BB=B6=E4=BA=BA=EF=BC=8C=
=E8=AF=B7=E7=AB=8B=E5=8D=B3=E5=88=A0=E9=99=A4=E6=AD=A4=E9=82=AE=E4=BB=B6=E3=
=80=82=E4=B8=A5=E7=A6=81=E9=80=9A=E8=BF=87=E4=BB=BB=E4=BD=95=E6=B8=A0=E9=81=
=93=EF=BC=8C=E4=BB=A5=E4=BB=BB=E4=BD=95=E7=9B=AE=E7=9A=84=EF=BC=8C=E5=90=91=
=E4=BB=BB=E4=BD=95=E4=BA=BA=E6=8A=AB=E9=9C=B2=E3=80=81=E5=82=A8=E5=AD=98=E6=
=88=96=E5=A4=8D=E5=88=B6=E9=82=AE=E4=BB=B6=E4=BF=A1=E6=81=AF=E6=88=96=E8=80=
=85=E6=8D=AE=E6=AD=A4=E9=87=87=E5=8F=96=E4=BB=BB=E4=BD=95=E8=A1=8C=E5=8A=A8=
=E3=80=82=E6=84=9F=E8=B0=A2=E6=82=A8=E7=9A=84=E9=85=8D=E5=90=88=E3=80=82 =
=C2=A9=E5=AE=89=E8=B0=8B=E7=A7=91=E6=8A=80=EF=BC=88=E4=B8=AD=E5=9B=BD=EF=BC=
=89=E6=9C=89=E9=99=90=E5=85=AC=E5=8F=B8 =E7=89=88=E6=9D=83=E6=89=80=E6=9C=
=89=E5=B9=B6=E4=BF=9D=E7=95=99=E4=B8=80=E5=88=87=E6=9D=83=E5=88=A9=E3=80=82
