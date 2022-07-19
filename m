Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B793B579596
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 10:51:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237123AbiGSIvu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 04:51:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234102AbiGSIvs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 04:51:48 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11EEC630D
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 01:51:47 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id w2so16561676ljj.7
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 01:51:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=uqcRTuP1/PnGezTwWXCroNTFnUr7WJ9h67m5Xsh5Hxw=;
        b=l/faQxKkdi5hUB6G5DNbfbqIGHVvSpAbQT9Rg4zT/ryIJkTpV+jOApo+PlhpBTrx0n
         X3z3CSyQSLW7SY8amqf6ovDcc6CJdVVnQTUCv1PN/YktasNAQHCUma6JukHuNUhxH3gt
         ATfDpo/rwF/oKlBFqwuIzQT3r9liX9JlNKA77Auu+69QErkJ2IYigq62nyW1qUHvLN8u
         l8DgN1akuPl3IwRiMwKJTP/DwSPe43D+IEtQGFdXWg5iLbd7zbHy88qmeuslKS+yjaND
         jSWM5/oW9BBPyT/dMLV4DWtwEXKD5ox1dRB6G5gXq7b1qRRLPRQJ+XKdakR6isD6owOj
         Kb+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=uqcRTuP1/PnGezTwWXCroNTFnUr7WJ9h67m5Xsh5Hxw=;
        b=eqosKnL/ltKqvT5VZ3eADrYGy2GbBeleHSSoZe3eIPYD+hBP8UWzit2Qte4byd7Qmv
         HStzZ8y67X+q5Bqb4cLZtEgefCFWAjFUI+0GMUb43AMqmRs85DOGf53td/7ObNf/d0TH
         eq/kcfoiJvp6DRlCa2oikixVC4D1EYmHj4Hf3vJF8us+14VnvLXjCB1mTLMhBB1vCtJ8
         ojrTqKM1wtNWnG7MdNFeBnyXEBlznykWtr6fdWrbmDmCyDuxZ/A7cE9kal1sWBmdLEUT
         KBI2P4SK/VSYY0DQYUQD1018z+auFW+R3J7XoUQXFOwm2uNVVinHRnROXkPDWbOf0uP0
         Iv2w==
X-Gm-Message-State: AJIora/mtlxbESI8+94DnkqG5V9xtdCtSpm8PrTG3vVJkCpeDan281JA
        eaJDmmbf5nywzQ/Yv7tDiTrsHBhc/P1I1FA0
X-Google-Smtp-Source: AGRyM1svSYUmExybb+FbIdf157mpyQkfESF1g+5aJMvkWEtloGT+FhH9OSX0U3lMBgz2JcWCf01LkA==
X-Received: by 2002:a2e:b015:0:b0:25d:8fc7:9ed9 with SMTP id y21-20020a2eb015000000b0025d8fc79ed9mr13990159ljk.483.1658220705485;
        Tue, 19 Jul 2022 01:51:45 -0700 (PDT)
Received: from [192.168.115.193] (89-162-31-138.fiber.signal.no. [89.162.31.138])
        by smtp.gmail.com with ESMTPSA id a1-20020ac25e61000000b0048a2995772asm2238006lfr.73.2022.07.19.01.51.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Jul 2022 01:51:44 -0700 (PDT)
Message-ID: <87da11a0-65e3-4b89-8209-fa470b09c67a@linaro.org>
Date:   Tue, 19 Jul 2022 10:51:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 1/3] dt-bindings: timer: renesas,cmt: Add r8a779f0 and
 generic Gen4 CMT support
Content-Language: en-US
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-renesas-soc@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20220713100603.3391-1-wsa+renesas@sang-engineering.com>
 <20220713100603.3391-2-wsa+renesas@sang-engineering.com>
 <62b1f1bd-c15d-662c-027e-1cdeff5eb580@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <62b1f1bd-c15d-662c-027e-1cdeff5eb580@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/07/2022 00:35, Daniel Lezcano wrote:
> On 13/07/2022 12:06, Wolfram Sang wrote:
>> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> 
> Krzysztof ?

You got now Rob's. :)


Best regards,
Krzysztof
