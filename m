Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C3D75A348B
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Aug 2022 06:35:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241234AbiH0EfO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Aug 2022 00:35:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236295AbiH0EfK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Aug 2022 00:35:10 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FF46192B8;
        Fri, 26 Aug 2022 21:35:08 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id r69so3111942pgr.2;
        Fri, 26 Aug 2022 21:35:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc;
        bh=SJNhJ1qE4MCsoFEdCOediDDt7pgmbkgeuipdnGt4+wI=;
        b=UFNsVSMD/K6fJcuwebO5RatjQETBb/k2+EtYySTVaUUq93Z4VKCgh4a26k9CQUX5B+
         NtwPh4oz6rF4P14hA7GR1i1af28biDQy90znpY3SofL/VCvPxrzsgAMyXJVhaTwLMjUy
         Y3Bwt3JglMSP0NzXbuXpYrxJHDhrGqF9fBGqKE7BbU//ms4KT/9L4kdAQesnCs0xT332
         Nn1QhYEuUqLnG++M7SlW/Glb4UcJt9COBNQXcHoZJ7uFwSyREp7JbdPDDxEt56XUyyei
         n28BUPNQNWDSVcOH9DBNsO3u6jZryoDVyZht7t/nv+M/Ia7GoNkz7wIti/7YCjGUhtSk
         89pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc;
        bh=SJNhJ1qE4MCsoFEdCOediDDt7pgmbkgeuipdnGt4+wI=;
        b=qEmBWyIxtogyNrxGNrJqUrRRjRw96kgU7JTi3lJvITuTWJPHqqHzok8SKZFO6ZmBhH
         PLYZ5rSlrfMS5FGroMMTRa/7szFz50LVNLT893GVF63kF488f5hgDQa379U+z0HTqqqD
         nc49gyZbpHK7hSFcFbqMEPfuv5/5KFamF4TX8r5bVmnJRogig13m1xbUsqk87DujW1ys
         kgGkW5OXkVIpDUm2I8KcpIYreeUlgMYr7ieeaU4EKnq4X6k2rn8LqKvWmBL5U373jhJL
         bGE6fYJqEetT0LXo+HXvxrs1cYlPhczDGK1OOqdlDgICpoEt2Q8df1fFnSjhFqEjanP+
         MQ8w==
X-Gm-Message-State: ACgBeo1MIHfqL4uJgS3U5O1zpTyupOoC7WdhLaogCBCtPgMXiLBpmQbh
        R64sKpXQuH+cplMcdvcVI9Q=
X-Google-Smtp-Source: AA6agR5l/tnuYPope4N3gPQOXWXnlOUzrr4B2yh9fCZmsIHFENTDxIMTrcDe7hxhyxVl7Hm0Q6jI4Q==
X-Received: by 2002:a63:4183:0:b0:41b:f6d3:8825 with SMTP id o125-20020a634183000000b0041bf6d38825mr5796741pga.193.1661574907581;
        Fri, 26 Aug 2022 21:35:07 -0700 (PDT)
Received: from [192.168.11.9] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id 73-20020a63014c000000b00419b66846fcsm2234669pgb.91.2022.08.26.21.35.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Aug 2022 21:35:06 -0700 (PDT)
Message-ID: <9b8ff6d7-e97a-c03f-7d46-4b80ae3cf196@gmail.com>
Date:   Sat, 27 Aug 2022 13:35:03 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Content-Language: en-US
To:     Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     linux-doc@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Akira Yokosawa <akiyks@gmail.com>
From:   Akira Yokosawa <akiyks@gmail.com>
Subject: [PATCH v3 0/2] docs: conf.py: Reduce texlive dependency
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

This is v3 which addresses Jon's comments to v2 [1], but slightly
different ways from Jon's suggestions.

Changes since v2 [1]:
 - Drop Patch 3/3, which is in docs-fixes now.
 - Patch 1/2:
     o Simplify find_command() by using shutil.which(). For guessing
       available commands, it should be good enough.
     o Mention find_command() in the changelog.
 - Patch 2/2:
     o Instead of silently ignoring unknown setting of SPHINX_IMGMATH,
       print a warning msg.

Acked-bys from Mauro are kept, as I assume these changes wouldn't
affect the purpose of each patch.

Changes since v1 [2]:
 - Patch 2/3: Rename LOAD_IMGMATH -> SPHINX_IMGMATH (Mauro).
 - For the series: Acked-bys from Mauro.

Amended coverletter:

This was inspired from the discussion on the expected behavior of
sphinx-pre-install [3].

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

Patch 1/2 adds code in conf.py so that for html docs, the imgmath
extension will be loaded only when both latex and dvipng are available.
For epub docs, imgmath will always be loaded (no change).

Patch 2/2 adds code respecting a new env variable "SPHINX_IMGMATH" which
will override the math renderer choice. This variable can be helpful
on distros such as Arch linux, Mageia, etc. whose packaging policy is
coarse-grained.

E.g., to test math rendering by mathjax, run:
    make SPHINX_IMGMATH=no htmldocs

I mentioned in the thread of [3] that imgmath can generate scalable
math images in SVG.

My plan was to implement that option as well.  But during tests under
Fedora/CentOS/openSUSE, I encountered a couple of warnings from dvisvgm.
That would be regressions on existing systems which happen to have
not-working dvisvgm along with working dvipng.  I'm thinking of adding
the SVG option later if I can figure out the minimal requirement for
dvisvgm under imgmath.

[1] v2: https://lore.kernel.org/r/c41cab17-afd6-bc99-56a1-e4e73b8c1ef6@gmail.com/
[2] v1: https://lore.kernel.org/r/12d078f5-6995-b039-7076-bdb1f372a799@gmail.com/
[3]: https://lore.kernel.org/r/3ba5a52e-cab6-05cf-a66e-adc58c467e1f@gmail.com/

        Thanks, Akira
--
Akira Yokosawa (2):
  docs/conf.py: Treat mathjax as fallback math renderer
  docs/conf.py: Respect env variable SPHINX_IMGMATH

 Documentation/conf.py | 41 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 40 insertions(+), 1 deletion(-)


base-commit: e1a0cc8865e3152e9fe43c6436b44e64c0359dfb
-- 
2.25.1

