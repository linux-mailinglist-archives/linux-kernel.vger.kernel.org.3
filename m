Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A318E53C908
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 13:05:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243918AbiFCLEp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 07:04:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237380AbiFCLEn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 07:04:43 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53B1F3BFB4
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jun 2022 04:04:42 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id h62-20020a1c2141000000b0039aa4d054e2so6177598wmh.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jun 2022 04:04:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=ExK+DYLUUomIg3mRJoq7EumeoyhrwGwm615hpYO0lXQ=;
        b=K19PSH3lwY1yW8Us7aXC4yemQGjRs8tmgABDOI0vD1UaDVhaH/YnOt4TU0pQtq9eTw
         fApFgN1kibEtjP25egxeZs1kpnOQIoxViM6OsebgTbVTljxbUhODUhk8QZINAYXoUjF0
         yN6YF1mqAoVnHgWpelghaiVa7DLUlNd5j2TKIvc7CdXWlh/Q4+s8lsoZDftzXn605iiJ
         LJEfnK/vRSQdUoyQkiByR6M/kGfadO9onx4Bi27AMDPQ0lB5CVx992UzbvzdK/w1d6jw
         iYsD2DwWOaeTfUz6/rZdNt4Dv1qd3Z0QH4qcfHc/Zk+Hi/Pqh4cc/SYy17mb3beo+aFu
         Mv2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ExK+DYLUUomIg3mRJoq7EumeoyhrwGwm615hpYO0lXQ=;
        b=MjWcvyn9qd5t4ylzUiJ8tM0T868I2/jHQdVoXp4fTbDS6R9QJbar8VcZDjCa+HRUwM
         JXSLE08PmG3O9VTxTGC+rtjmUc+XDGj/v2c1h1NnBVkuV4z3yquZ/B7LXKdDn3DF9/Ig
         vb5X7vVoO1EK24IirvkO0xnCmzJa5tG7OHCv0gOfG6SLxXO6sIAdMyjGS1lma5Khhrs+
         OSc5wRK2XyfYyshNer7n9gBDLNj/PjQY7G2/44xsvSTehXkR1vH81G9OS9JaOfGNJcxt
         4fCMuS+4yaD74T+cGmbKPVm1j5/X7/4cPmuvm17Upu+rYrI/kftsM1fiOnCTe0Qv49UU
         BBCw==
X-Gm-Message-State: AOAM531iTvSW3e2xC1JBxhWfjlcPCo8ngy5nZDXRDteb5BUNKpc6Wegs
        cjkEaA7Qjl7EamjiTXihmSV98A==
X-Google-Smtp-Source: ABdhPJwp2zagP6UI2fFhVdDyk5de0gUKb9cOw6NpGThJLza8s+4ag0BrvmVlDKzxY3wiX3nST3JQbg==
X-Received: by 2002:a05:600c:4f93:b0:399:e654:4481 with SMTP id n19-20020a05600c4f9300b00399e6544481mr28194292wmq.164.1654254280711;
        Fri, 03 Jun 2022 04:04:40 -0700 (PDT)
Received: from [192.168.1.41] (static-176-182-171-101.ncc.abo.bbox.fr. [176.182.171.101])
        by smtp.googlemail.com with ESMTPSA id h24-20020adfa4d8000000b0020d0a57af5esm7152854wrb.79.2022.06.03.04.04.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Jun 2022 04:04:40 -0700 (PDT)
Message-ID: <0ca654c0-d7b4-b955-7e9b-542452659694@linaro.org>
Date:   Fri, 3 Jun 2022 13:04:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 3/3] thermal/sysfs: Remove cooling device sysfs statistics
Content-Language: en-US
To:     Todd Kjos <tkjos@google.com>, Lukasz Luba <lukasz.luba@arm.com>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        rafael@kernel.org, quic_manafm@quicinc.com,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Wei Wang <wvw@google.com>
References: <20220601151441.9128-1-daniel.lezcano@linaro.org>
 <20220601151441.9128-3-daniel.lezcano@linaro.org>
 <be8395e3-98d7-7a8f-7153-c491b22d4463@arm.com>
 <cb35e356-bc90-2a67-6983-1a4c3a0ea62d@linaro.org>
 <eada018c-b857-7946-ae4b-2532e6866a45@arm.com>
 <CAHRSSEz9ExOgvByycztKYf1ncxCKeoy3uHuyQcnUC1r5nujc2w@mail.gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <CAHRSSEz9ExOgvByycztKYf1ncxCKeoy3uHuyQcnUC1r5nujc2w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Todd,

[adding Wei]

On 02/06/2022 21:02, Todd Kjos wrote:
> On Thu, Jun 2, 2022 at 2:16 AM Lukasz Luba <lukasz.luba@arm.com> wrote:

[ ... ]

>> I see, it makes sense. Let's see if Todd and Android folks don't
>> use this thermal sysfs stats, so we could remove them.
> 
> Android HALs do use the thermal sysfs stats. debugfs isn't a viable
> replacement since debugfs must not be mounted during normal operation.

Thanks for your answer.

I'm curious, what is the purpose of getting the statistics, especially 
the transitions stats from normal operation?

There were some complains about systems having a high number of cooling 
devices with a lot of states. The state transitions are represented as a 
matrix and result in up to hundred of megabytes of memory wasted.

Moreover, sysfs being limited a page size, the output is often truncated.

As it is automatically enabled for GKI, this waste of memory which is 
not negligible for system with low memory can not be avoided.

I went through the thermal HAL but did not find an usage of these 
statistics, do you have a pointer to the code using them ?

Thanks

   -- Daniel



-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
