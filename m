Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42DB148395C
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 01:04:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231374AbiADAEh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 19:04:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231310AbiADAEf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 19:04:35 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44A69C061761;
        Mon,  3 Jan 2022 16:04:35 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id t123so30628902pfc.13;
        Mon, 03 Jan 2022 16:04:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:cc:references:subject:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=LfI3AmZKBsaakQUxMJMZxrQzatevP8fdDjHAVNXBEcw=;
        b=UO+OxBZLwdo8sEZXkJoSQHHXFHdzzTtK2600hNgUHDUUg+immGIdHUl6EQTXPGUDIg
         SY/EWZ189HqBlX0LF5GPPV9LmSlRvow+yQXsrTAlhFTZcS1HSX0wPgkLoDQR4MNy6Egx
         k2+N1ASj7q54HkmbwVr01xI/IOoxp/rT+S802bOW3rFmnCgm7gD/98Tj0r5sltj5HGS4
         M++6KGX6RTm8271c0b57QO69G7PEQDAKgTDMcL+a0ueHHEmoBLloZ5Oh6/NITb9ZA6SC
         UfYXqjq7poNvOM8pnV96FQn7JtuS4e+id3mUb46USQQ3jxdb6b5vemqgNrnBYLe9YuSa
         ypgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:to:cc:references:subject:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LfI3AmZKBsaakQUxMJMZxrQzatevP8fdDjHAVNXBEcw=;
        b=rE7GD15cKI2vvNgcl7UYp83FSO3Gt5IyEQYO/OMC/KyszyHviGRKhFFDvDfYInE0RK
         CLgsST5TNU6TKd1ZESNb1eSvnOikZWAp9jpT1JqHq4Qer1q1lAvxQf9uebRUbyxrAV5T
         ukoSet4ARvk6lta+YgKQuCQm11hbXaooZHc6o6qpI1XeyKAkbuNMjpY6YsvgFrViWvBR
         IlPhEFDBm5YfqU73hXKYqYqTz4CbwyQs+Y4+rmX28zXAD8QXGTPb0HCXiE0acnA8pC6Z
         M/tFIeYN9szoAj2sbpBBLMC0pUUBM4lZQ+s3V8zgVcm4rNHnmmXAXPywv93kwj7OOV0h
         cTvA==
X-Gm-Message-State: AOAM531LNowlYLqgRGfV7KnOnYWYDE+b8uHShV4eypzOnTZ1v8f/omXT
        A/NJONGktoAb4s1r20EjtQm8s4R0dTY=
X-Google-Smtp-Source: ABdhPJwdjEZ7s5GS/TDvTueOPszVyYqTxb3u/qx6Kt+dhY+6HUqoZykiYG4U2MjmB20Jz0JxsM4exg==
X-Received: by 2002:a63:154f:: with SMTP id 15mr41891786pgv.521.1641254674814;
        Mon, 03 Jan 2022 16:04:34 -0800 (PST)
Received: from [192.168.11.5] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id s14sm39756399pfk.171.2022.01.03.16.04.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Jan 2022 16:04:34 -0800 (PST)
To:     corbet@lwn.net, mchehab@kernel.org
Cc:     hch@lst.de, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <87mtkcxws9.fsf@meer.lwn.net>
Subject: Re: [PATCH 1/1] scripts: sphinx-pre-install: add required ctex
 dependency
From:   Akira Yokosawa <akiyks@gmail.com>
Message-ID: <eeb773ef-0354-be1f-8438-07e3324fa9f6@gmail.com>
Date:   Tue, 4 Jan 2022 09:04:30 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <87mtkcxws9.fsf@meer.lwn.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 03 Jan 2022 15:46:30 -0700, Jonathan Corbet <corbet@lwn.net> wrote:
> Mauro Carvalho Chehab <mchehab@kernel.org> writes:
> 
>> After a change meant to fix support for oriental characters
>> (Chinese, Japanese, Korean), ctex stylesheet is now a requirement
>> for PDF output.

FWIW, ctexhook.sty is a new requirement of xeCJK.sty v3.8.7 released
in June 2021.

        Thanks, Akira

>>
>> Reported-by: Christoph Hellwig <hch@lst.de>
>> Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
>> ---
>>
>> See [PATCH 0/1] at: https://lore.kernel.org/all/cover.1641243581.git.mchehab@kernel.org/
>>
>>  scripts/sphinx-pre-install | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/scripts/sphinx-pre-install b/scripts/sphinx-pre-install
>> index 288e86a9d1e5..46aaab414098 100755
>> --- a/scripts/sphinx-pre-install
>> +++ b/scripts/sphinx-pre-install
>> @@ -78,6 +78,7 @@ my %texlive = (
>>  	'ucs.sty'            => 'texlive-ucs',
>>  	'upquote.sty'        => 'texlive-upquote',
>>  	'wrapfig.sty'        => 'texlive-wrapfig',
>> +	'ctexhook.sty'       => 'texlive-ctex',
>>  );
> 
> I've applied this, thanks.> 
> jon


