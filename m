Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7182E485245
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 13:10:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239940AbiAEMKH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 07:10:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235413AbiAEMKD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 07:10:03 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6CB7C061761;
        Wed,  5 Jan 2022 04:10:03 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id n16so29208634plc.2;
        Wed, 05 Jan 2022 04:10:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=sAj671otIWFV/u2RNPxxpcN+b27OaCYf0DUMoxLWnZo=;
        b=EpQDfqILS1350ToC4C6Y6JUKdAWBP18SdTZPsxBbL2jtskPRj06Mv8RVWF4rG1RbqF
         V6b1Ol/6BOkgOVoUwzUX3lVD6bwWnWE2hVkbfa8hLbusKeSL7XuSa9KC4ptcw8Dv7r1H
         jWCPIbP8C32VVseERINRow0caXToXbuw+PcmPE9pkj5g9U1XMo2804tpNvrUkL07jwuq
         SVGaaVuE9IwGWEKGaaN+vsD7QQd9EA817RXdFybgbsIbSB7V0HjVhQH+AgOS6fAmv4hA
         tUH16b9BVm5Gn+N6UJkx3GuFMovyoe1x3P8rIxQ6ZCmnmBz4AxKbDo3N87o77K4rY7Is
         mBuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=sAj671otIWFV/u2RNPxxpcN+b27OaCYf0DUMoxLWnZo=;
        b=gW7QvohwQleF7jShkztyNez0IPDnCG1cEjjb48ruuny35Hbq20GmdTtQY3j6uPBMjz
         /V+YV8fj7MyurBYs1VuxizbYjdl33eMzR6bZ8M2Y3pRwQ5sx2sV6dvN5Sn2XjwfYy19w
         wep9T/SXnwT+Xf2k+30SFMJRsAI5EHaCzKxJT+HSIE4wRth7HS33LjtW+1d/56u1DpbN
         T/BGxzLEOF4+mBCdCtOFf5DTbJCZH5OjODneeHTeT5iYTG3R7wIXEkdEs85x/90kHWwp
         iT/Vzs6YPaxhbyraFFWytHDfRLfoF2BnMwLXqlHFyfwpkdVvvy6bIUS3qysU8cScQ3CN
         ELbA==
X-Gm-Message-State: AOAM531bpllLgvY89zZ+DxfSaQWqxxt98kDH5oERSs91iEMVnOsKaYP/
        h62q9DeWGcqVNzZus6lPsCg=
X-Google-Smtp-Source: ABdhPJxWdw1PjvM0Jc5luZAegv6c5JON4C42KHMxd6aMoiUv7Xkic7cS0zNz/3F7iSQbJeYUGkSY5g==
X-Received: by 2002:a17:902:d650:b0:149:c6b7:c02d with SMTP id y16-20020a170902d65000b00149c6b7c02dmr5789094plh.30.1641384602570;
        Wed, 05 Jan 2022 04:10:02 -0800 (PST)
