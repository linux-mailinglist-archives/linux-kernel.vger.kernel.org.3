Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D96553D4C9
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Jun 2022 04:07:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349936AbiFDCH1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 22:07:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345631AbiFDCHY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 22:07:24 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E973313A9;
        Fri,  3 Jun 2022 19:07:21 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id d12-20020a17090abf8c00b001e2eb431ce4so8367752pjs.1;
        Fri, 03 Jun 2022 19:07:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vW/f8cKMH2tXPP5DERsOqeGBmSRqfZgMJ/o7YW6aZaA=;
        b=O89rwX5Clw1y6HYOM9jUXOMzKZti5N0Bp8oLKBxvrTRsZr8SCMU6D50/Xw5iIbmGGM
         Ea1Xvv8gSwcK2e3gcOVQKcmLIziYTVY+JelcKmeawLFWcsPQTFWu9K/Kp/Y2hu0wSTgL
         vjmyus7ON2X6+em9CTi1xkd2xgqigHbYUOZLP/Wjv4XHPIZ8IJ5xBnUqX/Ubjmcps0FV
         2PDoqXnen7va3NM6AB91gGtCr5ripbP7MeEgLab71Y8nUb+P3UY1GbTylYrGtetRLUA1
         rdagm+MXQhnMSacHYAcsBDXcq9hOKumDJgyyVVre5UCzBsN1keZVZLFE1SGKyHU7uwwD
         KV5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vW/f8cKMH2tXPP5DERsOqeGBmSRqfZgMJ/o7YW6aZaA=;
        b=g2r5dEETsmLvuCKz3ogkoSssMxbIRcvbuFtpvzttVz4qdm8+ITXg67MJe1D4wL4gnt
         XCC9H0zjkMG93bqVWUdjimhtNPs8LNjNtSXd2mbP7zP5IOmcZd3JbxGiR3IcvsCS1JTE
         T2t09pg0iixhJjZPzvVVX1PsTY3HeF1MWSTx315n7pu+S/DZNxG6GCiGeSwI1TdjYAmw
         iGhxmVE3hqGRuCY2Ssm+tRenUX6C/qZSYJVw/VtTeUepl0gEWhKBZE+zfRL+5wzBog9k
         tNobfhwx2V3ynuU0gqWxNxUQOt8tScz6PqhBqOWRurxB9gEQQ66lgn3K6WUgXzdPPG4N
         rA8A==
X-Gm-Message-State: AOAM531MLZnRReOV1mxPhUk5hurQyYM0w8ub78jNAd4TD4BLuIMW9Gpf
        +ydnZ/DkfSO51QeTL+igGzKiMwSdMf8=
X-Google-Smtp-Source: ABdhPJy4Nue4jpg7LM+nr0HISR1+I5KCAXBSSOv4nxRiYB063+TcRbZ2N6mlkGz2ch+16XRWjLUgLA==
X-Received: by 2002:a17:902:6b42:b0:15d:3603:6873 with SMTP id g2-20020a1709026b4200b0015d36036873mr12838922plt.30.1654308440641;
        Fri, 03 Jun 2022 19:07:20 -0700 (PDT)
Received: from debian.me (subs03-180-214-233-10.three.co.id. [180.214.233.10])
        by smtp.gmail.com with ESMTPSA id c14-20020a170902c2ce00b0015e8d4eb207sm6060553pla.81.2022.06.03.19.07.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jun 2022 19:07:19 -0700 (PDT)
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     linux-doc@vger.kernel.org
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        kernel test robot <lkp@intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>,
        Nikolai Kondrashov <spbnick@gmail.com>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        llvm@lists.linux.dev, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4] HID: uclogic: properly format kernel-doc comment for hid_dbg() wrappers
Date:   Sat,  4 Jun 2022 09:07:11 +0700
Message-Id: <20220604020711.252312-1-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.36.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Running kernel-doc script on drivers/hid/hid-uclogic-params.c, it found
6 warnings for hid_dbg() wrapper functions below:

drivers/hid/hid-uclogic-params.c:48: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
 * Dump tablet interface pen parameters with hid_dbg(), indented with one tab.
drivers/hid/hid-uclogic-params.c:48: warning: missing initial short description on line:
 * Dump tablet interface pen parameters with hid_dbg(), indented with one tab.
