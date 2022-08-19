Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E81DC599D65
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 16:18:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349366AbiHSORZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 10:17:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349216AbiHSORW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 10:17:22 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0160A026D
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 07:17:21 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id m3so655011lfg.10
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 07:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=ZP7/pN9LQxTPvYxi5HKb2nXXnhaq2Nc8r+By7c+Y8XI=;
        b=iJnvZwROEr7eyVt42APRy3CDs3DwcP72OtirjShu7JD4apfi/c9NR4HAHeHpX3tJlg
         TcaazsqTdt2Tg2ZNfkjSf1K3zEI/2TJePtXRR8cgdyh/8+3SIluNfG0wNw3cnu6eDaW7
         TYJ0WMdAWhQ7sCsVSoDtN7pg8067CAPao4/iWR/uXyIaA3fjAmimrHYrOCVqpBiuKY56
         qP7GZ2anmhxPVmFptQVyJWrhJR8awQCbBcvuV2br2DX7YJxD5/rtLrX5sF01A6jPjjUy
         6U45Ni4SFWdTKH5tvIzjFzmmPlGGgyDmAhdxibPjqGvY8N7w8HGrEsYUID5+DfrJdxYR
         1o5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=ZP7/pN9LQxTPvYxi5HKb2nXXnhaq2Nc8r+By7c+Y8XI=;
        b=wc6B0NoDIK6eqFjS8RHYJFdcPQpMMIL1xLWjGZ/Wt2FV5Ee71wfAGof/+kDF5Hy+hv
         2cv341gfqm6KZE8ewyzeQKEWNznLERQ4hNCmEiIbIpzmly8IWJj40Ve5MZOaKAzqcpEo
         z2szuuNmfMMkHkcbP2aTslxAAI88fSdPoTwDu39eYWEUyLyR8SzsRh+93tk8vlWKYzpv
         Xut1PtYLPj+hbHxYgBGPBnmGeMC8oqKxslDP7TIyAkc5AwjPt499SXUze3RIu5MuAlPf
         KL7yNFPE5+qQ6ucm03oqd2IsI5+JDhw6+3hvmrcrK6Z7t7W1Uy1CQiQbZ7nmVShMyq7s
         5SmA==
X-Gm-Message-State: ACgBeo08omqDKU4gdcpdmtlxtkmIfmGaQ+9pcFow+FQmqkUZemaScBIL
        qdyJSLMfiNQNgQ5iYu55nBCmSA==
X-Google-Smtp-Source: AA6agR4mQVqG+Lw9A96QRROjP3Cx8kJfoZ3CvE8DSd7qh9uGbqoOd+4+PPlHX1LIHOJfMNnfJSg27g==
X-Received: by 2002:a05:6512:3fa4:b0:492:34ba:e9fc with SMTP id x36-20020a0565123fa400b0049234bae9fcmr2432323lfa.174.1660918640222;
        Fri, 19 Aug 2022 07:17:20 -0700 (PDT)
Received: from ?IPV6:2001:14bb:ac:e5a8:ef73:73ed:75b3:8ed5? (d1xw6v77xrs23np8r6z-4.rev.dnainternet.fi. [2001:14bb:ac:e5a8:ef73:73ed:75b3:8ed5])
        by smtp.gmail.com with ESMTPSA id v19-20020a2ea453000000b0025e87b1fdbcsm611027ljn.63.2022.08.19.07.17.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Aug 2022 07:17:19 -0700 (PDT)
Message-ID: <a0a34ac8-4b62-4e69-f16f-7a51132a3987@linaro.org>
Date:   Fri, 19 Aug 2022 17:17:17 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v2 1/4] dt-bindings: sound: Add Apple MCA I2S transceiver
Content-Language: en-US
To:     =?UTF-8?Q?Martin_Povi=c5=a1er?= <povik+lin@cutebit.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Hector Martin <marcan@marcan.st>,
        Sven Peter <sven@svenpeter.dev>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        asahi@lists.linux.dev, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220819125430.4920-1-povik+lin@cutebit.org>
 <20220819125430.4920-2-povik+lin@cutebit.org>
 <AE646B68-CA14-483C-A1AB-30358560DAAD@cutebit.org>
 <8472463e-d99a-d0f6-9551-45a79a15f567@linaro.org>
 <737767DD-CB70-4941-8CF5-497333D3A801@cutebit.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <737767DD-CB70-4941-8CF5-497333D3A801@cutebit.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/08/2022 17:14, Martin Povišer wrote:
>>> Since it was brought up last time but I didn’t respond: the
>>> nonalphabetical order is as the chips were introduced (and
>>> matches other schemas).
>>
>> Sure, just keep that order for future compatibles as well - so always
>> put them according to verifiable time of market introduction...
>>
>> This is very poor reason, instead of alphabetical order. Even worse
>> reason is repeating wrong pattern just because someone else did it.
>>
>> Best regards,
>> Krzysztof
>>
> 
> I don’t see it nearly as clear-cut. Adding to the end seems pretty
> foolproof too, but OK, next submission will have it alphabet. ordered.

The concept is the same everywhere, be it Kconfig, Makefile or other
lists. If everyone adds at the end, you increase the chances of
conflicts. Having alphabetical order usually means simultaneous edits
will happen in different places.


Best regards,
Krzysztof
