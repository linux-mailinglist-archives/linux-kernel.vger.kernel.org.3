Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A835477B4E
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 19:10:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240550AbhLPSKr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 13:10:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231582AbhLPSKq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 13:10:46 -0500
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65D73C061574
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 10:10:46 -0800 (PST)
Received: by mail-oi1-x232.google.com with SMTP id p4so44679oia.9
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 10:10:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=YOWchjxbT8awDrzH+EQqczwYeehzrW37icFRbxVUkAQ=;
        b=diXUSroxW+klhen5e0aokPbRc6MtELRydGsQVcg5QPpNB3jlbh0BFbgVOpUV1B2N2k
         rsIl+sIaORXmHUJfDXR8IxDUBwlxj/sEUQFQRs7uQc3P2Ife/tqMsmwynTNzkAX8bmsh
         DQxLlSI6nJBK211xfep8+kEqLaulBRXIjREtQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=YOWchjxbT8awDrzH+EQqczwYeehzrW37icFRbxVUkAQ=;
        b=AEVTdyFT2SqVDd8miUiY6OK/+dBhwEvwC6RkWcYX9/YRcVshSGe8BBqB6WrpNrDeVW
         Cfbc6gqXoKdB4PbRYsSxsy0Yre3dQ1G9xkz5ftqn3MvY8rntwtPDWQkIaC+nUcsTs3n3
         WWoVIZk5LCo03wB8fVRvjgDulgtpYU5+uX44XFDq5B9oV25o9q2Wutmg8Hr06vpbuF+v
         IVxU0whjE34/FsZusEyvT7S2W8vzo+9VVR4eLHUgRnF7KUSheN0S/2h0z4gvt0wS6rRs
         lE0mjOiyuE/OeFQ1UL0JrrkYDdtfhoV0wVYWx3a1KbqwVTEgxlWhbmDevqGLhBDBCn5X
         Z0bA==
X-Gm-Message-State: AOAM533gR7nN+ojB2OFziu2Pf6uUPh0NJbhdcrtTwn128EK1bcRqdcLB
        zD4IFViZdfRvxPSqYoBMt4zKrpmm1cWDmg==
X-Google-Smtp-Source: ABdhPJx2fKN9YY9yNoLvXf036wIVClUK3bH3oOQsgdrBK9lUanEYFkKcTyh/Gl45yxnUxnTTrQDysg==
X-Received: by 2002:aca:ab87:: with SMTP id u129mr5105520oie.42.1639678245749;
        Thu, 16 Dec 2021 10:10:45 -0800 (PST)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id c3sm1190110oiw.8.2021.12.16.10.10.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Dec 2021 10:10:45 -0800 (PST)
Subject: Re: [PATCH] docs/vm: fix Unexpected indentation warns in page_owner
To:     Akira Yokosawa <akiyks@gmail.com>
Cc:     akpm@linux-foundation.org, corbet@lwn.net,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20211215001929.47866-1-skhan@linuxfoundation.org>
 <e3acf716-edd2-91d5-24c9-02c547f0d168@gmail.com>
 <f41c83f7-95f9-fd70-aa19-60887e7c4039@linuxfoundation.org>
 <ef40c328-78a7-3aeb-0dd5-8ccbd7279e53@linuxfoundation.org>
 <049f7d02-932c-b49c-4af3-10d0f3e8fdb7@gmail.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <4036edad-fd8f-6499-96d1-2ae12ddb73e9@linuxfoundation.org>
Date:   Thu, 16 Dec 2021 11:10:44 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <049f7d02-932c-b49c-4af3-10d0f3e8fdb7@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/16/21 8:00 AM, Akira Yokosawa wrote:
> On Thu, 16 Dec 2021 07:45:50 -0700, Shuah Khan wrote:
>> On 12/15/21 8:10 AM, Shuah Khan wrote:
>>> On 12/14/21 6:05 PM, Akira Yokosawa wrote:
>>>> Hi,
>>>>
>>>> On Tue, 14 Dec 2021 17:19:29 -0700, Shuah Khan wrote:
>>>>> Fix Unexpected indentation warns in page_owner:
>>>>>
>>>>> Documentation/vm/page_owner.rst:92: WARNING: Unexpected indentation.
>>>>> Documentation/vm/page_owner.rst:96: WARNING: Unexpected indentation.
>>>>> Documentation/vm/page_owner.rst:107: WARNING: Unexpected indentation.
>>>>
>>>> I guess these outputs should have been literal blocks.
>>>> Then Sphinx wouldn't complain about indentations.
>>>
>>> Good point. I will take a look and send v2.
>>>
>>
>> This is already in a literal block. A few of the lines in a literal block
>> are missing indentations - this patch is good as is.
> 
> Well, to show the context, embedding from current page_owner.rst.
> My comment is on the line starting with "#".
> 
> -----8<------
> 4) Analyze information from page owner::
> 
> 	cat /sys/kernel/debug/page_owner > page_owner_full.txt
> 	./page_owner_sort page_owner_full.txt sorted_page_owner.txt
> 
>     The general output of ``page_owner_full.txt`` is as follows:
> #  ^^^ this unindent to the level of "Analyze" above ends the literal block,
> #  so the final ":" needs to be "::".
> 	Page allocated via order XXX, ...
> 	PFN XXX ...
> 	 // Detailed stack
> 
> 	Page allocated via order XXX, ...
> 	PFN XXX ...
> 	 // Detailed stack
> -----8<------
>   

Yes. I understood you comment and made the exact change. What I wasn't
sure about is the flow of the text in the document and if the literal
block was just missed or the entire text is supposed to be in a single
block.

I now have a real example text from /sys/kernel/debug/page_owner to
use a real example and fix the warn at the same time.

thanks,
-- Shuah