Received: from [192.168.11.5] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id ot6sm2878908pjb.32.2022.01.05.04.10.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Jan 2022 04:10:02 -0800 (PST)
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
From:   Akira Yokosawa <akiyks@gmail.com>
Message-ID: <241d31e4-5447-a075-69b6-11c14427582d@gmail.com>
Date:   Wed, 5 Jan 2022 21:09:59 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20220105084809.157e3f34@coco.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Jan 2022 08:48:09 +0100, Mauro Carvalho Chehab wrote:
> Em Tue, 4 Jan 2022 19:26:10 +0900
> Akira Yokosawa <akiyks@gmail.com> escreveu:
> 
>> On Tue, 4 Jan 2022 09:05:48 +0100, Mauro Carvalho Chehab wrote:
>>> Em Tue, 4 Jan 2022 10:54:52 +0900
>>> Akira Yokosawa <akiyks@gmail.com> escreveu:
>>>   
>>>> Hi Mauro, see inline comments below.
>>>>
>>>> On Tue, 4 Jan 2022 09:04:30 +0900, Akira Yokosawa wrote:  
>>>>> Hi,
>>>>>
>>>>> On Mon, 03 Jan 2022 15:46:30 -0700, Jonathan Corbet <corbet@lwn.net> wrote:    
>>>>>> Mauro Carvalho Chehab <mchehab@kernel.org> writes:
>>>>>>    
>>>>>>> After a change meant to fix support for oriental characters
>>>>>>> (Chinese, Japanese, Korean), ctex stylesheet is now a requirement
>>>>>>> for PDF output.    
>>>>>
>>>>> FWIW, ctexhook.sty is a new requirement of xeCJK.sty v3.8.7 released
>>>>> in June 2021.
>>>>>
>>>>>         Thanks, Akira
>>>>>     
>>>>>>>
>>>>>>> Reported-by: Christoph Hellwig <hch@lst.de>
>>>>>>> Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
>>>>>>> ---
>>>>>>>
>>>>>>> See [PATCH 0/1] at: https://lore.kernel.org/all/cover.1641243581.git.mchehab@kernel.org/
>>>>>>>
>>>>>>>  scripts/sphinx-pre-install | 1 +
>>>>>>>  1 file changed, 1 insertion(+)
>>>>>>>
>>>>>>> diff --git a/scripts/sphinx-pre-install b/scripts/sphinx-pre-install
>>>>>>> index 288e86a9d1e5..46aaab414098 100755
>>>>>>> --- a/scripts/sphinx-pre-install
>>>>>>> +++ b/scripts/sphinx-pre-install
>>>>>>> @@ -78,6 +78,7 @@ my %texlive = (
>>>>>>>  	'ucs.sty'            => 'texlive-ucs',
>>>>>>>  	'upquote.sty'        => 'texlive-upquote',
>>>>>>>  	'wrapfig.sty'        => 'texlive-wrapfig',
>>>>>>> +	'ctexhook.sty'       => 'texlive-ctex',
>>>>>>>  );    
>>>>>>    
>>>>
>>>> I'm afraid this update of the list for Fedora/openSUSE won't help
>>>> Debian Stable (bullseye) users.
>>>>
>>>> ctexhook.sty is in texlive-lang-chinese on Debian/Ubuntu.  
>>>
>>> On such case, it is needed to map it for Debian/Ubuntu.
>>> Could you please test the enclosed patch, applied on the top
>>> of the previous one?  
>>
>> Looks like we need an additional hunk.  See below.
>>
>>         Thanks, Akira
>>
>>>
>>> Thanks!
>>> Mauro
>>>
>>> -
>>>
>>> [PATCH] scripts: sphinx-pre-install: Fix ctex support on Debian
>>>
>>> The name of the package with ctexhook.sty is different on
>>> Debian/Ubuntu.
>>>
>>> Reported-by: Akira Yokosawa <akiyks@gmail.com>
>>> Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
>>>
>>> diff --git a/scripts/sphinx-pre-install b/scripts/sphinx-pre-install
>>> index 46aaab414098..ea96d18ee946 100755
>>> --- a/scripts/sphinx-pre-install
>>> +++ b/scripts/sphinx-pre-install
>>> @@ -367,6 +367,7 @@ sub give_debian_hints()
>>>  		"Pod::Usage"		=> "perl-modules",
>>>  		"xelatex"		=> "texlive-xetex",
>>>  		"rsvg-convert"		=> "librsvg2-bin",
>>> +		"texlive-ctex"		=> "texlive-lang-chinese",
>>>  	);
>>>  
>>>  	if ($pdf) {
>>>   
>> @@ -380,6 +381,7 @@ sub give_debian_hints()
>>         }
>>  
>>         check_program("dvipng", 2) if ($pdf);
>> +       check_missing_tex(2) if ($pdf);
>>         check_missing(\%map);
>>  
>>         return if (!$need && !$optional);
>>
> 
> This would be more complex than that, and per-distro tests are
> required, in order to avoid the script to fail on other
> distros.

Thank you for looking into this!
I must admit I'm far from grasping how this perl script works...

> 
> Something like the following (possibly incomplete) patch.

