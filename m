Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D728A55DA22
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:22:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245621AbiF1HvG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 03:51:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245607AbiF1HvC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 03:51:02 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68F721171
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 00:51:00 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id q9so16376533wrd.8
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 00:51:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=FPuG2slX+fgnrij7UFSAjejroSuyzdpt+S2NxTs06r4=;
        b=ms+DL1wuK8oZDIA1k/Phb+J3PG+BjucVp/a/8c+3ABKUt1yU4IYe1i7yTrZv+ru8WY
         coDJwPsFyU/b213bbdPwkEmXGSBk7dCdZnRdBJrX5wNVa3N63+RSTT+RmYDPDhsKucsz
         dG07nuD3ygNO5w0AvJCk/lBAymKgnzn6P0BzoTSDB62kYXsMQj0F18U5w/9Yzl3s/NaV
         mplVKXuUPxrNN7SWUhKZ9j1YtpIqgXU8czDZDcIoO1S3k4x7ZI1oyKgSxqHgjK5Et8G5
         23OjOJcgAjhXvHoA2H5IH33lOv+4vL6o4g0twneVOe2Y332BJyiDt1/WkpeMQQp4JvWj
         td/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=FPuG2slX+fgnrij7UFSAjejroSuyzdpt+S2NxTs06r4=;
        b=WjWbgzdRSty9mumsHMlxPiHU6ywG03qdoSdCJ7bJspr4pHuzvSH8HvL7wraywqGplp
         3PeullDU1JtcxGLVWdL3eP44cITighGB0lZZ9llziiE+ofxxUAK7OqDWMDw2S/oDlQ+w
         zl+liaYSCAwTHo/lLxJLkPxHObypTZdyjFZamjH8eUp0Ark4PHSoKSXuQc6KK/JkGndW
         pZTroqdh8Ez+5PCKxelKcArRslGCPhgI8CO7XDyGCTgFwYcUn4isIMd3z7U9gcTSMs9o
         3Z4KaFNRKZct+/NYk2YKRrU8evGh/pXlNZjKX3sgFkLsKsCie3d9q/AbJrbHYTR7yqTG
         UBFw==
X-Gm-Message-State: AJIora8/uJp5yWSVpWNziKI8qDEgo/FgPjOxvJRkO0vkYUjaHwp8OOv4
        /gB3nxzS41Mka27MnIcMEYQSVKutvXYa8g==
X-Google-Smtp-Source: AGRyM1s+1Y2n+Dlb2cgUwS4/ez4e+dqiSQiRFZBd1i7u/YwBXsk4xreCIaxAwl8AEWTKNkag9hr6Fg==
X-Received: by 2002:a5d:414a:0:b0:21b:81fd:6b7f with SMTP id c10-20020a5d414a000000b0021b81fd6b7fmr7126184wrq.309.1656402659016;
        Tue, 28 Jun 2022 00:50:59 -0700 (PDT)
Received: from [192.168.0.252] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id c17-20020a05600c0ad100b003973ea7e725sm28172553wmr.0.2022.06.28.00.50.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Jun 2022 00:50:50 -0700 (PDT)
Message-ID: <93925a1d-19ca-9643-ca13-8de3a4e9ae0a@linaro.org>
Date:   Tue, 28 Jun 2022 09:50:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] dt-bindings: nfc: nxp,nci: drop Charles Gorand's mail
Content-Language: en-US
To:     Michael Walle <michael@walle.cc>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220628070959.187734-1-michael@walle.cc>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220628070959.187734-1-michael@walle.cc>
Content-Type: text/plain; charset=UTF-8
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

On 28/06/2022 09:09, Michael Walle wrote:
> Mails to Charles get an auto reply, that he is no longer working at
> Eff'Innov technologies. Remove the entry.
> 
> Signed-off-by: Michael Walle <michael@walle.cc>
> ---
>  Documentation/devicetree/bindings/net/nfc/nxp,nci.yaml | 1 -


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
