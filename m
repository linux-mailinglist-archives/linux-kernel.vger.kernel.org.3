Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 110E747576E
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 12:10:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236951AbhLOLKW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 06:10:22 -0500
Received: from mail-bjbop0216.outbound.protection.partner.outlook.cn ([42.159.33.216]:6016
        "EHLO CN01-BJB-obe.outbound.protection.partner.outlook.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236857AbhLOLKS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 06:10:18 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cac5XpHKTXXGfYca0epomiOULddVFH1p2mNlQu2DM1VNGGKgsMi5JxiMcfH4L/ZccW2o6Z8OHEffpv9twsmUKFepcq6dNOg5bH4AloHVDQ7o5FJyNydI2EkLNGj8c2AdI0ETeIf7W+VZs0BwfwvXr4PX/aZUf2Z9Kp7ZbCVNmtF44lNmKn1XlZo96qm465FZX2+S3CuziGfDeukKuU7DuZM72aMTf+uvy2FOEdM0sfc8ozehWfXple81e4WwYg+q1keAFNEogCiRS3RmjzHyBFRQc68Q8CjvQHgywNLObr0bHAs1oFI8ziUlO5i/a2OBi7FwwRgMRZe9lRA+x6Vs3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KUQwwe3Y75Qwd4kBXUakdujcL+XTwCBlfilhm0owzW4=;
 b=EwKPIpxGy4DIgWY82LCaXVn8CJA5p1A2J6RELUILXft5Rbneg5rnajqdfgaP4d4bOQpzWX+osz1XXYi8mNtabGsDQF7mEWyZAHfwPFLZPamqrgUo3k9K1TSv64ajFWwX/JB4pu1e1W1RSLzk0o79tAJep4CNlm6ZWCXQG4lZvLWPHXkdt9THZ3ifG2ls4+EE1h3jgTJJ0Xd1HyK2tEg2LQ5mto0zdPCu6ybQX2UTRJTVTYDQrvPgLsBpZhUph8JxjkFY8wuzXly+gYkuB0zixL2efUvwx3Yjy9lvAVV+W0ijYXBxBkFzxIF0Jsvx4SSHoq5R+rzQE+ULjit9LsFo1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=armchina.com; dmarc=pass action=none header.from=armchina.com;
 dkim=pass header.d=armchina.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=armchina.partner.onmschina.cn; s=selector1-armchina-partner-onmschina-cn;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KUQwwe3Y75Qwd4kBXUakdujcL+XTwCBlfilhm0owzW4=;
 b=cm1fG9ViorfvJJ26FwJLbN4qvFyqnEuQSNscwAmMogc2AudBkTSfPpjokehU4yocxhXkhbeBM7UA1DWZ6VaRigM+0AXOHzsJngBMv9GPaZ27QgfxmWGSF/fQIMuKIwyuIWmOl2ghENLnBR3KURyH76tKo5y/JLNUxs02/lArUKg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=armchina.com;
Received: from SH0PR01MB0634.CHNPR01.prod.partner.outlook.cn (10.43.108.74) by
 SH0PR01MB0827.CHNPR01.prod.partner.outlook.cn (10.43.106.150) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4778.13; Wed, 15 Dec 2021 10:36:22 +0000
Received: from SH0PR01MB0634.CHNPR01.prod.partner.outlook.cn ([10.43.108.74])
 by SH0PR01MB0634.CHNPR01.prod.partner.outlook.cn ([10.43.108.74]) with mapi
 id 15.20.4778.018; Wed, 15 Dec 2021 10:36:21 +0000
From:   Dejia Shang <dejia.shang@armchina.com>
To:     gregkh@linuxfoundation.org, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org
Cc:     dejia.shang@armchina.com, toby.shang@armchina.com
Subject: [PATCH 3/4] dt-bindings: add vendor-prefix and documentation for Zhouyi NPU
Date:   Wed, 15 Dec 2021 18:36:08 +0800
Message-Id: <20211215103609.9268-4-dejia.shang@armchina.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211215103609.9268-1-dejia.shang@armchina.com>
References: <20211215103609.9268-1-dejia.shang@armchina.com>
Content-Type: text/plain; charset="utf-8"
X-ClientProxiedBy: SHXPR01CA0021.CHNPR01.prod.partner.outlook.cn
 (10.43.110.222) To SH0PR01MB0634.CHNPR01.prod.partner.outlook.cn
 (10.43.108.74)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 764104a5-50f0-4d03-680d-08d9bfb6bc33
X-MS-TrafficTypeDiagnostic: SH0PR01MB0827:
X-Microsoft-Antispam-PRVS: <SH0PR01MB08273AB971AC9F2C733CABAE98769@SH0PR01MB0827.CHNPR01.prod.partner.outlook.cn>
Content-Transfer-Encoding: quoted-printable
X-MS-Oob-TLC-OOBClassifiers: OLM:1201;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6K1Hw/e2t8kFBCpst3OsQ1iht8iR512rwwshtv8UO0hcGzymfV5cGz+oqqyzkwkX/2gnvT2avDvmPSDzzRIWjYEIbltfeCqRBKy/NwdZYQEnnCINT6GZRfnHR2otS2A1eA1WcTxg4ma9dgHP2IrM8Fjwh/CmQ7BJAfJF0IahoVBdvErwIKPljhq4xGbyEaP5VW9uNnK0uyCgESQQIPSzQvgpBTgXdLTOjHk0fLM5+dxkkj56nm1kUdbuZ6eY9aQaPZs6WaENKaozLq6mqAQeryggixkrFDcfiITRgYdJJbCDvyo/Rt6fSDkjbweN5sUBp4IoSB7Q/gytO6fk90agEmVgmm0X1oAt6Y77FmVZkFVGpTFz9WNJJukP4YqQBtj5W8R/1P7rS75BYKrC7Ifuae9wilxZcIxcyVkSbL0HnL6a5W6Nt7nFypUS4E2k+ZezjierTNlsnDiXhDU+x5IakiyGvbX18iD6EoYoJUNuf8GGBS3oBrqKoAQO7EVw5M51fpjsl9wJyHGcte5eOClC6STb0Ni7+fPwYG3wyPMEJE2n3ErVs7GcqVTZmr0xm7aeQ7JiUpZXvXV5OnYuZvYNWOdiuq7GO0rdvNJ6yNguJUwijtMzL1nvv91QTVHXrIL3s08xJBTHAVY4AoGuL7IR061GQ1yEQeaYoY5yDJ/Mt6UjI6ZEDyZ2JWkDZuoyk8WD1Qeyes5aAFIeZoYqhjEf4g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SH0PR01MB0634.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230001)(366004)(1076003)(6666004)(508600001)(66476007)(186003)(86362001)(52116002)(2616005)(26005)(8676002)(40180700001)(107886003)(4326008)(38350700002)(38100700002)(8936002)(44832011)(40160700002)(36756003)(66556008)(5660300002)(2906002)(66946007)(83380400001)(20210929001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?v1lfoSs3//LT8vxRVfcNgnTYIFjDBzX18BEwBc4YpTKwG8XoVvmx4KxHzL4b?=
 =?us-ascii?Q?ueNN3UabYrP3tUPq9fKJ81JzcUZoe+dsYva1IXpCkF0Hjql4OVlWbkjUFf3z?=
 =?us-ascii?Q?ZXkIdBsyv8eYNs6VST4KSShdOuR2Fr3E6lMSaG3r+0heFZsLhS6Iy72S6PGn?=
 =?us-ascii?Q?Exs7wWbipa7x87TMS2Fx98D/MuWwkoDh87058ulm+xqwwIvHwhWq72LkHLRo?=
 =?us-ascii?Q?MshyS+hmaf1HyVtoH/WfU42HMM/PbYsvfCPW0FF2ue/2wrhitmqyORXPAabU?=
 =?us-ascii?Q?KQoX0CfY8dYSQgDlPjIX1bImWuD9yEGcg8gbs9ze8P3kjNo71wXnbxj38tZm?=
 =?us-ascii?Q?rrcFKkmV6qiyiaJzuczGbKO2C90mUUzH0JCdYfD5Vef3pc9715TWdxoThDz9?=
 =?us-ascii?Q?JwEHmABCNdTMnWPPjkj+1YVU5+1h36T9P4cLGJCt1lqOkEZcITTRkh9+Va+r?=
 =?us-ascii?Q?QiWx/jm4k3j/ipQi6mwTVrvGKBONtPryD/p9K38MPwo2byk5yXAgnVbsACTK?=
 =?us-ascii?Q?cotKM6632uHHNlHxiA8GkkvhR2F4jZ182ZIVO3aA/G1IteW7uVBMSdkYUwSo?=
 =?us-ascii?Q?huXQeAwiDwBycTVqRu0a0DSi91rfK6VyLgwLwMu+Gi5uCNJWQaDjS0srloU9?=
 =?us-ascii?Q?yMz/GZjnO5MzjTCYXONW+jgbthKm/FZmqtbsZJaUb2eOkJLYkDZTbd8MRngr?=
 =?us-ascii?Q?w1prF2vsmJWnzio0nks2A8K0ULdOuSTj3rzJR8VfsxDnfsSakq4NCSyQMvBA?=
 =?us-ascii?Q?4B+YEJz5XeGRTQeG0vUFMxJZYVNs+k9BzxMiLN46Bb8D8WmVUrS4gD0LmTLp?=
 =?us-ascii?Q?FezjdMcQg/Bwfho7uSXBNcPbsM9pN5BAPSKdcjfxM+vPst+01yUGabLxbg2O?=
 =?us-ascii?Q?CQ/4ZE9KWAgerxoHf6og8Z5VcksCPRZCCbhlUcKGBKMTDNknelp9YMVb7+WR?=
 =?us-ascii?Q?cXigXCD+m5qaILeI+FzVgjmcfZEp80NjmojsE9ZoAt4Wc5kPvfzqDpw2PVQr?=
 =?us-ascii?Q?FIkWuosC0kvJ/FOseOtt9yX8WjIEzJ7yBiYuxEOkFzO3uPiVXAxvetIw48qY?=
 =?us-ascii?Q?gYflXRoywxoKjFToMI0quaPqzEb6oi+pZvC4RyzC6ArfXuBk6ONes+pl5lCb?=
 =?us-ascii?Q?fgH7M9rzfaQ0mDRewbccApEBWfAA63YE+wiml44Q3wRfEHzENVYO6BUU9Dvo?=
 =?us-ascii?Q?ks9PhDzLicP+4fn164dFtNzvxOhoEftofeFn6yT9ssoWDIx694/WM9QIY9uk?=
 =?us-ascii?Q?hkHZ7u1NAhlGvfWCXAgDhf5xtqTGhtaBWNFUXNv24UQlMB75SrydzZY0+5Ky?=
 =?us-ascii?Q?hmCosr7Ii4oK3yBHKoMUHJF65nAQ3we6YJbZHILuLyyHJg8JLYCgf89MaqbY?=
 =?us-ascii?Q?OaCs3DYZmIl15tcNBg/LVrFCxJDeAc2RG0gSpaYq1NWOJasTjsg/Ho0btHIX?=
 =?us-ascii?Q?AqvZsIXTYwDxnxk2eGlMzc2qYpZoOrgTaQMuRbGGczsR5OQ9biMuWRyXaOIN?=
 =?us-ascii?Q?mQEjnn7anT6SocMMK251lu7F+gbrtRqQIKCQ1Aj2OvRbG7B28fjhe8NQZih5?=
 =?us-ascii?Q?YcoBuMshtjXUNu10Ds062Qzu07sgcrTTxPRsfd2EERX9N2ffYuGihNSTjWnz?=
 =?us-ascii?Q?YQ=3D=3D?=
X-OriginatorOrg: armchina.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 764104a5-50f0-4d03-680d-08d9bfb6bc33
X-MS-Exchange-CrossTenant-AuthSource: SH0PR01MB0634.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2021 10:36:21.3597
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 58b271af-432f-4dad-9dee-571f404bc6a0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: al9+/2zyKod/ZXHMHLcFZ6rlaSckc0rhN1qXyizmOjUh/B5v6B2CEs8XF/TDvARh5fmbvUbEt3TSDv4clFopy6gzRpsVYclF0rOLkvVPqog=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SH0PR01MB0827
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To enable this NPU IP in Arm-Linux system, SoC vendors should
write devicetree files as documented.

Signed-off-by: Dejia Shang <dejia.shang@armchina.com>
---
 .../bindings/misc/armchina,zhouyi-npu.yaml    | 57 +++++++++++++++++++
 .../devicetree/bindings/vendor-prefixes.yaml  |  2 +
 2 files changed, 59 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/misc/armchina,zhouyi-=
npu.yaml

diff --git a/Documentation/devicetree/bindings/misc/armchina,zhouyi-npu.yam=
l b/Documentation/devicetree/bindings/misc/armchina,zhouyi-npu.yaml
new file mode 100644
index 000000000000..d3fdea101114
--- /dev/null
+++ b/Documentation/devicetree/bindings/misc/armchina,zhouyi-npu.yaml
@@ -0,0 +1,57 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/misc/armchina,zhouyi-npu.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: ArmChina Zhouyi NPU bindings
+
+maintainers:
+  - Dejia Shang <dejia.shang@armchina.com>
+
+description: |
+  Armchina AI accelerator IP - Zhouyi NPU
+
+properties:
+  compatible:
+    items:
+      - const: armchina,zhouyi-v1
+      - const: armchina,zhouyi-v2
+      - const: armchina,zhouyi
+
+  reg:
+    maxItems: 1
+
+  memory-region:
+    maxItems: 2
+
+  interrupts:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - interrupts
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    reserved-memory {
+                #address-cells =3D <2>;
+                #size-cells =3D <2>;
+                ranges;
+
+                aipu_ddr_reserved: aipu-shmem@0xA0000000 {
+                        compatible =3D "shared-dma-pool";
+                        no-map;
+                        reg =3D <0x0 0xA0000000 0x0 0x4000000>;
+                };
+    };
+
+    aipu0@0x64000000 {
+                compatible =3D "armchina,zhouyi";
+                reg =3D <0x0 0x64000000 0x0 0x1000>;
+                memory-region=3D<&aipu_ddr_reserved>;
+                interrupts =3D <0 168 1>;
+    };
diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Docum=
entation/devicetree/bindings/vendor-prefixes.yaml
index 66d6432fd781..4b1865d92455 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -123,6 +123,8 @@ patternProperties:
     description: ARM Ltd.
   "^armadeus,.*":
     description: ARMadeus Systems SARL
+  "^armchina,.*":
+    description: Arm Technology (China) Co., Ltd.
   "^arrow,.*":
     description: Arrow Electronics
   "^artesyn,.*":
--
2.17.1

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
