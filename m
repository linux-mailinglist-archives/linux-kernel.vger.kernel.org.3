Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B95594FF74E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 15:01:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235689AbiDMND0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 09:03:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234194AbiDMNDT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 09:03:19 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C3F55DE7F
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 06:00:58 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id u18so2283610eda.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 06:00:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=LHqF1GjuEx3McVGIeuPFhwAsbM67ptWjDdKy3Vs5VqE=;
        b=RDm4Nl9amAehbRuUnGCSwd8FnlDdEcqKxRkwOZb5lapQKqKde6f10rzcqNZUWxApiK
         8cgK6QAsMxwhgMmj6h1PBMP6b1BwBQXDhRQNauzuzcIapxWBjAZCYA9PCC8Cq4TYe4cz
         ZtygZf+u6TzgYvZQzNmjOFg5+c2VXbTTkziTMU/3LINwbFh4one0V2yAOJyvqYrkWxVX
         UliEcVQ0dQ9Lugv/XMFHSKLcDhCL6qMm+goQzffZNXJJqLMyKJT8TykWi0jj+7M5L/yU
         ruVn4GoRD/AAfr6trMFGA0liuwRQ5MJVfpQ/FeKZeRQTTqtuik2OYQGRUvKiVDgfWQlD
         40Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=LHqF1GjuEx3McVGIeuPFhwAsbM67ptWjDdKy3Vs5VqE=;
        b=ehALbOUI6Lln3zqcMRkGxFbf2HY/Xr6dfNtbzCVpBerWZtwyEI/qr1y5dZ0jS46cdX
         EFfn7A1JatUwTW1BOv4nAx6pb3/7ix7iibfipZ/mqB36sQoCB+Igvv7isKR2cuqz5Jee
         CgF8LmcXhxX6ftU4w1IK4ZmeoGYpsM+0j1FWUBSzn7ZgjASVmKk2RGIvDxafkjy+WUDG
         T4SWE9viOMaH3qlEAxa86KCRCx4C+lKylJoiV8XVkvd5kvhkvIRhRHc1jvudBcraSYLh
         yHU6VwxtkIRs/DHADTouZOSQFhwClIVGONuHdLsB1XsQCuDzK6eQoTFe/dINmsggFwcZ
         q/aQ==
X-Gm-Message-State: AOAM533pX5sJoUhVC3YVVqK4ArMKVSpAfiW0ItjyupeOzEeRKy4algPf
        Ydl1hozgBjAAbL1lABhDPNYIAA==
X-Google-Smtp-Source: ABdhPJwq+ksrJNgobbLQ98WyhtQ/tFCVF+DdkcJJN7rO8VSlO7/s0RKGORvL8KuijCo1P//GlzPtjw==
X-Received: by 2002:aa7:d658:0:b0:41d:7875:74bf with SMTP id v24-20020aa7d658000000b0041d787574bfmr17896464edr.415.1649854857116;
        Wed, 13 Apr 2022 06:00:57 -0700 (PDT)
Received: from [192.168.0.204] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id f7-20020a0564021e8700b0041d03a94f27sm1163266edf.66.2022.04.13.06.00.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Apr 2022 06:00:56 -0700 (PDT)
Message-ID: <897a05fd-a568-9d33-dc20-5de4e5d2188f@linaro.org>
Date:   Wed, 13 Apr 2022 15:00:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v3 0/2] memory: omap-gpmc: Allow module build
Content-Language: en-US
To:     Roger Quadros <rogerq@kernel.org>
Cc:     linux-omap@vger.kernel.org, nm@ti.com,
        linux-kernel@vger.kernel.org, kishon@ti.com, tony@atomide.com,
        miquel.raynal@bootlin.com, vigneshr@ti.com
References: <20220411095516.24754-1-rogerq@kernel.org>
 <164984299612.34759.11981181842672620752.b4-ty@linaro.org>
 <20428012-f164-c03b-fcc5-d3d8df812aff@linaro.org>
 <ed2167af-fc9f-1f52-e8e2-c0881f5d53c6@linaro.org>
 <7b38a717-ffce-0f06-1a77-6d2a114c7e11@kernel.org>
 <68d16fbb-4250-73bd-b55e-a14db91abe8f@linaro.org>
 <fdafb49b-9349-087b-f483-4da888193683@kernel.org>
 <f2b7b48f-906e-3445-3861-dcdd4f6551e3@linaro.org>
 <605268c7-9d0f-83d5-d7e6-850dabb380f0@kernel.org>
 <06852353-9ca1-6f61-7447-b5f1d64ead25@linaro.org>
 <4681b00e-7f89-d9c4-6361-b781ced72656@kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <4681b00e-7f89-d9c4-6361-b781ced72656@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/04/2022 14:56, Roger Quadros wrote:
>>
>> If you have spare time, maybe you could investigate the compile testing
>> on other platforms as well and if something fails, fix it. But it seems
>> it is separate problem.
>>
> 
> I won't be able to test on all platforms. I'm ok to not add more dependency and
> just drop COMPILE_TEST.

I understand that. You can still test 8-12 popular ones on a regular
Ubuntu machine (there are like 10 or 12 cross compile toolchains now in
standard Ubuntu repos).

Another way is to put your patches on Github and ask kbuild folks to
test your trees. I think this was the repo (but double check):
https://github.com/fengguang/lkp-tests


Best regards,
Krzysztof
