Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CBE646F769
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 00:26:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234381AbhLIXaK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 18:30:10 -0500
Received: from mail-pf1-f180.google.com ([209.85.210.180]:41600 "EHLO
        mail-pf1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229760AbhLIXaJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 18:30:09 -0500
Received: by mail-pf1-f180.google.com with SMTP id g19so6840014pfb.8;
        Thu, 09 Dec 2021 15:26:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=pm55gXwdU1qO3Hxz5NUq9N4WUhc0k2zl1y3BfimlzRY=;
        b=Uuics3Gx2q/KhValaeBTVV+lz67kGIIyYO0lvRLeMjJ6QVbN7PeIzWwQ7ZSe5wSF06
         xCbUQ7bkfFb71c8Pjhljw6M7efI5fiHewoN9caM14J1EYAzbHene0uhJJV8+DN9TTHVd
         HUoPOgvug1D3IksUK1b5Y7iRSBdfWRsLcy5ii7XbsRS6Pf0E3JzGog8w/4jF0Q6jFSd+
         jE7AHx+VT8zFauNSIILkax9OG8q8CtwOnFHmYbusub+f4C02rj1v0G2sUdTE+Ih5NMvJ
         1qWjCcUphLxADYQXRmdq3lay2TZcHwQ6tGXMUW+dizWhEhDjYzCx1ixesx0OUYVd4WFb
         IkEQ==
X-Gm-Message-State: AOAM533K+jI0f0k7Lo5AhbVT9COBn9SP0/ttXshpz8oxBwPUZjV/wjza
        ss5Nf/VjV2PxRSeaFdekSZE=
X-Google-Smtp-Source: ABdhPJz+1Y5BZCgBBn9sLNTxgOukl+SUIWVtE6akZ0/lb+7RkHwTA6w/S5DVyXRR3nwV2z7NuQQVTA==
X-Received: by 2002:a05:6a00:2401:b0:4a8:909:1d01 with SMTP id z1-20020a056a00240100b004a809091d01mr14653287pfh.83.1639092394641;
        Thu, 09 Dec 2021 15:26:34 -0800 (PST)
Received: from ?IPv6:2620:0:1000:2514:4f5b:f494:7264:b4d4? ([2620:0:1000:2514:4f5b:f494:7264:b4d4])
        by smtp.gmail.com with ESMTPSA id r6sm649739pjg.21.2021.12.09.15.26.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Dec 2021 15:26:34 -0800 (PST)
Subject: Re: [PATCH v3 2/3] block: don't delete queue kobject before its
 children
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-mmc@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hannes Reinecke <hare@suse.de>
References: <20211208013534.136590-1-ebiggers@kernel.org>
 <20211208013534.136590-3-ebiggers@kernel.org>
 <2a029611-10da-9114-b66b-345a68a5bd36@acm.org>
 <YbKOj3lBEdJLE8mr@sol.localdomain>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <1dcedb60-300a-bfca-9ca8-62e121ac6b61@acm.org>
Date:   Thu, 9 Dec 2021 15:26:32 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <YbKOj3lBEdJLE8mr@sol.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/9/21 3:17 PM, Eric Biggers wrote:
> On Thu, Dec 09, 2021 at 02:38:02PM -0800, Bart Van Assche wrote:
>> On 12/7/21 5:35 PM, Eric Biggers wrote:
>>> +	/* Now that all child objects were deleted, the queue can be deleted. */
>>
>> Shouldn't the present tense be used above (were -> are)? Anyway:
>>
>> Reviewed-by: Bart Van Assche <bvanassche@acm.org>
> 
> "deleted" is an action here, not a state.  I think it's fine as-is, but maybe
> you would prefer the following?
> 
> 	/* Now that we've deleted all child objects, we can delete the queue. */

Both alternatives work for me.

Thanks,

Bart.
