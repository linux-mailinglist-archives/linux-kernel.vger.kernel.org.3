Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56CD357CFEE
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 17:42:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233232AbiGUPln (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 11:41:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233097AbiGUPjq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 11:39:46 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B4BD89A82;
        Thu, 21 Jul 2022 08:38:02 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id 72so2044646pge.0;
        Thu, 21 Jul 2022 08:38:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hs4O7l0pP6DRS5EHCNCIfeuQWOmUlfNFogQS7F4nGMY=;
        b=cVYaqki2RE96z91l8vkrxU1/8tPlu8X1aATtyQlcF4T9ti4vBKmOI8EyL7Gt7f/W3Z
         o8widG+rRMF3f8ZHy7YYqiW0Q1zdwMfU119G/LyQB8oMrvEMHZl5dWNgE4iSyRWdhv45
         V/XnZppMeYQtQh0HzArs2YcWpsNqBGahR3ORwwVxR12LnvHBYT7hBxSPoCol+9MYTXMf
         XNBIsoJWcwkdZ65FV2eXU4cYitKNyUZ6A9LBcqn79Ym72q+2yGyLT1mrl0zqAl5/Ml1S
         khXKW1X955h8zaSUx9favNoxaQIWGUYXrfCXYPVCcbFxn/fFJnP/pKFBsiX7Q1GPWPIy
         qjJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hs4O7l0pP6DRS5EHCNCIfeuQWOmUlfNFogQS7F4nGMY=;
        b=baKD6eqGZ3/nedf7lWrSdo/Ss7yQTzfWDXoq0j/WYzD1g1bMQNsxe1Zy+E0zskSrN9
         MlYNyRbKn01xjCnUh0A034TF/zpL/fMnk5SKc3/3c4lq+zYs+yc1qSN5hSAvrAxWyiDu
         eCi+gTmkru3ve70kUjkQnYvLI+qGxfxH7czEjVc9qQfZqSyLOvuJGje5uRduNJoMDxp/
         uObR6HwVtaAs3lYTXXmLRfJaC8us/RUq+ZvwwLMW1O7iW94On7gzpEtIihH2qxd7RfKO
         Sy8SIc9SNDT1btbnSamXrFTrdm9kguqIWyIsNavi19iuLD+niaSNESD5wz/AmNY5yO7T
         bAwA==
X-Gm-Message-State: AJIora+2s5sKSSaD4UiSdRhALelyIMWokraFmULmrn+PCdChsK2oTSF/
        RFI7w61B8Rylyl+inJwUDIs=
X-Google-Smtp-Source: AGRyM1vGJUj/7cE+gO0ZJD5zSmD5g+AuMgDYMxqGc5+o8h/XLlqkFxfyXAAB7zAMx4xWIT9su8odSQ==
X-Received: by 2002:a62:1b57:0:b0:52a:d646:de3c with SMTP id b84-20020a621b57000000b0052ad646de3cmr44520891pfb.60.1658417880600;
        Thu, 21 Jul 2022 08:38:00 -0700 (PDT)
Received: from localhost.localdomain ([2405:201:d01c:7038:6d29:af18:34a6:1c34])
        by smtp.googlemail.com with ESMTPSA id h12-20020a170902f7cc00b0016d1fee99ccsm1826583plw.298.2022.07.21.08.37.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jul 2022 08:38:00 -0700 (PDT)
From:   Abhijeet Srivastava <abhijeet.srivastava2308@gmail.com>
Cc:     abhijeet.srivastava2308@gmail.com,
        Corentin Labbe <clabbe@baylibre.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        mjpeg-users@lists.sourceforge.net, linux-media@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH] media: staging: media: zoran: Added * on subsequent lines of Blockcomment
Date:   Thu, 21 Jul 2022 21:07:37 +0530
Message-Id: <20220721153748.56687-1-abhijeet.srivastava2308@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Warning found by checkpatch.pl script

Signed-off-by: Abhijeet Srivastava <abhijeet.srivastava2308@gmail.com>
---
 drivers/staging/media/zoran/videocodec.h | 180 +++++++++++------------
 1 file changed, 90 insertions(+), 90 deletions(-)

