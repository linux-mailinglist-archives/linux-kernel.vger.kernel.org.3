Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E230475762
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 12:09:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236818AbhLOLJG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 06:09:06 -0500
Received: from mail-shaop0210.outbound.protection.partner.outlook.cn ([42.159.161.210]:6342
        "EHLO CN01-SHA-obe.outbound.protection.partner.outlook.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232306AbhLOLJF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 06:09:05 -0500
X-Greylist: delayed 1961 seconds by postgrey-1.27 at vger.kernel.org; Wed, 15 Dec 2021 06:09:04 EST
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RaJ7FUpU+8eNsXohMBVf3Leyi6QYolHxzH84L2/AIw6scU2laxtGh0pllDtZrB1Pm80ag9ufBoe9jK6ju6sp2zd43qSPztUUvGxL1oMTAcKP0TmxbaRcRge4VSr9fAxKaXNii0tvvJpRdLZFVKaNgdng+TId0seYKtQ3qlf0Dzm+MsRunVKpk1xD9kyrCwRpnYpDC2HyUMK3QiM/kBkIRlpwjwj5LqvBbyUKCt7RYo5PNrQhmnRvS24pmdbHIIMvc5RdCfpz2Y6UotTb6PuG4UyKNA72DjRPntGc1doQeELUZGfgs84qUAV5VgZ2Rp+dPmJazTF0dc86/WZDuivOYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XPjfI1AeIP3LRgemHdeGpu08c/yirG5c5cL3ZdTXLe8=;
 b=HfnQUhYzTReO2n+8ksTGF6pQv4XWBJzF1Lz6rovodqD9J/JddbSYDYQjNP7ILa/Rp4rTrbbPaJhMUYNKsTs4j02YIUIuzzbk601UWFG5GIQfCSjhmoz8gaCSoDzKCljBdL3CQgoKDSuyJBc7g0S/rqv+WC45KH/cOQ2hir8cTbJzrWDDz/CHyX2JjJn+LIv+eA9ERHqtq9hdqUQth3lnVKGm4VjpkT7z9Sy2XEoNLFtxQ1v+n/d/Sy6a7EfhH2ELA39nlaErrYkarQ8iVypAr/Nbdue2xuoHmyMH5UOEXiYFpTYOdhGm+vYp0ZKQiy86MqWMOAKwEGGrEkL67CX1RQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=armchina.com; dmarc=pass action=none header.from=armchina.com;
 dkim=pass header.d=armchina.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=armchina.partner.onmschina.cn; s=selector1-armchina-partner-onmschina-cn;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XPjfI1AeIP3LRgemHdeGpu08c/yirG5c5cL3ZdTXLe8=;
 b=oBFf43a0fWivygnz+0CyFeCBaKxmUrEvHcZUpNwPr51DjoUMzI0fiOhI+Q4bhLR+j53JpWSWA9SvjF1ZD9ZLfp44ZTI/aK1D1/dE5QDaMBnwqSjOR3NE0J/ci00veB3NBWQX3NuPelu8LO70sABbCMI9ceWDBBapCp1VU5sKzSY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=armchina.com;
Received: from SH0PR01MB0634.CHNPR01.prod.partner.outlook.cn (10.43.108.74) by
 SH0PR01MB0827.CHNPR01.prod.partner.outlook.cn (10.43.106.150) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4778.13; Wed, 15 Dec 2021 10:36:20 +0000
Received: from SH0PR01MB0634.CHNPR01.prod.partner.outlook.cn ([10.43.108.74])
 by SH0PR01MB0634.CHNPR01.prod.partner.outlook.cn ([10.43.108.74]) with mapi
 id 15.20.4778.018; Wed, 15 Dec 2021 10:36:19 +0000
From:   Dejia Shang <dejia.shang@armchina.com>
To:     gregkh@linuxfoundation.org, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org
Cc:     dejia.shang@armchina.com, toby.shang@armchina.com
Subject: [PATCH 0/4] misc: add ArmChina Zhouyi NPU driver
Date:   Wed, 15 Dec 2021 18:36:05 +0800
Message-Id: <20211215103609.9268-1-dejia.shang@armchina.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain; charset="utf-8"
X-ClientProxiedBy: SHXPR01CA0021.CHNPR01.prod.partner.outlook.cn
 (10.43.110.222) To SH0PR01MB0634.CHNPR01.prod.partner.outlook.cn
 (10.43.108.74)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0150d1de-9c18-4d27-2281-08d9bfb6bb19
X-MS-TrafficTypeDiagnostic: SH0PR01MB0827:
X-Microsoft-Antispam-PRVS: <SH0PR01MB082739DCEB41DD5E81C0FFF598769@SH0PR01MB0827.CHNPR01.prod.partner.outlook.cn>
Content-Transfer-Encoding: quoted-printable
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Hrwnm3LiRDeGFlef2H8xIrdmN0Is0XvhKVYJGxh6WcgT4kJ+fy9k2tyeMSgdgYwZGp89Sdb/MHxgWmMWSplXpL2m3zup2XEKlDzRc+nkQw/1O/MmTRQBb/R+PuvFub4HNo1gysRrWH2ryWsioLkn4oT4lNwQidqDEkElq/J5E8z6sUJQLOxJsRtyDuoR8T1b0MXjL6EshS9I2pJ6R8kRAB6lEYC29aJsmhO/TruosZEhbG6BoTewxPj+tBWiwTgl9yl2xNdgZYbvifUM30yJxk6zQUJO+UbnbyBLe5l+v2rxBOMwUjRaxLYJeBXoYjumxX2+Z/X2BCQBYltwqEnNksVtmu0l4MWcgvX3oO7tyW5AyDask7MnXnvugwy+ofyp5ewt+RUKT1NwnoSFalpXgVb0pjpkKTsekmVqViDXlacR6Hp+EUg73gSWgsNiHni/5Sbf41sUnaDrdFcfo+z+JYG/5eMPU23F0yzKo+tWVHA7x5NdPoBxhVG2CweTAQYSHlqITr7rEqt7i7xudC/tHIXDu9EMnV00xxz6xao9ScAvSFjVj2q65cVeZEbITM7wsJ7WAcgWr+P73LnXYu3IyEda7htPzpUHS5HwJ2W98rqBfhqd5Q6+JYUbanfiA0V0YIgzj6fuU1JP7G9qiGa+kZnMxMKMJtDpkHCcjLUjBYEbTFZtjGc95buvH1vo55nZvTAdclr9GVTmDk6wjpqTjw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SH0PR01MB0634.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230001)(366004)(1076003)(6666004)(508600001)(66476007)(186003)(86362001)(52116002)(2616005)(966005)(26005)(8676002)(40180700001)(107886003)(4326008)(38350700002)(38100700002)(8936002)(44832011)(40160700002)(36756003)(66556008)(5660300002)(2906002)(66946007)(83380400001)(20210929001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VdeD/AU6Ccr7HBZnMrN4hf5sWxyrDhn9tuHLmtG8cO8u8Pod47e96207EKVl?=
 =?us-ascii?Q?HHSRDYZv6mmz/ebzr7iDu1XNKBWpGpl94qXgYAe6g8wsaJrIppt6456K3Drs?=
 =?us-ascii?Q?7DC5UGYMdybMIjAB484SSSDdWTHbv9adKNzps5P3glCsN/h8Xg0fP6K++IDh?=
 =?us-ascii?Q?D58yKdRAlorEKv0RIei5CSrmKtp6LUcGMB+ezAPJpVRO84ZzrGQrXBNr0nXl?=
 =?us-ascii?Q?tHLLHBiZr/LjC2nqGd38/8kth8T6mCbolKGWlK5UEo2Nt2Hi7LAE57E8mTFz?=
 =?us-ascii?Q?r+3lMPQvj6ycQhcZmp+L8cSO1tdb6Bf5ZBcO0O9SmicnI43VeDq4DR85P9JD?=
 =?us-ascii?Q?dkAC8v+4Ujh4sytPNtdiEEugwOBPNES8QmUf2MU9ElYSnPJJeYJo1Jhd2x5k?=
 =?us-ascii?Q?E6it7BRjHCSc0t4VWyGxxJAhgAXw0sLTv9unAUiEBIV1IuNKc3IH8R2ITB5D?=
 =?us-ascii?Q?28h9AFOofTujtH20LSrl5e2HjtU23wR97QK+ai5uOvLNpGstHlodS9JPWHq3?=
 =?us-ascii?Q?cyel4M5eEDS2u1FPK1263KG+27SdmeaRKqzE80YzfGqMsO5bwLhsEjySGS5Z?=
 =?us-ascii?Q?ehBrW6ekROJKyVSxF6thaDYj51WOhMOPRhYRwNbK+nloYbA+nSkv0rNBo4te?=
 =?us-ascii?Q?CxgfJIl1G3PoUwRN26muh0dbWyUAPGAVzKN5kQrGrC+4Jr6Y5y8wZTMJz6Qo?=
 =?us-ascii?Q?cl+VB+FC28+dBAqMK15QPc1p9VwWuKVw0JF1p+/9wdXSdrESgXE1UDglRxRA?=
 =?us-ascii?Q?2IV2uyachSspVj8ki/uIXgGbYmst1AJzeHUGGd31pohRL9LBgmocd88B06im?=
 =?us-ascii?Q?qy8wktugOPbuT3f7kkmZCKspLFeOZdaZyZd/dp4ZTCNzwk55HJS9/IqsnDq5?=
 =?us-ascii?Q?VItoQX2Fx7VsN6ifOyT5nGjG/Rmi/WY135M7J5KaRUh9HrD9gq9KIJ/gjid0?=
 =?us-ascii?Q?JzQWb4yzRi7Naeg0ETaHjwYdG6djq611teQ52pVG7em/SwUqSeU7B33IkUFc?=
 =?us-ascii?Q?/O4dJzp9mlWLNHyA4RRQfYF9KSJpSJ9maxq8RJUMJr0CxIxmEj6nQsKnxPoy?=
 =?us-ascii?Q?YXxxR9rnuq7RoEwXvzU0r2KxDXJDWpLRC4pc0appDHo5g1C/UZdLqFiHJ5M9?=
 =?us-ascii?Q?40pZSaO/EJLrSNhvRjR7CZ9LXg6pXglnmZdQfk5hGqqJC0Da41zAEXMqIFbE?=
 =?us-ascii?Q?WsuXkiCu68Gwj/2hzSMywDI+5XRaZVaNLtvgOJzXrFwRoPY/haDMnP61qUid?=
 =?us-ascii?Q?NNS3SFQHY8MM68/Vq2yTWOBPyZNsNf4RJfQgkD8YMytQDFdAtSNtsxpE0BRP?=
 =?us-ascii?Q?4pT0Le7PITniUnNr1SKz4EJPU6u9KY9OBoMS3gr0mthYr0BbqMIRJPJpa/Iw?=
 =?us-ascii?Q?XtFq0M9I6YLVDZHA2wGaMPAO/wqB3cORrxpE84g+f9Rc0izcedTBzMsClU/o?=
 =?us-ascii?Q?MJBvRRGpxHArPf6fNiut1flweF6CAtJEmRpzsJZjemWxwBu+kPiuqs+Eozn6?=
 =?us-ascii?Q?/KZfF7CVdT54C8eTr3LeFumsIjZWhoisEGRYgQUbcbxxAz+G4l/rmM8+e0VT?=
 =?us-ascii?Q?mBrDKou0ts5SpgTOeJ+TKsEuHG2DuwaLTbT5uc9Zv8jvNeNJF2uD3tFN/HXs?=
 =?us-ascii?Q?oQ=3D=3D?=
X-OriginatorOrg: armchina.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0150d1de-9c18-4d27-2281-08d9bfb6bb19
X-MS-Exchange-CrossTenant-AuthSource: SH0PR01MB0634.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2021 10:36:19.4978
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 58b271af-432f-4dad-9dee-571f404bc6a0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1+awXN00kXRH4j0q/bVHb1VyQvtw3P8/n1/GzD9+SAoEZPeVy1IEZhb+s706/Y1F6ckWMj6B433qH+gkU8rXeyEWnm/S6E178EqLrUFnmNE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SH0PR01MB0827
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

These 4 patches add supports to the ArmChina Zhouyi NPU IPs.

The Zhouyi NPUs (and software for it) are designed by Arm Technology (China=
) Co. Ltd.,
i.e. short for ArmChina, for edge AI computing devices in markets like smar=
t home, auto,
IoT, mobile, etc. The brand name "Zhouyi" comes from a Chinese traditional =
classic about
changes and predictions. Currently two versions of Zhouyi IP (Z1 and Z2) ar=
e released,
and they are integrated into SoC chips Allwinner R329 and Siengine SE1000, =
respectively.

This driver supports the control of Zhouyi Z1 and Z2 NPUs. By using the use=
r mode driver
APIs, application program can schedule AI inference tasks on Zhouyi NPUs ef=
ficiently. The
user mode part of this driver is opensourced now and anyone can fetch it fr=
om github:
https://github.com/dejsha01/armchina-zhouyi.

We found that a few days ago someone submitted a legacy version of Zhouyi N=
PU driver:
https://lore.kernel.org/lkml/20211126021904.32325-1-caihuoqing@baidu.com/#t=
.
We think that the current version in these 4 patches is better for upstream=
ing because
it contains bug-fixes and code optimizations compared with the legacy versi=
on,
and the corresponding user mode driver for this kernel driver is opensource=
d.

I would appricate any feedback, question or review :)

