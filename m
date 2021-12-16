Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 388EA47752E
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 16:00:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238184AbhLPPAW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 10:00:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbhLPPAV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 10:00:21 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2768BC061574;
        Thu, 16 Dec 2021 07:00:21 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id q17so19618872plr.11;
        Thu, 16 Dec 2021 07:00:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ustp6AQzzXK1Xub8hDnQV7utN5Or1kU+D4H+rR3hbRw=;
        b=O+ZvsOcQX8lczj1cNd494WXNTqVvG0XBqFJ2RZDyFYsEl+MF6yAUBkcmd3v91Eb6Ub
         zfJ93JZEggFMYJDkeR8zDv6ANbF5rgykMQ5XxPaToOHYaq/vh5fXc2Jm1ljmCCnhpK3A
         D8GQO5x577HkdbR1r0i7wWRFv02Ioj9TxW/N6s9CRiIPgU+xSn8CBfE7bJ5ZfQUmAatw
         ukk+DOnlUlUSrL9fRm8KtNbcJkLftMEwNF9Gj26HUxDbcryAU/0368C+yHUI2opX8gFv
         Yljwkjb7St4aO1K5QP88wS2tlNnySmL9Czi6cA9DK+HP24SXSCBnhS7QxJlbkrXZ3msO
         APEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ustp6AQzzXK1Xub8hDnQV7utN5Or1kU+D4H+rR3hbRw=;
        b=Pb6jS9LewmT2BTvCQWjKGVleTPXHIVWkVRLH0C/YqtePYye/RF8/CvQrOGwlXark2i
         YTfBLsEN8iDPmW/3Lhft/2/VpYP/ScpwuxZW2kb6osvmmsv7vWjx2rxKqICOAZCnEUOq
         O/3XH2gH5fv+HE4sEfJYbj5yiTi5sCCfZgomijf9UlaFP5/qFkiU6yjnIDvS4LCregUY
         rBLuR3OcEOrEEINdxzNyad0VOctT/CyGE2N838DksinjQ5FfBJ6sZJNFjpl4Afptac6J
         mLlm1J6YDYg4hleDNuB1X/AyFnfjHLKhC2fa7YqunEV3li79ngZAuLvx7rtnbmnq8PBK
         C8YA==
X-Gm-Message-State: AOAM532n8QHRmpzPiYnPvdP1VabQp+LeEuDlAMbMFWtmhKMawEQ9Z8Px
        KnNUaJrnn88zwXxn4GRyBs0=
X-Google-Smtp-Source: ABdhPJyQFLD70bHjUEh24ugYKHq8NbiCGsVBm+OBKVKSnMq7FlgJpqpy+eLYJlrOJLbWSHE0HfElFQ==
X-Received: by 2002:a17:902:bcc4:b0:141:bfc4:ada with SMTP id o4-20020a170902bcc400b00141bfc40adamr16407986pls.20.1639666820531;
        Thu, 16 Dec 2021 07:00:20 -0800 (PST)
Received: from [192.168.11.5] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id n20sm5642782pjt.40.2021.12.16.07.00.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Dec 2021 07:00:19 -0800 (PST)
Subject: Re: [PATCH] docs/vm: fix Unexpected indentation warns in page_owner
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     akpm@linux-foundation.org, corbet@lwn.net,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Akira Yokosawa <akiyks@gmail.com>
References: <20211215001929.47866-1-skhan@linuxfoundation.org>
 <e3acf716-edd2-91d5-24c9-02c547f0d168@gmail.com>
 <f41c83f7-95f9-fd70-aa19-60887e7c4039@linuxfoundation.org>
 <ef40c328-78a7-3aeb-0dd5-8ccbd7279e53@linuxfoundation.org>
From:   Akira Yokosawa <akiyks@gmail.com>
Message-ID: <049f7d02-932c-b49c-4af3-10d0f3e8fdb7@gmail.com>
Date:   Fri, 17 Dec 2021 00:00:16 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <ef40c328-78a7-3aeb-0dd5-8ccbd7279e53@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Dec 2021 07:45:50 -0700, Shuah Khan wrote:
> On 12/15/21 8:10 AM, Shuah Khan wrote:
>> On 12/14/21 6:05 PM, Akira Yokosawa wrote:
>>> Hi,
>>>
>>> On Tue, 14 Dec 2021 17:19:29 -0700, Shuah Khan wrote:
>>>> Fix Unexpected indentation warns in page_owner:
>>>>
>>>> Documentation/vm/page_owner.rst:92: WARNING: Unexpected indentation.
>>>> Documentation/vm/page_owner.rst:96: WARNING: Unexpected indentation.
>>>> Documentation/vm/page_owner.rst:107: WARNING: Unexpected indentation.
>>>
>>> I guess these outputs should have been literal blocks.
>>> Then Sphinx wouldn't complain about indentations.
>>
>> Good point. I will take a look and send v2.
>>
> 
> This is already in a literal block. A few of the lines in a literal block
> are missing indentations - this patch is good as is.

Well, to show the context, embedding from current page_owner.rst.
My comment is on the line starting with "#".

-----8<------
4) Analyze information from page owner::

	cat /sys/kernel/debug/page_owner > page_owner_full.txt
	./page_owner_sort page_owner_full.txt sorted_page_owner.txt

   The general output of ``page_owner_full.txt`` is as follows:
#  ^^^ this unindent to the level of "Analyze" above ends the literal block,
#  so the final ":" needs to be "::".
	Page allocated via order XXX, ...
	PFN XXX ...
	 // Detailed stack

	Page allocated via order XXX, ...
	PFN XXX ...
	 // Detailed stack
-----8<------
 
Ditto for another output.

Hope this helps you!

        Thanks, Akira
> 
> thanks,
> -- Shuah
> 
