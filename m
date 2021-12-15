Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B47ED47575D
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 12:08:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236796AbhLOLI2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 06:08:28 -0500
Received: from mail-bjbop0212.outbound.protection.partner.outlook.cn ([42.159.33.212]:26895
        "EHLO CN01-BJB-obe.outbound.protection.partner.outlook.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232306AbhLOLI0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 06:08:26 -0500
X-Greylist: delayed 1079 seconds by postgrey-1.27 at vger.kernel.org; Wed, 15 Dec 2021 06:08:26 EST
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Uj9LufUh8P8Zk1P2eWxdq6V9e9gSqoq2rcyKvlPI+MwvX/FkZNqCNDWC0Zg86Z+2aJlkMCJeewzzzPOnVdNnfX28T3xryKQg1g1YbKm5Z4uitwnKLBFJGCJKikXuzHfPSWIiAHlpV5UIinbcDyZk3Rpp5B3fJZrmWT/4CxGc2kQl9xH2rC6sgHOszssTI7Ssl5cHRMwaRfOU+5sko1U15Yg5u02Gc0GkMlNB5mXoyaiYM8n552RzxVyl+ZvxzyW8ZTb/8qQ3vz4wjeLZ/h0rxQ789VjLM7yCl3TEQfWRcricKBPAGP3tQ73z5NqW4tWACrUiHMHlGqX547s39/luSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4jGQdzYhoRaffqlNk1eS1gngsaeSXsKsiqbasRqQuZ4=;
 b=CRnqZatki3JuQ7rDi5HT8jjbqIoPUOlB+mXrH1PoPkKYBc3Q4X+bQ7LrRUD8h/9oAeSIs1A7aWNyyBREBxTpRL7sPrRwuNgHLBGr46bMWOuyJdY7Rp/pdxnIZyvd0+IZAWR+FjHATkCxAzOtdRkPJMX5RFjDE8v5fZibeMttOznnw4F/7JjINDD+dNQNvpuP8KP8J7ucN8IYT5mAVBq7pQLMdKqBvXhhYmd13HaSwkVSzyr5rXzZH7aPd5f3K46V4PxkpiSuqhX6Ugo6szIL7wGLoBj8wpWvrdfoSJydPy+E7hr/tWV4SnC9U7oo84MSfb77wpp3JhKU+vnYmDf3JA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=armchina.com; dmarc=pass action=none header.from=armchina.com;
 dkim=pass header.d=armchina.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=armchina.partner.onmschina.cn; s=selector1-armchina-partner-onmschina-cn;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4jGQdzYhoRaffqlNk1eS1gngsaeSXsKsiqbasRqQuZ4=;
 b=oSQHGHTKnD9Tz3mO3mXAIgwqFOfzgF1gI5A3Lxpz67yb4K9xmA+W4ARStXb8DLOfw/TUPtwdPVm/gcliydHLLlQVfmJ/NXFgxanrjOMrdCY2xwXJpPS4Rx/bo8GTOH4jGNOwmvLSc/AqqMPg0DaTvYwZzlwm9xp+Th+KQguIgAQ=
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
Subject: [PATCH 4/4] MAINTAINERS: add maintainer info. for Zhouyi NPU
Date:   Wed, 15 Dec 2021 18:36:09 +0800
Message-Id: <20211215103609.9268-5-dejia.shang@armchina.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211215103609.9268-1-dejia.shang@armchina.com>
References: <20211215103609.9268-1-dejia.shang@armchina.com>
Content-Type: text/plain; charset="utf-8"
X-ClientProxiedBy: SHXPR01CA0021.CHNPR01.prod.partner.outlook.cn
 (10.43.110.222) To SH0PR01MB0634.CHNPR01.prod.partner.outlook.cn
 (10.43.108.74)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ebaa9d77-1d60-41cd-1543-08d9bfb6bc81
X-MS-TrafficTypeDiagnostic: SH0PR01MB0827:
X-Microsoft-Antispam-PRVS: <SH0PR01MB0827F4E66BD9AEF1EFBB884B98769@SH0PR01MB0827.CHNPR01.prod.partner.outlook.cn>
Content-Transfer-Encoding: quoted-printable
X-MS-Oob-TLC-OOBClassifiers: OLM:612;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xjBw4Vohl/VgzrF/kh22ccrv0zIkky/gffr628D59PdW60KCneYSFt1boV+cpmYAHKYE0Z3SAGWSf8lnq0/CM+CLGzil+OGZA6ztdMsgk2kF9HLh4n+cehUUIzsi/07qHaLz50YopRVn5lQBRJlTEWAxgRVRi/1Ifkaa5bKTXzkJnXhFZuP8SGHSDbSSzq7I82ypzj9XYOSCs8Jl998jlHJW0VOyen9YT9Q7HWB+ROGHEY4xUM2B96t0xfskqR+YwsjYHi+99O1FCRns25ySHTOEhScyCazErzF8BDQgaMv9wx/hyJkbfEdttKl0BVEUDU5pTeh8zZ1xHx2rvfT6US/CtgU5yn4fuqChJAHJiDbRWblglt8kNC90xUyGeLzFOAqHs/wVFvrrGQNLVSsEROKe9auas9po7qgetWT5kHw+mf2PuuTrXSpFZeFw6lenxc2qBJ2cUehQGugpedJ517VRN9AWdeesBl0x6xabxIHc92er3/+SMLuQuWqjzy4qO2bzoyk+wbyeb2yJkE0PtmfqIRGo4xtSdylxILR99hAUCrRJxat8e6Mw1YkUAz0E7YrD/Yd+mA1mXIzMuhnIJYmcWuRSOq0OFV9OGkuurpH1+9WAxFFmZHHWsVDVtMf0nK4uAEPCSiFojXQQRxcVQPXSKC0Kg8kWbtbdgaGsSmJowATUIK6eJs9O2LBDMcFVOs6T/F9ErdW2r85SeBZwJw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SH0PR01MB0634.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230001)(366004)(1076003)(6666004)(508600001)(66476007)(186003)(86362001)(52116002)(2616005)(26005)(8676002)(40180700001)(107886003)(4326008)(38350700002)(38100700002)(8936002)(44832011)(40160700002)(36756003)(66556008)(5660300002)(2906002)(66946007)(83380400001)(20210929001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?V3wTjk7Q6bFQLh8wjXi+dp6hhA3RwPe6FScW2/04SWdooOh+LfHH6Yh5GNMU?=
 =?us-ascii?Q?b0hOR7FR2eKmDW6dooc1OCkHuAGB6WLipkfD1J5uwxT5DwNvbimV/QYBe990?=
 =?us-ascii?Q?79qxBJbiGQcfhxRlTGN2ZqYoMv5UzH2ebDe1OIBjlJ1tcL3UePm9oEExsf6V?=
 =?us-ascii?Q?lYgbDwl/54MKzGjpSHyzj+rjebLsKsu/cgfH3eyVBUPHjncgVnOfCw+V7afB?=
 =?us-ascii?Q?B7yE28aduW4+Bvri1irl8WZjtdkURxaZsz3CO3/Mkq3uoicpf9Xj5l0+twz0?=
 =?us-ascii?Q?3o3B8rVR6uIiX2iUYTpjsNifabDkmKyvlL2E5Z2UCAKFkTZXpGexfGG9vEUM?=
 =?us-ascii?Q?lvRT4eA/Ta/kOMOmXxeg4ucDjumtaYFW8d1+Nsz2Kw5OfSd4yWsNYL9xOE7K?=
 =?us-ascii?Q?se6oXQo6xZqNVf2CNKnRbF17T4xrn8F/kJwOMv3AUuBCJnnpGz3xq3onRJvX?=
 =?us-ascii?Q?nnFEsKq2ci0FJ5OGbfD2Jl3HYQcXzOd1ZyKlTwZnDqiZBdnZ5fnOsGppj+tY?=
 =?us-ascii?Q?X3H0DFXSZeKzGpOd62211ucSyn3QhwpyyNpUa/Gh9ntyyYt/lPMM3N+9z8Me?=
 =?us-ascii?Q?gFbgJH8mauU8qVcZwIRcciDerue5qSL7WS2aM/VeKCDqlspH6a+WZ3V8ERyc?=
 =?us-ascii?Q?c2dRKYaHLFnf5DLO0Ghpl7ez4O80SDdg+yBo0TB/xPI3/dPAb1aRoRRi4Y6o?=
 =?us-ascii?Q?JC5otR58Yletjnd79iRZ9y/rBZT1ToLzymireflQ9P4upVg/jaEwCcOhVc5L?=
 =?us-ascii?Q?MSGyXq64fCHE6Jh+6m7Es1C4JRnE5nzUwZGIStJnKTZ0R3AvuSryA6am5QmG?=
 =?us-ascii?Q?lpBQaz38fMHopGHt3we1TDquoLQveq7oXHZ9Rvrh4VzsMaLacFH2D6hIWMNP?=
 =?us-ascii?Q?t0d99m8AXZcgVbaIpm4E2NT2jAkJOLEmntHsclMWGxBr9CjD0k7peLlawXcQ?=
 =?us-ascii?Q?Lwto+jVKEvVFiMM7sxxbr+6If7wxEODSzAy8sJ4h9AogKQijNHOljIzaKmHw?=
 =?us-ascii?Q?Hm9tUFMiiDvjQlxyEMnoRd/p1sfpCvkLSg3izwj5f9LF+nEG3Xz+kEO+q4Mj?=
 =?us-ascii?Q?pD3BxI5w3LJNLL1G1ioiEdGVT+ARteUg7x+jIs/JB4wE2S4LQuDPGy+J64mb?=
 =?us-ascii?Q?GAbToePhX9cFYQ8BVWgyItvUPE80vQftLMb59M6nWaHKnt/c+MwZxX0LTK5P?=
 =?us-ascii?Q?66yMKZ1JQzaUuSwoOMTJDbZTKGIopG4EVUk3PjYdzOQFOTMa+5OtRUMOJv/w?=
 =?us-ascii?Q?p5XB1VPDcF93sZe6nkigjClArNFyuUvKD1hcMUZbHngvr+IOTVdiCoWjDd5H?=
 =?us-ascii?Q?2o+LRXLDY4bxRxYbCchkl0d/4SvXs3Yu/5RBikW42I6J8YK13ie1+1TuCgwg?=
 =?us-ascii?Q?7/wR8ThECZPkS6oEAC8eNCdkhwwTta5fzhPFwZPsrW39yC6tiGlct+6OC9gD?=
 =?us-ascii?Q?zuIoWcN05yzfwDA32ANPWfUglWbQ1RKr2yy/rSap2+tiTHKkpv8McJHb6Rm+?=
 =?us-ascii?Q?Wfqa5kI0CGQybomxC00hv4kZS04UCS5CSUQUEB57kU7hKAj2dCwOx2zcIXYX?=
 =?us-ascii?Q?Q2YC/15AKG7sfui9ny1z5UMkn0n/lxplXMm+7LNyBOkOr8mue5luBgklsKhl?=
 =?us-ascii?Q?CA=3D=3D?=
X-OriginatorOrg: armchina.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ebaa9d77-1d60-41cd-1543-08d9bfb6bc81
X-MS-Exchange-CrossTenant-AuthSource: SH0PR01MB0634.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2021 10:36:21.8708
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 58b271af-432f-4dad-9dee-571f404bc6a0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mXKJ5JirzmqOAro5vPRTNGJG/qC1DBEmJoFJMUKc40zvyta1dnFetKF87p9qK7Cz9HNItDICYrgCS8mxS/SP4mhk4KkhOuZUzaRauc3LG14=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SH0PR01MB0827
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Zhouyi NPU IP and its SDK/driver are designed and maintained by
Arm Technology (China), i.e. ArmChina.

Signed-off-by: Dejia Shang <dejia.shang@armchina.com>
---
 MAINTAINERS | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 5f040a502859..7bb01176e169 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1827,6 +1827,16 @@ L:       linux-arm-kernel@lists.infradead.org (moder=
ated for non-subscribers)
 S:     Supported
 F:     drivers/net/ethernet/cavium/thunder/

+ARMCHINA NPU DRIVER
+M:     Dejia Shang <dejia.shang@armchina.com>
+M:     Toby Huang <toby.huang@armchina.com>
+L:     linux-arm-kernel@lists.infradead.org (moderated for non-subscribers=
)
+S:     Maintained
+F:     Documentation/ABI/testing/sysfs-devices-platform-armchina-npu
+F:     Documentation/devicetree/bindings/misc/armchina,zhouyi-npu.yaml
+F:     drivers/misc/armchina-npu/
+F:     include/uapi/misc/armchina-aipu.h
+
 ARM/CIRRUS LOGIC BK3 MACHINE SUPPORT
 M:     Lukasz Majewski <lukma@denx.de>
 L:     linux-arm-kernel@lists.infradead.org (moderated for non-subscribers=
)
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
