Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92DAD5A3492
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Aug 2022 06:38:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231895AbiH0Ei0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Aug 2022 00:38:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229983AbiH0EiX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Aug 2022 00:38:23 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1550A5C74;
        Fri, 26 Aug 2022 21:38:22 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id h11-20020a17090a470b00b001fbc5ba5224so3760007pjg.2;
        Fri, 26 Aug 2022 21:38:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=dEKV5G+5ehJFpFZg02Cmb2rWjLpf+O2SqBExv52ariU=;
        b=Qm5CZzfYjx1rG2MQoIuxH5kLzDOkH6d0+L/CY2JeQNGo7vL9F9gYBJNreUOEBO7n3p
         oA+GaUWNg1Oqf+qhs4fXMsGx2Zd+14oQc4M71rgHMuKXJ5Mm0FlbFMltw8vlL9YxLO2C
         UenvfPRTP/fafcTZbAw4p82nkVwmS8RO6F2iy8RoLJkJBrPCqs5QuwI5o2e5BiIlbYdB
         Hz54WG+Kz4eg/+VPPBzQX8mBklbNVe6oImi7S7+1xj4xpY+d5yd9f6xqWYop85Z0BRhd
         9O/V3Y6dLGLZMHgEX2Xzug92bwBZbEP9fkR5gU802xmkEDCR+xsmyNxO3CRUmdmA6oeZ
         6f0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=dEKV5G+5ehJFpFZg02Cmb2rWjLpf+O2SqBExv52ariU=;
        b=LSxtkgONVzceIm59TJYzd+g1rM6LQt7qVbA5EnAFj0EGxN0ikG0S2Tp4KxzAYlCYVC
         /C8c4XWt1XoVlUe15nerQ1ImGX61hAAvq2zCsh9pAa+0eIl72ZFPYk/Tw8rmwZC9bvUB
         39Uv7wY9BxiOh0jMlOw1mbO1uNKnrOc0JAzWujCt7dfSrp0PAhAXfsRrZRmOq2zytJYV
         lypf7rNoc6zut13qN50NDTlW9/MKmGm27BC/aISwCw3jnMrtqdeQqlhLm5jzEOEuMsP8
         mXE481i9wOi2oJNI/eH5mKrS+XzzGOEGf9J5+OV3Xmt7TmyOsuTopylVVE2C3OC0/K+i
         h0ig==
X-Gm-Message-State: ACgBeo0VVLGtxVKQIQ2FFkmTZZcCyfbY3EZR/QYAG5bL+f4b23ENlrB1
        aeS37HkmvDl/A0Fo8wO+LiwlCae14Zk=
X-Google-Smtp-Source: AA6agR5j9KW+vtffhmUCKZgWhAvVslJ9WVNEtrvHaJty4Vcy7Mxt+MATA+HJ9dfwqD8Heay1Fib9Pg==
X-Received: by 2002:a17:902:8606:b0:172:fecc:88d with SMTP id f6-20020a170902860600b00172fecc088dmr6662648plo.129.1661575102157;
        Fri, 26 Aug 2022 21:38:22 -0700 (PDT)
Received: from [192.168.11.9] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id p23-20020a17090a0e5700b001f56315f9efsm2487472pja.32.2022.08.26.21.38.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Aug 2022 21:38:21 -0700 (PDT)
Message-ID: <5a582b2b-d51c-a062-36b2-19479cf68fab@gmail.com>
Date:   Sat, 27 Aug 2022 13:38:17 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: [PATCH v3 2/2] docs/conf.py: Respect env variable SPHINX_IMGMATH
Content-Language: en-US
To:     Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     linux-doc@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Akira Yokosawa <akiyks@gmail.com>
References: <9b8ff6d7-e97a-c03f-7d46-4b80ae3cf196@gmail.com>
From:   Akira Yokosawa <akiyks@gmail.com>
In-Reply-To: <9b8ff6d7-e97a-c03f-7d46-4b80ae3cf196@gmail.com>
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
Changes since v2:
 - Emit warning on unknown setting of SPHINX_IMGMATH.

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
index c4aaedd96220..9678a8215457 100644
--- a/Documentation/conf.py
+++ b/Documentation/conf.py
@@ -124,8 +124,20 @@ autosectionlabel_maxdepth = 2
 # mathjax is the default math renderer since Sphinx 1.8.
 have_latex =  have_command('latex')
 have_dvipng = have_command('dvipng')
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
+    else:
+        sys.stderr.write("Unknown env SPHINX_IMGMATH=%s ignored.\n" % env_sphinx_imgmath)
+
+# Always load imgmath for Sphinx <1.8 or for epub docs
+load_imgmath = (load_imgmath or (major == 1 and minor < 8)
                 or 'epub' in sys.argv)
 
 if load_imgmath:
-- 
2.25.1


