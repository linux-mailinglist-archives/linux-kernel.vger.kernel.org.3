Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DE7E485E61
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 03:00:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344567AbiAFCAR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 21:00:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344555AbiAFCAO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 21:00:14 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB18DC061245;
        Wed,  5 Jan 2022 18:00:13 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id q14so1455093plx.4;
        Wed, 05 Jan 2022 18:00:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=4XiU3DBBBdtI9LoTZW+DPMRG7ojDY/j0JWWI8IOcxhQ=;
        b=f0eCT5qfLiKgZKOvPMSYCy4gzpv5BZ98sYIBmXjgj8ZHREigT3U3Ow7qKUyEv3TmGg
         a9yE40II91EBnjbyu09EVYPwvP0wXyJqiD4h2k7ax1JQbAPbIpssshnMg10junWoLsss
         S0Be9DnShE2aC8T2hzsUuMzq9LbfuKIxBB+kiV3RuPd0vjGier4DGo9gBf1OkvLPblwd
         2nx4IptkRwExqY3BJRyLYASjJ33KBELu3irdQa8Dha+ANwd0Pl4RUZ5hADAxTannb/1e
         XWh5Dm0WFJSKhmFlrjO+6aYenbtkNrU8NtZGEQCQgDx5v1U+dTMkqnfzs/e1tHpElsRt
         bgCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4XiU3DBBBdtI9LoTZW+DPMRG7ojDY/j0JWWI8IOcxhQ=;
        b=hfkFMGC7RbRsLBrVNL/3c3J9ScznFoCWbQLL/FRiWf37wGYJdQ/cT8UavD84T8XkLv
         zFi/p0dFG2KWgDO9wbClhD2YAwRUfzwbQVqM5V2Y+1vNjmWa8NJCOgtIo7v52AwG/2lL
         QjG9MeV32XW+b+pV0RMHoawqViLdxYL07Cy8ty+lSQWnC1EiRyh0z95qEWQjT7whF6ae
         N4ExGSt/Pxgdd3qWkDFWQn97rQO9Norr0dV3vFuiwyqYbTtBAwiCdW+aqJ7un2CpFWGi
         LTHnfrinjoBLVKAuBwR3LsPJm1gerojvwl9zhzkMw67bSYB6CUQKHZU+wq9rej+zJ1xS
         v00A==
X-Gm-Message-State: AOAM530tcSXh6F6Gij6leSrIpunoVmsCQrDKIKxhtX/u+S0cvS7Xo7Ok
        DolIMQbrFvE3dZQamtdgKg4=
X-Google-Smtp-Source: ABdhPJwMnXcUWGTDjYob15XFZ8DowbM6D/nkeb20M3ljhhRkYX6k7GZHkhOK89tMfn9RACIsrOC1+Q==
X-Received: by 2002:a17:90a:d510:: with SMTP id t16mr7492468pju.84.1641434413375;
        Wed, 05 Jan 2022 18:00:13 -0800 (PST)
Received: from [192.168.11.5] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id v10sm834263pjs.8.2022.01.05.18.00.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Jan 2022 18:00:13 -0800 (PST)
Subject: Re: [PATCH v2] scripts: sphinx-pre-install: Fix ctex support on
 Debian
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Akira Yokosawa <akiyks@gmail.com>
References: <84f90b41-7a18-d83c-8739-1d394175f74a@gmail.com>
 <63882425609a2820fac78f5e94620abeb7ed5f6f.1641429634.git.mchehab@kernel.org>
From:   Akira Yokosawa <akiyks@gmail.com>
Message-ID: <15aa5e03-8aac-af55-badc-b905ca91f281@gmail.com>
Date:   Thu, 6 Jan 2022 11:00:08 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <63882425609a2820fac78f5e94620abeb7ed5f6f.1641429634.git.mchehab@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  6 Jan 2022 01:41:02 +0100, Mauro Carvalho Chehab wrote:
> The name of the package with ctexhook.sty is different on
> Debian/Ubuntu.
> 
> Reported-by: Akira Yokosawa <akiyks@gmail.com>
> Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>

Tested-by: Akira Yokosawa <akiyks@gmail.com>

> ---
>  scripts/sphinx-pre-install | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/scripts/sphinx-pre-install b/scripts/sphinx-pre-install
> index 46aaab414098..f126ecbb0494 100755
> --- a/scripts/sphinx-pre-install
> +++ b/scripts/sphinx-pre-install
> @@ -370,6 +370,9 @@ sub give_debian_hints()
>  	);
>  
>  	if ($pdf) {
> +		check_missing_file(["/usr/share/texlive/texmf-dist/tex/latex/ctex/ctexhook.sty"],
> +				   "texlive-lang-chinese", 2);
> +
>  		check_missing_file(["/usr/share/fonts/truetype/dejavu/DejaVuSans.ttf"],
>  				   "fonts-dejavu", 2);
>  
> -- 
> 2.33.1

So are you planing to add similar checks incrementally for the
other distros ?

There are two things I'd like to mention.

First, on Debian buster, Ubuntu Bionic, and Ubuntu Focal,
xeCJK.sty are younger then v3.8.3 and ctexhook.sty is not necessary.
As texlive-lang-chinese is a fairly large package, it would be better
not to require the unnecessary package.

The new dependency can be checked by:

    $ grep ctex `kpsewhich xeCJK.sty`

If there is no hit, no need of ctexhook.sty.

It would be nice if the check can be made conditional.
But it would not be possible to check before you have xeCJK.sty
on your system.

Hmm??

Second, on CentOS stream8, texlive-ctex is not available.
Following is the error from "dnf install":

    $ sudo dnf install texlive-ctex
    Last metadata expiration check: 0:00:35 ago on Thu Jan  6 01:43:50 2022.
    No match for argument: texlive-ctex
    Error: Unable to find a match: texlive-ctex

xeCJK.sty there is also younger then v3.8.3.

So again, if the check of ctexhook.sty could be made conditional,
we would be able to list CentOS stream8 (or RHEL 8) as capable
of "make pdfdocs".

Longer term (for CentOS stream9 or RHEL 9), we might need to ask
EPEL maintainers to add texlive-ctex.

Thoughts?

List of xeCJK.sty version:

    Debian buster   v3.7.1
    Ubuntu Bionic   v3.6.1
    Ubuntu Focal    v3.8.1
    CentOS stream8  v3.5.0

        Thanks, Akira
