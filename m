Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93E8559AFA0
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Aug 2022 20:43:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231562AbiHTSmO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Aug 2022 14:42:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbiHTSmK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Aug 2022 14:42:10 -0400
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B17C44575;
        Sat, 20 Aug 2022 11:42:09 -0700 (PDT)
Received: from pps.filterd (m0148663.ppops.net [127.0.0.1])
        by mx0a-002e3701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27KH1xcI027339;
        Sat, 20 Aug 2022 18:41:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pps0720;
 bh=LI0liKpTskCO3MTpSkd7ZcBukzUbCOFkLvZvMZghXG0=;
 b=XotfJTeeva2tDLVxs9qIqdlqNbxZg24mVBu5UVwlrQw100l3Ibu2aAUy3nc4OTtRw/iC
 V9P0IE5Z2pgId/qTBZFtktpEDAyjrqI0pwC+qmcD0bR9vCvj4TtS3Z/r9xY6OUzZ9u1o
 tt12k48xNW/iV15lIHoW8s30Ole4Irs6qPftK1HSaOnOBgOGPCzTax4goqZHXAlVuTMe
 sXu2z3hFOaKyrhDWXZ6/UJZY1pjgSWXUSFB6S7PuaiZmJkC/c+8Cp5Q/L4bFR5AzzxKB
 1YnZhic+tIDBKM0uOhcbs7gAjiBrIAxHnxS8mDvaZM6Yux2mKguCiUM6fKYHTFATGBON eg== 
Received: from p1lg14881.it.hpe.com (p1lg14881.it.hpe.com [16.230.97.202])
        by mx0a-002e3701.pphosted.com (PPS) with ESMTPS id 3j2wnjj400-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 20 Aug 2022 18:41:56 +0000
Received: from p1lg14885.dc01.its.hpecorp.net (unknown [10.119.18.236])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14881.it.hpe.com (Postfix) with ESMTPS id 0997F804CB6;
        Sat, 20 Aug 2022 18:41:56 +0000 (UTC)
Received: from adevxp033-sys.us.rdlabs.hpecorp.net (unknown [16.231.227.36])
        by p1lg14885.dc01.its.hpecorp.net (Postfix) with ESMTP id 74678803510;
        Sat, 20 Aug 2022 18:41:55 +0000 (UTC)
From:   Robert Elliott <elliott@hpe.com>
To:     herbert@gondor.apana.org.au, davem@davemloft.net,
        ebiggers@kernel.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Robert Elliott <elliott@hpe.com>
Subject: [PATCH v3 00/17] crypto: Kconfig - simplify menus and help text
Date:   Sat, 20 Aug 2022 13:41:34 -0500
Message-Id: <20220820184151.1149247-1-elliott@hpe.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220817232057.73643-1-elliott@hpe.com>
References: <20220817232057.73643-1-elliott@hpe.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: IWCn3Nr6OJbAB3MVHwXW4mv1D9qM128s
X-Proofpoint-GUID: IWCn3Nr6OJbAB3MVHwXW4mv1D9qM128s
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-20_08,2022-08-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 clxscore=1015
 impostorscore=0 suspectscore=0 priorityscore=1501 adultscore=0 spamscore=0
 lowpriorityscore=0 bulkscore=0 phishscore=0 mlxlogscore=609 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2208200079
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Improve the "make menuconfig" experience under the
Cryptographic API page.

Tested by running commands like these for arm, arm64, mips, powerpc,
sparc, s390, and x86:
    make ARCH=arm O=build-arm allmodconfig  # also defconfig
    make ARCH=arm O=build-arm menuconfig

Patch series history:
v2: divide into arch-specific Kconfig files, stop series
    after the submenu patch
v3: added back the entry name/help text changes after the
    submenu patch; submenus suggested by Eric; rebased onto v6.0-rc1

Robert Elliott (17):
  crypto: Kconfig - move mips entries to a submenu
  crypto: Kconfig - move powerpc entries to a submenu
  crypto: Kconfig - move s390 entries to a submenu
  crypto: Kconfig - move sparc entries to a submenu
  crypto: Kconfig - move x86 entries to a submenu
  crypto: Kconfig - remove AES_ARM64 ref by SA2UL
  crypto: Kconfig - submenus for arm and arm64
  crypto: Kconfig - sort the arm64 entries
  crypto: Kconfig - sort the arm entries
  crypto: Kconfig - add submenus
  crypto: Kconfig - simplify public-key entries
  crypto: Kconfig - simplify CRC entries
  crypto: Kconfig - simplify aead entries
  crypto: Kconfig - simplify hash entries
  crypto: Kconfig - simplify userspace entries
  crypto: Kconfig - simplify cipher entries
  crypto: Kconfig - simplify compression/RNG entries

 arch/arm/Kconfig                         |    4 -
 arch/arm/configs/exynos_defconfig        |    1 -
 arch/arm/configs/milbeaut_m10v_defconfig |    1 -
 arch/arm/configs/multi_v7_defconfig      |    1 -
 arch/arm/configs/omap2plus_defconfig     |    1 -
 arch/arm/configs/pxa_defconfig           |    1 -
 arch/arm/crypto/Kconfig                  |  238 ++-
 arch/arm64/Kconfig                       |    3 -
 arch/arm64/configs/defconfig             |    1 -
 arch/arm64/crypto/Kconfig                |  281 ++-
 arch/mips/crypto/Kconfig                 |   74 +
 arch/powerpc/crypto/Kconfig              |   97 +
 arch/s390/crypto/Kconfig                 |  135 ++
 arch/sparc/crypto/Kconfig                |   90 +
 arch/x86/crypto/Kconfig                  |  466 +++++
 crypto/Kconfig                           | 2242 ++++++++--------------
 drivers/crypto/Kconfig                   |    2 -
 drivers/net/Kconfig                      |    2 -
 18 files changed, 2001 insertions(+), 1639 deletions(-)
 create mode 100644 arch/mips/crypto/Kconfig
 create mode 100644 arch/powerpc/crypto/Kconfig
 create mode 100644 arch/s390/crypto/Kconfig
 create mode 100644 arch/sparc/crypto/Kconfig
 create mode 100644 arch/x86/crypto/Kconfig


base-commit: 0eaf37ee04dabc136acc68567c39d6dc35def06c
prerequisite-patch-id: 45479e93dd6a6ed73701a2155cd151d2c296bc50
prerequisite-patch-id: cd82799c9463ceb05a6528e9eac583020618754e
-- 
2.37.1

