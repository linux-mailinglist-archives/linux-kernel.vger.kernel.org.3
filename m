Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5710158AC5E
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 16:24:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240947AbiHEOYx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 10:24:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238484AbiHEOYv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 10:24:51 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B43B5925A;
        Fri,  5 Aug 2022 07:24:50 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id a8so2899974pjg.5;
        Fri, 05 Aug 2022 07:24:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=rsvbdpDVmVTLiEyvBb5AVOQYTVyFER57JMOpNCoBxoQ=;
        b=XbGINiuA5ZKfsSdcZHTaPGv6WoyP4o5R1a2z0lTOd2DR2/EuKZEyqjzc1RSWGjYwW3
         wRgzE6+XYcEgYJEgBgDGBNodU8eZFAe2DO5/a+X+VdcT1Ke+uLZApMKPPVtHdBgPSchQ
         LwRlzP2zCTznxICqJS25ZPZ2dl4UdK4jVXnBa0TwuAicfUj8E69GDQWiCbeXEKqjXgoi
         XkBjha25PITSmlDFcqxiClGN3SVpUv2buKIB1/0/+xwKUNBYKTrj729so/JIMZGmbhU8
         Vl5xBLDrdqE2fQWDvxW4WFTAIn8BriwOWDCPheNkZXzm24Z/BURcADNRegxOGIjx08PG
         J6pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=rsvbdpDVmVTLiEyvBb5AVOQYTVyFER57JMOpNCoBxoQ=;
        b=0Z+6tbdtplB+Z68ba+3iDnYkGWYdtTe6HaXKGyqflp0oy1PiCZTBUXYnz2E5CJ1J7Y
         sjJzCHYoPwHsscxmIxVZ76+itvXx6oN95W35HdKjCkAfbVh6iQykL4fH7q37BVMwQUs0
         vfQhfDbSJU+/KzusJO1qnhNgRtVs/GuGxMdYCDROX0NNDDfthEfxjtikxUn/gFSPv5/K
         iVVT+SUcIGYJBTTfdiIDT4WdGXZkkoSPLfv0bKoX8IoyZpfQv61L8aTYpkx1uPHPqA7K
         ggxHj7IuHbKCxGZdxUvlSfvJL8ICEQHxJdQOLUvmIBJJnJYdYcxGOxAyMIYE2jeY/MBn
         keBw==
X-Gm-Message-State: ACgBeo2mbM0v80oIHq7z+IQ3zmcNSjxrRVq2zVzs4zh6hMwDwXGSzuwJ
        F5f91pa4seIU9aTpjI37L7Q=
X-Google-Smtp-Source: AA6agR54YqDtwEgUfhnwlAQ6EbNZ/wBTrMaFTFcfeGnJHRd3BeWwKzPpf7IljKUhsWh7a+tRqkZ8XQ==
X-Received: by 2002:a17:902:848b:b0:16d:4c6b:bf00 with SMTP id c11-20020a170902848b00b0016d4c6bbf00mr7027430plo.58.1659709489715;
        Fri, 05 Aug 2022 07:24:49 -0700 (PDT)
Received: from [192.168.11.9] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id z20-20020aa79594000000b0052895642037sm3068028pfj.139.2022.08.05.07.24.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Aug 2022 07:24:49 -0700 (PDT)
Message-ID: <aeb5e6fc-4af9-8e3e-a9db-bbcb22d9d913@gmail.com>
Date:   Fri, 5 Aug 2022 23:24:46 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: [PATCH 2/3] docs/conf.py: Respect env variable LOAD_IMGMATH
Content-Language: en-US
To:     Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Akira Yokosawa <akiyks@gmail.com>
References: <12d078f5-6995-b039-7076-bdb1f372a799@gmail.com>
From:   Akira Yokosawa <akiyks@gmail.com>
In-Reply-To: <12d078f5-6995-b039-7076-bdb1f372a799@gmail.com>
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
variable "LOAD_IMGMATH" which overrides the automatic choice
of math renderer for html docs.

    LOAD_IMGMATH=yes : Load imgmath even if dvipng is not found
    LOAD_IMGMATH=no  : Don't load imgmath (fall back to mathjax)

Signed-off-by: Akira Yokosawa <akiyks@gmail.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
---
 Documentation/conf.py | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/Documentation/conf.py b/Documentation/conf.py
index 3ec1f845c839..03613eb59578 100644
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
+# Respect LOAD_IMGMATH (for html docs only)
+if 'LOAD_IMGMATH' in os.environ:
+    opt_load_imgmath = os.environ['LOAD_IMGMATH']
+    if 'yes' in opt_load_imgmath:
+        load_imgmath = True
+    elif 'no' in opt_load_imgmath:
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


