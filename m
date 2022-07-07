Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6230D56AAF8
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 20:45:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236219AbiGGSpS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 14:45:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236199AbiGGSpQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 14:45:16 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A37A33E1E;
        Thu,  7 Jul 2022 11:45:15 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 5F3B04E91;
        Thu,  7 Jul 2022 18:45:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 5F3B04E91
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1657219515; bh=J5c8hy79DdtSV1ytf0aM7ul96dmS6b15P+GeZiqhtuQ=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=XarWzkSrfO6MjePvlab2tmpX87v9x+RVQ/TuS9/7cNcKLlMOGLFDI5VkSDy5NMKlg
         FUCKoqiGWQEYswC5CCI/gXlmDmpwE/gfyn44RnCL60IdGnCfJ71rkms9Z2FRiU5AGc
         yhpfcAWXO0X2AT7riMzr1b1wmkAEg6bEWT/1h2RWUxgpKR50p9E5oQ4aIxdYOCgvnr
         gtwsYtB+FgIbGJPZ/sjG+83Jp5d4y2RQQi9MbFNbMwCsmf481JUQW4NDDSR9P1it0h
         eDzhfe0czkB6pdGVUbUexaq1nYT5opt7blfwxr0vX0zpjoHJ3PecMDfUlrEFlrjnHc
         2B/AySzNo+yQQ==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Akira Yokosawa <akiyks@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     ksummit-discuss@lists.linuxfoundation.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        mchehab+huawei@kernel.org, Akira Yokosawa <akiyks@gmail.com>
Subject: Re: [PATCH v2 0/5] Address some issues with sphinx detection
In-Reply-To: <d0e1a08a-b965-ada6-e026-4e1cc38fbd90@gmail.com>
References: <cover.1656756450.git.mchehab@kernel.org>
 <d0e1a08a-b965-ada6-e026-4e1cc38fbd90@gmail.com>
Date:   Thu, 07 Jul 2022 12:45:14 -0600
Message-ID: <87ilo8bw3p.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Akira Yokosawa <akiyks@gmail.com> writes:

> TL;DR, my suggestion of options and defaults to sphinx-pre-install:
>
>     --no-pdf (default): for htmldocs only
>     --no-virtualenv (default): distro Sphinx package
>          (mention --virtualenv if distro Sphinx package is too young)
>     --virtualenv: Sphinx by venv/virtualenv
>     --pdf: for pdfdocs
>         --no-cjk (default): don't bother with CJK pdfdocs
>         --cjk: for CJK pdfdocs
>                (print warning if user's distro doesn't support CJK)
>
> Thoughts?

I think this makes sense.  As far as I can tell, PDF builds are a
relative rarity these days, and most people would rather not have to
deal with virtualenv if they can avoid it.  We should definitely
emphasize native installs whenever that can work.

I'm planning to go ahead and apply Mauro's sphinx-pre-install patches
since they make things better, but then we should look at these tweaks.

Thanks,

jon
