Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8513486794
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 17:25:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241184AbiAFQZj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 11:25:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241167AbiAFQZi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 11:25:38 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF6C5C061245;
        Thu,  6 Jan 2022 08:25:37 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id k18so5791925wrg.11;
        Thu, 06 Jan 2022 08:25:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=FHJg4hW/f88/Sk6mRnWtxmcYfEUH34oJVmaSAFiTGEY=;
        b=mW6GTaZxtsfnj83+t4msieNNayuvTXb3hFE+YF0e8Ih7/ks4rF2fysgMfv8a/geSdS
         BGyBsASuW6Ds5PzjE0t88LHqd9lZsuo95sQ9kkP5EmQvlBC4YJaDHdNDgTZAjrPz9kPS
         l36VX9af77phwXRV3WbIkVPp2whCrngk8ZR1XbREu63lko2ZZsh2XY0YsJSSLScTbGvq
         zdtfHdsi5tYA5N6njglw36mRZVr1+OH7liHaSFqU2ygU1ixjrjIUzwxgLUMg/Prc2/LJ
         k+VVwIKpTAGFHSe3DWAbJRpOmvBxhcB6UfMUXk43sR+FUBYrI03JtzRH630IB/TUnuCN
         qfpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=FHJg4hW/f88/Sk6mRnWtxmcYfEUH34oJVmaSAFiTGEY=;
        b=Du5Ctkba6dKok1QGHcQsJRv4LFUxBNBQt+8oERo4CEF+cv9e1ck+0l56E9tiDKWTqB
         xMmQBJgesTi3qDDfq1UlRdGmQUP+/igPA4KKJ2h1c2DMAbKfCnJH8h3TZ6rVumJlWlbi
         Ov4+fcpUCn9Cl/VdIXMjT0hiF8KJs82YdlBj4BDDfLp7QF91rOgBiZ8VxDVV83v8xFJ1
         y0qPCz+Rya96QySeEoIV4b0EgWlV0p4L6FOBbxxGRNmQByKFtHwqGlaQ1peD8SFOaR7l
         uMYiQC4FnoQJJNUbLXwoqv1/odRan4X/B6f7S32q1u043BtMti6dkjNp04qJCRGgR06x
         0qlw==
X-Gm-Message-State: AOAM530mVVVtM1VVS0DOR5d7GVf+psakNJKjrqFEvOQ12vUcoerSyPbz
        WlBGAVTPvZxRZ7UoBQP9rC6MqOjM2DP6zg==
X-Google-Smtp-Source: ABdhPJyImdMn57LWiiLC1zVWGweD/+JciRzkrHvu3/CDh0w1sIxu+Y9qdd/8NBYAS+HgC9+P9N+BsQ==
X-Received: by 2002:a5d:698c:: with SMTP id g12mr2589709wru.69.1641486336534;
        Thu, 06 Jan 2022 08:25:36 -0800 (PST)
Received: from [172.22.36.87] (redhat-nat.vtp.fi.muni.cz. [78.128.215.6])
        by smtp.gmail.com with ESMTPSA id u3sm3105044wrs.0.2022.01.06.08.25.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Jan 2022 08:25:35 -0800 (PST)
Message-ID: <120368dc-e337-9176-936c-4db2a8bf710e@gmail.com>
Date:   Thu, 6 Jan 2022 17:25:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [dm-devel] [PATCH v4 00/13] x86: Support Key Locker
Content-Language: en-US
To:     "Bae, Chang Seok" <chang.seok.bae@intel.com>
Cc:     "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Krishnakumar, Lalithambika" <lalithambika.krishnakumar@intel.com>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        "Lutomirski, Andy" <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@suse.de>, Ingo Molnar <mingo@kernel.org>,
        "Gairuboyina, Charishma1" <charishma1.gairuboyina@intel.com>,
        "Dwarakanath, Kumar N" <kumar.n.dwarakanath@intel.com>,
        Eric Biggers <ebiggers@kernel.org>
References: <20211214005212.20588-1-chang.seok.bae@intel.com>
 <YbqRseO+TtuGQk5x@sol.localdomain>
 <4101B942-6327-49A9-BE8B-9E51F0427F50@intel.com>
 <YdZ5HrOKEffBrQIm@sol.localdomain>
From:   Milan Broz <gmazyland@gmail.com>
In-Reply-To: <YdZ5HrOKEffBrQIm@sol.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/01/2022 06:07, Eric Biggers wrote:
> On Wed, Jan 05, 2022 at 09:55:17PM +0000, Bae, Chang Seok wrote:
>>>> +-----------+---------------+---------------+
>>>> | Cipher    |   Encryption  | Decryption    |
>>>> | (AES-KL)  |    (MiB/s)    | (MiB/s)       |
>>>> +-----------+---------------+---------------+
>>>> | AES-CBC   |     505.3     |   2097.8      |
>>>> | AES-XTS   |     1130      |   696.4       |
>>>> +-----------+-------------------------------+
>>>
>>> Why is AES-XTS decryption so much slower than AES-XTS encryption?  They should
>>> be about the same.
>>
>> Analyzing and understanding this with specific hardware implementation takes
>> time for us. Will come back and update you when we have anything to share here.
> 
> Note that for disk encryption, decryption performance is usually more important
> than encryption performance.  So your performance results are strange.

If the test results are from "cryptsetup benchmark", it just run benchmark
through userspace crypto API (AF_ALG) - no dm-crypt is involved at all.

Proper test with dm-crypt should be run to get some numbers too.

(But the test results are really strange... there is no reason
decryption should be slower for XTS.)

Also you mention that
> Bare metal disk encryption is the only use case intended by these patches.
> Userspace usage is not supported because there is no ABI provided to
> communicate and coordinate wrapping-key restore failures to userspace.

The cryptsetup benchmark is userspace use (just with kernel netlink
access to kernel crypto). So I am not sure if these number are so important.

Milan
