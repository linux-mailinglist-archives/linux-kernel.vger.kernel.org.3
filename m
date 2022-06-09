Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FCCC544D8D
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 15:25:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237623AbiFINZL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 09:25:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343868AbiFINZG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 09:25:06 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C96FB152BB2;
        Thu,  9 Jun 2022 06:25:03 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id u12-20020a17090a1d4c00b001df78c7c209so26681600pju.1;
        Thu, 09 Jun 2022 06:25:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=+QrEfwNyUObZpg4FR+sDjlTmpv+zGn+vrSq3i8QmgIA=;
        b=KjljSREzL0wSolOtkUlpNwONHUFbpDBeP4bOEVdzkt7/LC+m0uNQ952f84SvOUHVuN
         bMD7CDu5uh2CMmetkp8JZR+W/2B5oNX6TX4koHVCBkolsJkCkxzquLgmLdfYXRp/8TAd
         CuCO8abxzcObs0NX31sjtO6YZc4FtEPkOcpbeS+dEVA0PR9ECTg9QYihqMurlTSsZUgz
         nGiu3dc+PalMt9Uf2UfpkBbDsHpSum7BdqTLV8OJWN4vyGUcQlZAQ77z0jJFunrQ6Aao
         OGvxqAPnh3BNEoWDZ9UmymrKJsIW3IlRdC7xpY1uJg6QASP57GEOxro2NRBvcuCweXGY
         7P1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=+QrEfwNyUObZpg4FR+sDjlTmpv+zGn+vrSq3i8QmgIA=;
        b=AZ3NN2irCrrh2m8IOaVFX1Yf2ztpB5fROI9ZnaOaj0H1O9n3j0hMZjVEYx11aWSsiJ
         7Z6lAKJ+xAEQn58OidaqH+hX46/nm0AyqxbEC43EfDWIOkZc8/ZO5kv2JZT3mhDiXfYA
         9dQo/78+bgj16hyUFe0ZwerXPw6hxVoh3u9QhsJzTBpKqMRgr8GHR+D6f1ZYiaY8Nioj
         P3iAGgS0l7WKm9c2kHnWonUGfRl/tu3voSVJXUdPZ2z4vuzrTpSurpaJ8yJnwps5gwut
         ezfUtNXzpg3kqq+BxQ8MK3pASseBaPva6N1UV1UxxT81M1SKFMJcY0FHVeo/MeVHz0SF
         /uKA==
X-Gm-Message-State: AOAM533swU1KKvwU2rqc2TKKhJ5c/5mXGCkehPj+2xwP3N4OmS5HcqrQ
        EPvxRcXOOOeoRP+XNmK9nB0lxi8o2II=
X-Google-Smtp-Source: ABdhPJwsevakWlOrt4ajIp6BMcqWo0rbDiVYcTI3fI1UWc0KtcPGoRi7pihMy42NUg8+RwLL19mXhQ==
X-Received: by 2002:a17:90b:4c4e:b0:1e3:368b:c09c with SMTP id np14-20020a17090b4c4e00b001e3368bc09cmr3466584pjb.140.1654781103319;
        Thu, 09 Jun 2022 06:25:03 -0700 (PDT)
Received: from [192.168.11.5] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id t15-20020a17090340cf00b0016168e90f2csm16596512pld.208.2022.06.09.06.25.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jun 2022 06:25:02 -0700 (PDT)
Message-ID: <ff89c064-e24a-0f2f-fc03-b029e5d04338@gmail.com>
Date:   Thu, 9 Jun 2022 22:24:58 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: [PATCH 2/5] docs/doc-guide: Mention make variable SPHINXDIRS
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

SPHINXDIRS is useful when you want test builds of only those
documents affected by your changes.

Mention it in the "Sphinx Build" section.

Signed-off-by: Akira Yokosawa <akiyks@gmail.com>
Cc: Maciej W. Rozycki <macro@orcam.me.uk>
---
This change is inspired from correspondence with Maciej [1].

[1]: https://lore.kernel.org/r/f4d40da6-756b-9e75-b867-cc9eedc4b232@gmail.com

--
 Documentation/doc-guide/sphinx.rst | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/doc-guide/sphinx.rst b/Documentation/doc-guide/sphinx.rst
index edc4fa023986..efcccab68286 100644
--- a/Documentation/doc-guide/sphinx.rst
+++ b/Documentation/doc-guide/sphinx.rst
@@ -151,6 +151,10 @@ If the theme is not available, it will fall-back to the classic one.
 
 The Sphinx theme can be overridden by using the ``DOCS_THEME`` make variable.
 
+There is another make variable ``SPHINXDIRS``, which is useful when test
+building a subset of documentation.  Again, see the documentation section
+of ``make help`` for the details.
+
 To remove the generated documentation, run ``make cleandocs``.
 
 .. [#ink] Having ``inkscape(1)`` from Inkscape (https://inkscape.org)
-- 
2.25.1


