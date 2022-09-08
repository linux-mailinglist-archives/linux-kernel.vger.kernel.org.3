Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7354D5B1893
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 11:24:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231265AbiIHJYq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 05:24:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231738AbiIHJYY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 05:24:24 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3D6DF5C63
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 02:22:52 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id z25so26740286lfr.2
        for <linux-kernel@vger.kernel.org>; Thu, 08 Sep 2022 02:22:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=dH3CbhVOQrBIzFdsMYEQAzEoE3B2m4SSznn5rAk+rYM=;
        b=FHf5Ic/nwRoqqtgsFHSSGFDXZc98X2hpVH5Ttn0/VY/T+Rl1xxX8eAP+p5gs+pa44G
         dqojHG/7TfSA3gOeWxAIl+UZh8PDFCPoea9kdGdQqDETSUMlihGsJQtxcvAzwkVOy9sT
         3fDJ01OAxnONes0Gle2gdPEa0FKu6zFZ/j+W9iF0qpfbRbL6px2LC8vg21uN+B1a+F6d
         U7OQShHt5p86KP5e2r9IZo+K/7ynXnUdLMF1xVA5svaLjFkS8ALinaYJ0yT0hTOm1z5y
         5k/Ar9Kn+1s6rjhMYGbHk8a9pG3X93HkuWGNY4axTv/+yed/0Q6jeQnF9lV+pUJTF328
         eDOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=dH3CbhVOQrBIzFdsMYEQAzEoE3B2m4SSznn5rAk+rYM=;
        b=V6f9lOrrcrhW1EVug3RnkEmgjvpw7EkMgVc04+U0gWbDTZw/m4hdiiSEXpGfa6JrRx
         TgIYpIlg4iUUAtaOyF6MrdbasJPfox1xdxINWx+yhImFc6ftrtFQGrl6E/AQF7C8yUGv
         8wrJn6yvKz1ur1/4vQGTgKZpAk3TpJ8uquTlXSm/EeY93kTZqPqgQzqTlItP+3PUhqN7
         MYxv0Vne4/QP5pR4FZJWaZGYeoNU+UVXtXOLk86qy5obbdUxXJuK6WcWARR7fxHjq85t
         MDQrL5HGmon598uXY7JLh9N1xGeA00DGeEOuoKHg8wUeidrgdnrdFZNB4I4AsFY6qXPc
         tWVA==
X-Gm-Message-State: ACgBeo3CUf0qKJjG/VPe1wcmgrHkLpjeSVD/E1c58SMyMEIh0EW2eBMW
        +mfN5lLuDrd0Sw8wtT4rNVfc8w==
X-Google-Smtp-Source: AA6agR4x1bQbWHYoUICIygFzuOYuWPgfmCbP5o72xJn3+fJ+P+x9kq1cdfCrhlbhILkhk07z1Y2DaA==
X-Received: by 2002:a05:6512:1193:b0:492:7e33:870 with SMTP id g19-20020a056512119300b004927e330870mr2475777lfr.37.1662628970810;
        Thu, 08 Sep 2022 02:22:50 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id bu13-20020a056512168d00b004947f8b6266sm175119lfb.203.2022.09.08.02.22.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Sep 2022 02:22:50 -0700 (PDT)
Message-ID: <0b8b2e01-5209-6437-c79e-3cff9b29bfcb@linaro.org>
Date:   Thu, 8 Sep 2022 11:22:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v9 2/2] ASoC: sun50i-dmic: dt-bindings: add DT bindings
 for DMIC controller
Content-Language: en-US
To:     =?UTF-8?B?54+t5rab?= <fengzheng923@gmail.com>
Cc:     lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, wens@csie.org,
        jernej.skrabec@gmail.com, samuel@sholland.org,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org
References: <1661872039-40174-1-git-send-email-fengzheng923@gmail.com>
 <25072fba-64e2-df11-c8f0-a274037141f0@linaro.org>
 <CAE=m619qeaDYkWiB5kh50gY1Kndyrvo4oZuZjFKRCKK=j99K2w@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAE=m619qeaDYkWiB5kh50gY1Kndyrvo4oZuZjFKRCKK=j99K2w@mail.gmail.com>
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

On 07/09/2022 15:03, 班涛 wrote:
>>> +++
>> b/Documentation/devicetree/bindings/sound/allwinner,sun50i-h6-dmic.yaml
>>> @@ -0,0 +1,79 @@
>>> +# SPDX-License-Identifier: (GPL-2.0+ OR BSD-2-Clause)
>>> +%YAML 1.2
>>> +---
>>> +$id: http://devicetree.org/schemas/sound/allwinner,sun50i-h6-dmic.yaml#
>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>> +
>>> +title: Allwinner H6 DMIC Device Tree Bindings
>>
>> s/Device Tree Bindings//
>>
> 
> So, modify it to 'Allwinner H6 DMIC Devices Tree Bindings', sure?

You pasted the same message, so what is the modification? I wrote you a
 search&replace pattern.



Best regards,
Krzysztof
