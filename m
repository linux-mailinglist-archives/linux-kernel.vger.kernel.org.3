Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6B6F544DA3
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 15:27:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343721AbiFIN1k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 09:27:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343670AbiFIN1g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 09:27:36 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B11B0110988;
        Thu,  9 Jun 2022 06:27:33 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id r1so3000272plo.10;
        Thu, 09 Jun 2022 06:27:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=/w33OC2nKB0l49BpBE16Q95GGKplWgpgkQkpZKKx9XU=;
        b=Saf2DH6GH3ZFWu6ilc7JhttO6h1rIVxm8yxUGdYoDGgSyY6z8OBBwyX19KwLSOFYTt
         1b1aqBlem3FP97Fq0+HTBc4aMncTJJHLVuTHrvqLlfNQPoud3iyEkR3N/I0Joabdv841
         UBAxZw7KU9ZhPlwqLi3qxK+FwSVFoCVNXo5Grn7Qt1eGtgxbEHfs1cGXna5kZQXIuf1J
         mNIdewOE8McOsy0Q0k4xFherTtf0Kj6UdANdGHflT9rK7qyJd+/M/8Ouaz4l0hWRlLtp
         jr45ETHGXprdUiTDCWzosZtC/qmKG0lu7J6YTYjgV+VBE+A7lrjvaQPBQp7HOaGkm5Pf
         kkzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=/w33OC2nKB0l49BpBE16Q95GGKplWgpgkQkpZKKx9XU=;
        b=o25gjnyNJvF+uVGdcJQwA3L2skq/EY20uspHNJMyZWZGuP7Yh0E0a8HaWeGMFWQONZ
         1FdDHP7+Y/LbGo1q2RERSPT5RmZ/XDLmJJ2xe0zIo14HyOr8LCTvnXYck4CdEcNMxen3
         CYdwTIbUtcuW9mvlJZpTvo/quXU8IKf0cJ9atFJUbjdGr4gwvF8boCsrEcXERR7EiRUQ
         5Y0j774AlEnnyvqW87WvqwNfFopE727+lDsGJkAPHAmRsEzWO/Nw5qTzsurDJTmde2gX
         besxx+1lcu5D7tKc8Rd78EBW6AcT+nPyU5VGHYqB7HPbWmfXxbPTcJ91ZI9Li239n2fo
         x3Iw==
X-Gm-Message-State: AOAM533+LLsjiVzzm1rT2cYYr0sjKhAitKmMixbwssaZiBN0lmRMt1SF
        lEIoswPQOrVbQn7kkPVs1kA=
X-Google-Smtp-Source: ABdhPJyzZwTxrKl6bUcnX4/gvAWipAyf49NA3Zu5vDclNm8uqtyLx1279BiLXP9/GjSMUPsOKKoEJQ==
X-Received: by 2002:a17:902:b215:b0:165:7bdd:a9f1 with SMTP id t21-20020a170902b21500b001657bdda9f1mr40101997plr.41.1654781253192;
        Thu, 09 Jun 2022 06:27:33 -0700 (PDT)
Received: from [192.168.11.5] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id q17-20020a656851000000b003f5d7f0ad6asm17809441pgt.48.2022.06.09.06.27.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jun 2022 06:27:32 -0700 (PDT)
Message-ID: <42600ccb-8cfd-434e-cb4f-f871fd8de708@gmail.com>
Date:   Thu, 9 Jun 2022 22:27:27 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: [RFC PATCH 4/5] docs/doc-guide: Pull guidelines for title adornments
 out into subsection
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

As it becomes too large as an item in bullet lists, make it a
subsection of its own.

Signed-off-by: Akira Yokosawa <akiyks@gmail.com>
---
 Documentation/doc-guide/sphinx.rst | 29 ++++++++++++++++-------------
 1 file changed, 16 insertions(+), 13 deletions(-)

diff --git a/Documentation/doc-guide/sphinx.rst b/Documentation/doc-guide/sphinx.rst
index f257c4785607..f8bbf86fa15a 100644
--- a/Documentation/doc-guide/sphinx.rst
+++ b/Documentation/doc-guide/sphinx.rst
@@ -202,7 +202,16 @@ Here are some specific guidelines for the kernel documentation:
 * Also update the content, not just the formatting, when converting
   documentation.
 
-* Please stick to this relative order of section title adornments:
+* For inserting fixed width text blocks (for code examples, use case
+  examples, etc.), use ``::`` for anything that doesn't really benefit
+  from syntax highlighting, especially short snippets. Use
+  ``.. code-block:: <language>`` for longer code blocks that benefit
+  from highlighting. For a short snippet of code embedded in the text, use \`\`.
+
+Guidelines for title adornments
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+Please stick to this relative order of section title adornments:
 
   1. ``=`` with overline for 1st level titles::
 
@@ -225,12 +234,12 @@ Here are some specific guidelines for the kernel documentation:
        4th level title
        ~~~~~~~~~~~~~~~
 
-  Although RST doesn't mandate a specific order ("Rather than imposing a fixed
-  number and order of section title adornment styles, the order enforced will be
-  the order as encountered."), having the higher levels the same overall makes
-  it easier to follow the documents.
+Although RST doesn't mandate a specific order ("Rather than imposing a fixed
+number and order of section title adornment styles, the order enforced will be
+the order as encountered."), having the higher levels the same overall makes
+it easier to follow the documents.
 
-  .. note::
+.. note::
     - It is not easy to tell the levels (chapter, section, etc.) of title
       adornments in a particular .rst file.  A title that appears first in
       a .rst file can be at any level of document, chapter, section, or
@@ -258,7 +267,7 @@ Here are some specific guidelines for the kernel documentation:
     .. [#rstdoc] https://docutils.sourceforge.io/docs/ref/rst/restructuredtext.html#document
     .. [#rstdirtitle] https://docutils.sourceforge.io/docs/ref/rst/directives.html#metadata-document-title
 
-  .. warning::
+.. warning::
     For existing documents, manually updating title adornments just to meet
     these guidelines is not recommended.  Such changes can be error-prone and
     may break section hierarchy without being caught by reviewers.  They may
@@ -268,12 +277,6 @@ Here are some specific guidelines for the kernel documentation:
     It would be appreciated if adjustment of those adornments could be
     automated in some way.
 
-* For inserting fixed width text blocks (for code examples, use case
-  examples, etc.), use ``::`` for anything that doesn't really benefit
-  from syntax highlighting, especially short snippets. Use
-  ``.. code-block:: <language>`` for longer code blocks that benefit
-  from highlighting. For a short snippet of code embedded in the text, use \`\`.
-
 
 the C domain
 ------------
-- 
2.25.1


