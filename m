Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A95B53A927
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 16:27:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353556AbiFAO1T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 10:27:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355044AbiFAO0z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 10:26:55 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4619865BC;
        Wed,  1 Jun 2022 07:21:48 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id c197so1380872qke.12;
        Wed, 01 Jun 2022 07:21:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qrASeeoMBWlckEV00ZNAT86iUYmYHAG/1QJtuQ7vhsQ=;
        b=ohu+s7qgiXPXl5GzU0nViruYGWQqaFjfsU5JSGJdfT9G6azp3Ra3BFmEjtA5dodBwt
         nQkV+ysfOaNSlKDIa8EgC+aQ+7FoMe9j3enjHi0HuGZcSCB196ZyyG6dMMin3I4Em7tr
         XZXL63flh4PEQ/8caN4pXkFSOo3o6UvCHDlrAJDiv2lJ0mQY7YL0sb2yEu95mD2yf+Bg
         G8LGoW5JHmQL2imrxcplObolasPQEv3/s+E4gv2Nb0/3G3z1RtnrnXEHLH4ciURlLO03
         9Q1Pzjpr8RY56I4iuIdA86UoA754q+KSE7TJVRbbHrhzMQNZA5+TAAaBAp9QGTUblGmf
         Vu0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qrASeeoMBWlckEV00ZNAT86iUYmYHAG/1QJtuQ7vhsQ=;
        b=hXMOlVfZGia0/60BUw5uPVe/na34sqG31NPGlr2i2IpSp1cYaqy+eV6UVN1mo64LnX
         J4RIaCgZLX3YDVMbBmdPTv+PwHynHyJF6P1TvNSQh3wV82yB493Xbx/SruXzrTzpdXdi
         xxnLLS6JEX9/ov16iU2S8xlc1eUkCYkxsU+qGhJNfppeLCvfxVU1DHUJrGYpSvR8U1VU
         ddj9nrGXZ+ZBxKRjGMsVlDvKIbjatfm1C8FkSrfHft7ROdLnd8Nzft3h8ag0UFI9dNTx
         m4hdZgP+zw1zVtOjypdonatJfSKy905kDWsUrBdAk/R/PmBXg2jP21kxdTUh757jkFzS
         vZlg==
X-Gm-Message-State: AOAM530EbyjI6rN1mB2P1qejBEYjZHEN12xlsICJJ3lid+sBrxIGecas
        rvCKG6c0PaZnlGrjGhi2aezK0I1kQquXSA==
X-Google-Smtp-Source: ABdhPJzqSJtF8CQVzG219yTKRwbvqj+v4SGGCw5/ICo4f1twSeWtgokshw6/KWUqhIaZaO/B6CXgZA==
X-Received: by 2002:a05:620a:2950:b0:6a3:a838:ad70 with SMTP id n16-20020a05620a295000b006a3a838ad70mr243737qkp.14.1654093307307;
        Wed, 01 Jun 2022 07:21:47 -0700 (PDT)
Received: from shaak.. (modemcable055.92-163-184.mc.videotron.ca. [184.163.92.55])
        by smtp.gmail.com with ESMTPSA id x23-20020ac86b57000000b002f93760e4cfsm1159895qts.26.2022.06.01.07.21.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jun 2022 07:21:46 -0700 (PDT)
From:   Liam Beguin <liambeguin@gmail.com>
To:     liambeguin@gmail.com, jic23@kernel.org, rdunlap@infradead.org
Cc:     peda@axentia.se, masahiroy@kernel.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: [PATCH 1/1] iio: test: fix missing MODULE_LICENSE for IIO_RESCALE=m
Date:   Wed,  1 Jun 2022 10:21:38 -0400
Message-Id: <20220601142138.3331278-1-liambeguin@gmail.com>
X-Mailer: git-send-email 2.35.1.4.g5d01301f2b86
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When IIO_RESCALE_KUNIT_TEST=y and IIO_RESCALE=m,
drivers/iio/afe/iio-rescale.o is built twice causing the
MODULE_LICENSE() to be lost, as shown by:

	ERROR: modpost: missing MODULE_LICENSE() in drivers/iio/afe/iio-rescale.o

Rework the build configuration to have the dependency specified in the
Kconfig.

Reported-by: Randy Dunlap <rdunlap@infradead.org>
Fixes: 8e74a48d17d5 ("iio: test: add basic tests for the iio-rescale driver")
Signed-off-by: Liam Beguin <liambeguin@gmail.com>
Acked-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org>
Reviewed-by: Masahiro Yamada <masahiroy@kernel.org>
---
 drivers/iio/test/Kconfig  | 2 +-
 drivers/iio/test/Makefile | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/test/Kconfig b/drivers/iio/test/Kconfig
index 56ca0ad7e77a..4c66c3f18c34 100644
--- a/drivers/iio/test/Kconfig
+++ b/drivers/iio/test/Kconfig
@@ -6,7 +6,7 @@
 # Keep in alphabetical order
 config IIO_RESCALE_KUNIT_TEST
 	bool "Test IIO rescale conversion functions"
-	depends on KUNIT=y && !IIO_RESCALE
+	depends on KUNIT=y && IIO_RESCALE=y
 	default KUNIT_ALL_TESTS
 	help
 	  If you want to run tests on the iio-rescale code say Y here.
diff --git a/drivers/iio/test/Makefile b/drivers/iio/test/Makefile
index f15ae0a6394f..880360f8d02c 100644
--- a/drivers/iio/test/Makefile
+++ b/drivers/iio/test/Makefile
@@ -4,6 +4,6 @@
 #
 
 # Keep in alphabetical order
-obj-$(CONFIG_IIO_RESCALE_KUNIT_TEST) += iio-test-rescale.o ../afe/iio-rescale.o
+obj-$(CONFIG_IIO_RESCALE_KUNIT_TEST) += iio-test-rescale.o
 obj-$(CONFIG_IIO_TEST_FORMAT) += iio-test-format.o
 CFLAGS_iio-test-format.o += $(DISABLE_STRUCTLEAK_PLUGIN)
-- 
2.35.1.4.g5d01301f2b86

