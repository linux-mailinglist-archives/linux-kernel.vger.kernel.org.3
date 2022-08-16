Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C41B59577E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 12:06:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233255AbiHPKGQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 06:06:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234190AbiHPKFL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 06:05:11 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 016C8C6CD1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 01:11:40 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id uj29so17568270ejc.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 01:11:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=W5qjF+03yjl4vJJBs76s6kPKVqJeVUsMt0AyY8twYsQ=;
        b=a31uzct1G3C9D+Hs2qHPBGDerVJo1D+cDFBOyXDZSEkBthnRBULx8L05BG1z4Nz+vB
         DlWvwn77Tw3lX8P+LXQ1P+3WsLW4h4nq4mtuqyh233rjBsC0l+Z4ljNbcsh1tWBYy/cQ
         TrvXLv3+OD7spjwanEqomikpoS2aXmgZ6O4kRPp5m0FeDgxEU4lYUr4zl6QjJLdnkHr0
         wiIznDUa21X6AddFwyVviVV15YX3yGbXDhI1P3P13Vi4a9NzRijk9nXmDiEX4SiCzh2i
         smMr8cxGrPjWXTRKjFfOwBEVcr3Fbz8TFyNWD6FbEJxSsDYLRgLKZd0/URunHsAi5UEm
         NThw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=W5qjF+03yjl4vJJBs76s6kPKVqJeVUsMt0AyY8twYsQ=;
        b=zI8nUgZ5nOEmYj9nWBYuWlVPZphBuUTWWJm1DP9H5DGPi5DQh0rsPgV4lWdwaFJShr
         1HDaNH7mtzZeLDquedjRJVxVYV1p3xvK8ODDdVE3PHo7KB7a8M7zTKaDGwQCgpEgjuxG
         cVxr8BYM7Xq2B7wIrwYq0w+QdT5jAB5V0xo9c9Rv6u9ov3PVkBN60qsGz8N4znYQelwQ
         cT7iBuWIPBpwvl58uPJ1C1+3wzjYGyL9V9pOsIBAq74igo8MjVEB+f0MiyyUUPAcxwFV
         nTfiINh4yNuLFcWSybPWewQ26O/j8AQ1BOt6lITyBTBtgvqwtI0U2VlX1lXSmLgLSpBc
         Yumw==
X-Gm-Message-State: ACgBeo0KVCj6wbktkbg5kh3wRqiyq/lx8j46U1WaKYvjgCFDlt6XEh5l
        rQQry3RpaLffDGW0ALQQQ7Lj9A==
X-Google-Smtp-Source: AA6agR4WrdhecqaaLYVQ7wHTuKDpRrGzTG8WAdXe81yRK8N0ygsJbeUh5JlV6PmM5HfJe1+47RuRww==
X-Received: by 2002:a17:907:762f:b0:730:95d9:9955 with SMTP id jy15-20020a170907762f00b0073095d99955mr12330008ejc.505.1660637497239;
        Tue, 16 Aug 2022 01:11:37 -0700 (PDT)
Received: from [192.168.1.69] (120.205.87.79.rev.sfr.net. [79.87.205.120])
        by smtp.gmail.com with ESMTPSA id f25-20020a50fc99000000b004424429afd4sm8078244edq.16.2022.08.16.01.11.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Aug 2022 01:11:36 -0700 (PDT)
Message-ID: <0730c493-b49f-02f5-c0e7-999d5871dc4a@baylibre.com>
Date:   Tue, 16 Aug 2022 10:11:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.0
Subject: Re: [PATCH v4 3/3] counter: capture-tiecap: capture driver support
 for ECAP
Content-Language: en-US
To:     William Breathitt Gray <william.gray@linaro.org>
Cc:     vilhelm.gray@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        mranostay@ti.com
References: <20220810140724.182389-1-jpanis@baylibre.com>
 <20220810140724.182389-4-jpanis@baylibre.com> <Yvkq9Hy+hxAPQd8J@fedora>
 <YvosCeuntEKXJz+e@fedora>
From:   Julien Panis <jpanis@baylibre.com>
In-Reply-To: <YvosCeuntEKXJz+e@fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 15/08/2022 13:20, William Breathitt Gray wrote:
> On Sun, Aug 14, 2022 at 01:03:48PM -0400, William Breathitt Gray wrote:
>> On Wed, Aug 10, 2022 at 04:07:24PM +0200, Julien Panis wrote:
>>> +static int ecap_cnt_function_read(struct counter_device *counter,
>>> +				  struct counter_count *count,
>>> +				  enum counter_function *function)
>>> +{
>>> +	*function = COUNTER_FUNCTION_INCREASE;
>>> +
>>> +	return 0;
>>> +}
>>> +
>>> +static int ecap_cnt_action_read(struct counter_device *counter,
>>> +				struct counter_count *count,
>>> +				struct counter_synapse *synapse,
>>> +				enum counter_synapse_action *action)
>>> +{
>>> +	*action = COUNTER_SYNAPSE_ACTION_BOTH_EDGES;
>>> +
>>> +	return 0;
>>> +}
>> Right now you have a Signal defined for the ECAPSIG line, but there is
>> at least one more relevant Signal to define: the clock updating ECAPCNT.
>> The Synapse action of COUNTER_SYNAPSE_ACTION_BOTH_EDGES is for that
>> clock Signal, but for the ECAPSIG Signal you will need to report a
>> Synapse action based on the polarity of the next capture (i.e. whether
>> high or low).
> I need to make a correction here. IIUC, the ECAPSIG signal doesn't
> affect the count value of ECAPCNT (ECAPSIG only triggers the captures),
> so the Synapse action for ECAPSIG should always be
> COUNTER_SYNAPSE_ACTION_NONE. You don't need to account for the capture
> polarities because they're not relevant in this particular situation:
> ECAPSIG doesn't trigger the ECAPCNT count function.
>
> William Breathitt Gray

It appears to me that you spoke about TSCNT register content (32 bits). 
So, you were
not talking about the Mod4 counter (2 bits).
Do you confirm that ?
