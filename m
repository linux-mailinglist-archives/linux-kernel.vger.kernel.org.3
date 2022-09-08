Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 351FA5B1B98
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 13:35:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231387AbiIHLf0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 07:35:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231386AbiIHLfF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 07:35:05 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8F1F3AE4A
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 04:35:02 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id y29so6926367ljq.7
        for <linux-kernel@vger.kernel.org>; Thu, 08 Sep 2022 04:35:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=rGbehmmbFjGdP39Tva2lX3JsZ3RKZXRTihQXkTFVj0Y=;
        b=u6D+fKJ2Lhfyp6EpZaftp621lBz6Wd859kwOBiqFQ3lUxvV9CWJbk8wOUpHBKAnWOJ
         Ay19wrgdZbZWV7IS7+EwTdDnyzs1gQo+vI4ToLdDyGdhHkq1VlOwt7MAYkg9PE1lU6qo
         F16V9/sqUWF0TWbcg/8py5MBiAGP+i7UlE06Zvuba3U2XsCSkq0BGs6XNK1XPEcmncx3
         j5w4fQ2F/4zInUlUf2dTKh4Myma9gGm+JZNaFR8GdOtrtDQwJ1WGRKxb5AUbN+YFwZap
         w16k9HfAxB5IseMpsnbuKf1KdTr3ZczXUc4GMFHag3eMo9Kbo/zinntSpaM1kmLh/0h9
         UmPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=rGbehmmbFjGdP39Tva2lX3JsZ3RKZXRTihQXkTFVj0Y=;
        b=Ll5nm/cxjHRg8R4xNI+TF411pBgTw3miFkvElRFg2O+nt10V2jFEf24ES9/ILju7lO
         6SJtPfJUlNC0ospSwIuE4U8II+lgeulMqh0928yVDy61yTzxiKBcZfnwPnjyymUJGjdU
         m/oP/3oHuLRK3jXWop915Mxes4wRIsgL1nGdaD6tztaG3qn5vNA2xrVYWhQvSHvsB4Kz
         G40iffzm+Hbe7QnqoNQovGkB1izbvP0IkrpVLJwSif6RTtAFqJ2h/Fo2FoiqgTFaoiJp
         gxZ58Qhe81GSapyOEYd/KXhnBqP3mF+LekGIFOQlQjSNcTIIY1nyb8t+Q214E6PVM8JT
         XlHg==
X-Gm-Message-State: ACgBeo1dNaiiPdjmU+lQW+diBW1kcujK1jrhKQkQ9GmBQRxKt6oQ8r1X
        ydqHGGFEmlsAU+JrRo4FDnFuTw==
X-Google-Smtp-Source: AA6agR4ui+DsaI/rx9G71gnDc6YAJvWKPoB3zCyZaJ1nLjK+vVvOPNBMn6vOY0NTUCUZDxAiUFpecw==
X-Received: by 2002:a05:651c:1a26:b0:269:15ee:809a with SMTP id by38-20020a05651c1a2600b0026915ee809amr2203010ljb.307.1662636900510;
        Thu, 08 Sep 2022 04:35:00 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id v25-20020a05651203b900b00497aae401f8sm770409lfp.184.2022.09.08.04.34.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Sep 2022 04:34:59 -0700 (PDT)
Message-ID: <d0dacbf4-3768-7bbf-77a5-957bb37cd2b7@linaro.org>
Date:   Thu, 8 Sep 2022 13:34:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v2 2/5] dt-bindings: net: Add Broadcom BCM4377 family PCIe
 Bluetooth
Content-Language: en-US
To:     =?UTF-8?Q?Martin_Povi=c5=a1er?= <povik@cutebit.org>
Cc:     Sven Peter <sven@svenpeter.dev>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Hector Martin <marcan@marcan.st>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        asahi@lists.linux.dev, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220907170935.11757-1-sven@svenpeter.dev>
 <20220907170935.11757-3-sven@svenpeter.dev>
 <bcb799ea-d58e-70dc-c5c2-daaff1b19bf5@linaro.org>
 <E53D41D9-1675-42EB-BC76-3453043FCB6E@cutebit.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <E53D41D9-1675-42EB-BC76-3453043FCB6E@cutebit.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/09/2022 13:29, Martin Povišer wrote:
>>> + brcm,taurus-cal-blob:
>>> + $ref: /schemas/types.yaml#/definitions/uint8-array
>>> + description: A per-device calibration blob for the Bluetooth radio. This
>>> + should be filled in by the bootloader from platform configuration
>>> + data, if necessary, and will be uploaded to the device.
>>> + This blob is used if the chip stepping of the Bluetooth module does not
>>> + support beamforming.
>>
>> Isn't it:
>> s/beamforming/beam forming/
>> ?
> 
> Doesn’t seem like it:
> https://www.google.com/search?hl=en&q=beam%20forming

OK, thanks :)


Best regards,
Krzysztof