diff --git a/drivers/staging/media/zoran/videocodec.h b/drivers/staging/media/zoran/videocodec.h
index 9dea348fee40..58365b0932b4 100644
--- a/drivers/staging/media/zoran/videocodec.h
+++ b/drivers/staging/media/zoran/videocodec.h
@@ -13,108 +13,108 @@
 /* =================== */
 
 /* Should ease the (re-)usage of drivers supporting cards with (different)
-   video codecs. The codecs register to this module their functionality,
-   and the processors (masters) can attach to them if they fit.
-
-   The codecs are typically have a "strong" binding to their master - so I
-   don't think it makes sense to have a full blown interfacing as with e.g.
-   i2c. If you have an other opinion, let's discuss & implement it :-)))
-
-   Usage:
-
-   The slave has just to setup the videocodec structure and use two functions:
-   videocodec_register(codecdata);
-   videocodec_unregister(codecdata);
-   The best is just calling them at module (de-)initialisation.
-
-   The master sets up the structure videocodec_master and calls:
-   codecdata=videocodec_attach(master_codecdata);
-   videocodec_detach(codecdata);
-
-   The slave is called during attach/detach via functions setup previously
-   during register. At that time, the master_data pointer is set up
-   and the slave can access any io registers of the master device (in the case
-   the slave is bound to it). Otherwise it doesn't need this functions and
-   therfor they may not be initialized.
-
-   The other functions are just for convenience, as they are for sure used by
-   most/all of the codecs. The last ones may be omitted, too.
-
-   See the structure declaration below for more information and which data has
-   to be set up for the master and the slave.
-
-   ----------------------------------------------------------------------------
-   The master should have "knowledge" of the slave and vice versa.  So the data
-   structures sent to/from slave via set_data/get_data set_image/get_image are
-   device dependent and vary between MJPEG/MPEG/WAVELET/... devices. (!!!!)
-   ----------------------------------------------------------------------------
-*/
+ * video codecs. The codecs register to this module their functionality,
+ * and the processors (masters) can attach to them if they fit.
+ *
+ * The codecs are typically have a "strong" binding to their master - so I
+ * don't think it makes sense to have a full blown interfacing as with e.g.
+ * i2c. If you have an other opinion, let's discuss & implement it :-)))
+ *
+ * Usage:
+ *
+ * The slave has just to setup the videocodec structure and use two functions:
+ * videocodec_register(codecdata);
+ * videocodec_unregister(codecdata);
+ * The best is just calling them at module (de-)initialisation.
+ *
+ * The master sets up the structure videocodec_master and calls:
+ * codecdata=videocodec_attach(master_codecdata);
+ * videocodec_detach(codecdata);
+ *
+ * The slave is called during attach/detach via functions setup previously
+ * during register. At that time, the master_data pointer is set up
+ * and the slave can access any io registers of the master device (in the case
+ * the slave is bound to it). Otherwise it doesn't need this functions and
+ * therfor they may not be initialized.
+ *
+ * The other functions are just for convenience, as they are for sure used by
+ * most/all of the codecs. The last ones may be omitted, too.
+ *
+ * See the structure declaration below for more information and which data has
+ * to be set up for the master and the slave.
+ *
+ * ----------------------------------------------------------------------------
+ *  The master should have "knowledge" of the slave and vice versa.  So the data
+ *  structures sent to/from slave via set_data/get_data set_image/get_image are
+ *  device dependent and vary between MJPEG/MPEG/WAVELET/... devices. (!!!!)
+ *  ----------------------------------------------------------------------------
+ */
 
 /* ========================================== */
 /* description of the videocodec_io structure */
 /* ========================================== */
 
 /*
-   ==== master setup ====
-   name -> name of the device structure for reference and debugging
-   master_data ->  data ref. for the master (e.g. the zr36055,57,67)
-   readreg -> ref. to read-fn from register (setup by master, used by slave)
-   writereg -> ref. to write-fn to register (setup by master, used by slave)
-	       this two functions do the lowlevel I/O job
-
-   ==== slave functionality setup ====
-   slave_data -> data ref. for the slave (e.g. the zr36050,60)
-   check -> fn-ref. checks availability of an device, returns -EIO on failure or
-	    the type on success
-	    this makes espcecially sense if a driver module supports more than
-	    one codec which may be quite similar to access, nevertheless it
-	    is good for a first functionality check
-
-   -- main functions you always need for compression/decompression --
-
-   set_mode -> this fn-ref. resets the entire codec, and sets up the mode
-	       with the last defined norm/size (or device default if not
-	       available) - it returns 0 if the mode is possible
-   set_size -> this fn-ref. sets the norm and image size for
-	       compression/decompression (returns 0 on success)
-	       the norm param is defined in videodev2.h (V4L2_STD_*)
-
-   additional setup may be available, too - but the codec should work with
-   some default values even without this
-
-   set_data -> sets device-specific data (tables, quality etc.)
-   get_data -> query device-specific data (tables, quality etc.)
-
-   if the device delivers interrupts, they may be setup/handled here
-   setup_interrupt -> codec irq setup (not needed for 36050/60)
-   handle_interrupt -> codec irq handling (not needed for 36050/60)
-
-   if the device delivers pictures, they may be handled here
-   put_image -> puts image data to the codec (not needed for 36050/60)
-   get_image -> gets image data from the codec (not needed for 36050/60)
-		the calls include frame numbers and flags (even/odd/...)
-		if needed and a flag which allows blocking until its ready
-*/
+ * ==== master setup ====
+ * name -> name of the device structure for reference and debugging
+ * master_data ->  data ref. for the master (e.g. the zr36055,57,67)
+ * readreg -> ref. to read-fn from register (setup by master, used by slave)
+ * writereg -> ref. to write-fn to register (setup by master, used by slave)
+ * this two functions do the lowlevel I/O job
+ *
+ * ==== slave functionality setup ====
+ * slave_data -> data ref. for the slave (e.g. the zr36050,60)
+ * check -> fn-ref. checks availability of an device, returns -EIO on failure or
+ * the type on success
+ * this makes espcecially sense if a driver module supports more than
+ * one codec which may be quite similar to access, nevertheless it
+ * is good for a first functionality check
+ *
+ * -- main functions you always need for compression/decompression --
+ *
+ * set_mode -> this fn-ref. resets the entire codec, and sets up the mode
+ * with the last defined norm/size (or device default if not
+ * available) - it returns 0 if the mode is possible
+ *
+ * set_size -> this fn-ref. sets the norm and image size for
+ * compression/decompression (returns 0 on success)
+ * the norm param is defined in videodev2.h (V4L2_STD_*)
+ * additional setup may be available, too - but the codec should work with
+ * some default values even without this
+ *
+ * set_data -> sets device-specific data (tables, quality etc.)
+ * get_data -> query device-specific data (tables, quality etc.)
+ *
+ * if the device delivers interrupts, they may be setup/handled here
+ * setup_interrupt -> codec irq setup (not needed for 36050/60)
+ * handle_interrupt -> codec irq handling (not needed for 36050/60)
+ *
+ * if the device delivers pictures, they may be handled here
+ * put_image -> puts image data to the codec (not needed for 36050/60)
+ *
+ * get_image -> gets image data from the codec (not needed for 36050/60)
+ * the calls include frame numbers and flags (even/odd/...)
+ * if needed and a flag which allows blocking until its ready
+ */
 
 /* ============== */
 /* user interface */
 /* ============== */
 
 /*
-   Currently there is only a information display planned, as the layer
-   is not visible for the user space at all.
-
-   Information is available via procfs. The current entry is "/proc/videocodecs"
-   but it makes sense to "hide" it in the /proc/video tree of v4l(2) --TODO--.
-
-A example for such an output is:
-
-<S>lave or attached <M>aster name  type flags    magic    (connected as)
-S                          zr36050 0002 0000d001 00000000 (TEMPLATE)
-M                       zr36055[0] 0001 0000c001 00000000 (zr36050[0])
-M                       zr36055[1] 0001 0000c001 00000000 (zr36050[1])
-
-*/
+ * Currently there is only a information display planned, as the layer
+ * is not visible for the user space at all.
+ *
+ * Information is available via procfs. The current entry is "/proc/videocodecs"
+ * but it makes sense to "hide" it in the /proc/video tree of v4l(2) --TODO--.
+ *
+ * A example for such an output is:
+ *
+ * <S>lave or attached <M>aster name  type flags    magic    (connected as)
+ * S                          zr36050 0002 0000d001 00000000 (TEMPLATE)
+ * M                       zr36055[0] 0001 0000c001 00000000 (zr36050[0])
+ * M                       zr36055[1] 0001 0000c001 00000000 (zr36050[1])
+ */
 
 /* =============================================== */
 /* special defines for the videocodec_io structure */
-- 
2.34.1

