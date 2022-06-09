Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54335544D99
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 15:26:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238773AbiFIN0h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 09:26:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234891AbiFIN0e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 09:26:34 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAAFD33EA2;
        Thu,  9 Jun 2022 06:26:32 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id u12-20020a17090a1d4c00b001df78c7c209so26685261pju.1;
        Thu, 09 Jun 2022 06:26:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=ShDYdI8cJz4eKhe2LZx3gBgV6zn8fmqFJsqslddaRT8=;
        b=BmuptZ+PRTXtGSlYMIwn2u4mFKTReW1Z/1FJI7LJxsf7Mn1VfFfgPde7zSZ3/NhjI0
         tf0v4Fk7UXtADlco79KE74hB6yRX6jpQ/bligG8DxftDoIXNaeA2zNGijJ0pGoS2JKVS
         tMt3IpcyoLV2TpfogRpU8oRpapPDlmK9Gu9og4dLA+9yj1H3VNtbjfAOk6+pxtUJncwb
         owzN3z4QDuYHd+yel95cYYtep89BA4XSFZVBof4GFtXJaklaoGe5BLM6jzLInlR64PED
         /sKcz/dkuYhMvAZ9yYyOrulq26yz8MILI4PMV87OVCqdrgKnSeXNPqzoO/NFQPzLSLIm
         KNRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ShDYdI8cJz4eKhe2LZx3gBgV6zn8fmqFJsqslddaRT8=;
        b=mK7ewL16s4E4P/eL8nSR8jqGFDE/QFQEBE9HaXWtmqXB9DuvwMkkKSDrMcYPgKT7kB
         FmFEpEsVc2AjFayxt6VzkJ9RJK34zG5+RGXlJJA9Oxk71yxqWZ41zp1LxqHHZ/Dntl/K
         V/CQaPk/2GVXCL2KmWLTJeMq8EY5LBTaJHJsYxILbsQfJYKt9rGWr+/jT4Zw09/6UxTK
         Eihp4r1kjrEoY7+DtfQ2oHRbLG/kfWGsghSNHLd3tDstUnDT2+zW9lYB2sqHMBmG9ZxG
         Km82Qw1GagNI1jVS4p4RwqRw7l2tBmdmJ3VR47ajQLjH5GjqkHHFHMQVWVNQtI48h84j
         gMtA==
X-Gm-Message-State: AOAM531gKDRxLPta7wlKNbxPyZoUp3xz2QNLnz+mIfPSVxPLNyAavglK
        ITtqUl0dWNRIANhxIsLMTa0=
X-Google-Smtp-Source: ABdhPJxPz16UeP1BW5ZLa39ojvoPfNniXTPAI605fb6GHDhmj91YhA0rItyFO3mIoMbFouKiVZwGjA==
X-Received: by 2002:a17:90a:778c:b0:1df:56a5:8474 with SMTP id v12-20020a17090a778c00b001df56a58474mr3505689pjk.63.1654781191888;
        Thu, 09 Jun 2022 06:26:31 -0700 (PDT)
Received: from [192.168.11.5] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id i19-20020a17090320d300b00163f8ddf160sm16745441plb.161.2022.06.09.06.26.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jun 2022 06:26:30 -0700 (PDT)
Message-ID: <732154bc-aa35-2326-2b64-87b6c4dd02e7@gmail.com>
Date:   Thu, 9 Jun 2022 22:26:27 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: [RFC PATCH 3/5] docs/doc-guide: Update guidelines for title
 adornments
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

Existing guidelines predate the sub-directory wise document
management.

Update the guidelines to reflect the current state of affairs.

Signed-off-by: Akira Yokosawa <akiyks@gmail.com>
Cc: Miguel Ojeda <ojeda@kernel.org>
---
 Documentation/doc-guide/sphinx.rst | 66 +++++++++++++++++++++++-------
 1 file changed, 52 insertions(+), 14 deletions(-)

diff --git a/Documentation/doc-guide/sphinx.rst b/Documentation/doc-guide/sphinx.rst
index efcccab68286..f257c4785607 100644
--- a/Documentation/doc-guide/sphinx.rst
+++ b/Documentation/doc-guide/sphinx.rst
@@ -202,34 +202,72 @@ Here are some specific guidelines for the kernel documentation:
 * Also update the content, not just the formatting, when converting
   documentation.
 
-* Please stick to this order of heading adornments:
+* Please stick to this relative order of section title adornments:
 
-  1. ``=`` with overline for document title::
+  1. ``=`` with overline for 1st level titles::
 
-       ==============
-       Document title
-       ==============
+       ===============
+       1st level title
+       ===============
 
-  2. ``=`` for chapters::
+  2. ``=`` for 2nd level titles::
 
-       Chapters
-       ========
+       2nd level title
+       ===============
 
-  3. ``-`` for sections::
+  3. ``-`` for 3rd level titles::
 
-       Section
-       -------
+       3rd level title
+       ---------------
 
-  4. ``~`` for subsections::
+  4. ``~`` for 4th level titles::
 
-       Subsection
-       ~~~~~~~~~~
+       4th level title
+       ~~~~~~~~~~~~~~~
 
   Although RST doesn't mandate a specific order ("Rather than imposing a fixed
   number and order of section title adornment styles, the order enforced will be
   the order as encountered."), having the higher levels the same overall makes
   it easier to follow the documents.
 
+  .. note::
+    - It is not easy to tell the levels (chapter, section, etc.) of title
+      adornments in a particular .rst file.  A title that appears first in
+      a .rst file can be at any level of document, chapter, section, or
+      subsection (or deeper) depending on the file's inclusion depth.
+
+    - The RST language does not have an explicit means to specify a "document
+      title".  Quote from the RST documentation\ [#rstdoc]_ with minor edit:
+
+	*Specifically, there is no way to indicate a document title and
+	subtitle explicitly in reStructuredText.  Instead, a lone top-level
+	section title can be treated as the document title.*
+
+      In the kernel documentation processing, the first title in a top-level
+      ``index.rst`` can be considered the document title.  In HTML, as each
+      .html output has its source .rst file, the title which happens to come
+      first is used as the title of the resulting HTML page.
+      Alternatively, it is possible to specify a page title by using the
+      directive "title".\ [#rstdirtitle]_
+
+    - There may be a 2nd or 3rd level adornment at the first title in a .rst
+      file.  This usage is often seen in .rst files that are derived and
+      split from a larger .rst file.  It is sufficient if relative order is
+      preserved.
+
+    .. [#rstdoc] https://docutils.sourceforge.io/docs/ref/rst/restructuredtext.html#document
+    .. [#rstdirtitle] https://docutils.sourceforge.io/docs/ref/rst/directives.html#metadata-document-title
+
+  .. warning::
+    For existing documents, manually updating title adornments just to meet
+    these guidelines is not recommended.  Such changes can be error-prone and
+    may break section hierarchy without being caught by reviewers.  They may
+    be justified if done in conjunction with a section reorganization or
+    similar.
+
+    It would be appreciated if adjustment of those adornments could be
+    automated in some way.
+
 * For inserting fixed width text blocks (for code examples, use case
   examples, etc.), use ``::`` for anything that doesn't really benefit
   from syntax highlighting, especially short snippets. Use
-- 
2.25.1


