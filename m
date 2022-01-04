Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90856483A5E
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 03:00:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232245AbiADCAS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 21:00:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231309AbiADCAH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 21:00:07 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2FEEC061784;
        Mon,  3 Jan 2022 18:00:06 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id e5so73035882wrc.5;
        Mon, 03 Jan 2022 18:00:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tjAkEHNcdl0hsyrkAlIgXS8/cjp5tCrQhI1C/+QzliQ=;
        b=Ranw6u3xv/cq1XygBK7vLEkyCiFvqYUYFdBS4T5P4VKP80U0XuEfZy2OjOwfUxx07G
         3oWAHi4i5YJtFQQpdv8B1plHjcYYNHV58vQCwXhyAUdiaDXuKPisnna4GEBoCM7oKnAz
         3d+RUivaHeZpyKut00km24t9wRpDEN7+wZg84Nav+YOcCX4zoKMwDsYyhQVCXYJJQxhT
         uVhBoc51aedX+n0cofmRSBnoF3W1fwq7VU8kWRcHhTrAdXkKV/ErQE1AaKFZQHGBjWwP
         ujkONFPfj//hxUxGFJ1NccN9T/gK81w3KfrYqacjocW0x3yzJJ5GkwHCLmHeukfyg7+1
         TcPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tjAkEHNcdl0hsyrkAlIgXS8/cjp5tCrQhI1C/+QzliQ=;
        b=CEKKgtLeJYh1//pQNuvpOCuZAqwHq2VRbK9JMdCNmQt38+iJbIaWQ7jUCBkrYksU+D
         0/CpfCIBTNCS9veS9gpIOf9rr/haZqxzO9YiUfwsNe4oQNBufp0Iuzl6zKJVlhhyO8Ps
         oo4u0K8i0NduzwjO8wreyhaohBMZZjujlwbPHB4pAi9a77cI/UB5J2ZmZK82Zi5nvpcE
         smX5C3iL8CyTvh1iW5ZV7G9aBVDIkThD8LtQNES1tgHCT0M0wkk9j6eO++VvpqaocpKW
         Zd+QjLu0vDKKkGn6kii72E2n8w/7buZ8UzuBja5JRfK7MkPMN0dCwsBWp5o/GOWSRrin
         8rxQ==
X-Gm-Message-State: AOAM530tWTwZzF9WDaIi8NNmX6BSKTHXtvkBSSG0UqToUTP9oeM8LmpU
        7vEiaJRgWFimjf86fu5H25upyfcb/tVH+w==
X-Google-Smtp-Source: ABdhPJxpox9Ga5u9J8PN+X4fuyeJWjb1A032efhp299iKLtlD/YdOuNZ1L787w6k8q7zqVR83Uwr3A==
X-Received: by 2002:a5d:5746:: with SMTP id q6mr40712678wrw.163.1641261605535;
        Mon, 03 Jan 2022 18:00:05 -0800 (PST)
Received: from fuji.fritz.box (ip-89-161-76-237.tel.tkb.net.pl. [89.161.76.237])
        by smtp.gmail.com with ESMTPSA id j17sm36422654wrp.68.2022.01.03.18.00.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jan 2022 18:00:05 -0800 (PST)
From:   =?UTF-8?q?Tomasz=20Warnie=C5=82=C5=82o?= 
        <tomasz.warniello@gmail.com>
To:     corbet@lwn.net
Cc:     =?UTF-8?q?Tomasz=20Warnie=C5=82=C5=82o?= 
        <tomasz.warniello@gmail.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 07/15] scripts: kernel-doc: Translate the "Output selection" subsection of OPTIONS
Date:   Tue,  4 Jan 2022 02:59:38 +0100
Message-Id: <20220104015946.529524-8-tomasz.warniello@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220104015946.529524-1-tomasz.warniello@gmail.com>
References: <20220104015946.529524-1-tomasz.warniello@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The plurals in -function and -nosymbol are corrected to singulars.
That's how the script works now. I think this describes the syntax better.
The plurar suggests multiple FILE arguments might be possible. So this
seems more coherent.

Other notes:
- paragraphing correction
- article correction

* Transform documentation into POD (7/15)
See step 1 for the series details.

Signed-off-by: Tomasz Warniełło <tomasz.warniello@gmail.com>
---
 scripts/kernel-doc | 42 +++++++++++++++++++++++++++++-------------
 1 file changed, 29 insertions(+), 13 deletions(-)

diff --git a/scripts/kernel-doc b/scripts/kernel-doc
index f26966dd8bde..629ba514db5d 100755
--- a/scripts/kernel-doc
+++ b/scripts/kernel-doc
@@ -83,19 +83,6 @@ sub usage {
     my $message = <<"EOF";
 Usage: $0 [OPTION ...] FILE ...
 
-Output selection (mutually exclusive):
-  -export		Only output documentation for symbols that have been
-			exported using EXPORT_SYMBOL() or EXPORT_SYMBOL_GPL()
-                        in any input FILE or -export-file FILE.
-  -internal		Only output documentation for symbols that have NOT been
-			exported using EXPORT_SYMBOL() or EXPORT_SYMBOL_GPL()
-                        in any input FILE or -export-file FILE.
-  -function NAME	Only output documentation for the given function(s)
-			or DOC: section title(s). All other functions and DOC:
-			sections are ignored. May be specified multiple times.
-  -nosymbol NAME	Exclude the specified symbols from the output
-		        documentation. May be specified multiple times.
-
 Output selection modifiers:
   -no-doc-sections	Do not output DOC: sections.
   -enable-lineno        Enable output of #define LINENO lines. Only works with
@@ -2591,4 +2578,33 @@ found on PATH.
 
 =back
 
+=head2 Output selection (mutually exclusive):
+
+=over 8
+
+=item -export
+
+Only output documentation for the symbols that have been exported using
+EXPORT_SYMBOL() or EXPORT_SYMBOL_GPL() in any input FILE or -export-file FILE.
+
+=item -internal
+
+Only output documentation for the symbols that have NOT been exported using
+EXPORT_SYMBOL() or EXPORT_SYMBOL_GPL() in any input FILE or -export-file FILE.
+
+=item -function NAME
+
+Only output documentation for the given function or DOC: section title.
+All other functions and DOC: sections are ignored.
+
+May be specified multiple times.
+
+=item -nosymbol NAME
+
+Exclude the specified symbol from the output documentation.
+
+May be specified multiple times.
+
+=back
+
 =cut
-- 
2.30.2

