Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF18E485BF6
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 23:57:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245248AbiAEW5l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 17:57:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245203AbiAEW52 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 17:57:28 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DE55C061245;
        Wed,  5 Jan 2022 14:57:28 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id c2so659122pfc.1;
        Wed, 05 Jan 2022 14:57:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=DlCMujE1/OmNnvwwZTqguq1pdTbjjaD9QBsoFGAZY5o=;
        b=Hod97O7eHY5pJOJOH1z0I335xtcE3oGtGAqR59E0P0HcffpgVcr2pyWgwcR0D7lWzB
         pUBOAkJNBw8TlfxhtNkA5EYUxUIN4dBMy52tTrBztsRmh9SEiJCj8rNtKVv49MPtwTKO
         MuiVzoNhLVf9a6XDXvArPYrzvBIfviYT/GlCG27dDu11eJu4cwRTXB2vnP8KYPkgF/vD
         wF1dGygeIYHwFaGgBGaqtK9bxnfaMKRD9zKQ6u8Mq2Fjug+fN49oxyT+KYdjJfFR8iis
         xR2x0KbYmFxEq3Ejrz8se1V2DXmGEWApikbikZho4MLPgqto1Sh7qu2NgOqoD8rx3TTW
         Pv2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DlCMujE1/OmNnvwwZTqguq1pdTbjjaD9QBsoFGAZY5o=;
        b=Sd/FOFjpqYJiOw2q+J8iJFinJg9ndUnKQAV8SFT5JFl13oYRyUbDTd8QaPzk0bo5dx
         ocdiP7ZCYRdtqH7HHdd9PO8pTxMwvu+wxwUUfOM/wfwQmHCWlRUmLmo9DyhjUcWH9im6
         DAOwRbsgR1YLFS+ySqe8XYf79sVi70cv8CVKRnSfkTo3Z7EYzNSRNtn/x3+zovLVIS9Q
         esyPDBfz7+WicwnVlhlqdivn1FPUTIGoTPaGtGZIqRwUE1EUO43bx411W/s+YfZ9w3p4
         T/cu1v5bFiSYIVTuhbVKWGk2lemslqbUNQIfXnm5yQe9E738euUCOXbMnKQKwjSzvatO
         zGfA==
X-Gm-Message-State: AOAM530BOK0aEL+GdQLHTV+9yikfVfYVdiWbG7dGidqwyhYTc85/c7pZ
        7w7hgoacsV75hKU+/kiMG/79wzuRsBk=
X-Google-Smtp-Source: ABdhPJwPgbApNZNhCp7Y2clmVhB/DVQ5vm7YxX5Jqp6RXmiRXEUZ9J9pJzcDY18nZbYi6aSsnE1dhQ==
X-Received: by 2002:a63:9049:: with SMTP id a70mr50526530pge.625.1641423447988;
        Wed, 05 Jan 2022 14:57:27 -0800 (PST)
Received: from [192.168.11.5] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id t8sm140372pfj.114.2022.01.05.14.57.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Jan 2022 14:57:27 -0800 (PST)
Subject: Re: [PATCH 1/1] scripts: sphinx-pre-install: add required ctex
 dependency
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     hch@lst.de, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, corbet@lwn.net
References: <87mtkcxws9.fsf@meer.lwn.net>
 <eeb773ef-0354-be1f-8438-07e3324fa9f6@gmail.com>
 <07f8cf68-525b-4fca-a1f9-fd40150fc6e1@gmail.com>
 <20220104090548.76112534@coco.lan>
 <73e62b16-7685-ace2-18d4-e1b79f543caf@gmail.com>
 <20220105084809.157e3f34@coco.lan>
 <241d31e4-5447-a075-69b6-11c14427582d@gmail.com>
 <20220105224230.0700351f@coco.lan>
From:   Akira Yokosawa <akiyks@gmail.com>
Message-ID: <84f90b41-7a18-d83c-8739-1d394175f74a@gmail.com>
Date:   Thu, 6 Jan 2022 07:57:22 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20220105224230.0700351f@coco.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Jan 2022 22:42:30 +0100, Mauro Carvalho Chehab wrote:
> Em Wed, 5 Jan 2022 21:09:59 +0900
> Akira Yokosawa <akiyks@gmail.com> escreveu:
> 
[...]
>>
>> I'll test it under various distros/setups.
>> It may take a while.
> 
> Did a quick test here with this lxc container:
> 
> 	$ OS=debian REL=bullseye ;lxc-create -n ${OS} -t /usr/share/lxc/templates/lxc-download -- --dist ${OS} --release ${REL} --arch amd64
> 
> If we add check_missing_tex(), it will then complain about lots
> of packages that don't exist in Debian (se logs at the end).

Now I think I understand what kind of tests we need.

My plan was to intentionally uninstall texlive-ctex (or whichever
package contains ctexhook.sty) and see if the lack of ctexhook.sty
is detected or not.

Apparently, such a test would mean little for sphinx_pre_install.

> 
> That's one of the biggest issue with texlive: each distro splits it on
> different ways. So, basically, the %texlive hash at the script is meant
> to the way Fedora and openSuse distros usually map packages. I would
> expect that Mageia would also be similar if not identical, but other
> distros map packages on different ways.
> 
> I'll prepare another patch for fixing the debian issue.

Then I'll wait for it.

        Thanks, Akira

> 
> Regards,
> Mauro
> 
> ---
> 
> mchehab@debian:~/docs$ make pdfdocs
> Documentation/Makefile:41: The 'sphinx-build' command was not found. Make sure you have Sphinx installed and in PATH, or set the SPHINXBUILD make variable to point to the full path of the 'sphinx-build' executable.
> 
> Detected OS: Debian GNU/Linux 11.
> Warning: better to also install "convert".
> Warning: better to also install "dot".
> Warning: better to also install "dvipng".
> Warning: better to also install "fonts-dejavu".
> Warning: better to also install "fonts-noto-cjk".
> ERROR: please install "gcc", otherwise, build won't work.
> Warning: better to also install "latexmk".
> ERROR: please install "python", otherwise, build won't work.
> Warning: better to also install "rsvg-convert".
> Warning: better to also install "texlive-amscls".
> Warning: better to also install "texlive-amsfonts".
> Warning: better to also install "texlive-amsmath".
> Warning: better to also install "texlive-anyfontsize".
> Warning: better to also install "texlive-capt-of".
> Warning: better to also install "texlive-cmap".
> Warning: better to also install "texlive-ctex".
[...]

