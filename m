Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B41EF52D18D
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 13:34:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237479AbiESLdv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 07:33:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237446AbiESLd1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 07:33:27 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14D9FB0A50
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 04:33:25 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id l13so1934585lfp.11
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 04:33:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=oZEhROINlJWM7vdViG2IE8Bwfk0C1vKAbaV7Oeo94UQ=;
        b=EGYii0kO3qs08FhyjVI9Y2ePF+IohLbIeqqa7oK57S3FHkA5RVZPqNblDLIW75kFcH
         6oX9s2gDFeGn/Roq1TarZsxyRUt40VFfb5c7GuE3GAwRVG6wR8/7g+uoxQtyoal+s1Bb
         DURdbTlR841WX2Cbo1oPkbROxz3gHWrGzyDokChBKsDSyyNLlTTlKnxN/3AY28EWxs81
         7LfNbBhSuRzanMHZYwj8TfSLIbfXB9SULTllFtS5cdp1cEyf+zg05PoipkxYaZYsOqld
         9XXXp7qDW7uDXI0zwLWNUMJpf5xEn0ESsqk27e/JgyB/aRM43jaj70OtEgW7UJkTnhV5
         lftQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=oZEhROINlJWM7vdViG2IE8Bwfk0C1vKAbaV7Oeo94UQ=;
        b=ldVw3tJRZkUBqe1rFaEGTFhtX3hRjfDb71VYf1xX6WKOCZ/97/DYOMviLHu8dp8G5x
         /1bf7FjHIbpBlX4hpbzNgrsZi4oWPWl09+sgEN1wg90emS7x2XFKR0FXVbRlZS6YPn18
         MiqlSHk8ijvfD5D7wAk5lLAHICkFi0DgKOGNvv03rZIyvmonOZnID3RmaVsZ56CINFT8
         MtmYUgFoanti44e5OvduzNKG1WV/uHue+E1FU+W67lLcNcK1ipaUdVgQH5H0o9deRR6f
         pt/vKoUdYda2QnEM/t47OunCczYLQbuMkI3H+K6WvHcJAv8KcGOyOjhVE6Eq5d5TtsNL
         ghoQ==
X-Gm-Message-State: AOAM530BzMTfa/E/s0xmdm9HoUzhMViYti4B3bWsqoQdA25dzBp1QR9R
        BZDCFeCpnbnEriR1/rzoIL9yFA==
X-Google-Smtp-Source: ABdhPJyUim5e9pHHMifbYzMw77E1dUklze9AipVmBtmLAVQKy142zJwXyX5rENYYXJsuBfOx5tzKxw==
X-Received: by 2002:a05:6512:2215:b0:473:c124:434b with SMTP id h21-20020a056512221500b00473c124434bmr3049278lfu.24.1652960003454;
        Thu, 19 May 2022 04:33:23 -0700 (PDT)
Received: from [192.168.0.17] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id 189-20020a2e09c6000000b00253b5bb829esm556593ljj.98.2022.05.19.04.33.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 May 2022 04:33:22 -0700 (PDT)
Message-ID: <c74b0524-60c6-c3af-e35f-13521ba2b02e@linaro.org>
Date:   Thu, 19 May 2022 13:33:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v2 4/5] dt-bindings: net: Add documentation for optional
 regulators
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>
Cc:     Corentin Labbe <clabbe@baylibre.com>, andrew@lunn.ch,
        calvin.johnson@oss.nxp.com, davem@davemloft.net,
        edumazet@google.com, hkallweit1@gmail.com,
        jernej.skrabec@gmail.com, krzysztof.kozlowski+dt@linaro.org,
        kuba@kernel.org, lgirdwood@gmail.com, linux@armlinux.org.uk,
        pabeni@redhat.com, robh+dt@kernel.org, samuel@sholland.org,
        wens@csie.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@lists.linux.dev, netdev@vger.kernel.org
References: <20220518200939.689308-1-clabbe@baylibre.com>
 <20220518200939.689308-5-clabbe@baylibre.com>
 <95f3f0a4-17e6-ec5f-6f2f-23a5a4993a44@linaro.org>
 <YoYqmAB3P7fNOSVG@sirena.org.uk>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <YoYqmAB3P7fNOSVG@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/05/2022 13:31, Mark Brown wrote:
> On Thu, May 19, 2022 at 11:55:28AM +0200, Krzysztof Kozlowski wrote:
>> On 18/05/2022 22:09, Corentin Labbe wrote:
> 
>>> +  regulators:
>>> +    description:
>>> +       List of phandle to regulators needed for the PHY
> 
>> I don't understand that... is your PHY defining the regulators or using
>> supplies? If it needs a regulator (as a supply), you need to document
>> supplies, using existing bindings.
> 
> They're trying to have a generic driver which works with any random PHY
> so the binding has no idea what supplies it might need.

OK, that makes sense, but then question is why not using existing
naming, so "supplies" and "supply-names"?

Best regards,
Krzysztof