I'll test it under various distros/setups.
It may take a while.

        Thanks, Akira

> 
> Thanks,
> Mauro
> 
> [PATCH RFC] scripts: sphinx-pre-install: better handle pdf dependencies
> 
> Not all distro hints check for missing LaTeX dependencies.
> So add a call for it for check_missing_tex() to all distros.
> 
> While here, change the parameters to pass the map hash, as
> distro-specific mapping could be needed.
> 
> Reported-by: Akira Yokosawa <akiyks@gmail.com>
> Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
> 
> diff --git a/scripts/sphinx-pre-install b/scripts/sphinx-pre-install
> index ea96d18ee946..03c252590e54 100755
> --- a/scripts/sphinx-pre-install
> +++ b/scripts/sphinx-pre-install
> @@ -227,7 +227,8 @@ sub check_pacman_missing($$)
>  
>  sub check_missing_tex($)
>  {
> -	my $is_optional = shift;
> +	my $map = %{$_[0]};
> +	my $is_optional = 2;
>  	my $kpsewhich = findprog("kpsewhich");
>  
>  	foreach my $prog(keys %texlive) {
> @@ -381,6 +382,7 @@ sub give_debian_hints()
>  	}
>  
>  	check_program("dvipng", 2) if ($pdf);
> +	check_missing_tex(\%map) if ($pdf);
>  	check_missing(\%map);
>  
>  	return if (!$need && !$optional);
> @@ -449,7 +451,7 @@ sub give_redhat_hints()
>  
>  	check_rpm_missing(\@fedora26_opt_pkgs, 2) if ($pdf && !$old);
>  	check_rpm_missing(\@fedora_tex_pkgs, 2) if ($pdf);
> -	check_missing_tex(2) if ($pdf);
> +	check_missing_tex(\%map) if ($pdf);
>  	check_missing(\%map);
>  
>  	return if (!$need && !$optional);
> @@ -503,7 +505,7 @@ sub give_opensuse_hints()
>  	# "Noto Sans CJK SC" on openSUSE
>  
>  	check_rpm_missing(\@suse_tex_pkgs, 2) if ($pdf);
> -	check_missing_tex(2) if ($pdf);
> +	check_missing_tex(\%map) if ($pdf);
>  	check_missing(\%map);
>  
>  	return if (!$need && !$optional);
> @@ -548,6 +550,7 @@ sub give_mageia_hints()
>  	}
>  
>  	check_rpm_missing(\@tex_pkgs, 2) if ($pdf);
> +	# check_missing_tex(\%map) if ($pdf);
>  	check_missing(\%map);
>  
>  	return if (!$need && !$optional);
> @@ -578,6 +581,7 @@ sub give_arch_linux_hints()
>  				   "noto-fonts-cjk", 2);
>  	}
>  
> +	check_missing_tex(\%map) if ($pdf);
>  	check_missing(\%map);
>  
>  	return if (!$need && !$optional);
> @@ -604,6 +608,8 @@ sub give_gentoo_hints()
>  				   "media-fonts/noto-cjk", 2);
>  	}
>  
> +	# Gentoo doesn't need to map tex, as there's a single package,
> +	# and extra fonts are mapped via check_missing_file()
>  	check_missing(\%map);
>  
>  	return if (!$need && !$optional);
> @@ -622,7 +628,7 @@ sub give_gentoo_hints()
>  		printf("\tsudo su -c 'echo \"$cairo\" > $portage_cairo'\n");
>  	}
>  
> -	printf("\tsudo emerge --ask $install\n");
> +	printf("\tsudo USE="-cjk" emerge --ask $install\n");
>  
>  }
>  
> @@ -685,7 +691,7 @@ sub check_distros()
>  	my %map = (
>  		"sphinx-build" => "sphinx"
>  	);
> -	check_missing_tex(2) if ($pdf);
> +	check_missing_tex(\%map) if ($pdf);
>  	check_missing(\%map);
>  	print "I don't know distro $system_release.\n";
>  	print "So, I can't provide you a hint with the install procedure.\n";
> 
