Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B032577C55
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 09:19:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233814AbiGRHTD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 03:19:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233789AbiGRHTA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 03:19:00 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE279638D
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 00:18:54 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id be14-20020a05600c1e8e00b003a04a458c54so6771207wmb.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 00:18:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=6SW50VnLhaL+wz7KdW1u+6jKOuGu4ai++hAw+MCwKnM=;
        b=CQ+p7HL7BOEl95DRyAdhpSUpabEd/HNhy6SC574YMKWizqAcpaTQVPcTiLluSg+CdM
         bJs7+aT7w5lF3oV7HtlDqe6nrgfifx/tpLFEAPfENRaC6yCUQrwaVTCYiZq/fZRNiLK3
         g8n8EJ2zva0XdD/jBJCbBPL0tkeUUO5+e3bdy8Cbp2yDOovWT0TcX2SV+Up9DiNpUsBq
         sMcxMd8RNpUHbAXy2WubpaOrwvth4UIcp5yeYVFIJz40VZLDYN3k5lHEFjdsZYFxCRwB
         1/ktGR3hlar1zqeJDK/hdnYyDDNc48Af19nWm+KaN8vhvQD2sSBCOkb85JsfrO4sWWIo
         DGZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=6SW50VnLhaL+wz7KdW1u+6jKOuGu4ai++hAw+MCwKnM=;
        b=zqTpVTd1mMkzCXmOAm8A2BaKDNTzsvlsXJFupyO5lFrEOgKRpCFL6P0ikdqfTTKgYX
         QU1JLwn/k3uu02W8dCiCl0qVspE75l4Q2/SefrW1Wo8q1ozPNZ2fD1ezATVqHXqfKuQD
         ZTmKusFa/4YvKSIgmdEDg+9d3YFEKFFLGQq71iMy+eQA3SXrSZrinZVbj6LBZWq9nQuy
         1MEHPSGn5PXOUaLNMBroEglnQ/B1bGUeR7hovP0E4LTruJo+sh5F8sZemJ+C6yzNe8K2
         r5NkUESragzvR1Rvt8BlpZH2lhoC+0eR1VzGU5kj8ZVjYobpS665YFSApydTWK6BBUrj
         snHg==
X-Gm-Message-State: AJIora/bM9h3oS7ZM0b2xM22+ruaN0KLPzOQnXjUkPxlail9zuJjpYFJ
        SXqCU7X7J1Df27rtJO1RJQYMIQ==
X-Google-Smtp-Source: AGRyM1uGmZa3ggEQq2uQallLk+xB7214xoVJTdr68AHyhKDL+T90KSQVTGjLmvfbGsqLYi//ucT9DQ==
X-Received: by 2002:a7b:c453:0:b0:3a3:1c65:ff97 with SMTP id l19-20020a7bc453000000b003a31c65ff97mr2285430wmi.180.1658128733294;
        Mon, 18 Jul 2022 00:18:53 -0700 (PDT)
Received: from [10.35.4.171] ([167.98.27.226])
        by smtp.gmail.com with ESMTPSA id a6-20020adfdd06000000b0021b970a68f9sm9888164wrm.26.2022.07.18.00.18.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Jul 2022 00:18:53 -0700 (PDT)
Message-ID: <a38e887f-fb79-349a-3985-35f1b603d105@sifive.com>
Date:   Mon, 18 Jul 2022 08:18:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 6/7] pwm: dwc: remove the CONFIG_OF in timer clock
Content-Language: en-GB
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Greentime Hu <greentime.hu@sifive.com>,
        Jude Onyenegecha <jude.onyenegecha@sifive.com>,
        Sudip Mukherjee <sudip.mukherjee@sifive.com>,
        William Salmon <william.salmon@sifive.com>,
        Adnan Chowdhury <adnan.chowdhury@sifive.com>
References: <20220712100113.569042-1-ben.dooks@sifive.com>
 <20220712100113.569042-7-ben.dooks@sifive.com>
 <bcbd1b29-7c6d-1d1d-2c72-b8818e99c65c@linaro.org>
 <77c97281-96d9-c969-18cf-6e609098aa57@sifive.com>
 <20220713061143.qvgt5wry3onbswlg@pengutronix.de>
From:   Ben Dooks <ben.dooks@sifive.com>
In-Reply-To: <20220713061143.qvgt5wry3onbswlg@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/07/2022 07:11, Uwe Kleine-König wrote:
> On Tue, Jul 12, 2022 at 11:20:23AM +0100, Ben Dooks wrote:
>> On 12/07/2022 11:09, Krzysztof Kozlowski wrote:
>>> On 12/07/2022 12:01, Ben Dooks wrote:
>>>> We should probably change from the #ifdef added earlier in
>>>> 49a0f4692a8752c7b03cb26d54282bee5c8c71bb ("wm: dwc: add timer clock")
>>>> and just have it always in the dwc data so if we have a system with
>>>> both PCI and OF probing it should work
>>>>
>>>> -- consider merging with original patch
>>>
>>> Missing SoB. Please run checkpatch.
>>
>> This was meant to be an RFC about whether it should be a single patch
>> or merged back into the previous one.
> 
> +1 for merging these

Yes, done for v2.


