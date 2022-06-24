Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 980F155A419
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Jun 2022 00:00:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231534AbiFXV6S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 17:58:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230392AbiFXV6Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 17:58:16 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F42B5FD3;
        Fri, 24 Jun 2022 14:58:15 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id 184so3539529pga.12;
        Fri, 24 Jun 2022 14:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:content-language:to:cc:from
         :subject:content-transfer-encoding;
        bh=6x6Z4E26nV0ZtU/SyJqV7Zl5vmGkEtDni/w+IrGDa38=;
        b=eEsTcA/FaqNfiUT/PmbTpXPlMbPGRT3Z+1Lsr84kB5KF/nmelhYk0S+ejtndA7k+Yk
         DGYAnXJBWkAt01cR+0z4bX3PXB7gzA7JIdaDK1jEmh6oflXH0ciJcCO1jJtByL5s6v42
         lYrCKjBkgG5lr4uud48ybA7dzgfCwpH40EybioQ4m/7Jfh1lhKqRTKJ7Ozv6erp8v58f
         lEQ5Pm8VRIsN4Ufsbtb5+TgR06QqvIqSvsnFZWLsmlqDe8c2xWhZtzrX17D441fbte9V
         Dx9yyIjOH93tRXBlfqnZg9ud+6HW43ptI1olMVzCVy1G/DJIzSPzIOayzd8BZ7LGvZ6v
         LtDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:from:subject:content-transfer-encoding;
        bh=6x6Z4E26nV0ZtU/SyJqV7Zl5vmGkEtDni/w+IrGDa38=;
        b=iucYNXsrB8yq9lMOHLzYw6w1kb1PGNOQmSzK3AfmfuGeY1pfOtd2onVUWDS8K5fvqc
         To/9UPJEOjlolxQCYiOjt49TlDVWOrKz+AJijwpXKpHDcbZiYcdP7vsrfiZPflAgAmag
         JHrgWc4a462IHd6zLXTTVu+NO1lv6AaH6n2/WN0YlUfIWhG6BO2cmzBA1nQa8dAYQl5/
         6N8bCL2wlXKqb9eqQ26uqx1N5PHBQfxM+s2gvFro4ptZI9El0skipJWRw4wLJHo+MDSw
         ojH9UllARWd999zYh3CFqabxM+y5DgUwSpwWFxXx8ChHz7X7woUtQmaU0/RD7FGWgPq+
         9BhQ==
X-Gm-Message-State: AJIora/TFrh1myXjpEahToyxZ6jf7f+AHPw2f2zvnTxBC2NBMD0EbSwW
        5jRNVk0FWqfUqIXo+7PkeIKTQDXrrpw=
X-Google-Smtp-Source: AGRyM1twBJGNS79yLEz+PXmwXUsFzg02LWoSSYdaqbbydRVznHpppNmORI5PDc+RwAb2+O1GvzzvJg==
X-Received: by 2002:a63:6f43:0:b0:408:d61b:77b0 with SMTP id k64-20020a636f43000000b00408d61b77b0mr804444pgc.529.1656107894640;
        Fri, 24 Jun 2022 14:58:14 -0700 (PDT)
Received: from [192.168.11.5] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id o17-20020a170902779100b0015e8d4eb218sm2289717pll.98.2022.06.24.14.58.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Jun 2022 14:58:14 -0700 (PDT)
Message-ID: <50d6f0bc-030d-9529-0665-e2b3e7c792d8@gmail.com>
Date:   Sat, 25 Jun 2022 06:58:09 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Content-Language: en-US
To:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        "Maciej W. Rozycki" <macro@orcam.me.uk>,
        Miguel Ojeda <ojeda@kernel.org>, linux-kernel@vger.kernel.org,
        Akira Yokosawa <akiyks@gmail.com>
From:   Akira Yokosawa <akiyks@gmail.com>
Subject: [PATCH v2] docs/doc-guide: Mention make variable SPHINXDIRS
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

SPHINXDIRS is useful when you want to test build only those
documents affected by your changes.

Mention it in the "Sphinx Build" section.

Signed-off-by: Akira Yokosawa <akiyks@gmail.com>
Cc: Maciej W. Rozycki <macro@orcam.me.uk>
---
v1 -> v2:
  - Added command example (Jon)

v1: https://lore.kernel.org/r/ff89c064-e24a-0f2f-fc03-b029e5d04338@gmail.com/
--
 Documentation/doc-guide/sphinx.rst | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/doc-guide/sphinx.rst b/Documentation/doc-guide/sphinx.rst
index edc4fa023986..1228b85f6f77 100644
--- a/Documentation/doc-guide/sphinx.rst
+++ b/Documentation/doc-guide/sphinx.rst
@@ -151,6 +151,13 @@ If the theme is not available, it will fall-back to the classic one.
 
 The Sphinx theme can be overridden by using the ``DOCS_THEME`` make variable.
 
+There is another make variable ``SPHINXDIRS``, which is useful when test
+building a subset of documentation.  For example, you can build documents
+under ``Documentation/doc-guide`` by running
+``make SPHINXDIRS=doc-guide htmldocs``.
+The documentation section of ``make help`` will show you the list of
+subdirectories you can specify.
+
 To remove the generated documentation, run ``make cleandocs``.
 
 .. [#ink] Having ``inkscape(1)`` from Inkscape (https://inkscape.org)

base-commit: 0ebe4dd124d3a0e708ea24734c13d52657e36363
-- 
2.25.1

