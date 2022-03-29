Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 594C04EB6B0
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 01:23:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240206AbiC2XZO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 19:25:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240153AbiC2XZJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 19:25:09 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03A6B182DAF;
        Tue, 29 Mar 2022 16:23:22 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id z8so20535253oix.3;
        Tue, 29 Mar 2022 16:23:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=XPzvHUJFcmrmwBdLqv88phqCPGJz+AlJYWNEiHZ+N9k=;
        b=kv0gkWrKiGBy8kYA4uYrQ1vrivtKVfzqOyTvCj+p//11dTmhxCKTaLhU4ihHXdOGJ+
         EPBxOP94TQqKyAzQw16ZSCf0Q+KrvjahcXqouAlSnK0trik/L+5SiYi51LU8kzDiAk3U
         DMdYEIeZzyQUqIcYWxYqMDJd9ef96WJ/yvJrLNby/7RHZ8sjjA1Z4RrblYwyR86n21GE
         U2gyVHQVvANKcmiQGb/1APnAQQnnyRpCwMgyr8pi9ZY0x0Oi66zuS/15RlNdVL4ZdNE3
         Rf0IHJShFGcgrB9qbdW89h9J6ehCrxlMNzySC96KMwlna3arfnkwzEEdANfL4KTtAjAt
         0dTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XPzvHUJFcmrmwBdLqv88phqCPGJz+AlJYWNEiHZ+N9k=;
        b=GbbjDTiaWn9paHpAuoQVFfp5LEDdMKZm2Il2aNf4a1X3WmmdghtdnO87XinAIW5ykH
         PyaZID721DFYgHxMD2s09lhhz3enGmpumplakTXnk0KxyGTyaR8JyesnDYxVoJ1ceLZH
         YL5in5SpVgc2NyQXT30yi4FwDpobQnsRwc+g6Z8JD1lETVT6//bZj9bQGSZAjAuERqSn
         EPI/uYb/NlZiONfTCDyafw2mSBA8h+sZ8iBn02mJb7zXZV/PuaSKCFDBUJzhMHtzjf9+
         XK4HHSdWork8675TbKRxcymB6ekJopxnjIuPDkY1U/RuS87y6X8ocvQticAt2Cfd7VYp
         o5Rw==
X-Gm-Message-State: AOAM530SlsBgUZie3NnwMRKsXRFfZHE7h33BO+XJbwHY75Jibx2BzUhM
        bHyRXnVEZluSj2hPmHagSWU=
X-Google-Smtp-Source: ABdhPJzLQP2ylpqyfwQ0/iHWuE5kgaqVA+koSF2KnxNt0QjXk6vd3PbeNN2JVnO26ZeoR+Z9yWlUig==
X-Received: by 2002:aca:4b50:0:b0:2ef:b47:294a with SMTP id y77-20020aca4b50000000b002ef0b47294amr701959oia.69.1648596201324;
        Tue, 29 Mar 2022 16:23:21 -0700 (PDT)
Received: from marsc.168.1.7 ([2804:d57:1503:f300:282c:2283:f732:e1c7])
        by smtp.gmail.com with ESMTPSA id s6-20020a4ae546000000b0032480834193sm8863192oot.46.2022.03.29.16.23.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Mar 2022 16:23:21 -0700 (PDT)
Date:   Tue, 29 Mar 2022 20:23:14 -0300
From:   Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To:     corbet@lwn.net, mchehab+huawei@kernel.org, dlatypov@google.com,
        davidgow@google.com
Cc:     linux-doc@vger.kernel.org, linux-sparse@vger.kernel.org,
        cocci@inria.fr, smatch@vger.kernel.org,
        linux-kernel@vger.kernel.org, skhan@linuxfoundation.org,
        dan.carpenter@oracle.com, julia.lawall@inria.fr
Subject: [PATCH v2 2/2] Documentation: dev-tools: Enhance static analysis
 section with discussion
Message-ID: <11f4750c6d4c175994dfd36d1ff385f68f61bd02.1648593132.git.marcelo.schmitt1@gmail.com>
References: <cover.1648593132.git.marcelo.schmitt1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1648593132.git.marcelo.schmitt1@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enhance the static analysis tools section with a discussion on when to
use each of them.

This was mainly taken from Dan Carpenter and Julia Lawall's comments on
the previous documentation patch for static analysis tools.

Lore: https://lore.kernel.org/linux-doc/20220329090911.GX3293@kadam/T/#mb97770c8e938095aadc3ee08f4ac7fe32ae386e6

Signed-off-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Cc: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Julia Lawall <julia.lawall@inria.fr>
---
 Documentation/dev-tools/testing-overview.rst | 33 ++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/Documentation/dev-tools/testing-overview.rst b/Documentation/dev-tools/testing-overview.rst
index b5e02dd3fd94..91e479045d3a 100644
--- a/Documentation/dev-tools/testing-overview.rst
+++ b/Documentation/dev-tools/testing-overview.rst
@@ -146,3 +146,36 @@ Documentation/dev-tools/coccinelle.rst documentation page for details.
 
 Beware, though, that static analysis tools suffer from **false positives**.
 Errors and warns need to be evaluated carefully before attempting to fix them.
+
+When to use Sparse and Smatch
+-----------------------------
+
+Sparse is useful for type checking, detecting places that use ``__user``
+pointers improperly, or finding endianness bugs. Sparse runs much faster than
+Smatch.
+
+Smatch does flow analysis and, if allowed to build the function database, it
+also does cross function analysis. Smatch tries to answer questions like where
+is this buffer allocated? How big is it? Can this index be controlled by the
+user? Is this variable larger than that variable?
+
+It's generally easier to write checks in Smatch than it is to write checks in
+Sparse. Nevertheless, there are some overlaps between Sparse and Smatch checks
+because there is no reason for re-implementing Sparse's check in Smatch.
+
+Strong points of Smatch and Coccinelle
+--------------------------------------
+
+Coccinelle is probably the easiest for writing checks. It works before the
+pre-compiler so it's easier to check for bugs in macros using Coccinelle.
+Coccinelle also writes patches fixes for you which no other tool does.
+
+With Coccinelle you can do a mass conversion from
+``kmalloc(x * size, GFP_KERNEL)`` to ``kmalloc_array(x, size, GFP_KERNEL)``, and
+that's really useful. If you just created a Smatch warning and try to push the
+work of converting on to the maintainers they would be annoyed. You'd have to
+argue about each warning if can really overflow or not.
+
+Coccinelle does no analysis of variable values, which is the strong point of
+Smatch. On the other hand, Coccinelle allows you to do simple things in a simple
+way.
-- 
2.35.1

