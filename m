Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCE5F49FF89
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 18:28:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234707AbiA1R2g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 12:28:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344064AbiA1R15 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 12:27:57 -0500
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF67BC061714
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 09:27:56 -0800 (PST)
Received: by mail-io1-xd2a.google.com with SMTP id n17so8623043iod.4
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 09:27:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=hI+Pb4Qj4STgOuzbId2s9PWOgJpYgz54ZXJVFK6xdro=;
        b=LDrlVegD4OczCTpSThYZQahsywE58n2csztjLpYCX0DbQXsDPpnQjHsQ7NaVNe6s/U
         kZqQQCxgzePex3Wg9EhnUShaUaM/mYzddJOn9EyqW8wzZv5SImX4T8zxMjbnF1aC6fxo
         /tkGq0Wld2rlH7iw5TmoS/jf72nlYAj6Es4MQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hI+Pb4Qj4STgOuzbId2s9PWOgJpYgz54ZXJVFK6xdro=;
        b=ehowJvMVaMDAzcc+AiKXvZtph6IvENsK8cbNWzaR2XajjJglYYFYEPVvWoiedEuQ4C
         wm9z+CgClcWLmOTC6fDQQPM2jrQd0vq19wnaPdOHdd0joUqVjiF90LErK4U1LcOwX6nI
         rptmE/2eyJ6ypPtAQG/GD9tEtryceyI0JUGU5vNZ2idAi9Smlaerrwxgj1g4t8OZA2Mg
         LW94WzXIHNhI6beICyOLWdRABg0mVmnj1Nl/HTPpuTg4l7TCVnfC7GbgO5nATg2l1QMk
         CqQUHOA8bMnfR7C3wlqRI/ToS37epB0dWaG9yCIaAICTrZfmQmaQpLSURpWhyIq5KHNe
         RvbA==
X-Gm-Message-State: AOAM532eoS5C2JZV/YUpVyVbSqUDWUsnxXz1z1L/nwCQ6K+eI6uDF7gR
        KLm4cIfbooGXAZlRauY0DDlpFXu/1CXZPA==
X-Google-Smtp-Source: ABdhPJwlAJwtqXZWsYjubtsCZ9BvWMOO/2eR7kskV3EhbH9JFJmtzo1ff4MXiwHTtwOHpfZvkqd52w==
X-Received: by 2002:a02:95e7:: with SMTP id b94mr5287475jai.98.1643390876164;
        Fri, 28 Jan 2022 09:27:56 -0800 (PST)
Received: from ?IPv6:2601:282:8200:4c:4e31:d3a8:3801:7e36? ([2601:282:8200:4c:4e31:d3a8:3801:7e36])
        by smtp.gmail.com with ESMTPSA id k5sm3863748ilr.7.2022.01.28.09.27.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Jan 2022 09:27:55 -0800 (PST)
Subject: Re: [tools headers UAPI] e2bcbd7769: kernel-selftests.ir.make_fail
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Sean Young <sean@mess.org>
Cc:     kernel test robot <oliver.sang@intel.com>,
        Alexei Starovoitov <ast@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        lkp@lists.01.org, kbuild test robot <lkp@intel.com>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220128075346.GG8421@xsang-OptiPlex-9020>
 <YfO39Q3mNHMQOkd4@gofer.mess.org>
 <CAADnVQJ3RCPUQ0k9nu2urrRK=U7SUetuPmY0_b17M_PD=j4fkw@mail.gmail.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <e5b72f09-a208-a579-3e51-10935ccee1ff@linuxfoundation.org>
Date:   Fri, 28 Jan 2022 10:27:52 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <CAADnVQJ3RCPUQ0k9nu2urrRK=U7SUetuPmY0_b17M_PD=j4fkw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/28/22 9:49 AM, Alexei Starovoitov wrote:
> On Fri, Jan 28, 2022 at 1:32 AM Sean Young <sean@mess.org> wrote:
>>

>>> ir_loopback.c: In function ‘main’:
>>> ir_loopback.c:147:20: error: ‘RC_PROTO_RCMM32’ undeclared (first use in this function); did you mean ‘RC_PROTO_RC6_MCE’?
>>>      if (rc_proto == RC_PROTO_RCMM32 &&
>>>                      ^~~~~~~~~~~~~~~
>>>                      RC_PROTO_RC6_MCE
>>
>> So this commit removes the copy of lirc.h from tools/include/uapi/linux/lirc.h,
>> so now the test uses /usr/include/linux/lirc.h. It appears that this file
>> does not have RC_PROTO_RCMM32 defined on this system, which means it is a
>> kernel header from v5.1 or earlier (this was added in commit
>> 721074b03411327e7bf41555d4cc7c18f49313f7).
>>
>> It looks like this machine is redhat 8.3, which ships with kernel 4.18.
>>
>> I guess my change was far too optimistic; I had no ideal enterprise kernels
>> were so ancient.
>>
>> We should probably drop e2bcbd7769ee8f05e1b3d10848aace98973844e4. Sorry about
>> the turbulence.
> 
> I'd rather avoid reverting.
> Just add ifdef or something to shut up the error on old distros.
> 

Sean,

Let's not add release checks.

Since RC_PROTO_RCMM32 is the only one missing, perhaps you could define
just that one in ir_loopback.c with a comment that it can be removed.

ifndef RC_PROTO_RCMM32 ---

thanks,
-- Shuah


