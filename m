Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F37DF58C50B
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 10:49:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234256AbiHHItr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 04:49:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230127AbiHHItp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 04:49:45 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1F096363;
        Mon,  8 Aug 2022 01:49:40 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d16so7923805pll.11;
        Mon, 08 Aug 2022 01:49:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:content-language:from
         :subject:to:cc:content-transfer-encoding;
        bh=oFbfW+6eBoSd9lHzaSWXN4qCai+JIjJq05pd6OQMU5E=;
        b=JxZrR1+OnBtNim0vw7zXSz+LUKhlwQmPhmpSfbr9kARInimgkF2VIQsY24jCyFjFGh
         UhU4ixxym3zxmvc9BIOExrHt8b2qTigTSlOF0n4dOSmsqUQi6j0KDUmlJ7QsSmTo5CFx
         qwY2ilpVj+Wywr4DWyabDX5NScuF4EdtjDTVjE4jViO4AOsNQOBxNfOst2C/8fGZLncM
         /1ak/gDZ6qnMDjwxmZ9MwIC4FyQy3M7EVPUVOWzX5FaXzLAhcYAdANXV0Zuq2YN0rbw0
         jOqF+6BL3RP7Nu1cefla25ldHZO1VK99NuoTkDJI0ZMC5Vztmq2ad4SiuQhyUQTKMhHx
         MdOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:from:subject:to:cc:content-transfer-encoding;
        bh=oFbfW+6eBoSd9lHzaSWXN4qCai+JIjJq05pd6OQMU5E=;
        b=vp295VGEK8xuqG+BVBALut/hfa5vyqzESdOSH34b7y5fhWY+0A8941Y0UPIE1uGqWa
         Ad+bBIDRfETeEWwm467ypDuw0kefyKLfatjsdL3U4FeX4N7hZEl4+Ci/I+4gg/1FIe12
         8pHH+2M2mn/3SRT2RXXMmzcxSa2XFL3LxEcC6TCb6G0vrwU31uvj24xEUvF0oA5NMpiA
         zrtsU1iVr8Vx6ptmep13zVSvMpx0sB0YvqvTlmuqcGnWWkW1sqoOhpvGzYiY2qd9lq1l
         Iku3x3dSAUa8PXw9Zn6VjO0NdVFxCDVQ2WuTFgTFx/3LVOdPFCSQ+t5564ytqz26SDjt
         3T+g==
X-Gm-Message-State: ACgBeo2mXB5w16vZ6SKKBdKDZ0ThamcsOYx1pJVQ33AbIYO+G8cTLfc4
        RSFwGTkGAn19si4tcNKqrWxWJIzlfQA=
X-Google-Smtp-Source: AA6agR4sJC8tHznMpaiSUY2aqAw6/FBTROKgm+C906VThCVw97Nl+HlHp+apVkT7b7nQm4Id4V/cnQ==
X-Received: by 2002:a17:90b:3d85:b0:1f7:6a32:3576 with SMTP id pq5-20020a17090b3d8500b001f76a323576mr286044pjb.187.1659948580241;
        Mon, 08 Aug 2022 01:49:40 -0700 (PDT)
Received: from [192.168.11.9] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id i11-20020a17090332cb00b0016d1b708729sm8200661plr.132.2022.08.08.01.49.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Aug 2022 01:49:39 -0700 (PDT)
Message-ID: <c41cab17-afd6-bc99-56a1-e4e73b8c1ef6@gmail.com>
Date:   Mon, 8 Aug 2022 17:49:36 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Content-Language: en-US
From:   Akira Yokosawa <akiyks@gmail.com>
Subject: [PATCH v2 0/3] docs: conf.py: Reduce texlive dependency
To:     Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     linux-doc@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Akira Yokosawa <akiyks@gmail.com>
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

Hi,

This is v2 with the env variable of SPHINX_IMGMATH as suggested by
Mauro.

Changes since v1 [1]:
 - Patch 2/3: Rename LOAD_IMGMATH -> SPHINX_IMGMATH (Mauro).
 - For the series: Acked-bys from Mauro.

This was inspired from the discussion on the expected behavior of
sphinx-pre-install [2].

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

Patch 2/3 adds code respecting a new env variable "SPHINX_IMGMATH" which
will override the math renderer choice. This variable can be helpful
on distros such as Arch linux, Mageia, etc. whose packaging policy is
coarse-grained.

E.g., to test math rendering by mathjax, run:
    make SPHINX_IMGMATH=no htmldocs

I mentioned in the thread of [2] that imgmath can generate scalable
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

[1] v1: https://lore.kernel.org/r/12d078f5-6995-b039-7076-bdb1f372a799@gmail.com/
[2]: https://lore.kernel.org/r/3ba5a52e-cab6-05cf-a66e-adc58c467e1f@gmail.com/

        Thanks, Akira

--
Akira Yokosawa (3):
  docs/conf.py: Treat mathjax as fallback math renderer
  docs/conf.py: Respect env variable SPHINX_IMGMATH
  docs: kerneldoc-preamble: Test xeCJK.sty before loading

 Documentation/conf.py                       | 46 ++++++++++++++++++++-
 Documentation/sphinx/kerneldoc-preamble.sty | 22 +++++++---
 2 files changed, 61 insertions(+), 7 deletions(-)


base-commit: 339170d8d3da5685762619080263abb78700ab4c
-- 
2.25.1

