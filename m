Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10401483FDE
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 11:26:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231319AbiADK0Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 05:26:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbiADK0P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 05:26:15 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A2FEC061761;
        Tue,  4 Jan 2022 02:26:15 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id f5so2990452pgk.12;
        Tue, 04 Jan 2022 02:26:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=dgw8eDYqou5ZCuUdcSytV47CYd/9SnsR4ZS8RG4Ba6k=;
        b=ArMaYkhasIdI5TSdGpezs6x8xFRZP6Rwxnp2+tSzzepO6hodRbHSvtoHVBc9ydkQld
         cSVgJNHiRsL5msZHH4BXvVL8wd9XEP3UWLG2YvZHoBiF/+d3vFxr7loQweHarIj3ZKbz
         LaxbwRrKycVGZHJx2ps8s/9ucYdlHWnK21/4ZB2omUM4sBXn9oivDbuvEbZA+j7XJAn/
         NHDz4sKxVeWSJ8FHWos/NRuW8Q4CF1tKezDBwNdXgqnKOC9WbVPMj8x2qGJVCRRESNLP
         orw2KeI3awVQyItQ1EoPQnEwsZOfgV3E8C8mvo6ebIIZqCm3xQAjIYQJMFFiGviS5DRF
         2egw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dgw8eDYqou5ZCuUdcSytV47CYd/9SnsR4ZS8RG4Ba6k=;
        b=PRWAQiEMELhEwnjx2R/ULBOKcFXMktoU8Xhwjoz4s8pysj6WTrd8HotN12S9i+34MI
         xsrK97Njs+t3Q6FDMUbIQxlJIkRRh9Pcg4ZmvnoC0ICctixda0l6g1xxGqBzTlvfk4RR
         Rf+WPOvwJtH9F1aSrjcnVldRfxtaQCAxlekpyN9aVrPF2V2QWU5gRrnnPCvhbrZ2yPWP
         vn7+nQC5wO+o73lQhN1bA6MV5x4X9ykYxRtTOKy7BXyklaUPfLNs80brCr0fFA0Qpjt1
         Mb17jizESWttaX0Y3w0vEEYfBOdjYPKvqJLq8TqJCkArkWyAaTEulKqD3sIBUPGfiQHC
         sSSQ==
X-Gm-Message-State: AOAM531FjC2CbxZFSjrkDvqmSV7nsEqMFb8BQCzyfPHBoUfKq1LD3PTF
        By2KJsI6WFq97kg9sDMbIs8=
X-Google-Smtp-Source: ABdhPJyUlXC6ovBdJpX4bBP2exJQpw/OKVYkqGMummXWOg6CG3Et4yc2FSpJIwgo68uH8bC5mzkYGQ==
X-Received: by 2002:a63:8648:: with SMTP id x69mr42903540pgd.9.1641291974741;
        Tue, 04 Jan 2022 02:26:14 -0800 (PST)
Received: from [192.168.11.5] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id s8sm39932056pfe.196.2022.01.04.02.26.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Jan 2022 02:26:14 -0800 (PST)
Subject: Re: [PATCH 1/1] scripts: sphinx-pre-install: add required ctex
 dependency
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     hch@lst.de, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, corbet@lwn.net
References: <87mtkcxws9.fsf@meer.lwn.net>
 <eeb773ef-0354-be1f-8438-07e3324fa9f6@gmail.com>
 <07f8cf68-525b-4fca-a1f9-fd40150fc6e1@gmail.com>
 <20220104090548.76112534@coco.lan>
From:   Akira Yokosawa <akiyks@gmail.com>
Message-ID: <73e62b16-7685-ace2-18d4-e1b79f543caf@gmail.com>
Date:   Tue, 4 Jan 2022 19:26:10 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20220104090548.76112534@coco.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 Jan 2022 09:05:48 +0100, Mauro Carvalho Chehab wrote:
> Em Tue, 4 Jan 2022 10:54:52 +0900
> Akira Yokosawa <akiyks@gmail.com> escreveu:
> 
>> Hi Mauro, see inline comments below.
>>
>> On Tue, 4 Jan 2022 09:04:30 +0900, Akira Yokosawa wrote:
>>> Hi,
>>>
>>> On Mon, 03 Jan 2022 15:46:30 -0700, Jonathan Corbet <corbet@lwn.net> wrote:  
>>>> Mauro Carvalho Chehab <mchehab@kernel.org> writes:
>>>>  
>>>>> After a change meant to fix support for oriental characters
>>>>> (Chinese, Japanese, Korean), ctex stylesheet is now a requirement
>>>>> for PDF output.  
>>>
>>> FWIW, ctexhook.sty is a new requirement of xeCJK.sty v3.8.7 released
>>> in June 2021.
>>>
>>>         Thanks, Akira
>>>   
>>>>>
>>>>> Reported-by: Christoph Hellwig <hch@lst.de>
>>>>> Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
>>>>> ---
>>>>>
>>>>> See [PATCH 0/1] at: https://lore.kernel.org/all/cover.1641243581.git.mchehab@kernel.org/
>>>>>
>>>>>  scripts/sphinx-pre-install | 1 +
>>>>>  1 file changed, 1 insertion(+)
>>>>>
>>>>> diff --git a/scripts/sphinx-pre-install b/scripts/sphinx-pre-install
>>>>> index 288e86a9d1e5..46aaab414098 100755
>>>>> --- a/scripts/sphinx-pre-install
>>>>> +++ b/scripts/sphinx-pre-install
>>>>> @@ -78,6 +78,7 @@ my %texlive = (
>>>>>  	'ucs.sty'            => 'texlive-ucs',
>>>>>  	'upquote.sty'        => 'texlive-upquote',
>>>>>  	'wrapfig.sty'        => 'texlive-wrapfig',
>>>>> +	'ctexhook.sty'       => 'texlive-ctex',
>>>>>  );  
>>>>  
>>
>> I'm afraid this update of the list for Fedora/openSUSE won't help
>> Debian Stable (bullseye) users.
>>
>> ctexhook.sty is in texlive-lang-chinese on Debian/Ubuntu.
> 
> On such case, it is needed to map it for Debian/Ubuntu.
> Could you please test the enclosed patch, applied on the top
> of the previous one?

Looks like we need an additional hunk.  See below.

        Thanks, Akira

> 
> Thanks!
> Mauro
> 
> -
> 
> [PATCH] scripts: sphinx-pre-install: Fix ctex support on Debian
> 
> The name of the package with ctexhook.sty is different on
> Debian/Ubuntu.
> 
> Reported-by: Akira Yokosawa <akiyks@gmail.com>
> Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
> 
> diff --git a/scripts/sphinx-pre-install b/scripts/sphinx-pre-install
> index 46aaab414098..ea96d18ee946 100755
> --- a/scripts/sphinx-pre-install
> +++ b/scripts/sphinx-pre-install
> @@ -367,6 +367,7 @@ sub give_debian_hints()
>  		"Pod::Usage"		=> "perl-modules",
>  		"xelatex"		=> "texlive-xetex",
>  		"rsvg-convert"		=> "librsvg2-bin",
> +		"texlive-ctex"		=> "texlive-lang-chinese",
>  	);
>  
>  	if ($pdf) {
> 
@@ -380,6 +381,7 @@ sub give_debian_hints()
        }
 
        check_program("dvipng", 2) if ($pdf);
+       check_missing_tex(2) if ($pdf);
        check_missing(\%map);
 
        return if (!$need && !$optional);

