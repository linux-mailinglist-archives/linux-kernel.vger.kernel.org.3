Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71B3356622A
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 06:16:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234668AbiGEEQH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 00:16:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230432AbiGEEQG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 00:16:06 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF5F512612;
        Mon,  4 Jul 2022 21:16:03 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id l12so4640186plk.13;
        Mon, 04 Jul 2022 21:16:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:to:cc:references:subject
         :content-language:from:in-reply-to:content-transfer-encoding;
        bh=FPgdnVKTSovzKEuqlXZPKdYIpQvBN8n+683l+K9eqcM=;
        b=UctD2AqvOkh/6d8nBmh6a7CHTFzQV5gjwiInjr7Utwt9ahrsxtxvWRykGPBn5/VPLM
         X1NFZdh9a0UfamHQt0OUinDAmuuAeHiYI0MWnKV7Vhz74Udb9gP64wOpmSx/AclI+Jc3
         lpFN5wgo+c5FCKLAvWQfpSTb5RQJhfFuan4EB9mc4G5t6TT175IOoLjEkJa5HYgPaugV
         hyzTQUjPavimPgbIZ9lL0XgXQlo4zG3P/3W293/fy4gvo9j9wW/Lba5/eB6IsJ4O+RFT
         Rr8g6KfL2cdgUHF8GolxIKH78TWFYms8azpahCM7wnf4OXk8xNvQpas/lqsRR5GR8nrm
         NhBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:to:cc
         :references:subject:content-language:from:in-reply-to
         :content-transfer-encoding;
        bh=FPgdnVKTSovzKEuqlXZPKdYIpQvBN8n+683l+K9eqcM=;
        b=NK1s2sIeEMqGo/CaZMHtADJ7iij9WL2dFLybwBx6pBQmVXwcfUawL/G4DseaLpjNMM
         n2lg2WXzGmDtaopiSzf21WnrhTM0dQekPZXQ1zl/f4vIf5vzJDpMSlyeDeZnHfHt2PKa
         nd29wpV2M6w6phKuQR+GVTvpR3wLPY8gCSdnE8it0Q/oghUHKFI5XQNBK2pfKIiwUfYL
         7skIQA/cZBz57xFrFFpwtcSHsXVrZoGlrjGtbPY/PBjxGUkHpq3uj5IBgP8TjTGPYAzV
         fJDfl9JUrrzZEmT76ecLiomcdTh1f4lVbOGLhGKzzfsuCWyhEwtcOaveuyP07E1HiFDx
         t+MQ==
X-Gm-Message-State: AJIora9+QijI0cwQ7irEWskXcRUZ2x6JG0ivuj9EY5Q3NggsJq4+/5s8
        BVx8ynGaEVov+Y0MejDDtiqRcG0dNro=
X-Google-Smtp-Source: AGRyM1uNQq4+BCQxt5a0xs4aoLtC7s4QPf7vrQkTCu8n5KD6HPinOv9at5zwwVDTmH1qp03rZKlCmg==
X-Received: by 2002:a17:90b:e95:b0:1ef:825f:cb40 with SMTP id fv21-20020a17090b0e9500b001ef825fcb40mr13432969pjb.29.1656994563259;
        Mon, 04 Jul 2022 21:16:03 -0700 (PDT)
Received: from [192.168.11.9] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id b8-20020a170903228800b0016b8746132esm8570201plh.105.2022.07.04.21.16.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Jul 2022 21:16:02 -0700 (PDT)
Message-ID: <d0e1a08a-b965-ada6-e026-4e1cc38fbd90@gmail.com>
Date:   Tue, 5 Jul 2022 13:15:57 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     corbet@lwn.net, ksummit-discuss@lists.linuxfoundation.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        mchehab+huawei@kernel.org, Akira Yokosawa <akiyks@gmail.com>
References: <cover.1656756450.git.mchehab@kernel.org>
Subject: Re: [PATCH v2 0/5] Address some issues with sphinx detection
Content-Language: en-US
From:   Akira Yokosawa <akiyks@gmail.com>
In-Reply-To: <cover.1656756450.git.mchehab@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mauro,

