Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49328483A06
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 02:55:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231947AbiADBy5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 20:54:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230190AbiADBy5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 20:54:57 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECEA2C061761;
        Mon,  3 Jan 2022 17:54:56 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id z3so26009920plg.8;
        Mon, 03 Jan 2022 17:54:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=7XOxlnihJNMmhMJC4frwgCphojMquF9H552ZdaXQfI8=;
        b=pOdkZCflzdk4ZQkACnghCc7yu/F022dKUXkJxTqD/LpYg0sudjudimpR8u2Xmoojyn
         nbry6J0Fw8pvawxNu6K6uIjZf1B57ddVupVtLXpPceXaPHB78gLOogEfV2P+k30PDvtp
         0jUEXWBpZ8gY2elprAXWPR5mqG5jTsjRCntrAMU7/pjBmQ/Sk4WVkI8kG3oqfO6WVvWp
         9bukPBN3jk6aijW2HZtzsrS5CWw1E6uTnt3/NaGodJCUpoiuQlkiuT08YbYgFtbQVeJw
         D/O/55r64Rq9R0hj/mb+g9kMNWNmMgCJC6qnkBzj7g3NnnxS761MALyjf9EJDfugtWro
         WlGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7XOxlnihJNMmhMJC4frwgCphojMquF9H552ZdaXQfI8=;
        b=I0gJisusG9K0PxW8HJVQfgUqhHxr5PMwQKV3sj+1nKpwcoqabPX/ysxChKxYzuC+qX
         MKrwF9C7oklEvuZVSamZ4s6T31aeFtuPh3dZCIrKCieygpu/I+xazNtqzLDjt3FSpqCn
         Nehp1gNnQ9grqxzem5MpDzA0zMx9jw+17/kWdbdf5gSPZ0VqeL2rS8hTfL5mWm6mQhM3
         Ncpolz/yj1t3I1jbIfPYolvbDvA9y/lHHPltsWT0KRlSw/dc1Bx2o23Y8jT2YJaDT8Bf
         o5QnG2gn3AaAp6h/ljK+L1Rpc0XXf61ajz07xGA5Qs6nmo/tK2ngMsbHcIsTEzLRIOed
         mvlQ==
X-Gm-Message-State: AOAM532EZJACzk0SkxCNHtq53SQjDkCYT0dr5et8wLUIIfuJ9iupzQ6O
        f4GJPB8z8eKuzCiLvyMoqdA=
X-Google-Smtp-Source: ABdhPJxWaf35M1NOsyJrhLT3k18/0Kk7ZQ+kKdN9KgbmZvFxlzzAA27cJOaY8cTUvm9eAecF/1uJfg==
X-Received: by 2002:a17:90b:4a41:: with SMTP id lb1mr57603700pjb.61.1641261296571;
        Mon, 03 Jan 2022 17:54:56 -0800 (PST)
Received: from [192.168.11.5] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id z2sm32735121pge.86.2022.01.03.17.54.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Jan 2022 17:54:56 -0800 (PST)
Subject: Re: [PATCH 1/1] scripts: sphinx-pre-install: add required ctex
 dependency
From:   Akira Yokosawa <akiyks@gmail.com>
To:     mchehab@kernel.org
Cc:     hch@lst.de, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, corbet@lwn.net
References: <87mtkcxws9.fsf@meer.lwn.net>
 <eeb773ef-0354-be1f-8438-07e3324fa9f6@gmail.com>
Message-ID: <07f8cf68-525b-4fca-a1f9-fd40150fc6e1@gmail.com>
Date:   Tue, 4 Jan 2022 10:54:52 +0900
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

Hi Mauro, see inline comments below.

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

I'm afraid this update of the list for Fedora/openSUSE won't help
Debian Stable (bullseye) users.

ctexhook.sty is in texlive-lang-chinese on Debian/Ubuntu.

        Thanks, Akria


>> I've applied this, thanks.> 
>> jon
> 
> 