Thanks,
Dejia

Dejia Shang (4):
  misc: add ArmChina Zhouyi NPU driver
  Documentation: add sysfs entries for Zhouyi NPU
  dt-bindings: add vendor-prefix and documentation for Zhouyi NPU
  MAINTAINERS: add maintainer info. for Zhouyi NPU

 .../sysfs-devices-platform-armchina-npu       |  13 +
 .../bindings/misc/armchina,zhouyi-npu.yaml    |  57 ++
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 MAINTAINERS                                   |  10 +
 drivers/misc/Kconfig                          |   1 +
 drivers/misc/Makefile                         |   1 +
 drivers/misc/armchina-npu/Kconfig             |  15 +
 drivers/misc/armchina-npu/Makefile            |  11 +
 drivers/misc/armchina-npu/aipu.c              | 312 ++++++++
 drivers/misc/armchina-npu/aipu_core.c         | 418 ++++++++++
 drivers/misc/armchina-npu/aipu_core.h         | 100 +++
 drivers/misc/armchina-npu/aipu_io.c           |  74 ++
 drivers/misc/armchina-npu/aipu_io.h           |  27 +
 drivers/misc/armchina-npu/aipu_irq.c          | 113 +++
 drivers/misc/armchina-npu/aipu_irq.h          |  36 +
 drivers/misc/armchina-npu/aipu_job_manager.c  | 689 ++++++++++++++++
 drivers/misc/armchina-npu/aipu_job_manager.h  | 110 +++
 drivers/misc/armchina-npu/aipu_mm.c           | 740 ++++++++++++++++++
 drivers/misc/armchina-npu/aipu_mm.h           | 127 +++
 drivers/misc/armchina-npu/aipu_priv.c         | 280 +++++++
 drivers/misc/armchina-npu/aipu_priv.h         |  58 ++
 drivers/misc/armchina-npu/aipu_soc_default.c  |  82 ++
 drivers/misc/armchina-npu/config.h            |  12 +
 .../armchina-npu/include/armchina_aipu_soc.h  |  52 ++
 drivers/misc/armchina-npu/zhouyi/Makefile     |   4 +
 drivers/misc/armchina-npu/zhouyi/z1.c         | 244 ++++++
 drivers/misc/armchina-npu/zhouyi/z1.h         |  33 +
 drivers/misc/armchina-npu/zhouyi/z2.c         | 311 ++++++++
 drivers/misc/armchina-npu/zhouyi/z2.h         |  47 ++
 drivers/misc/armchina-npu/zhouyi/zhouyi.c     | 142 ++++
 drivers/misc/armchina-npu/zhouyi/zhouyi.h     |  73 ++
 include/uapi/misc/armchina_aipu.h             | 335 ++++++++
 32 files changed, 4529 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-devices-platform-armchi=