On Sat,  2 Jul 2022 11:11:24 +0100, Mauro Carvalho Chehab  wrote:
> Checking if Sphinx is available and read to run is tricky, and may involve
> installing several packages for the document build to happen.
> 
> There are two options to install Sphinx:
> 
> 	- via distro-provided packages;
> 	- via pip, using virtualenv/venv.
> 
> Some recent discussions showed a couple of misleading instructions.
> 
> This series improves the Sphinx detection by:
> 
> - Fixing the logich with checks if a past venv is working and recommend
>   just enabling it instead of installing a new venv;
> - Detect if sphinx-build stopped working on a venv. This may happen during
>   distribution updates;
> - Move the PDF minimal version to be later, in order for it to be printed only
>   after finishing the Sphinx version check;
> 
> Additionally, as now the Sphinx provided on almost all modern distros are
> above the minimal required version, place instructions about how to install
> Sphinx from the distro-provided packages after placing the instructions for
> installing it via venv.
> 
> This will hopefully help to have more developers checking documentation
> builds with
> 
> 	make htmldocs
So this is a meta-level feedback considering the most likely uses
of sphinx-pre-install.

I think first-time users of sphinx-pre-install are more likely
interested in getting ready for running "make html".  They won't
bother with "make pdfdocs".  They won't likely be interested in
virtualenv, either.

So I think it would be reasonable to change the default behavior
of sphinx-pre-install.

I mean the reasonable behavior without any option would be that of
when both --no-pdf and --no-virtualenv are given to the current
version.

There are a few issues on --no-pdf.

It says imagemagick and gcc are necessary, but they are redundant
in "make html", as far as I see.

Furthermore, it doesn't check dvipng and latex, which are used
for generating math equation images in HTML.

Fedora, RHEL/CentOS, and openSUSE Leap provide helpful packages
for installing math expression support.

    Fedora 36               python3-sphinx-latex (python3-sphinx depends on this)
    RHEL 9/CentOS stream 9  ditto
    openSUSE Leap 15.4      python3-Sphinx_4_2_0-latex
                                (python3-Sphinx_4_2_0 depends on this) or
                            python3-Sphinx-latex
                                (python3-Sphinx depends on this, version: 2.3.1)

Other distros, whose texlive packages are coarse grained, don't provide
such helper packages.

Also, as mentioned previously, RHEL 9/CentOS stream9's texlive-xecjk 
doesn't work at the moment due to the lack of its dependency (texlive-ctex).
I opened a bug ticket at RedHat bugzilla:
   https://bugzilla.redhat.com/show_bug.cgi?id=2086254

Unfortunately, I've heard no response yet.
If you know some means to boost its priority, please provide a comment
or two to the ticket.

Until the issue can be resolved, "make pdfdocs" is limited to non-CJK
build on CentOS stream 9, RHEL 9 and its clones if you must stick to
distro packages.  For non-CJK build to work, you must not have
google-noto-sans-cjk-ttc-fonts.

openSUSE Leap does not support full CJK build of "make pdfdocs", either.
Its Noto font packaging is peculiar and a similar named package of
noto-sans-cjk-fonts installs a set of language-specific fonts, each
of which doesn't qualify as a CJK font.

Seeing these problems of LTS distros, I'd suggest sphinx-pre-install
--pdf would check packages for non-CJK builds.

Another option of --cjk would show you additional packages for full CJK build.

TL;DR, my suggestion of options and defaults to sphinx-pre-install:

    --no-pdf (default): for htmldocs only
    --no-virtualenv (default): distro Sphinx package
         (mention --virtualenv if distro Sphinx package is too young)
    --virtualenv: Sphinx by venv/virtualenv
    --pdf: for pdfdocs
        --no-cjk (default): don't bother with CJK pdfdocs
        --cjk: for CJK pdfdocs
               (print warning if user's distro doesn't support CJK)

Thoughts?

        Thanks, Akira

>
> ---
> 
> v2:
> - Fix some issues at the logic that was recommending installing via
>   distro-package manager;
> - Add a notice about Sphinx 3.0+ false-positive warnings due to a
>   Sphinx bug. People using a version different than the recommended
>   one should know about that.
> 
> Mauro Carvalho Chehab (5):
>   scripts: sphinx-pre-install: fix venv version check logic
>   scripts: sphinx-pre-install: report broken venv
>   scripts: sphinx-pre-install: check for PDF min version later on
>   scripts: sphinx-pre-install: provide both venv and package installs
>   scripts: sphinx-pre-install: place a warning for Sphinx >= 3.0
> 
>  scripts/sphinx-pre-install | 90 +++++++++++++++++++++++++++++---------
>  1 file changed, 69 insertions(+), 21 deletions(-)
> 
> -- 
> 2.36.1
