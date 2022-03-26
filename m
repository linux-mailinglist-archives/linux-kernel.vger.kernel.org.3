Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8FF24E7FD1
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Mar 2022 08:48:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231879AbiCZHuW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Mar 2022 03:50:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229869AbiCZHuU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Mar 2022 03:50:20 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C29F838790;
        Sat, 26 Mar 2022 00:48:44 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id gp15-20020a17090adf0f00b001c7cd11b0b3so5342226pjb.3;
        Sat, 26 Mar 2022 00:48:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:content-language:to:cc:from
         :subject:content-transfer-encoding;
        bh=PB4B3Q2t4krcia/xZSMmf20XfdxsFQb3TO6OQonmIyY=;
        b=KDoVmiJENQtFD1yizaT91CW9z8QYVtNf3BJ/LqR891rZGZ78PuLoqRTceZabRQsiyc
         IQJFYCt+xuSgZebRIMJI6f+LnvFpBN5hAAJ8vEcqv/K2Xnbtb3ffnosm/ziKR6JV1Grq
         9MMeFVsvZ3kcldVeFwE4ID4j3x94vN6wFek3R6AyCCjfaydjUy9AN+xk3Srs7RtzJSEd
         JlQVGasPgEZr8+oZ8fPoS2UUX4MExIWqxQ8enkjXeHQisBmOFsUzlJAqxkbp/xdrzeLO
         ibH/zgnN++rW4b1wXcBQyqpw5up6m2f8+5dlfn7J5Nq63osHiFSoiWzegLIeGfo74wWY
         yXKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:from:subject:content-transfer-encoding;
        bh=PB4B3Q2t4krcia/xZSMmf20XfdxsFQb3TO6OQonmIyY=;
        b=KAJ+3vWRlpeL6tGFAzjmd3DmyjJQnG/b7zERCWaYXl3Yff04MwM4zp8aGEX6ARuwE8
         AOJ12lgmnF7Lhsr1GmGmmxO9uMT0z9/QlCU8SI++abvVwj3tJPQ3xHzCN+aJSfRpDllA
         h1qvIPs2uSpzAw10DRa99ywzenXK9ycae+qP9H64eMhb5DCQ1LC9/2qD1wtCEMOEvElN
         Dgz5oIyWayBtqzPqgdmSr6qyKtw69/rcJkEwBaIRVHwnK7MWOgy8FIYOqO25ecUOkoB6
         70dSYMJsc7XZV8fhJUc4XasAzWNDnBYu+iHd7aABWEfaatzsi1a9LTGZa85as77d1Ot1
         FlUg==
X-Gm-Message-State: AOAM530J/k+fU6Rawmf6dtetmrUXh0pRO1+cFRmkqMbuVSk3u+9lMohJ
        eSiwh2HMWSjvklGepy1ZrCE=
X-Google-Smtp-Source: ABdhPJwTY1dPoG1ypktHA40mcGloYaxjCqTmKixz82zdr/+EPQ0cUxWgmlcocF5duzQ8yRODkokSfQ==
X-Received: by 2002:a17:902:ea03:b0:154:4af3:bb5e with SMTP id s3-20020a170902ea0300b001544af3bb5emr16204554plg.95.1648280924291;
        Sat, 26 Mar 2022 00:48:44 -0700 (PDT)
Received: from [192.168.11.5] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id u10-20020a6540ca000000b0037445e95c93sm7232265pgp.15.2022.03.26.00.48.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 26 Mar 2022 00:48:43 -0700 (PDT)
Message-ID: <c80e1481-10d4-7151-fe59-e846259eb0d4@gmail.com>
Date:   Sat, 26 Mar 2022 16:48:39 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Content-Language: en-US
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Akira Yokosawa <akiyks@gmail.com>
From:   Akira Yokosawa <akiyks@gmail.com>
Subject: [PATCH] docs: kfigure.py: Don't warn of missing PDF converter in
 'make htmldocs'
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SVG -> PDF conversion is not required in "make htmldocs".
It is pointless to always warn of a missing converter.
Demote the log message in setupTools() to verbose.

For "make pdfdocs" (or "make latexdocs"), promote the dynamic
message of "include SVG raw" to a warn.
Expand the message and recommend installing Inkscape or
ImageMagick.

Fixes: 8ccd05697a9d ("docs: sphinx/kfigure.py: Use inkscape(1) for SVG -> PDF conversion")
Signed-off-by: Akira Yokosawa <akiyks@gmail.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-doc@vger.kernel.org
---
 Documentation/sphinx/kfigure.py | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/Documentation/sphinx/kfigure.py b/Documentation/sphinx/kfigure.py
index 24d2b2addcce..cefdbb7e7523 100644
--- a/Documentation/sphinx/kfigure.py
+++ b/Documentation/sphinx/kfigure.py
@@ -212,7 +212,7 @@ def setupTools(app):
         if convert_cmd:
             kernellog.verbose(app, "use convert(1) from: " + convert_cmd)
         else:
-            kernellog.warn(app,
+            kernellog.verbose(app,
                 "Neither inkscape(1) nor convert(1) found.\n"
                 "For SVG to PDF conversion, "
                 "install either Inkscape (https://inkscape.org/) (preferred) or\n"
@@ -296,8 +296,10 @@ def convert_image(img_node, translator, src_fname=None):
 
         if translator.builder.format == 'latex':
             if not inkscape_cmd and convert_cmd is None:
-                kernellog.verbose(app,
-                                  "no SVG to PDF conversion available / include SVG raw.")
+                kernellog.warn(app,
+                                  "no SVG to PDF conversion available / include SVG raw."
+                                  "\nIncluding large raw SVGs can cause xelatex error."
+                                  "\nInstall Inkscape (preferred) or ImageMagick.")
                 img_node.replace_self(file2literal(src_fname))
             else:
                 dst_fname = path.join(translator.builder.outdir, fname + '.pdf')

base-commit: 8d6451b9a51b555be2c9a6c326a980b2de00741a
-- 
2.25.1

