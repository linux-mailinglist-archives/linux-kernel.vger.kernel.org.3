Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5667573268
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 11:26:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234793AbiGMJ0d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 05:26:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234603AbiGMJ0c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 05:26:32 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7913DF2700
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 02:26:30 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id c15so12839514ljr.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 02:26:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=OZFjfGPRJEW+XiqadcZTKJjaB0j0swaCsivThrUDMjU=;
        b=FCq6yuxggtQBm0dxq0c7IwcN9P1nVA62ZuMomo1VhXktJb+Sd35ROgB0YAtDZn+KAx
         ztIXecxk77fQfTuTU2FE7kDuGF0eFSy+kcNeFLyb9jdJeP4nQl0CvF5cvUAnIEaFu07o
         ZNAc59DTx9DhmY0BPQ3Vo1AWzsisEqWKB+pKkqSwM0Qpty9YI1xHXiDqG65dc375evFf
         uPnMKKwz0Aiz+KVRW+/lf2Ng0mF4QZj5M1kkTyZXZtscz4ASABAJ2efqmhG1/VCcCAnm
         k+GOHSmkv5sVHk80Lrg7GD4GEs1b3dGa0uMQe5KEJ0pjKYC7j/mPNhbvo4NwQZgKwvzv
         1Gkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=OZFjfGPRJEW+XiqadcZTKJjaB0j0swaCsivThrUDMjU=;
        b=35kLPthGw7xmZBSmHKOVd8UyHoerkl+AWFvEv840pgcw0VzWBpjLqAS3YDrvmLD4pu
         x5LO0kAYfIpQKIYuOHcbZ5s2RqqVJqotAKukL2ae8ktw3Ghh2mQzxYNZSQZ3QH53jhoe
         BtmbYtcbWZAy5gNy+vn7BLISs8Cp8Lmi7saLr66Bk/PhJQ48+cE1u4MO6NtJ1CdCc/LP
         8hkGNvjXtrZ2Cyw5JuVYk/eFc9wk50kEe7voMIkb+3f5r8KOJIx0Ym07wl5JGwUxu92S
         N23143T5DjbN6uMaDhs4F2KCSrO0eFQ51+2ppW26IOmZ7VBlDVI6FRr3ZW7cUxTIMZeX
         oGVQ==
X-Gm-Message-State: AJIora9zhrqXuCX7PtDfu9HXiYBy3M1djEp8jjyKegflsFqJxfDIaqou
        rE/36tvdo+UORnhkrKron5tBtA==
X-Google-Smtp-Source: AGRyM1sQ+DurMXduxwN29r9TeaVTPcZRiz0hdxAFf3tJqkALw+WRbPHct7ZSENDmwyDn5R8afxflAg==
X-Received: by 2002:a05:651c:1a1f:b0:25d:4517:faf with SMTP id by31-20020a05651c1a1f00b0025d45170fafmr1166257ljb.415.1657704388771;
        Wed, 13 Jul 2022 02:26:28 -0700 (PDT)
Received: from [10.0.0.8] (fwa5da9-171.bb.online.no. [88.93.169.171])
        by smtp.gmail.com with ESMTPSA id v6-20020a2ea606000000b0025a672e97a6sm3033273ljp.80.2022.07.13.02.26.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Jul 2022 02:26:27 -0700 (PDT)
Message-ID: <6acbebb6-177c-c5b5-f9e8-a374b9276fc1@linaro.org>
Date:   Wed, 13 Jul 2022 11:26:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 3/7] pwm: dwc: add of/platform support
Content-Language: en-US
To:     Ben Dooks <ben.dooks@sifive.com>, linux-pwm@vger.kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        u.kleine-koenig@pengutronix.de,
        Thierry Reding <thierry.reding@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Greentime Hu <greentime.hu@sifive.com>,
        Jude Onyenegecha <jude.onyenegecha@sifive.com>,
        Sudip Mukherjee <sudip.mukherjee@sifive.com>,
        William Salmon <william.salmon@sifive.com>,
        Adnan Chowdhury <adnan.chowdhury@sifive.com>
References: <20220712100113.569042-1-ben.dooks@sifive.com>
 <20220712100113.569042-4-ben.dooks@sifive.com>
 <fdef31b4-9c27-ddda-f1e5-ee881812aa4e@linaro.org>
 <3a1eea1f-b598-58ad-60a6-c76b77cb08c4@sifive.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <3a1eea1f-b598-58ad-60a6-c76b77cb08c4@sifive.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/07/2022 11:21, Ben Dooks wrote:
> On 12/07/2022 11:08, Krzysztof Kozlowski wrote:
>> On 12/07/2022 12:01, Ben Dooks wrote:
>>> The dwc pwm controller can be used in non-PCI systems, so allow
>>> either platform or OF based probing.
>>>
>>> Signed-off-by: Ben Dooks <ben.dooks@sifive.com>
>>> ---
>>>   .../devicetree/bindings/pwm/pwm-synposys.yaml | 40 ++++++++++++++
>>
>> Bindings must be a separate patch. Preferably first in the series. Use
>> proper subject prefix matching the subsystem.
>>
>> Best regards,
>> Krzysztof
> 
> Thanks, seems counter-intuitive that one change is split up like that.

Why? Bindings are not really related to driver implementation, they are
shared with other projects. Binding reviewers usually care less about
implementation, so combining it with drivers forces me to read carefully
each one of 300 emails I receive...

Anyway, that's the policy since years, so nothing new here.

Best regards,
Krzysztof
