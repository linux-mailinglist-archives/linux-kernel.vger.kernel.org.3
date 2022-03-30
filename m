Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EF994EBEB3
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 12:25:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245344AbiC3K1W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 06:27:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245338AbiC3K1T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 06:27:19 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDFB025FD6F
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 03:25:34 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id bg31-20020a05600c3c9f00b00381590dbb33so3148784wmb.3
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 03:25:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=HIWpi/8D1djUzx7THE7n67oIfPKGmrvE/SwlU2lSkLA=;
        b=lUWULG+IN08a/hn4fiOqt6bNpyrGelQJQQY1CO+dbSwLUb9LqmiaxxfEyaUmS1WD1E
         6Jh9UUc1S9Faj6gbNsE1UGXowCMXW9fox/hH8ydwEozmwmjHofa2kmtOeViq1U77opI2
         vWjMN/479f4tpGR1N/HBWVWKoSWriXnn5aTNLupu48ytgHgQfKXB5xNZ6wMEw6E/rd2f
         tga/3YYw9x4s3e7bXWWAxkM0GhNB8rXBdc0zwV20vnf/aqnBi6V5jV5sUyOQnWEhRkAA
         gGWeg1S5vX7034R0tAt8JAAr98CdjhB+5x56eT4ZrVkfDpatE41YlX20jXiou0JSMMot
         gnrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=HIWpi/8D1djUzx7THE7n67oIfPKGmrvE/SwlU2lSkLA=;
        b=iho6tb92KWlTzqjt52VHUsjWeVENWid02QqdhyXVJNAiZB6jb1bR6cjIkATdzKoEC/
         pxoD7tEnV/NgDQyWpofHuL+Dcws9lao2QqKeo3CYSQ3VU9jIyEtk83MQaBYHqhvWNCeR
         eWg5dFekddXzYx8J7A05f/L0pLgElpKUpLOWmVadpmeXs1wO/3uZ2czkBXD3X1lZz/t8
         Py+0nViJAvcWDjkpCKvAre8ldHC6G/t7yb4RpTDSSqjPKxGteQGs5/NxiH7Tcj4ZATRL
         f1OIGzpzv2UvidR7ad3fBPO8CcDeX44oKb5o8dWeDaJIpZKf+DWPppQNjJVr8odp2gzk
         GJdw==
X-Gm-Message-State: AOAM530ePUCYvLMBF8E8DSlH+qZ45aL4wUq/1FFfRGlmHdbrVXwkNGjD
        8tYGsght/tI5zBqt3q5cYJgkjg==
X-Google-Smtp-Source: ABdhPJyG1sVXUz6I5tf6C8RXiwYzb3kTwXz6SO1D1h3jIBPDn8sAoDtDK/poWTpvBTCo65fGctX0OA==
X-Received: by 2002:a05:600c:34c5:b0:38c:30e3:1e6c with SMTP id d5-20020a05600c34c500b0038c30e31e6cmr3824774wmq.144.1648635933279;
        Wed, 30 Mar 2022 03:25:33 -0700 (PDT)
Received: from [192.168.86.34] (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.googlemail.com with ESMTPSA id g10-20020a5d46ca000000b00203fd86e198sm16609627wrs.96.2022.03.30.03.25.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Mar 2022 03:25:32 -0700 (PDT)
Message-ID: <b59fd0f0-cedd-dc48-52bf-090358ce7786@linaro.org>
Date:   Wed, 30 Mar 2022 11:25:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 1/3] dt-bindings: mmc: mmci: add a property to disable DMA
 LLI
Content-Language: en-US
To:     Linus Walleij <linus.walleij@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>
Cc:     Yann Gautier <yann.gautier@foss.st.com>, ulf.hansson@linaro.org,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Christophe Kerello <christophe.kerello@foss.st.com>,
        Ludovic Barre <ludovic.barre@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Russell King <linux@armlinux.org.uk>,
        Marek Vasut <marex@denx.de>, kernel@dh-electronics.com,
        Grzegorz Szymaszek <gszymaszek@short.pl>
References: <20220304135134.47827-1-yann.gautier@foss.st.com>
 <20220304135134.47827-2-yann.gautier@foss.st.com>
 <CACRpkdYQz+-im3n-r0_8RKL7so2bHS=aZobty4BbzixmPzms-Q@mail.gmail.com>
 <0bc53018-fce4-4104-fa47-6e60d2367d69@foss.st.com>
 <20220329153114.GA58120@thinkpad>
 <71b10ce2-7b87-14d5-c8e4-3a4598c889e0@foss.st.com>
 <20220329173322.GC58120@thinkpad>
 <CACRpkdaiOhMGzuWPwoRLZ05HyM8BO_-cZt4TiAqAYQvDaJA-mA@mail.gmail.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <CACRpkdaiOhMGzuWPwoRLZ05HyM8BO_-cZt4TiAqAYQvDaJA-mA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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



On 29/03/2022 22:16, Linus Walleij wrote:
> On Tue, Mar 29, 2022 at 7:33 PM Manivannan Sadhasivam <mani@kernel.org> wrote:
>> [Yann]
>>> As for Prabhakar's answer, the IDMA here is inside our IP, and not used in
>>> any other IP. So I'm not sure it is really relevant to move that to another
>>> dmaengine driver.
>>
>> Okay, I think this justification makes sense. I was worried of DMA IPs that get
>> sandwiched into many peripherals like the one on Renesas platforms. It turned
>> out that each subsystem has to add internal DMA support for it :/
> 
> That is a justified worry.
> 
> Qualcomm has "BAM DMA" (I think it is called?) which is added to each IP
> that needs DMA. drivers/mmc/host/mmci_qcom_dml.c
> It's for older Qualcomm platforms but I *think* it is actually not just used
> for the MMCI, just noone ever got around to adding it to any other
> peripheral? Srini do you know?

There are multiple instances of BAM (Bus access manager) on Qcom SoC, 
some of these instances are dedicated for each peripheral instance.
In this particular case we have 4 instances of BAM each of which are 
dedicated to 4 instances of SD Controllers.

BAM dmaengine is used across many Qualcomm peripheral drivers.

--srini

> 
> Yours,
> Linus Walleij
