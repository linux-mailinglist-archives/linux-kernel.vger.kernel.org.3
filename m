Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44E8F4BBF53
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 19:17:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239095AbiBRSRS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 13:17:18 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239066AbiBRSRC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 13:17:02 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CDC4E46;
        Fri, 18 Feb 2022 10:16:45 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id x5so11077970wrg.13;
        Fri, 18 Feb 2022 10:16:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4uog9y8e2uGEDe7ul64TEQZKDjtI1qlVaFMwkdOVDqo=;
        b=BcRgIjpCjdKsmD1hifDCxyFo7H8M+pelERGXldq/KXqEHk6EkcL0zFiu1G2aBagFdw
         Ycm5NTRmPepuel/RcIcGgKLiU63n4TeV+wyDXRQ74M4FfpY9yra8PkRUVI48MD9yG7X6
         LEsAaWL5q0YdJq3jali0uTa0KMBZOxnI4jQ0urGcoSyxmBiv1rsDzRtPxxxklKpUyb5r
         6z2rnXkWYoN+Lq2hCHKajRhJNEvXBF0jL8vhdiFU+GuxEe07eDxUGJB/iZCbZtRv9xPD
         VxRiKf2hf3QCBy1JgYQi+77olsvbVEeYpN76PCxKMuPZsDn552gH3dfHts44S+phhn0Z
         0BtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4uog9y8e2uGEDe7ul64TEQZKDjtI1qlVaFMwkdOVDqo=;
        b=qEWj5OruEeRwzOxjV3rWIeBfi7mCh6EC0UTc4Tk5UnLy4i8VaE7bHpbHTBWOqplZCj
         jnbk8Qgc2GiZ7ApgbKbDIrK33h6o+jg+16/2cLmLq9fXlUJn31v1PQwP5qp7PGcp8lWO
         HuQF6EJ/46I0OgdTwaMFTpTVFJvungvzmgLSy1LQsaX7UOrkNzr2fN6W2C1djleJQ5zf
         8D1vBZseh3RlHCoIpEcAk8v18RcmeHsZ7ND6wM8oBchtq+F/8r7JC2ROGUqcT2fhM5U6
         0YsK44OZ3UhsUqLEgPl4kK7kUsi3gmNO494QDvdxMCOM+qqU2aOz5+hYg5wKmHOW1Spg
         ZRcg==
X-Gm-Message-State: AOAM531b1vjpGhxhEjY9B/txsPrETQAZ1VYQbdLiM47q5Ako3jApNnI6
        8Gktm/b8NYa7z0dv+FXn91M=
X-Google-Smtp-Source: ABdhPJwoGAqCnTbH6+8pCXavYOeKOon6tieBJ1Aoa51OqKaHWYhCdLMszt/uM6Vdcl8otOgbgFTMUQ==
X-Received: by 2002:a05:6000:144c:b0:1e8:50e5:fec1 with SMTP id v12-20020a056000144c00b001e850e5fec1mr7113263wrx.648.1645208203688;
        Fri, 18 Feb 2022 10:16:43 -0800 (PST)
Received: from fuji.fritz.box (ip-89-161-76-237.tel.tkb.net.pl. [89.161.76.237])
        by smtp.gmail.com with ESMTPSA id b2sm20978639wri.35.2022.02.18.10.16.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Feb 2022 10:16:43 -0800 (PST)
From:   =?UTF-8?q?Tomasz=20Warnie=C5=82=C5=82o?= 
        <tomasz.warniello@gmail.com>
To:     corbet@lwn.net
Cc:     =?UTF-8?q?Tomasz=20Warnie=C5=82=C5=82o?= 
        <tomasz.warniello@gmail.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 04/11] scripts: kernel-doc: Translate the "Output format selection" subsection of OPTIONS
Date:   Fri, 18 Feb 2022 19:16:21 +0100
Message-Id: <20220218181628.1411551-5-tomasz.warniello@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220218181628.1411551-1-tomasz.warniello@gmail.com>
References: <20220218181628.1411551-1-tomasz.warniello@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Another step in the direction of a uniform POD documentation, which will
make users happier.

Options land at the end of the script, not to clutter the file top.

The default output format is corrected to rst. That's what it is now.

A POD delimiting comment is added to the script head, which improves
the script logical structure.

Signed-off-by: Tomasz Warniełło <tomasz.warniello@gmail.com>
---
 scripts/kernel-doc | 31 ++++++++++++++++++++++++++-----
 1 file changed, 26 insertions(+), 5 deletions(-)

diff --git a/scripts/kernel-doc b/scripts/kernel-doc
index e4203f13fa93..18eca172c4b5 100755
--- a/scripts/kernel-doc
+++ b/scripts/kernel-doc
@@ -52,6 +52,8 @@ See Documentation/doc-guide/kernel-doc.rst for the documentation comment syntax.
 
 =cut
 
+# more perldoc at the end of the file
+
 # 18/01/2001 - 	Cleanups
 # 		Functions prototyped as foo(void) same as foo()
 # 		Stop eval'ing where we don't need to.
@@ -81,11 +83,6 @@ sub usage {
     my $message = <<"EOF";
 Usage: $0 [OPTION ...] FILE ...
 
-Output format selection (mutually exclusive):
-  -man			Output troff manual page format. This is the default.
-  -rst			Output reStructuredText format.
-  -none			Do not output documentation, only warnings.
-
 Output format selection modifier (affects only ReST output):
 
   -sphinx-version	Use the ReST C domain dialect compatible with an
@@ -2563,3 +2560,27 @@ if ($Werror && $warnings) {
 } else {
     exit($output_mode eq "none" ? 0 : $errors)
 }
+
+__END__
+
+=head1 OPTIONS
+
+=head2 Output format selection (mutually exclusive):
+
+=over 8
+
+=item -man
+
+Output troff manual page format.
+
+=item -rst
+
+Output reStructuredText format. This is the default.
+
+=item -none
+
+Do not output documentation, only warnings.
+
+=back
+
+=cut
-- 
2.30.2

