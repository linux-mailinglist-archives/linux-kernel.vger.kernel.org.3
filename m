Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E60665865C4
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 09:38:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229797AbiHAHio (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 03:38:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229805AbiHAHik (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 03:38:40 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B2263AB10
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 00:38:39 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id r83-20020a1c4456000000b003a3a22178beso3498350wma.3
        for <linux-kernel@vger.kernel.org>; Mon, 01 Aug 2022 00:38:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=9M7ldFJwPPyHRHC4pJgvhcKgnF4pbM0tP8St0djzKuw=;
        b=sW8QpDnWF7xSXsUFb0joWJpFbsJqVghEnrKrJiEApa5LRNUMreHQchJqNvaJXnjeIY
         RwJAt4hM+PIx/vy1HV0B/EmXNipyqYuCEZcJpZ9PwoIAEC6czpPBu/6BkoxJhu0xPPfy
         DWK67l7OHjeoEU1+R5qE5bLNiGi+3dysmc4SftaMj5xgGbuVVn0vNz8zLC1IvzDS7vfB
         et1x6XPqtgukzkSOIgZdA/eZqCsY9AVczZ68zbKqaqzk8mH2CQ67i84zjPIDqUC3rE2g
         F467MLLePwrZCHDdooMO3PqZITyPuaIqH0vT2VzOpsWsUEN7zsAhQKc9GcaacWrf55ks
         NcvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=9M7ldFJwPPyHRHC4pJgvhcKgnF4pbM0tP8St0djzKuw=;
        b=BrIJe48K+cQ8qMldAXQWRn0dUHueWHDnudrAE1l5/1XCkaQWAx0sIrACXkG0IvswY5
         RchjLady3t/dy77fYgenlvrQ6iPk3kcR5ghgiy7kLQjZoVEVZyjQ/npJV4l8Rs4CCNNe
         ajGcimSy9EOMaZkJveCFa9W9qNV7x8P82+D/kYppazrNtRtM4SQIk5s3xD4j9uS7I3Y7
         oQ9Iy2GMRZqc1IIU7R9puRedrW2RBLx5E7n86Rg1d0J6B0HjZz0DrzCUysF5zrm5PkWA
         xoRcqN9Zc2/3+70f92/80HtMNIACKqraTB6R4j1HX7yOoIv5wBdYLaTCrPKWqgv5ZYex
         6JQw==
X-Gm-Message-State: AJIora/1xJ6+AKES1XQlOc3CWuzekYXl8h0pSbSb/9qGgABT5x+fzZ5A
        anIQnHPwbXQShRlavZr8cSBsNg==
X-Google-Smtp-Source: AGRyM1uiAOLx+QSU7QqVWX8hyXfWnsrdp3pynTasFZMa2HyimA+kO0txTY3bP8kzaaOaIuTSSAIOvw==
X-Received: by 2002:a05:600c:b5a:b0:3a3:186f:a564 with SMTP id k26-20020a05600c0b5a00b003a3186fa564mr10613679wmr.71.1659339517668;
        Mon, 01 Aug 2022 00:38:37 -0700 (PDT)
Received: from [192.168.1.5] ([195.24.90.54])
        by smtp.googlemail.com with ESMTPSA id u11-20020a056000038b00b0021e4829d359sm11473355wrf.39.2022.08.01.00.38.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Aug 2022 00:38:37 -0700 (PDT)
Message-ID: <aebc16fa-b5be-5db4-c4d3-17bfde697eed@linaro.org>
Date:   Mon, 1 Aug 2022 10:38:09 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: WARNING: CPU: 4 PID: 326 at drivers/opp/core.c:2471
 dev_pm_opp_set_config+0x344/0x620
Content-Language: en-US
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mansur Alisha Shaik <mansur@codeaurora.org>,
        open list <linux-kernel@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        regressions@lists.linux.dev, Linux PM <linux-pm@vger.kernel.org>,
        lkft-triage@lists.linaro.org, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>
References: <CA+G9fYuGFReF0Z9qj7-80eY0gz-J2C5MVpno_8NjrGSH5_RB0Q@mail.gmail.com>
 <20220725102711.p6eerjjzgeqi4blu@vireshk-i7>
 <f914f5c5-dd61-8495-b362-3043406582da@linaro.org>
 <20220801023636.p5ytjqasedpohmdy@vireshk-i7>
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
In-Reply-To: <20220801023636.p5ytjqasedpohmdy@vireshk-i7>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Viresh,

On 8/1/22 05:36, Viresh Kumar wrote:
> On 25-07-22, 14:55, Stanimir Varbanov wrote:
>> Hi Viresh,
>>
>> I can take a look and provide a patch to fix that.
> 
> Any update on this ? I am going to send pull request for 5.20 very soon and it
> would have been much better if this was fixed before I send that.
> 

I hope, I will finish up this today.


-- 
regards,
Stan
