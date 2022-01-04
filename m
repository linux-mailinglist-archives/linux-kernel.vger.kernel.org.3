Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32626483A6D
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 03:01:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231579AbiADCBQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 21:01:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231278AbiADCA6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 21:00:58 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23055C061761;
        Mon,  3 Jan 2022 18:00:58 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id r16-20020a17090a0ad000b001b276aa3aabso26082304pje.0;
        Mon, 03 Jan 2022 18:00:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=zHgCyi01uuP4qo6TGXeku6sGAM7fudZBzRV41HxMXiY=;
        b=m3Eci0lvT+i/Rbhep+lusaotdS6X+uiXclSfEVKysn7+m++q+Btce6+By4fX1dYmdH
         G/nHFxVaoMpnXBMdM8+lCFdTYBNbletuBBzWI9HHRIT/f4d89qt/5Fi13fQ703K7yi4G
         h8dE01mQelnr+AoZQBhTVDs+BhoT6fBqyVqZz4E44o7VC7Ps3x9V/+xroUnvHje2asWW
         oJyOsd7sNQQmG8qVoB4FdHfX6pDUdHpCDKbaLtbLA1LGkUMPgok6ALBSMu0EmXyXj2IO
         R3/3fcLCBcN5sI/WrUmwud3a+cmFnavcpefv8I13J+3n83CkitWBLiSR8jKvWelav7nb
         Q2VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zHgCyi01uuP4qo6TGXeku6sGAM7fudZBzRV41HxMXiY=;
        b=bWjkBDpejFTNy4ZwjMzIzmGuwkAsmG9eR9+AGGKNjtqYASVyYCGLfi3OTEmV32Sl8y
         GgcfoS0/e9TcT3QM/ZF+ruRaZX87aJRofmckpreCyXyyvhO1c9rIYpSCNu7wDZYsJSnT
         5RCCDYycVPU4Ajn3fvdA5FJh7FSpEvlMmHafJCPTdJPu95gO4I/dbI8uF62dlpmDWjj/
         +GkslJviDB/nX+3qCYxJQ3twCFhXzrWzVEaAzMvXw317Pv2uHp3pgkQib8qM2CvVrkMB
         ysGzKHVb+1Cy2a4lFC5qev8/euopvkKRYn2IKuwMBlDYc1T4I7WkTKbSRe7/ZjIamkI0
         9zmA==
X-Gm-Message-State: AOAM5305AnQ6I4lir17vG5I/TjgTpUDBErRFvyZZgUASLcYIFKgswael
        H+VuM/axztamYHR9D2EQwoIndHASurQ=
X-Google-Smtp-Source: ABdhPJwOdKcEbkwpO5RozxQJ4FCtQkMWNCfmd9dI2Vu7CDOm2WitcG69ZcJ+s+s6OXS2yJAkzCnwbQ==
X-Received: by 2002:a17:90b:1e08:: with SMTP id pg8mr58652808pjb.53.1641261657688;
        Mon, 03 Jan 2022 18:00:57 -0800 (PST)
Received: from [192.168.11.5] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id m9sm25510648pjk.51.2022.01.03.18.00.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Jan 2022 18:00:57 -0800 (PST)
Subject: Re: [PATCH 1/1] scripts: sphinx-pre-install: add required ctex
 dependency
From:   Akira Yokosawa <akiyks@gmail.com>
To:     corbet@lwn.net, mchehab@kernel.org
Cc:     hch@lst.de, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <87mtkcxws9.fsf@meer.lwn.net>
 <eeb773ef-0354-be1f-8438-07e3324fa9f6@gmail.com>
Message-ID: <3616ea08-5695-67fd-d0a2-556bb133ff4d@gmail.com>
Date:   Tue, 4 Jan 2022 11:00:53 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <eeb773ef-0354-be1f-8438-07e3324fa9f6@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 Jan 2022 09:04:30 +0900, Akira Yokosawa wrote:
> Hi,
> 
> On Mon, 03 Jan 2022 15:46:30 -0700, Jonathan Corbet <corbet@lwn.net> wrote:
>> Mauro Carvalho Chehab <mchehab@kernel.org> writes:
>>
>>> After a change meant to fix support for oriental characters
>>> (Chinese, Japanese, Korean), ctex stylesheet is now a requirement
>>> for PDF output.
> 
> FWIW, ctexhook.sty is a new requirement of xeCJK.sty v3.8.7 released
> in June 2021.

This is not the case.  ctexhook.sty is required since xeCJK.sty v3.8.3
released in May 2020.

Sorry for the noise.

        Thanks, Akira

> 
>         Thanks, Akira
> 
>>>
>>> Reported-by: Christoph Hellwig <hch@lst.de>
>>> Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
>>> ---
>>>
>>> See [PATCH 0/1] at: https://lore.kernel.org/all/cover.1641243581.git.mchehab@kernel.org/
>>>
>>>  scripts/sphinx-pre-install | 1 +
>>>  1 file changed, 1 insertion(+)
>>>
>>> diff --git a/scripts/sphinx-pre-install b/scripts/sphinx-pre-install
>>> index 288e86a9d1e5..46aaab414098 100755
>>> --- a/scripts/sphinx-pre-install
>>> +++ b/scripts/sphinx-pre-install
>>> @@ -78,6 +78,7 @@ my %texlive = (
>>>  	'ucs.sty'            => 'texlive-ucs',
>>>  	'upquote.sty'        => 'texlive-upquote',
>>>  	'wrapfig.sty'        => 'texlive-wrapfig',
>>> +	'ctexhook.sty'       => 'texlive-ctex',
>>>  );
>>
>> I've applied this, thanks.> 
>> jon
> 
> 
