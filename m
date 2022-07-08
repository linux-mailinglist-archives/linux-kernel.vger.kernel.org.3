Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4833656B896
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 13:35:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237615AbiGHLeK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 07:34:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231533AbiGHLeH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 07:34:07 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8366951C9;
        Fri,  8 Jul 2022 04:34:05 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id x184so9925352pfx.2;
        Fri, 08 Jul 2022 04:34:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:from:subject:to:cc
         :references:content-language:in-reply-to:content-transfer-encoding;
        bh=M6OFwUPb12h/pvXHZfbZYc/U1LLVevjKdrUoO8uPr7E=;
        b=hqWjInc8rpZJXQ4RSF/A/W8riAfawzXqE3/GKozWwkvUopMIH3cwpYvmTOFCJcUh4n
         WXB1cr19OUfsKGfg3sSyzfD3QkRKMY1SG4YWYHyt4IMN/t/xL3zRle6EA65JboNuayC6
         bibhuwPO7m9pbWkihQh6vanPB8ipwZYbLQXsss4T26E9jqAuBiIGVjNVNKSi+WY3SsEs
         FNaLFmtz1md3ajCXEchDDgxRA0aKN+BXKTbylngw5mjk10n9CIyedIPE7Ppa3TpQQ360
         B80CFovNAJKFKIGg7AEV+Nk4axtflCP9VSEPpFk1gh/azgrfNHRWX/ylVztAoqvKqvrk
         0TJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:from
         :subject:to:cc:references:content-language:in-reply-to
         :content-transfer-encoding;
        bh=M6OFwUPb12h/pvXHZfbZYc/U1LLVevjKdrUoO8uPr7E=;
        b=V7TpGJV7MULlDm9McgKrxOgQBMN0Jmy5TzP9Iwdvv9yKgPk8R4HUtUQvhvW8IpwfLp
         r/r4I6LQ19pTW32Wb6mDokPL0YfFn1WJCTGPZp1fZ52nBHC+SpWVMYxhGdcMKTiHx8Au
         pPEyeCEQoQHHSvymb2Uv0+WbszZAigDVMTg7kISDnd4ABY7Yq3yCxoJYpSXoJujiE/ji
         N7m4TQyam1qfffD36V7tPjJfPq6p0EP7xqEnfprekOuO/wXZCkvy9xRR652TSYLvuGlY
         4gdFKXerEkkF1Ctp7Fehu9OTEOanCMwes21yaIzneSqoNSUISHwvrrW57XzczEId6z0n
         JV+A==
X-Gm-Message-State: AJIora/+Cu+n0ZC1bpSNf2MFJ2PrZ9JKViU47fJRvgFM+sjoXEWPKFXE
        q1PPXMCcU/s9s6YYuJVKH3Hlhch1Ed0=
X-Google-Smtp-Source: AGRyM1szvIR9fEA0phmqUrXfv4P1IMti+QQ2J5vRs9mK05PzQw3QiFL6bQP9MIQUBh8VrNIa7xVjNg==
X-Received: by 2002:a63:77ca:0:b0:412:953e:d61b with SMTP id s193-20020a6377ca000000b00412953ed61bmr2942145pgc.397.1657280045238;
        Fri, 08 Jul 2022 04:34:05 -0700 (PDT)
Received: from [192.168.11.9] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id t3-20020a62ea03000000b005253e6605b5sm28845336pfh.44.2022.07.08.04.34.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Jul 2022 04:34:04 -0700 (PDT)
Message-ID: <3ba5a52e-cab6-05cf-a66e-adc58c467e1f@gmail.com>
Date:   Fri, 8 Jul 2022 20:34:00 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
From:   Akira Yokosawa <akiyks@gmail.com>
Subject: Expectation to --no-pdf option (was Re: [PATCH v2 0/5] Address some
 issues with sphinx detection)
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     corbet@lwn.net, ksummit-discuss@lists.linuxfoundation.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        mchehab+huawei@kernel.org, Akira Yokosawa <akiyks@gmail.com>
References: <cover.1656756450.git.mchehab@kernel.org>
 <d0e1a08a-b965-ada6-e026-4e1cc38fbd90@gmail.com>
 <20220707211558.438a27d4@sal.lan>
