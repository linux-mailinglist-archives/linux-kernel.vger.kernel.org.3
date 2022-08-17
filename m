Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF338597A23
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 01:24:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242342AbiHQXVh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 19:21:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235937AbiHQXVW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 19:21:22 -0400
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F149AA50D4;
        Wed, 17 Aug 2022 16:21:21 -0700 (PDT)
Received: from pps.filterd (m0150244.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27HMgCNL023252;
        Wed, 17 Aug 2022 23:21:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pps0720;
 bh=bQld4rL5LBgqnoah5xiovpyjvvJHcFSDBe7l7OLOxTs=;
 b=d1+7To2SkeN+cCkmC6r+NF1a/HfEgJJbgTtDhoPaOWjiyFS64xZuCeW5vd6hR4jpunjW
 SK4DNxNGZraRJWoCxGszW3mFdpT1nTJwxbrN+K2Re9vyGx1ZN6XQvEhyV3vtyITBjqIx
 tz27rl7jUKEaHCw5kqfLenp7WbT1pE7GFnvnxWA9ExZtQGi9yusUYexGMfeng92aQgL7
 HP010Wu4IQAuJiNsVlPS0QGkri6KbaDt1tZsr5tUwH7gmS+6cqGvXqmtklUvXsl5gFrJ
 oiXRlnH3jXgCQvN83Z8uhAebcU+PL7d+h2/5RPmQP32AKgAaV3UHElX/URXZ40zdLoDY Aw== 
Received: from p1lg14878.it.hpe.com (p1lg14878.it.hpe.com [16.230.97.204])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3j19bv08xq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 17 Aug 2022 23:21:10 +0000
Received: from p1lg14886.dc01.its.hpecorp.net (unknown [10.119.18.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14878.it.hpe.com (Postfix) with ESMTPS id 483B7D2EC;
        Wed, 17 Aug 2022 23:21:09 +0000 (UTC)
Received: from adevxp033-sys.us.rdlabs.hpecorp.net (unknown [16.231.227.36])
        by p1lg14886.dc01.its.hpecorp.net (Postfix) with ESMTP id 8FA7380A46C;
        Wed, 17 Aug 2022 23:21:07 +0000 (UTC)
From:   Robert Elliott <elliott@hpe.com>
To:     herbert@gondor.apana.org.au, davem@davemloft.net,
        ebiggers@kernel.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Robert Elliott <elliott@hpe.com>
Subject: [PATCH v2 00/10] crypto: Kconfig - simplify menus and help text
Date:   Wed, 17 Aug 2022 18:20:47 -0500
Message-Id: <20220817232057.73643-1-elliott@hpe.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220815190608.47182-9-elliott@hpe.com>
References: <20220815190608.47182-9-elliott@hpe.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: o3E5VO7-DHXyiU4hsgFvqPupkgoexC9k
X-Proofpoint-ORIG-GUID: o3E5VO7-DHXyiU4hsgFvqPupkgoexC9k
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-17_15,2022-08-16_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 spamscore=0 priorityscore=1501 clxscore=1015
 mlxlogscore=618 phishscore=0 mlxscore=0 malwarescore=0 adultscore=0
 bulkscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208170088
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Improve the "make menuconfig" experience under the
Cryptographic API page.

The first of two patch series. This series extracts all the
architecture-specific entries from
    crypto/Kconfig
into
    arch/*/crypto/Kconfig

A subsequent series will work on the entry titles and help text.

Tested by running commands like these for arm, arm64, mips, powerpc,
sparc, s390, and x86:
    make ARCH=arm O=build-arm allmodconfig
    cd build-arm
    make ARCH=arm menuconfig
    make ARCH=arm CROSS_COMPILE=arm-linux-gnu- -j 55

Notes: 
1. powerpc doesn't build for reasons unrelated to this series.

2. arm (32-bit) requires the fix to the SA2UL driver included
in this series.

3. arm (32-bit) and mips require increasing the following value
from 1024. That change is not included in the series.
    CONFIG_FRAME_SIZE=2048


Robert Elliott (10):
  crypto: Kconfig - move mips entries to a submenu
  crypto: Kconfig - move powerpc entries to a submenu
  crypto: Kconfig - move s390 entries to a submenu
  crypto: Kconfig - move sparc entries to a submenu
  crypto: Kconfig - move x86 entries to a submenu
  crypto: Kconfig - remove AES_ARM64 selection by SA2UL entry
  crypto: Kconfig - move arm and arm64 menus to Crypto API page
  crypto: Kconfig - sort the arm64 entries
  crypto: Kconfig - sort the arm entries
  crypto: Kconfig - add submenus

 arch/arm/Kconfig                         |   4 -
 arch/arm/configs/exynos_defconfig        |   1 -
 arch/arm/configs/milbeaut_m10v_defconfig |   1 -
 arch/arm/configs/multi_v7_defconfig      |   1 -
 arch/arm/configs/omap2plus_defconfig     |   1 -
 arch/arm/configs/pxa_defconfig           |   1 -
 arch/arm/crypto/Kconfig                  | 125 ++-
 arch/arm64/Kconfig                       |   3 -
 arch/arm64/configs/defconfig             |   1 -
 arch/arm64/crypto/Kconfig                |  63 +-
 arch/mips/crypto/Kconfig                 |  60 ++
 arch/powerpc/crypto/Kconfig              |  77 ++
 arch/s390/crypto/Kconfig                 | 120 +++
 arch/sparc/crypto/Kconfig                | 103 +++
 arch/x86/crypto/Kconfig                  | 491 ++++++++++++
 crypto/Kconfig                           | 964 +++--------------------
 drivers/crypto/Kconfig                   |   2 -
 drivers/net/Kconfig                      |   2 -
 18 files changed, 1029 insertions(+), 991 deletions(-)
 create mode 100644 arch/mips/crypto/Kconfig
 create mode 100644 arch/powerpc/crypto/Kconfig
 create mode 100644 arch/s390/crypto/Kconfig
 create mode 100644 arch/sparc/crypto/Kconfig
 create mode 100644 arch/x86/crypto/Kconfig

-- 
2.37.1