na-npu
 create mode 100644 Documentation/devicetree/bindings/misc/armchina,zhouyi-=
npu.yaml
 create mode 100644 drivers/misc/armchina-npu/Kconfig
 create mode 100644 drivers/misc/armchina-npu/Makefile
 create mode 100644 drivers/misc/armchina-npu/aipu.c
 create mode 100644 drivers/misc/armchina-npu/aipu_core.c
 create mode 100644 drivers/misc/armchina-npu/aipu_core.h
 create mode 100644 drivers/misc/armchina-npu/aipu_io.c
 create mode 100644 drivers/misc/armchina-npu/aipu_io.h
 create mode 100644 drivers/misc/armchina-npu/aipu_irq.c
 create mode 100644 drivers/misc/armchina-npu/aipu_irq.h
 create mode 100644 drivers/misc/armchina-npu/aipu_job_manager.c
 create mode 100644 drivers/misc/armchina-npu/aipu_job_manager.h
 create mode 100644 drivers/misc/armchina-npu/aipu_mm.c
 create mode 100644 drivers/misc/armchina-npu/aipu_mm.h
 create mode 100644 drivers/misc/armchina-npu/aipu_priv.c
 create mode 100644 drivers/misc/armchina-npu/aipu_priv.h
 create mode 100644 drivers/misc/armchina-npu/aipu_soc_default.c
 create mode 100644 drivers/misc/armchina-npu/config.h
 create mode 100644 drivers/misc/armchina-npu/include/armchina_aipu_soc.h
 create mode 100644 drivers/misc/armchina-npu/zhouyi/Makefile
 create mode 100644 drivers/misc/armchina-npu/zhouyi/z1.c
 create mode 100644 drivers/misc/armchina-npu/zhouyi/z1.h
 create mode 100644 drivers/misc/armchina-npu/zhouyi/z2.c
 create mode 100644 drivers/misc/armchina-npu/zhouyi/z2.h
 create mode 100644 drivers/misc/armchina-npu/zhouyi/zhouyi.c
 create mode 100644 drivers/misc/armchina-npu/zhouyi/zhouyi.h
 create mode 100644 include/uapi/misc/armchina_aipu.h

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
