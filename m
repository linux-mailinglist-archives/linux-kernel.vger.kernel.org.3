Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C066C59158F
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 20:41:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236176AbiHLSlr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 14:41:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230498AbiHLSlo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 14:41:44 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81BD0AE9D2
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 11:41:33 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id u3so2432829lfk.8
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 11:41:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=AVMExjC/PZ+IN90kCT2j4IDPkufVZOCe6pOQAghuGnM=;
        b=kNStvDU4SbWI3BtJsp7e0HJyLYsswIgEe6Q48/DACT6mca2ExpeOlccGEneA2kTZ16
         HXHY39V4qcYbCX9Rc8ro9lGLMVijTzNRqlPpRXs40v7YfjmTPxQPwh8DUacWqXaZGjm6
         aw9Jf57kGHjCUxnWw6cN7mhWPKhv3PnN2tSCv7iw5chP9U6spmuWnkdTLr/byFdp9zLA
         UpYHYHlo1fwGZcWUWXwgdUUK0JVAA9yDieXtPUxCIz/+ADJzqf21Ap3RaeUxnAQqqMqE
         EHozSiOHy4ulFAUpT1XMYAzHWbFjVALkMN4LQGfUIzoBdpaCmgV9kC7RWtW2R9ZA81Ex
         tfeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=AVMExjC/PZ+IN90kCT2j4IDPkufVZOCe6pOQAghuGnM=;
        b=icSoqo2F9GSGVWRe2C90Q3Kma/jWTsZL+4PTvvveRC8US/rR2u/4j6yJ/YwvqtbIUi
         Ga28J7lGLdRLd5SQNUPvHrNs2FpnrXA2qkk6UYJK9egJnQY04MD8Sq0fpqKMaH2lNnrr
         /W7INH/r7M8XbBDdHSosWpBciW6O3KrqjO+DAVbSNNtxS2v727aR1BdvVe/rTjPX2yOD
         8rAhK78z3sjiD8j4FZD7Yy9T3TFPtVgfQSBStkocucRZAE+gknJ0Ev+YVr4evem7STX7
         +KP8OtzhwcWNihlCUUPnhc97ywNwU0pBVJKn1nf0FBH6GU7ezIgsubEk7uTcPMPnguGs
         ZUZg==
X-Gm-Message-State: ACgBeo2FX/Ul6BtA9K8dXP2CBErG+At9xZUa3Ah/4BXxeajONY5tvLk1
        gV/yEVm+kF52YUnFdWO4uoK63w==
X-Google-Smtp-Source: AA6agR5TGMC3pAxFYMqF0pg6wHiqcx21KuEoRtHiCPRcFUtj3sn7nZUcoZK1Ent4J6EwV596ZAGq6Q==
X-Received: by 2002:a05:6512:12c9:b0:48b:3e0f:7a79 with SMTP id p9-20020a05651212c900b0048b3e0f7a79mr1772348lfg.52.1660329691834;
        Fri, 12 Aug 2022 11:41:31 -0700 (PDT)
Received: from [192.168.1.39] ([83.146.140.105])
        by smtp.gmail.com with ESMTPSA id n26-20020a05651203fa00b0048b0526070fsm300281lfq.71.2022.08.12.11.41.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Aug 2022 11:41:31 -0700 (PDT)
Message-ID: <c51c360e-a73f-9333-ffa1-3461de29f41f@linaro.org>
Date:   Fri, 12 Aug 2022 21:41:22 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v3 3/3] memory: Add Broadcom STB memory controller driver
Content-Language: en-US
To:     Florian Fainelli <f.fainelli@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        "moderated list:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
References: <20220801220931.181531-1-f.fainelli@gmail.com>
 <20220801220931.181531-4-f.fainelli@gmail.com>
 <26ad247d-a4b3-4051-b8d9-505c09b76f6b@linaro.org>
 <375eac04-dbfd-080a-3003-cae3eda1f42b@gmail.com>
 <fa283e3c-5b96-b0a4-95c5-a7230d16d8ca@linaro.org>
 <ec06e9c6-f475-fe19-9046-d57a6168e72b@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <ec06e9c6-f475-fe19-9046-d57a6168e72b@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/08/2022 20:52, Florian Fainelli wrote:

>>> unless you also implied enclosing those functions under an #if
>>> IS_ENABLED(CONFIG_PM) or something which is IMHO less preferable.
>>
>> Are you sure you added also pm_ptr()? I don't see such warnings with W=1
>> and final object does not have the functions (for a different driver but
>> same principle).
> 
> Yes I am sure I added pm_ptr() see the v4 I just submitted. I don't see 
> how the compiler cannot warn about the functions being unused the day 
> they stop being referenced by the pm_ops structure which is eliminated?

I don't have the answer how it exactly works (or which gcc version
introduced it), but I tested it and the functions were not present in
the object file, thus of course no warnings.

The driver change I am referring to is:
https://lore.kernel.org/all/20220808174107.38676-15-paul@crapouillou.net/

I think the only difference against your v4 is:
DEFINE_SIMPLE_DEV_PM_OPS
and lack of __maybe_unused on the functions.

The DEFINE_SIMPLE_DEV_PM_OPS itself adds __maybe_unused for !CONFIG_PM
case, but I don't think it is relevant.

Best regards,
Krzysztof
