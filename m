Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8D41544D73
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 15:23:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343766AbiFINXj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 09:23:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245054AbiFINXe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 09:23:34 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 806882600;
        Thu,  9 Jun 2022 06:23:33 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id d129so21806768pgc.9;
        Thu, 09 Jun 2022 06:23:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=+YkdE4hgL9nudEqBz5hZQ0msyQAME4oIXjwpc7HKTC4=;
        b=kSLcdlt+IN5JIBnJAeI9HUaw3v+tFe11y6pKaRx+W+JMBoNlQEfYvNyH3QWBzC3hQZ
         /FQfM+NN+dQC50RZW8QaG7gYa9LfyDjqCercchn4qONMAz/FScyoeZ1wsBgYD7+Io6Wr
         oelsqYApYfG3r+dcjopj2SolZNdcp9pK9zqqhSfcY7C/3iFqfIi0tVCFZQIG4CTNUnqc
         ASsA0Ds+gfQxTT4NjQRXNu6EupkB2lcdORW68vR2sFPuf7YMyKfkQRwD+TjsWFHPZn9V
         41r480kar8I3HEbHcrdd1KvthfxSX2hwg/3YE5Zlb8wh7emejC8YRGWqOX5l13BEfXym
         2m8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=+YkdE4hgL9nudEqBz5hZQ0msyQAME4oIXjwpc7HKTC4=;
        b=56AKyi6QVnbcairB7MAZ4+b6lWJlgpF6C4kktqJJeWPwUZQDeCsUSne3GcfcjO0SkO
         JOCT+csuCPT7UGhkoZ/5T8R/51IGfSDh4pdgneptDBB1wHeZEaTaeotLgpQ9QjXHx9d0
         QL4KS9Z/h1NFQz2k36hQR8GKfNsAArUF6S7et87vEQLtMcQnRpCavpdVvPLmByZAoWv0
         Qk+e/+apawd2f6nnG6ZGvkaidniKC6bVcpHNYxICd6SC7wYx4Mu9LgRUu/TuuCI7ZMUz
         4EB8frxV/GB8WhLUgVi82gOhKKAPLBDfpEpabce2MVE/uBlK30Vx92ClymoYmg/JtAns
         sPZA==
X-Gm-Message-State: AOAM533xsUTRr+0DTg8LyLGT+FO0aVHhKOYdudNE3PBfIuhbB++UG/BQ
        KHzCJspcQ+RdZ2dgAQ+z/nw=
X-Google-Smtp-Source: ABdhPJyMOFMlhAynmsJzHw50MAGtr8ty3qmRrNgcjKI3OM2dTXIg01V2FcUu4QCq1unNbC/t1pS8KA==
X-Received: by 2002:a05:6a00:1387:b0:51c:2712:7859 with SMTP id t7-20020a056a00138700b0051c27127859mr19074541pfg.38.1654781013066;
        Thu, 09 Jun 2022 06:23:33 -0700 (PDT)
Received: from [192.168.11.5] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id a21-20020a170902ee9500b00161a40b2135sm16914849pld.104.2022.06.09.06.23.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jun 2022 06:23:32 -0700 (PDT)
Message-ID: <81cddbde-bc28-bec1-fca4-3c8fe2df502f@gmail.com>
Date:   Thu, 9 Jun 2022 22:23:27 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: [PATCH 1/5] docs/doc-guide: Add footnote on Inkscape for better
 images in PDF documents
Content-Language: en-US
To:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        "Maciej W. Rozycki" <macro@orcam.me.uk>,
        Miguel Ojeda <ojeda@kernel.org>, linux-kernel@vger.kernel.org,
        Akira Yokosawa <akiyks@gmail.com>
References: <dccb5233-7f4f-1be6-d1f4-bbe9f42f88e0@gmail.com>
From:   Akira Yokosawa <akiyks@gmail.com>
In-Reply-To: <dccb5233-7f4f-1be6-d1f4-bbe9f42f88e0@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With kernel releases v5.18 and later, if you have Inkscape, images
embedded in PDF documents are of vector graphics, not the raster
images as are the case with pre-v5.18 releases.
Even with pre-5.18 releases, having Inkscape would improve images
converted from some of SVG files which are not fully covered by the
limited capability of rsvg-convert(1) [1].

Add a footnote mentioning the expected improvements of such images.

Link: https://gitlab.gnome.org/GNOME/librsvg#non-goals-of-librsvg [1]
Signed-off-by: Akira Yokosawa <akiyks@gmail.com>
---
 Documentation/doc-guide/sphinx.rst | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/Documentation/doc-guide/sphinx.rst b/Documentation/doc-guide/sphinx.rst
index 2ff1ab4158d4..edc4fa023986 100644
--- a/Documentation/doc-guide/sphinx.rst
+++ b/Documentation/doc-guide/sphinx.rst
@@ -132,7 +132,8 @@ format-specific subdirectories under ``Documentation/output``.
 To generate documentation, Sphinx (``sphinx-build``) must obviously be
 installed. For prettier HTML output, the Read the Docs Sphinx theme
 (``sphinx_rtd_theme``) is used if available. For PDF output you'll also need
-``XeLaTeX`` and ``convert(1)`` from ImageMagick (https://www.imagemagick.org).
+``XeLaTeX`` and ``convert(1)`` from ImageMagick
+(https://www.imagemagick.org).\ [#ink]_
 All of these are widely available and packaged in distributions.
 
 To pass extra options to Sphinx, you can use the ``SPHINXOPTS`` make
@@ -152,6 +153,10 @@ The Sphinx theme can be overridden by using the ``DOCS_THEME`` make variable.
 
 To remove the generated documentation, run ``make cleandocs``.
 
+.. [#ink] Having ``inkscape(1)`` from Inkscape (https://inkscape.org)
+	  as well would improve the quality of images embedded in PDF
+	  documents, especially for kernel releases 5.18 and later.
+
 Writing Documentation
 =====================
 
-- 
2.25.1


