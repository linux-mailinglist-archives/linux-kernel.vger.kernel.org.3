Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B038475B7D
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 16:12:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243743AbhLOPKt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 10:10:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243701AbhLOPKs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 10:10:48 -0500
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35990C061574
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 07:10:48 -0800 (PST)
Received: by mail-io1-xd2a.google.com with SMTP id k21so30626414ioh.4
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 07:10:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=UCrXISXUyk4MfZ8zuO+8mM8z2Y5gGAsvge/ZiUM2/GI=;
        b=hhoMFuMzEkn1cMsWVWgMea3KqEyiCO86v5kku3FnmfTCcAMjGK2tQ2YJvsv20oFn4q
         /0RvhRhT8Q+a2mUeD2cxU2macOwCzCobhwEgPnwwWGJ8p3eStizpT87RvpEYFXkN2VZk
         6L0cbwYu1M75T+Q8rNIWfyInanin9O35MVdu0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UCrXISXUyk4MfZ8zuO+8mM8z2Y5gGAsvge/ZiUM2/GI=;
        b=vBh2Gf0IN7ALu62MwbOE9DIKTMVkClW15Xst9Fri0F31JSAgflSQg1NAVKbyxezii2
         Zv0No62c6hFLXvI6r8U30u8ZhCrZQZ/Fze09n6wcmaXfe2AdkGgxLNFTQmbiOF9CRGfL
         jH9JKDruNuUTmc76O+Nswto2Wk/mq3eIITRfFYxpsbHG7+aHDln+9F2n7cCIvgxBPZ2C
         hU7wzyVs7Wv6zCUVJU+NjYdUXqk5Z3crIk9dUisvjKiwM54lbFZN32HA0p8rcRGmioIN
         uzWEVukBEP9TW+s1Q2nGdQmfGm7CKEZcD1KZ5JMMI9MG6B7pZshIKe1B1K5uc7QewMHc
         Ztcg==
X-Gm-Message-State: AOAM530CZoOBrkoSOoHNYRRIgK7HLqOuRsUbJPcyx9wk/lph1X56MTUO
        XYzx/vuL03j8ns8xDLkTR4UCBQ==
X-Google-Smtp-Source: ABdhPJzdLYogqbKqUccCBrpjCcWXvCKYxFP+Ov+JvKpWuEBanj3l+RlBSc4FmhQn41S+Fc0DPseNlw==
X-Received: by 2002:a02:770f:: with SMTP id g15mr5877003jac.552.1639581047637;
        Wed, 15 Dec 2021 07:10:47 -0800 (PST)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id y21sm1071530ioj.41.2021.12.15.07.10.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Dec 2021 07:10:47 -0800 (PST)
Subject: Re: [PATCH] docs/vm: fix Unexpected indentation warns in page_owner
To:     Akira Yokosawa <akiyks@gmail.com>
Cc:     akpm@linux-foundation.org, corbet@lwn.net,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20211215001929.47866-1-skhan@linuxfoundation.org>
 <e3acf716-edd2-91d5-24c9-02c547f0d168@gmail.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <f41c83f7-95f9-fd70-aa19-60887e7c4039@linuxfoundation.org>
Date:   Wed, 15 Dec 2021 08:10:46 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <e3acf716-edd2-91d5-24c9-02c547f0d168@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/14/21 6:05 PM, Akira Yokosawa wrote:
> Hi,
> 
> On Tue, 14 Dec 2021 17:19:29 -0700, Shuah Khan wrote:
>> Fix Unexpected indentation warns in page_owner:
>>
>> Documentation/vm/page_owner.rst:92: WARNING: Unexpected indentation.
>> Documentation/vm/page_owner.rst:96: WARNING: Unexpected indentation.
>> Documentation/vm/page_owner.rst:107: WARNING: Unexpected indentation.
> 
> I guess these outputs should have been literal blocks.
> Then Sphinx wouldn't complain about indentations.

Good point. I will take a look and send v2.

thanks,
-- Shuah
