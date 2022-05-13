Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C2F2525DFF
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 11:19:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378461AbiEMInb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 04:43:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378454AbiEMInU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 04:43:20 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B5EC27E3FB
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 01:43:19 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id h16so9764854wrb.2
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 01:43:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=/oUtUHOBPRzkpU69NgRbxeNPAKdNVn3BJh6gwBygmcw=;
        b=J7ZZ8Q6o70r3XUjLCowaXYXvP6NAuYGycMg6K/LKrCJOt7h3oDhIEXloqEx+/SJ9eB
         cv7TWSz6eHazluaHq6iZpfDG7baRvjp/QJ23MdXEc78eqlSGLfu+nkdXoSfzWjP2GoYE
         vosg5Pw1L0hmc2pUdOv9+YKbYOoOha7LwPXOxQRjte7mCCYQjVmjMVa+5o6oXfCxptsK
         B++m2+wAqAb0uIpcBknS1imzG+QLn6J3kPr/etsRr3ZTYqd7PQaQa1k+pzp7Ovv0UEJC
         3PHoDsVN3qR7VazFZO5QK7d8Opms2Fmodd+1CPQfnmQC92ZF+G6H2s5vvpUGZucR3y5v
         hdcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=/oUtUHOBPRzkpU69NgRbxeNPAKdNVn3BJh6gwBygmcw=;
        b=LWPgP3Lw6H5fUHbVPOdAEdc6yVFCIdo5FOm8ao4uXDPYz4ciodVNU9THgHrd1VmeP1
         L+uElNpHbdAxuqZxZCip5xSrNG218jF5vhMfX6ph+PwsGb0xHfZpzAv7M+57PC9ouvxz
         C2F2bEZC6MUOK0NyLhD/6/uOoFgn95mgvSIPiN0sqBxN0MJEGn2aS4w59v1kvfKcEQF7
         OKjbihmOGw3MG6VXHi7rRJPud0L05GUh5k36Hqcs/LOOr8j6NPjUBuko1dt6GVeMuVWV
         nAPPo/qVJ9QLKQXHIveE42aqgbARpOGvQldc7GnOupSkq/Az3n0RjGV56deyY2LQAde0
         UzxA==
X-Gm-Message-State: AOAM532jF7KzOX+PHDr4K14zMxzYm5dN9xwnesBkUlT1ggv2p+ZtvzNs
        LTL2/7iprSJJFNZ3tLE83qxHVA==
X-Google-Smtp-Source: ABdhPJyPnXyPYFlYNhmKv6HlpR9kp6cusChdNu3DUslg97TxmV52KAs+1ePCGN4+/Q5a+p0aLOKe1w==
X-Received: by 2002:adf:e74e:0:b0:20a:e015:b575 with SMTP id c14-20020adfe74e000000b0020ae015b575mr2969871wrn.151.1652431397621;
        Fri, 13 May 2022 01:43:17 -0700 (PDT)
Received: from [192.168.0.169] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id m18-20020adfa3d2000000b0020c5253d8ffsm1524420wrb.75.2022.05.13.01.43.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 May 2022 01:43:16 -0700 (PDT)
Message-ID: <b66faff6-a984-1417-cabe-de1e70a80dab@linaro.org>
Date:   Fri, 13 May 2022 10:43:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v3 03/11] arm64: dts: marvell: espressobin-ultra: add
 generic Espressobin compatible
Content-Language: en-US
To:     Robert Marko <robert.marko@sartura.hr>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, andrew@lunn.ch,
        gregory.clement@bootlin.com, sebastian.hesselbarth@gmail.com,
        kostap@marvell.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20220512124905.49979-1-robert.marko@sartura.hr>
 <20220512124905.49979-3-robert.marko@sartura.hr>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220512124905.49979-3-robert.marko@sartura.hr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/05/2022 14:48, Robert Marko wrote:
> Espressobin Ultra is part of the Espressobin family and shares the basic
> design, so add the generic "globalscale,espressobin" compatible to it as
> well.
> 
> Signed-off-by: Robert Marko <robert.marko@sartura.hr>
> ---
>  arch/arm64/boot/dts/marvell/armada-3720-espressobin-ultra.dts | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
