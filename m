Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38ECB483A5A
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 03:00:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232269AbiADCAO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 21:00:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232023AbiADCAF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 21:00:05 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19AB9C061792;
        Mon,  3 Jan 2022 18:00:05 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id e5so73035706wrc.5;
        Mon, 03 Jan 2022 18:00:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YYgfZnQEoOcAY409R8rAQypLrB633uHUXM6T9j56ZIQ=;
        b=WrSJb9sDXxdGsDSdszh3NbDoV0v9gHcUQEKFyoY1AqJziwJB33V1+75zY98krG5sd4
         sjl7K7vI+O1HaG1ZSl5OT26LIbFfO+CQd8qncryE0KUIdpIayeW4eoMcVLB1Y3k9/ESu
         JpzFQ6YKH0VlDbqYJYNoMASkz+V+2Mn2Jd9onhZRSODzaadRiu/9f8oCt+29BD10S8Va
         7oV152M8PHj+pDGuwarIFLEcvnCYnqby3eesg06vGGjTQ6shoCmrRePOKpJsLcy69ihC
         qqbm5wkvV+5+TV74dJx6tzQVb9fuuxV6eJVX3VoWJpO5VICd2wvq0KlJkB2GMKUIERrJ
         6Tjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YYgfZnQEoOcAY409R8rAQypLrB633uHUXM6T9j56ZIQ=;
        b=eJ8iqqxfCFSFoOZgZ8ziwWAIdBofxjWLVOgHR8vRW2qjzdOnNR4y4IGB0Puvg08lj3
         nRKpuwqjgRflp6UopiNA/rsSimw3hmaJTetjz35Puk6x79VPR7rjh+JV4VHuXIZEI/Rq
         cIGDSa5GOtGZzvzm+RYAbirhMAWE8zqInvPOnPbpgALgv2XMFfh1pXo7k+QFKqpnOOhm
         XE8cKNaW3boOlo8Ij5z+o32/7A7YT1CpC7dfvwjDdm5ZE0lzLqDjjuIkiTpTy+FKA3ih
         4WrK00TM2b3A5eq/MQxLyj/KzVH26gkUKgt33y6pttMLvpV/UepOYLVT5VrZaYXcJn92
         6VWg==
X-Gm-Message-State: AOAM5331UWNV8W3CcgeDLqrxj4Zs3mSLZt/r9B/FVz0oGyccxjFbaq6Q
        42DMH/o2V0GKXAhaxFYA9nM=
X-Google-Smtp-Source: ABdhPJyAOIFiTAQRIzAn2pqNmtOz3xP5LAd36aQvwVzofpYEf7nn4dWS9vckdTRxyHm3DPH7rKX44A==
X-Received: by 2002:adf:efc6:: with SMTP id i6mr39575714wrp.428.1641261603749;
        Mon, 03 Jan 2022 18:00:03 -0800 (PST)
Received: from fuji.fritz.box (ip-89-161-76-237.tel.tkb.net.pl. [89.161.76.237])
        by smtp.gmail.com with ESMTPSA id j17sm36422654wrp.68.2022.01.03.18.00.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jan 2022 18:00:03 -0800 (PST)
From:   =?UTF-8?q?Tomasz=20Warnie=C5=82=C5=82o?= 
        <tomasz.warniello@gmail.com>
To:     corbet@lwn.net
Cc:     =?UTF-8?q?Tomasz=20Warnie=C5=82=C5=82o?= 
        <tomasz.warniello@gmail.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 05/15] scripts: kernel-doc: Translate the "Output format selection" subsection of OPTIONS
Date:   Tue,  4 Jan 2022 02:59:36 +0100
Message-Id: <20220104015946.529524-6-tomasz.warniello@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220104015946.529524-1-tomasz.warniello@gmail.com>
References: <20220104015946.529524-1-tomasz.warniello@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Options land at the end of the script, not to clutter the file top.

The default output format is corrected to rst. That's what it is now.

* Transform documentation into POD (5/15)
See step 1 for the series details.

Signed-off-by: Tomasz Warniełło <tomasz.warniello@gmail.com>
---
 scripts/kernel-doc | 31 ++++++++++++++++++++++++++-----
 1 file changed, 26 insertions(+), 5 deletions(-)

diff --git a/scripts/kernel-doc b/scripts/kernel-doc
index 4d0b38c82bfb..8213399fd7ec 100755
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

