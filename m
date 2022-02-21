Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38FC64BEC08
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 21:44:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233951AbiBUUol (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 15:44:41 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233918AbiBUUoj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 15:44:39 -0500
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70BAA237F0;
        Mon, 21 Feb 2022 12:44:16 -0800 (PST)
Received: by mail-qv1-xf2e.google.com with SMTP id d3so35053145qvb.5;
        Mon, 21 Feb 2022 12:44:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=7JX+0ZFjE4qyEsI/0+NODInFwKrPND2Oeh+TaiRXRr0=;
        b=bNDrppQbiS9f53sbnDXLHA/PoVLTWsZqZzbcbv2ISbSkJ079rW5TymNMJGSVA+HWyj
         FN14F7kW9YlTdmXqruHTOkljP56PRF590yxy25ETqVDX2pPod8+q1jA3zNUj/K/V+dCl
         Cl925mT5bfl3iYpcwKj4K0Aj2qdzo2WcGM09omtlztOGwB7oapb2fTtdgXpuOLznsGIQ
         iY9rK6JWe6WKCFulFqac/2UcN7ywO9TNBlA8tnONGQolWQP4V8o9y6/tfowyJdV9Uzoa
         cN3waiv++bu9e4WAT87TZjvZW+Mx9UZG8+bwNxdTZdK6JGXQiA7z3UdFgmi6kstiyKVi
         vEWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=7JX+0ZFjE4qyEsI/0+NODInFwKrPND2Oeh+TaiRXRr0=;
        b=iKa+vMlKNcV5UpMBglP8B3Zyb3fGYPTWCswgoiMkBe8LDkrv/+AbnrYxURWyXO8cAQ
         eazmOBWAYFAtCQ4x5sv4quanch4vjU+E6zPBugHO8EMHOQAfzKhvVW2fweBT8f/9BDR5
         XxqgKRnxio4muJdZxxLwWC8d/fEU0g++fGLQR+WUxUGeUf6gbxYrsglBKIWVbeKF8DHV
         bOFX71pFJtWLlavLpNdBCZO8AoXzxRr9S4jYvf97GQ5GBER0UaQ/0InTkjels7r1Ht3Y
         1Qz5Y8oTv9QQ6T+ZA/jVicUL4YTiqRRo5shJSSjg3L4ci8r8hELE2RK865C9DdRlV3Ov
         AHTQ==
X-Gm-Message-State: AOAM530XTprVuklnvjUmkkg+4UvAmxa5QKOKvILy9AwnMOjM4+udMGgK
        pmrwTORpTb3RE/ENc5U4yxU=
X-Google-Smtp-Source: ABdhPJxZGix683QoGNL4LkSlAk/B0XoOVEy8jpQZ3hWxDDqixJAie/IM3T4v7zBFJ3ELHmSOqXZE7g==
X-Received: by 2002:ac8:7d49:0:b0:2de:4cfa:e8eb with SMTP id h9-20020ac87d49000000b002de4cfae8ebmr775542qtb.70.1645476255641;
        Mon, 21 Feb 2022 12:44:15 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id u38sm5930756qtc.17.2022.02.21.12.44.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Feb 2022 12:44:15 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <46ca0731-0d4f-9cd1-cd2b-4d8cf73cbfcc@roeck-us.net>
Date:   Mon, 21 Feb 2022 12:44:12 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: Linux 5.17-rc5
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Rob Herring <robh@kernel.org>, Maxime Ripard <mripard@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Linus Walleij <linus.walleij@linaro.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>
References: <CAHk-=wiWZ=3dTuRq46KvQVpx-e7xqrnMAVB73dzj7g4Pbwc1zg@mail.gmail.com>
 <1778a683-30fa-9119-c3ce-2dddb5939809@roeck-us.net>
 <CAHk-=wgyJOBhc9PQr-iAW7yYWoni8Gr+O30vtwDR--opn8hyTA@mail.gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <CAHk-=wgyJOBhc9PQr-iAW7yYWoni8Gr+O30vtwDR--opn8hyTA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/21/22 10:31, Linus Torvalds wrote:
> On Mon, Feb 21, 2022 at 10:10 AM Guenter Roeck <linux@roeck-us.net> wrote:
>>
>> Oh, that is "just" the result of the netfilter build problem.
> 
> Oh, ok. I assumed it was some runtime failure since it was under the
> qemu rubric.
> 

Sorry for the confusion. I'll try to clarify if that happens again
in the future.

Guenter

>> The real question is why to patch introducing the problem made it
>> upstream even though the problem was reported several days before
>> the push request was sent.
> 
> Yeah, there's a separate gripe-thread for that. The fix is in the
> netfilter tree and has been there for a week...
> 
>                 Linus