drivers/hid/hid-uclogic-params.c:48: info: Scanning doc for function Dump
drivers/hid/hid-uclogic-params.c:80: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
 * Dump tablet interface frame parameters with hid_dbg(), indented with two
drivers/hid/hid-uclogic-params.c:80: warning: missing initial short description on line:
 * Dump tablet interface frame parameters with hid_dbg(), indented with two
drivers/hid/hid-uclogic-params.c:80: info: Scanning doc for function Dump
drivers/hid/hid-uclogic-params.c:105: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
 * Dump tablet interface parameters with hid_dbg().
drivers/hid/hid-uclogic-params.c:105: warning: missing initial short description on line:
 * Dump tablet interface parameters with hid_dbg().

One of them is reported by kernel test robot.

Fix these warnings by properly format kernel-doc comment for these
functions.

Link: https://lore.kernel.org/linux-doc/202205272033.XFYlYj8k-lkp@intel.com/
Fixes: a228809fa6f39c ("HID: uclogic: Move param printing to a function")
Reported-by: kernel test robot <lkp@intel.com>
Tested-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: José Expósito <jose.exposito89@gmail.com>
Acked-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Nikolai Kondrashov <spbnick@gmail.com>
Cc: Jiri Kosina <jikos@kernel.org>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: llvm@lists.linux.dev
Cc: linux-input@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Changes since v3 [1]:
   - Drom stable ML from CC list (in response to Greg KH reply)

 [1]: https://lore.kernel.org/linux-doc/20220602082321.313143-1-bagasdotme@gmail.com/

 drivers/hid/hid-uclogic-params.c | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/drivers/hid/hid-uclogic-params.c b/drivers/hid/hid-uclogic-params.c
index db838f16282d64..e5e65d849faa97 100644
--- a/drivers/hid/hid-uclogic-params.c
+++ b/drivers/hid/hid-uclogic-params.c
@@ -23,11 +23,11 @@
 /**
  * uclogic_params_pen_inrange_to_str() - Convert a pen in-range reporting type
  *                                       to a string.
- *
  * @inrange:	The in-range reporting type to convert.
  *
- * Returns:
- *	The string representing the type, or NULL if the type is unknown.
+ * Return:
+ * * The string representing the type, or
+ * * %NULL if the type is unknown.
  */
 static const char *uclogic_params_pen_inrange_to_str(
 				enum uclogic_params_pen_inrange inrange)
@@ -45,10 +45,12 @@ static const char *uclogic_params_pen_inrange_to_str(
 }
 
 /**
- * Dump tablet interface pen parameters with hid_dbg(), indented with one tab.
- *
+ * uclogic_params_pen_hid_dbg() - Dump tablet interface pen parameters
  * @hdev:	The HID device the pen parameters describe.
  * @pen:	The pen parameters to dump.
+ *
+ * Dump tablet interface pen parameters with hid_dbg(). The dump is indented
+ * with a tab.
  */
 static void uclogic_params_pen_hid_dbg(const struct hid_device *hdev,
 					const struct uclogic_params_pen *pen)
@@ -77,11 +79,12 @@ static void uclogic_params_pen_hid_dbg(const struct hid_device *hdev,
 }
 
 /**
- * Dump tablet interface frame parameters with hid_dbg(), indented with two
- * tabs.
- *
+ * uclogic_params_frame_hid_dbg() - Dump tablet interface frame parameters
  * @hdev:	The HID device the pen parameters describe.
  * @frame:	The frame parameters to dump.
+ *
+ * Dump tablet interface frame parameters with hid_dbg(). The dump is
+ * indented with two tabs.
  */
 static void uclogic_params_frame_hid_dbg(
 				const struct hid_device *hdev,
@@ -102,10 +105,11 @@ static void uclogic_params_frame_hid_dbg(
 }
 
 /**
- * Dump tablet interface parameters with hid_dbg().
- *
+ * uclogic_params_hid_dbg() - Dump tablet interface parameters
  * @hdev:	The HID device the parameters describe.
  * @params:	The parameters to dump.
+ *
+ * Dump tablet interface parameters with hid_dbg().
  */
 void uclogic_params_hid_dbg(const struct hid_device *hdev,
 				const struct uclogic_params *params)

base-commit: 1f952675835bfe18d6ae494a5581724d68c52352
-- 
An old man doll... just what I always wanted! - Clara

