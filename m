Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 056E058C512
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 10:53:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235717AbiHHIxA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 04:53:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231861AbiHHIw6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 04:52:58 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBBD89FFB;
        Mon,  8 Aug 2022 01:52:56 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id gj1so8223287pjb.0;
        Mon, 08 Aug 2022 01:52:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=CM2guZb6Hn0pwfDRg7CFUO0ej/Lsp2LuT1wX5l0Jt8g=;
        b=k45ypWaGJAvcx1jVTyF1lwQ5Ncs9Htz0s/AN7ToMcU1XIJo3Qj8955IS9iiUTMTg9o
         hPISvzy2/4mtnH31tDJEpdrUjfSjwUkbg+EmNNR7VZCSj3soYoZvxgi8M/1gN3TaqMNY
         c/l0OFymbBzRN3mC0ZUimIKWqKn9AzujwnbTo0ukJAYZ3Z0MZCuDgMLVqpjzGfEfvamb
         Hdsq3xJ15UwDUNjcHBXiAWZYMY6wCp03poVljLyiAOAF9SadfAYj1DPuCVTEY6FxihIH
         n9ywsfmXWU/wXp2FJY8rrBenCEkdBYjIm6y8eYVIBTXNMGRL3jGFqXmjMvyJVdfyfEiM
         LSNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=CM2guZb6Hn0pwfDRg7CFUO0ej/Lsp2LuT1wX5l0Jt8g=;
        b=fNOpOA1xp50tG1gQg9R9WyR/smuBC7H42O8rEQY44x5XrluqIPUPReUep3D8GdWrq7
         Xh4xyYzLQrKtIUsRE6KIGgbuO7cny3CeQvNuoSk8DKjPAc7E8/Un70fYSFokvNsH8SiV
         yCr14KP9F+LUOS/mc19zzA4oGUqBsPKUdWxwur5lZUhCZXp2d0TZfqZoU7VSjFQEaDkC
         XcMBZ6yHmittSDdAW9crFO61YJyCL9DRj8/Ad417Sdq6WHlkehM/zN97hJu8A1Z0Gty2
         Zsu0zddcFbWDdYrvJbIm7l4A67tyPkHzAKRePO6zhN72gr+avX3FkkgMug/qLRvt2r5q
         YDXA==
X-Gm-Message-State: ACgBeo3IQpGowjJIZ3QM4b1CbrHvbVkskxHNgiQydjqsyyrHcPD4N5lX
        Uwpqb/n/FyPlQUdAnPa6tiA=
X-Google-Smtp-Source: AA6agR5HFR3R02lOfrMcBsBKgjA+us7p2/6lea3lBBqeCWq6Hpd/S9k2kAhbzLEohbBqWWcg6S9PCg==
X-Received: by 2002:a17:902:848b:b0:16d:4c6b:bf00 with SMTP id c11-20020a170902848b00b0016d4c6bbf00mr17628923plo.58.1659948776412;
        Mon, 08 Aug 2022 01:52:56 -0700 (PDT)
Received: from [192.168.11.9] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id n15-20020a056a00212f00b0052deda6e3d2sm8260417pfj.98.2022.08.08.01.52.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Aug 2022 01:52:55 -0700 (PDT)
Message-ID: <736e39fd-b068-80dd-b383-70e061e71bf5@gmail.com>
Date:   Mon, 8 Aug 2022 17:52:52 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: [PATCH v2 2/3] docs/conf.py: Respect env variable SPHINX_IMGMATH
Content-Language: en-US
To:     Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     linux-doc@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Akira Yokosawa <akiyks@gmail.com>
References: <c41cab17-afd6-bc99-56a1-e4e73b8c1ef6@gmail.com>
From:   Akira Yokosawa <akiyks@gmail.com>
In-Reply-To: <c41cab17-afd6-bc99-56a1-e4e73b8c1ef6@gmail.com>
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

On some distros with coarse-grained packaging policy, dvipng is
installed along with latex.  In such cases, math rendering will
use imgmath by default.  It is possible to override the choice by
specifying the option string of "-D html_math_renderer='mathjax'"
to sphinx-build (Sphinx >= 1.8).

To provide developers an easier-to-use knob, add code for an env
variable "SPHINX_IMGMATH" which overrides the automatic choice
of math renderer for html docs.

    SPHINX_IMGMATH=yes : Load imgmath even if dvipng is not found
    SPHINX_IMGMATH=no  : Don't load imgmath (fall back to mathjax)

Signed-off-by: Akira Yokosawa <akiyks@gmail.com>
Acked-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---
Changes since v1:
 - No logical changes.
 - Renames:
     LOAD_IMGMATH -> SPHINX_IMGMATH (Mauro),
     opt_load_imgmath -> env_sphinx_imgmath.
 - Acked-by from Mauro.

--
 Documentation/conf.py | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/Documentation/conf.py b/Documentation/conf.py
index 3ec1f845c839..0b8f20e8e22c 100644
--- a/Documentation/conf.py
+++ b/Documentation/conf.py
@@ -128,8 +128,20 @@ autosectionlabel_maxdepth = 2
 # mathjax is the default math renderer since Sphinx 1.8.
 have_latex =  have_command('latex', '--version', 'pdfTeX')
 have_dvipng = have_command('dvipng', '--version', 'dvipng')
-load_imgmath = ((have_latex and have_dvipng)
-                or (major == 1 and minor < 8)
+load_imgmath = have_latex and have_dvipng
+
+# Respect SPHINX_IMGMATH (for html docs only)
+if 'SPHINX_IMGMATH' in os.environ:
+    env_sphinx_imgmath = os.environ['SPHINX_IMGMATH']
+    if 'yes' in env_sphinx_imgmath:
+        load_imgmath = True
+    elif 'no' in env_sphinx_imgmath:
+        load_imgmath = False
+    else: # otherwide, auto selection
+        pass
+
+# Always load imgmath for Sphinx <1.8 or for epub docs
+load_imgmath = (load_imgmath or (major == 1 and minor < 8)
                 or 'epub' in sys.argv)
 
 if load_imgmath:
-- 
2.25.1


