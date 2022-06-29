Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A90A55FE47
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 13:13:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231401AbiF2LMp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 07:12:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229952AbiF2LMn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 07:12:43 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08AB6366AC
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 04:12:41 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id q6so31778810eji.13
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 04:12:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=ZklBbrhWeRu7F0FN0Aat62/hrdRJUTCtSkFm/hGOW5k=;
        b=Cn585zu3809Rjl4M/+WAgSXANgY9EbR6kBiumg85SPIlAFcp2ij9ntr7mWL+wma/Oh
         xXudPLJponuwkVBdm8CrU7H9IzMb8oRoeS+Frzi1yT1RvMofP0FgwTCn2JvUdez3GKCA
         2O++VwJNa3uaaMZZdor2aoP0ayFFqYKbaUab2mqH2+kRRweYywTidyl3+g9bRtiIzMDe
         a6Iu0JEPBZnPEARMY6JaS+uzcTT5jxphvnqyaJHkPrQ6VY07IoMVtcAsgs1yHz2/Kexv
         d7m2dut6jAWbcPaqcx/aQppAFTGVSa8ue73kHVkRud5H9d3/DNt+RX9ViNIwLUwYZ/Yi
         npHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ZklBbrhWeRu7F0FN0Aat62/hrdRJUTCtSkFm/hGOW5k=;
        b=tdcGT6M0EDmAlBjBFRzFl2DKUQCuNjIgsoDpfB6joK/eamdPrkHPF9Kmn87xlnZdxN
         Xvgt305yGMNZWG+2LykWa1BWxhOYuYc0OcMtdbG3jdChEZTSKWFpUDVlB/X4bc1VqUnd
         +eTdrJGIWApnqtWiLQGp1Be0iz2BJCSSSzLC58WxdC6rWLEo1FgMVqR1P0I1QOjanxBf
         RWuzPWzUQPNuZzsSDnukEVio/8rOn0KE0cWW7slIAY5U1Krae208b693ib+KqQ+/RbTb
         y6BcHsg6d1pZm2IMwRA4LZsrkkZjoi4lSa6hzgb4vu54VhCIKBuXBg66n63yrAVteNz8
         4K+A==
X-Gm-Message-State: AJIora8skdUBEfWL7d3rmrTnmBr4jd6o0j72ebGV175r1hXoaAw56KSY
        ZymAFXBILkfZudoZXyYhKO/0NA==
X-Google-Smtp-Source: AGRyM1scRNZiTlfpuZxRNQgJz5mgfY4et1r59dsU2jOJq3RWl2MpKqBbzxXhl1VxC9ZRgy+vujVKEw==
X-Received: by 2002:a17:906:6448:b0:723:2e05:af41 with SMTP id l8-20020a170906644800b007232e05af41mr2735760ejn.423.1656501159622;
        Wed, 29 Jun 2022 04:12:39 -0700 (PDT)
Received: from [192.168.0.184] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id s1-20020aa7c541000000b004357171dcccsm11162081edr.12.2022.06.29.04.12.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jun 2022 04:12:38 -0700 (PDT)
Message-ID: <3ad4876b-1efa-c4c4-2139-3823cf80ff68@linaro.org>
Date:   Wed, 29 Jun 2022 13:12:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v3 2/4] dt-bindings: arm: msm: Convert kpss-acc driver
 Documentation to yaml
Content-Language: en-US
To:     Christian Marangi <ansuelsmth@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>
References: <20220628184137.21678-1-ansuelsmth@gmail.com>
 <20220628184137.21678-3-ansuelsmth@gmail.com>
 <e625e2c9-7321-51fa-b9bb-40ed9742ffcc@linaro.org>
 <62bc2c1d.1c69fb81.09d2.e244@mx.google.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <62bc2c1d.1c69fb81.09d2.e244@mx.google.com>
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

On 29/06/2022 12:40, Christian Marangi wrote:
> On Wed, Jun 29, 2022 at 08:14:12AM +0200, Krzysztof Kozlowski wrote:
>> On 28/06/2022 20:41, Christian Marangi wrote:
>>> Convert kpss-acc driver Documentation to yaml.
>>> The original Documentation was wrong all along. Fix it while we are
>>> converting it.
>>> The example was wrong as kpss-acc-v2 should only expose the regs but we
>>> don't have any driver that expose additional clocks. The kpss-acc driver
>>> is only specific to v1. For this exact reason, limit all the additional
>>> bindings (clocks, clock-names, clock-output-names and #clock-cells) to
>>> v1 and also flag that these bindings should NOT be used for v2.
>>>
>>> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
>>> Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
>>
>> This is still not fixed and not tested. Since 4 versions of this
>> patchset (previously was part of other set).
>>
>> I retract my review. Please test the bindings.
>>
>> Best regards,
>> Krzysztof
> 
> Thing is that I tested them and on my side I don't have such errors.

Then maybe update your dtschema because I can easily see them.

> 
> I'm using the linux-next branch. Should I use something else that have
> newer schema files?
> 
> Also on other patch there are some error reported that are unrelated to
> my change and that looks strange.

The other might be not be relevant, but this one is real and reproducible.

Best regards,
Krzysztof
