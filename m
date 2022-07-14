Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87257574B42
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 12:54:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238535AbiGNKyK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 06:54:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237851AbiGNKyI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 06:54:08 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EE9A48CA5
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 03:54:06 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id r9so2135382lfp.10
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 03:54:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=evol56Qb1Jrqp/O+5OAWfUa2w9gHxjlVRZkeU1fNA8Q=;
        b=YKVHA9WXoJ2iIjWXvvjVVvd6xXBx3cGBDX8TkWN3dqhhJNAI8J8IHNI2rs7rZn/Lxu
         76XbcObhapvN6zJVtbEXEAwwkIpT4Cjf+KoXSWzhsTIzpHvaelVIjafgZVQbvDXoZ4cN
         mSuxVbIzs9fR/HoH3oZojtsAMprWUqVxzG/c3TIu2Mi5/Z5wSKG86d7xZ3E4OsUBGjWP
         WxwoNtYl/SsUPQ6H6ZgKkAqwdxzZ4F7BQXi/Z8UxqfJeYgVgpLmKPVrgJX0JXxtxPNS7
         R9jGxRhjJsAiOJhjkvJST/JLnd58gs6rF3efQ9otP0zNvGzKqJyxVuCsVyc5Q5VZsOwx
         iIkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=evol56Qb1Jrqp/O+5OAWfUa2w9gHxjlVRZkeU1fNA8Q=;
        b=BuzgXv7cjtQWlfta1JMCfzhilcSjU1bJdBPuDGUzmziXvC7tu29jYDBaPKJekjMAsM
         4EB6UDUrjAD1XjuKDhVrlaNCGu5zM9XKiei5Ssz+ZQ+ZkJHciP/WPRLwcUtRXMqS2+gT
         q1r3uVrQvJT8MtHUpz11YDTcRu2bn1E4xwZdWAN0+PRQLN21YWOKW9pFCXUAKdrRU7c+
         pkWjIY8Bhc036/ln2caQuJy6ivpG+AOSu6ZlR7sR2l4tCt8A8Y8x7vBgb//M6zzwT+mP
         fJVEETWNH6hv5QKtdX/FqOWklHPJdKwvYm+Avpnklo0GlEJ11wTqEbPcXScWuNXFS3Ns
         cCYQ==
X-Gm-Message-State: AJIora9oNnuMTjrj3nLYhwxmn84F8fs7qxIAM8sEEQ3tRxy3cOqzAPZQ
        u4mj8WxvISZbUVIDL/onVsJJWw==
X-Google-Smtp-Source: AGRyM1tSWHYHNMLy6OL6X+EL4E1sl95D1xGDPdjwDaRaxN8UU4cPtoRQSkCjIZTcE/2mBSpLsm0a4Q==
X-Received: by 2002:a05:6512:c29:b0:489:e65c:4632 with SMTP id z41-20020a0565120c2900b00489e65c4632mr5128562lfu.511.1657796044766;
        Thu, 14 Jul 2022 03:54:04 -0700 (PDT)
Received: from [10.0.0.8] (fwa5da9-171.bb.online.no. [88.93.169.171])
        by smtp.gmail.com with ESMTPSA id o22-20020ac24bd6000000b00480f1c9dbb2sm293170lfq.157.2022.07.14.03.54.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Jul 2022 03:54:03 -0700 (PDT)
Message-ID: <2fcbccbf-f4d4-5fa6-d10c-9b120d76a626@linaro.org>
Date:   Thu, 14 Jul 2022 12:54:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 6/7] arm64: dts: qcom: sc7280: reorder USB interrupts
Content-Language: en-US
To:     Johan Hovold <johan+linaro@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Felipe Balbi <balbi@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220713131340.29401-1-johan+linaro@kernel.org>
 <20220713131340.29401-7-johan+linaro@kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220713131340.29401-7-johan+linaro@kernel.org>
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

On 13/07/2022 15:13, Johan Hovold wrote:
> Only one of the USB controllers supports SuperSpeed and have an SS PHY
> wakeup interrupt.
> 
> Reorder the interrupts so that they match the updated binding which
> specifically has the optional interrupt last.
> 
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