Content-Language: en-US
In-Reply-To: <20220707211558.438a27d4@sal.lan>
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

On Thu, 7 Jul 2022 21:15:58 +0100, Mauro Carvalho Chehab wrote:
> Em Tue, 5 Jul 2022 13:15:57 +0900
> Akira Yokosawa <akiyks@gmail.com> escreveu:
> 
>> Hi Mauro,
>>
[...]

>> So this is a meta-level feedback considering the most likely uses
>> of sphinx-pre-install.
>>
>> I think first-time users of sphinx-pre-install are more likely
>> interested in getting ready for running "make html".  They won't
>> bother with "make pdfdocs". 
> 
> True, but, as you're pointing below, math expressions require LaTeX.
> 
> The idea of using --no-pdf is to setup an environment without LaTeX,
> meaning that math tags would only be partially parsed: basically, the
> output would be html with LaTeX-like math expressions (at least last
> time I tried).

Oh, that is your intention.  :-/

When I saw this help text in "./scripts/sphinx-pre-install --help":

    --no-pdf	- don't check for dependencies required to build PDF docs

for the first time, my expectation was like this:

    If I make "./scripts/sphinx-pre-install --no-pdf" happy, "make htmldocs"
    will complete without any warning on package requirements.

But I got this warning from "make htmldocs" among others:

    WARNING: dvipng command 'dvipng' cannot be run (needed for math display), check the imgmath_dvipng setting

And my reaction to it was something like:

    "What!!!  Why sphinx-pre-install didn't complain?"
    "OK. I'll ignore sphinx-pre-install.  Let's see what I need to install."

The reason why this mismatch has never surfaced as a problem is, I suppose,
because most people don't use --no-pdf at all.

However, in thinking of making --no-pdf the default, I thought --no-pdf
should be more trustworthy.

If your goal is to provide LaTeX-free packages for "make htmldocs",
the option should have been named --no-latex or similar (probably in
addition to --no-pdf), no?

Well, arguing does not help. I stop here.

More constructive approach would be to make "make htmldocs" be
truly latex-free.  Then --no-pdf and --no-latex will be equivalent.

Fortunately, it is possible by using the mathjax extension instead of
imgmath.  With mathjax, rendering of math expressions is delegated to
web browsers.

The resulting HTML will depend on mathjax code and math fonts from
somewhere in the cloud (by default, https://cdnjs.cloudflare.com/ajax/libs/mathjax/...
or https://cdn.jsdelivr.net/npm/mathjax@3/... depending on the Sphinx
version).

All you need is this one-liner:

--------
diff --git a/Documentation/conf.py b/Documentation/conf.py

index 934727e23e0e..fe1084510329 100644

--- a/Documentation/conf.py

+++ b/Documentation/conf.py

@@ -106,7 +106,7 @@ else:

 autosectionlabel_prefix_document = True

 autosectionlabel_maxdepth = 2

 

-extensions.append("sphinx.ext.imgmath")

+extensions.append("sphinx.ext.mathjax")

 

 # Add any paths that contain templates here, relative to this directory.

 templates_path = ['_templates']
--------

In my tests, the mathjax extension works with all the versions of Sphinx
I tested (1.7.9, 2.4.4, 3.4.3 (debian bullseye), 4.2.0 (openSUSE LEAP 15.4),
and 5.0.2).
Note that math expressions should look much sharper (vector fonts)
than those from imgmath (pixel images).
The time for a browser to complete the rendering might be longer than
with imgmath, especially for pages with a lot of math expressions,
though.  (Yes, I see some of media documents have a lot of them.)

When you are detached from network connections, browsers will give
up and show those expressions in mathjax source code.

Mauro, wouldn't this approach work for you?

        Thanks, Akira

PS: Replies to the other topics will be sent separately.
