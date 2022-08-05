Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A69BD58AC52
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 16:21:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240925AbiHEOVZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 10:21:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230095AbiHEOVU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 10:21:20 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 688BA15820;
        Fri,  5 Aug 2022 07:21:19 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id f28so2408572pfk.1;
        Fri, 05 Aug 2022 07:21:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:content-language:from
         :subject:to:cc:content-transfer-encoding;
        bh=rXNow5gqUbkKynqjVClwEN34zi5YChlSfSC++OuolEw=;
        b=lA0Hi0Qls8/HOM+mQD/3xoGxtOv7xgkXVWE+jOuOUMFTFboUlWTL6enIowiLc3kN/0
         RZ4aZRZBmUSS4+HhgcdqVXyl2EMdTz01kl2XxZZxf9V6SxwiN6cBnYnpuOtoQPX/XOqF
         0B1NxEUOeHYwcKdbVJOiOU9R9T3/wlZhu2rXcd1HQyYaZ0oTwsVBC6/SBfX/BOWm+g59
         6iQt+IYisL68tUrjz3m7y3FUuJIjuRV4UUtduZQKQauJO99ycYy5U3fR1400Pht4Ux2O
         FBEd1Ch4OHA05BLvsM3wiixqFOvVVLj4/R60/CGgRgfccj8HuNFAXdpR5tA2awGi17Hr
         wnsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:from:subject:to:cc:content-transfer-encoding;
        bh=rXNow5gqUbkKynqjVClwEN34zi5YChlSfSC++OuolEw=;
        b=1F8lU8zH57dHoMdsszprT0+P3ObN1wxHoGfFCdf+W2ExvzDnJrBARv15JkSBjnHOHT
         dqlGfgZdNc/Cg7/tbG5i2BDYNhXtKNL6AnnnU+fn6v0mfqpAX6UYT4LIbMDeGNYk6LKs
         blXHtudVYTCqjLYZngSx0D/bkbZPEJrTpEw3SpenCac67MHYtvmnkRnE9Ve1lt9P+yA8
         kPiki/31LVhP4asRzob3rKf1w9/IITlRBy9ADvAc7EbUZOaOEHKEzkhAZNmM6iTF9rmi
         RsAHEwnbStLjdby7ELLW3VQb+vUIHJztRb9wjas6/dBZ9ZLie5tISZWbcA2Pe92Nxg9/
         sxQw==
X-Gm-Message-State: ACgBeo0GuWY8X5gj64et9Stk4Aa8xlpJZDDPAWIoDhQWkUVLdqOg9t2g
        9sepP9IGzEGy5KZpB4Sect/b+oDsZ7w=
X-Google-Smtp-Source: AA6agR7ced9Eh7JPfY+hYio26XKmu+deIOW7HuHiOXeA+Q4q+GnuBdiVERgR1eUKVio0td+dekqSpw==
X-Received: by 2002:a05:6a00:4147:b0:52e:2d56:17c8 with SMTP id bv7-20020a056a00414700b0052e2d5617c8mr7095103pfb.51.1659709278870;
        Fri, 05 Aug 2022 07:21:18 -0700 (PDT)
Received: from [192.168.11.9] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id f11-20020aa79d8b000000b00528c3ad8e09sm3059969pfq.66.2022.08.05.07.21.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Aug 2022 07:21:18 -0700 (PDT)
Message-ID: <12d078f5-6995-b039-7076-bdb1f372a799@gmail.com>
Date:   Fri, 5 Aug 2022 23:21:13 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Content-Language: en-US
From:   Akira Yokosawa <akiyks@gmail.com>
Subject: [PATCH 0/3] docs: conf.py: Reduce texlive dependency
To:     Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Akira Yokosawa <akiyks@gmail.com>
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

This was inspired from the discussion on the expected behavior of
sphinx-pre-install [1].

There was a mismatch between Mauro's intent and my expectation for
the --no-pdf option of sphinx-pre-install.

My thought was if I installed all the packages suggested from
"./scripts/sphinx-pre-install --no-pdf", "make htmldocs" should run
free of complaints of missing commands or packages.

However, I got this warning when I tried the procedure on a debian-
based container image:

    WARNING: LaTeX command 'latex' cannot be run (needed for math display),
    check the imgmath_latex setting

, or:

    WARNING: dvipng command 'dvipng' cannot be run (needed for math display),
    check the imgmath_dvipng setting

Mauro's response to my complaint was this:

> The idea of using --no-pdf is to setup an environment without LaTeX,
> meaning that math tags would only be partially parsed: basically, the
> output would be html with LaTeX-like math expressions (at least last
> time I tried).

The mismatch can be resolved by using "mathjax" for math rendering
and making "make htmldocs" be free of texlive packages.

mathjax is the default math renderer since Sphinx 1.8.  It delegates
math rendering to web browsers.  

As Mauro has pointed out, "make epubdocs" requires imgmath.

So this patch set treats mathjax as a fallback math renderer for html
docs when imgmath requirements are not met.
Existing systems which meet imgmath requirements are not affected by
this change.

Summary of math rendering in html:

         dvipng, browser             before           after
    ==========================  ===============  ================
    dvipng                      imgmath (png)    <--
    no divpng, with javascript  raw math:: code  mathjax
    no dvipng, w/o javascript   raw math:: code  raw mathjax code

Patch 1/3 adds code in conf.py so that for html docs, the imgmath
extension will be loaded only when both latex and dvipng are available.
For epub docs, imgmath will always be loaded (no change).

Patch 2/3 adds code respecting a new env variable "LOAD_IMGMATH" which
will override the math renderer choice. This variable can be helpful
on distros such as Arch linux, Mageia, etc. whose packaging policy is
coarse-grained.

E.g., to test math rendering by mathjax, run:
    make LOAD_IMGMATH=no htmldocs

I mentioned in the thread of [1] that imgmath can generate scalable
math images in SVG.

My plan was to implement that option as well.  But during tests under
Fedora/CentOS/openSUSE, I encountered a couple of warnings from dvisvgm.
That would be regressions on existing systems which happen to have
not-working dvisvgm along with working dvipng.  I'm thinking of adding
the SVG option later if I can figure out the minimal requirement for
dvisvgm under imgmath.

Patch 3/3 is an independent change in the LaTeX preamble for pdf docs.
Currently, xeCJK.sty provided for RHEL 9 (and its clones) is broken
due to the lack of new dependency.  As a workaround, treat the absence
of xeCJK.sty as the additional knob for skipping CJK contents.

Note: Generated LaTeX sources will be the same regardless of existence
of the "Noto Sans CJK SC" font and xeCJK.sty.

[1]: https://lore.kernel.org/r/3ba5a52e-cab6-05cf-a66e-adc58c467e1f@gmail.com/

        Thanks, Akira
--
Akira Yokosawa (3):
  docs/conf.py: Treat mathjax as fallback math renderer
  docs/conf.py: Respect env variable LOAD_IMGMATH
  docs: kerneldoc-preamble: Test xeCJK.sty before loading

 Documentation/conf.py                       | 46 ++++++++++++++++++++-
 Documentation/sphinx/kerneldoc-preamble.sty | 22 +++++++---
 2 files changed, 61 insertions(+), 7 deletions(-)


base-commit: 339170d8d3da5685762619080263abb78700ab4c
-- 
2.25.1

