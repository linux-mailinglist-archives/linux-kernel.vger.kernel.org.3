Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FE724774E5
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 15:45:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234808AbhLPOpx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 09:45:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229979AbhLPOpw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 09:45:52 -0500
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05B3EC061574
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 06:45:52 -0800 (PST)
Received: by mail-io1-xd31.google.com with SMTP id 14so35304731ioe.2
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 06:45:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/m5IjU8cEr4hhVbp6UPYr7O2aRXlpDEgmWqofIxjBW0=;
        b=DSRTGLZ6KlenlEJ57G+hFZrDf+Uy0YIUrLrkUnDz4zHJjOlqJJ8hVjWQNMe1eIHnXS
         Gio2YlVn9I8DDDB18P0CER4KCayZzPviR2c/UYG6Crczf328txP6Lda3Bk8t1MzGVSL3
         jCSJRbEV70kIWj0Bf2zdMFz9OH5SQm3Tl+TAI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/m5IjU8cEr4hhVbp6UPYr7O2aRXlpDEgmWqofIxjBW0=;
        b=DnHg4R3R6hq5g2AVKXynRRPKl8APoYC7SF0u3LYlSi+7BJjcxo6so4f+QEoC1XdjII
         l1osJDNLHGdoQ9Zb5KMfwzjUgrSR38wO954C0NLdx4hyoZDlGzoNe5v01JBUjD1uUV3K
         Sbq8UShCOHn0NDeAgFVjsNJKIBX3ZTRAhfnerG+5OgpF4ZC/cOdS0uC/OO0u7MTPwifb
         fjFAQUHYMOczcntGvuolhFLnBO/Rq3IcxHd1C4cL+D/CtZAafsc1BRj5ShU3C1c4LT/F
         Pn0jqDFtf0oaYYNSnAJ+rI7FlgJ3lB/oLUHWXzJ72te7s0XkqA7/bvqMt8/MbF0DBOMO
         OWJA==
X-Gm-Message-State: AOAM531hr6jJfdPE2wa6U58iqaEEoUb6tdC0AH+gL4akYeRLVC3Xai/U
        0pW5mK4BIVzfg309P5g0sLq5AUthUEmYgA==
X-Google-Smtp-Source: ABdhPJyWe6wBFOOv0X5wiGcnL6hlp/oNiGKu2EMOU0xpIlaZKKd7mJee0N7j0MmhHMsNCE/i/AfRSw==
X-Received: by 2002:a05:6638:3590:: with SMTP id v16mr10113512jal.159.1639665951446;
        Thu, 16 Dec 2021 06:45:51 -0800 (PST)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id j6sm3545139ils.77.2021.12.16.06.45.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Dec 2021 06:45:51 -0800 (PST)
Subject: Re: [PATCH] docs/vm: fix Unexpected indentation warns in page_owner
To:     Akira Yokosawa <akiyks@gmail.com>
Cc:     akpm@linux-foundation.org, corbet@lwn.net,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20211215001929.47866-1-skhan@linuxfoundation.org>
 <e3acf716-edd2-91d5-24c9-02c547f0d168@gmail.com>
 <f41c83f7-95f9-fd70-aa19-60887e7c4039@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <ef40c328-78a7-3aeb-0dd5-8ccbd7279e53@linuxfoundation.org>
Date:   Thu, 16 Dec 2021 07:45:50 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <f41c83f7-95f9-fd70-aa19-60887e7c4039@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/15/21 8:10 AM, Shuah Khan wrote:
> On 12/14/21 6:05 PM, Akira Yokosawa wrote:
>> Hi,
>>
>> On Tue, 14 Dec 2021 17:19:29 -0700, Shuah Khan wrote:
>>> Fix Unexpected indentation warns in page_owner:
>>>
>>> Documentation/vm/page_owner.rst:92: WARNING: Unexpected indentation.
>>> Documentation/vm/page_owner.rst:96: WARNING: Unexpected indentation.
>>> Documentation/vm/page_owner.rst:107: WARNING: Unexpected indentation.
>>
>> I guess these outputs should have been literal blocks.
>> Then Sphinx wouldn't complain about indentations.
> 
> Good point. I will take a look and send v2.
> 

This is already in a literal block. A few of the lines in a literal block
are missing indentations - this patch is good as is.

thanks,
-- Shuah

