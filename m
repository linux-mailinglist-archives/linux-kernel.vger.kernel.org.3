Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DEAF4DAFF7
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 13:43:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355853AbiCPMnx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 08:43:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355827AbiCPMnw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 08:43:52 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CA9266233;
        Wed, 16 Mar 2022 05:42:38 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id r13so3899640ejd.5;
        Wed, 16 Mar 2022 05:42:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=9IInFWrLxCVqPix8X21YygHN86QpSMY0BdaJzSVmBoc=;
        b=LDbSMsXV8Ov5U+KaAZBIfn3hKYyhKypsC3fWznpL7UpqseP5Ua6h/w2tMR44iqQti5
         QemZ8IxrxCLE77kqxTCw1fgpxUV/l3sHc3ODOXRxIjRUvVWkcXfZxvg8YQOboMZ9OzIz
         8tXvEt1qUp/ReRB6aVnSK8rukyTcpSgwgxoyNTcw9gTd1wcKXo3Hc1/I4FsciXYMsC5A
         Gu4fVuHX39pymWOYyRBetJOHc/2XJuj6Bx+Bbm35ldz9+VT6nnQTL/+93SVeUWDlI5yr
         SJlVjlAXYS54I71RDpnkSZwbo9IM61mop1gRNOf2Gte7TJhOtwjYufxncW6OiZIw2SE7
         RLDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=9IInFWrLxCVqPix8X21YygHN86QpSMY0BdaJzSVmBoc=;
        b=l/y89eA+HO92TH10vn/rDFDNwadsQrssBbKc+CX9WfjiR/XaegXijA23xdaqBe39+b
         TCCmLSbUPsg7RhdPzDf+YiVvpmZ+QkNAtWHiHpLI18hWt3GoPHARAuQHGj1q3t0y+x+C
         aNbLIe8UoZj5l/cC0e9tHAq4c7aUim3VUCJzzrhD0syH5aXlazWlXTDOcXNR/VUF0kxJ
         Z9fgUzFWh++rxOwqXG/amGxbmREKnJCdoWVEOLRtvdhd7G4mbsRQSivJJE6uMWX5acBd
         nddE3ybu61iDQDWCOtxboNP/FKNku4y4tkvkEbq3J2C0hzYyxIJscXyRsqVKbQOIGFz0
         AEvg==
X-Gm-Message-State: AOAM531qAln5egxCAyzWY760JbfxTFVg+pMRRvzCOqyyQeylK81quT6b
        ySO/60hL33Dg1v+WMhEngb0=
X-Google-Smtp-Source: ABdhPJxzYN1LhU3YiE/4BtEOd+7p1K6N+tDvf5hL4uhYLhywE2nS+2o556lATWec5chd0V0Ja9Uheg==
X-Received: by 2002:a17:906:58b:b0:6cf:65f5:de28 with SMTP id 11-20020a170906058b00b006cf65f5de28mr25879917ejn.614.1647434556867;
        Wed, 16 Mar 2022 05:42:36 -0700 (PDT)
Received: from felia.fritz.box (200116b826783100351493f9f729970f.dip.versatel-1u1.de. [2001:16b8:2678:3100:3514:93f9:f729:970f])
        by smtp.gmail.com with ESMTPSA id ji15-20020a170907980f00b006df87edf6ebsm129620ejc.154.2022.03.16.05.42.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Mar 2022 05:42:36 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
        Alex Williamson <alex.williamson@redhat.com>
Cc:     Zhou Wang <wangzhou1@hisilicon.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] MAINTAINERS: adjust entry for header movement in hisilicon qm driver
Date:   Wed, 16 Mar 2022 13:42:24 +0100
Message-Id: <20220316124224.29091-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit ff5812e00d5e ("crypto: hisilicon/qm: Move the QM header to
include/linux") moves drivers/crypto/hisilicon/qm.h to
include/linux/hisi_acc_qm.h, but misses to adjust MAINTAINERS.

Hence, ./scripts/get_maintainer.pl --self-test=patterns complains about a
broken reference.

Adjust the file entry in the HISILICON QM AND ZIP Controller DRIVER
following this file movement.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
Alex, please pick this minor clean-up on your -next tree on top of the
commit above.

 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 845b36c0f0f5..963d7001f2ce 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8852,9 +8852,9 @@ L:	linux-crypto@vger.kernel.org
 S:	Maintained
 F:	Documentation/ABI/testing/debugfs-hisi-zip
 F:	drivers/crypto/hisilicon/qm.c
-F:	drivers/crypto/hisilicon/qm.h
 F:	drivers/crypto/hisilicon/sgl.c
 F:	drivers/crypto/hisilicon/zip/
+F:	include/linux/hisi_acc_qm.h
 
 HISILICON ROCE DRIVER
 M:	Wenpeng Liang <liangwenpeng@huawei.com>
-- 
2.17.1

