Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34AED58C341
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 08:25:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235970AbiHHGZv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 02:25:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235837AbiHHGZt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 02:25:49 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 736C4634C
        for <linux-kernel@vger.kernel.org>; Sun,  7 Aug 2022 23:25:47 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id z6so3782850lfu.9
        for <linux-kernel@vger.kernel.org>; Sun, 07 Aug 2022 23:25:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=z8c+nGdXCtSyoS1Lq3ADyegDLTS/6+jKQLvmXALH/Tg=;
        b=cJ7S3O7sbSq0E4BszRrgR7uv+r9M045/EES38w0uQaZiNBs2uKIqlSiVWMqhtsNl9/
         itLxj+59UKFlN60rtEGfxqlyLhJioBURBdTwHjEN7GRNVLQ4ww3twgBF3v9S3RE2Q3IE
         Bh/T88wn1WaROlaPieJ0zkkxpxeJP4cCJw16F7x9tifxGWppDW2codpsAwgbaPPh6yFR
         zxtM06H12XfYWCvzjxC01KxZu/9U4AQdaHGNjMsfauuE96xlZGgRN7ld4M5jlKcJVbg8
         r/2vcpSlnnlbupZ4NrUoRhoWNLr31m3RLJtzJLCdU2XGtslrdF7xNYYP+njmrJz4wRLs
         gP2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=z8c+nGdXCtSyoS1Lq3ADyegDLTS/6+jKQLvmXALH/Tg=;
        b=Dubg81Rhm0MM0Uypo7nSOOWjtY1d9ewliHkCh8CQP/2edpU6RRYFzSJ/GMXMtOcTXw
         /ALMrx4v/E2YIuZHaZlE90VUZelVp5h2OgoqQy250OOZvLxXBoTR3Nt35DVKjSFHzsVA
         560aqP0xDAE4xxNCdM/40bMCKhGZVwSNM6r1nTrmQXeLfT2/PrBLHJofBUKw6XbLTVwJ
         4LWlP4wnIKfQndV6Irs/NXpmuQwQn9g4M/k8LPOxgPj2iJcUACljdgN+V3lw/XrgPJkQ
         wsyj099FJDP+eTxuvgeM/GjCBicSXxilVnWIdl7tfGrEUwynj44upai5KEtGBrgBpvfl
         yrKg==
X-Gm-Message-State: ACgBeo0u+Q9owc3PJ0m2cOWg8srC71Nukir+Nb4iRtSA60zfixXof4PN
        7N4I9C8vZoG9jhg+62vTO0ba/Q==
X-Google-Smtp-Source: AA6agR4LICjSd+r7ACtHJpR5eKFuof/7wXOtfdE8s4zpr4yPJmEhRJ4wrJHcmZoo/I65oE0Xt/czcw==
X-Received: by 2002:a19:7b1d:0:b0:48a:f0f2:cd with SMTP id w29-20020a197b1d000000b0048af0f200cdmr6311176lfc.533.1659939945853;
        Sun, 07 Aug 2022 23:25:45 -0700 (PDT)
Received: from [192.168.1.39] ([83.146.140.105])
        by smtp.gmail.com with ESMTPSA id g25-20020ac24d99000000b0048b052a7980sm1307779lfe.168.2022.08.07.23.25.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Aug 2022 23:25:45 -0700 (PDT)
Message-ID: <c5458546-8000-bd7f-8526-2ad4716ff30f@linaro.org>
Date:   Mon, 8 Aug 2022 09:25:44 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v2] dt-binding: ipmi: add fallback to npcm845 compatible
Content-Language: en-US
To:     minyard@acm.org, Tomer Maimon <tmaimon77@gmail.com>
Cc:     Avi Fishman <avifishman70@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Joel Stanley <joel@jms.id.au>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        openipmi-developer@lists.sourceforge.net,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>
References: <20220804181800.235368-1-tmaimon77@gmail.com>
 <20220805115827.GG3834@minyard.net>
 <CAP6Zq1gfvEpUF-TKhA8EdJqBtwaVvJR3qxtn=8Li4swHB6sDYQ@mail.gmail.com>
 <20220807121138.GL3834@minyard.net>
 <CAP6Zq1iL7okjGU8_-CnrBnRUzjLKPD8FNw_oYso-jbthbeR1iQ@mail.gmail.com>
 <20220807160545.GM3834@minyard.net>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220807160545.GM3834@minyard.net>
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

On 07/08/2022 18:05, Corey Minyard wrote:
>> We had a disscation with Arnd, Arnd asked us to use a fallback as we
>> did here if NPCM8XX device module is similar to NPCM7XX module:
>> https://lore.kernel.org/lkml/20220522155046.260146-5-tmaimon77@gmail.com/
>>
>> I think we should use a fallback to describe the NPCM8XX KCS in the
>> dt-binding document.
> 
> I'm ok with that option.  I guess I should have mentioned it.  Add
> nuvoton,npcm-kcs-bmc to the driver's of_device_id table. 

To be clear - NAK. It's not a specific compatible, therefore it is not
appropriate at all.

> Then use that
> in that compatible string in the device tree.  Leave the 750 compatible
> string in the table for backwards compatibility.
> 
> There's no point in having a bunch of those strings if they are all the
> same.  If a new one comes out that is different, we can handle that when
> the time comes.\
There is a point. It's exactly how we do in all DT bindings. It is
recommended by writing bindings document.

Best regards,
Krzysztof
