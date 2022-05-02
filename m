Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C7245177DD
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 22:18:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387270AbiEBUWH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 16:22:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352110AbiEBUWF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 16:22:05 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45E80BF7E
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 13:18:35 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id y3so29737257ejo.12
        for <linux-kernel@vger.kernel.org>; Mon, 02 May 2022 13:18:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=jDGt1toRucqj+cK6LtNSDQpKseZ2xT2PNfCkDdoqIXE=;
        b=toBxE4V5+mFB5bvYet/OhPmOhK4Dutdz6f3lm5zbVetmSHCSlhSLvBVNiz8TAwVzXN
         aePuCPComJN8lKFroxUwx9Htebi/8fzhYomJ9Gsa/PNEG64fr9+oaVlGQlZivSwaGgdl
         5rY2/534CchDq7QF40I+nmtdZDV9nWUoHPb+G9bhMWCijpAzr4kuz/gJ62/Lg07Ijqmh
         hIqlhmZbE4q1LXe//1okxmwS4XpZFKQXb+lPF0FUCG/uIEHQ9ALZuS9DXRy8L8v5K3Zi
         yRiNkbam2C3XZ3Zn1P0+JsqSo2Sx9dDlRTl605GlmE3dHi5CmXdlSjIRp4vOKbV9TV9A
         DRHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=jDGt1toRucqj+cK6LtNSDQpKseZ2xT2PNfCkDdoqIXE=;
        b=jrmOUhVK2/kN6VQgtlVu6LwKnwwpZ/LDQ5+uZ2G/VCQB2kbq2w3hIzXGcYzhRhHX2/
         gknRsvuDYDyFqder9xDbiGK2joKDSrhEmQYJpqXA3ozeykqf9QhhvXAplBfN+1zBzPlV
         WrgqDROuBEuZ5k0By1fc3s8/OXsa1EHrGe22zqxnG5ftTn9ZL8BHziWYUZxS3PAAAKMt
         r+DEM5A12AA49W9btl6svBMgfcPY4JaZUSq4dIRHYG9Rf9jxPe9weUr+mW2RE3hs9nl/
         5rUvgFXW0PEvPoaqrMjK8fhtDv7wcrspSj6iWXTCqen7zRvqNgP1s15H58ue93qyAWX8
         RDVw==
X-Gm-Message-State: AOAM530Mlsz3XiteJG6fxwCGbuVIdLIdOks5OoFemNjAGJSwyx2KNwMc
        Z7FpI8qbFtRmqIPUo7oCBGKWSQ==
X-Google-Smtp-Source: ABdhPJwAYb0fylLmk7MP2C/59GviEWpwlDWkT4/97mN4Lqiw2X3v8TDzbdRlW7U5Ma537L+RGk5mfg==
X-Received: by 2002:a17:907:c0d:b0:6f3:ed89:d9c with SMTP id ga13-20020a1709070c0d00b006f3ed890d9cmr12526499ejc.502.1651522713790;
        Mon, 02 May 2022 13:18:33 -0700 (PDT)
Received: from [192.168.0.197] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id d12-20020a50fb0c000000b0042617ba6399sm7002590edq.35.2022.05.02.13.18.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 May 2022 13:18:33 -0700 (PDT)
Message-ID: <b3bda9d7-2c50-547d-35ab-510ecab4f7d2@linaro.org>
Date:   Mon, 2 May 2022 22:18:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2 3/3] dt-bindings: arm: msm: Convert kpss-gcc driver
 Documentation to yaml
Content-Language: en-US
To:     Ansuel Smith <ansuelsmth@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org
References: <20220430060125.9124-1-ansuelsmth@gmail.com>
 <20220430060125.9124-4-ansuelsmth@gmail.com>
 <fec305d1-d4b3-3f9d-bc31-bc33490d1ad7@linaro.org>
 <626d4cbf.1c69fb81.e6965.76b4@mx.google.com>
 <0711b822-506b-7b90-6b63-50c5c0ce4f6e@linaro.org>
 <626fb971.1c69fb81.fcab0.5f71@mx.google.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <626fb971.1c69fb81.fcab0.5f71@mx.google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/05/2022 12:40, Ansuel Smith wrote:
> 
> The idea is that you put the clk name in 'clock-output-names' and the
> driver needs to have support for it (and set the clk name based on the
> name defined in the dts)
> 
> This driver doesn't have support for it and is actually hardcoded.
> So you are right and I should just drop it.
> 
> But now another question... Since #clock-cells was added as a
> requirement for clock-output-names, should I drop also that?
> 
> In theory #clock-cells should always be declared for clock providers, is
> it right to add it in the conversion commit or I should put this change
> in another commit? (since it's now an addition and now something required
> to fix a bot warning)

These are not the best bindings to convert, if you are not into the qcom
DTS and drivers. :)

It looks like the bindings were added to match current Linux
implementation and in this implementation the device is not used in DTS
as a clock provider (even though it registers a clock) but as a syscon.
I am not even sure if it is used as a clock provider outside of DTS
(through using a fixed clock name in some clock consumer).

Probably this should be made either a proper clock controller or
something stripped down to the point matching current usage (accepting
the fact that bindings are incomplete). Anyway your choice should be
made according to how this device and its driver fit to entire system.
IOW, it's not a simple binding conversion and you should not just
convert it to make dtbs_check happy.

Best regards,
Krzysztof
