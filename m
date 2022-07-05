Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 673DD56678A
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 12:14:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231570AbiGEKOH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 06:14:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230429AbiGEKOF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 06:14:05 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DB5513FB3
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 03:14:04 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id c15so13958374ljr.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jul 2022 03:14:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=YExG+e7a0Sa7NJEj+5xnmdh+Unak83hrCasOVIHdEy0=;
        b=tC5uSfTj4Fy60naqPgp97OwT5AkHHkfee+8eLp9FoH20tHMHMBXKU6LRfhi1UyHp6r
         tfak6nHwHQpcDAFT1DyLkYQ+e5CZbeOkExJKZ4TuDAddCQvMqNr6HQc+GEguOi8Ew0Am
         Yvy1+wrD71g2WKI5CSDwKbAdQgl7eh/YIRg0rMbRzj3JU8yuAWVuJuaC2UhSRwr3efyF
         9yHEBsyT7rfs/QYHGn/hBkeoG5oV6AuFloT5fCSHcyTqSJ520bWvAQPDYC8R+YAUXFhC
         1fV1YnanYXK92pbnwVwkloKN/pOmmiPim0RA/ArsFxmj4AAhEF2U1LeGDx8DfCefa+Hc
         +KOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=YExG+e7a0Sa7NJEj+5xnmdh+Unak83hrCasOVIHdEy0=;
        b=44/W0kgThe/TDrUaHIBlDqbrYga9A9VI/SpP0o80hN1GqGCV9jE/7KU+F1UoH3yRLY
         4C9xZKH03kXhTyGppN8CEJsFcXcK7ZgtQI74MENKrUgbFJsr4Fgcb2qLqzKN26ueIs/3
         jpDyZrXGl8IOu0oATQNdoulZgJp7p5Q9J7Hqw+n3rc/mxLkeav9ylRRZKHiF+66xGHeo
         BwDWtjO7ghmWLAPh+YnnkZwc1Pkt5C1wjXOx74I/IrIDicMlJry2kR6pmpb77aJr4wRV
         OQIGZkLYQhXDzX/rlm5/1CNq2YUbwBN6uTPQBOPyPD+Ljc8ilco8MWN90EeQutXVgDqD
         kSiA==
X-Gm-Message-State: AJIora+k3yy0Wz+J/NUJKx/n9ha1MfTUiGszkb6EO3gys6He9h/P9Ls9
        BXgBZAX9HvPvcrWJXLkcmdsrmg==
X-Google-Smtp-Source: AGRyM1vW5Lmj5rXm5hrCoWS2Wi54jz7pYqa6w/8RzgATIbyj3LK6r4kZKzxJzLIg4Aujo3fpMmE2ww==
X-Received: by 2002:a05:651c:244:b0:253:ecad:a4ee with SMTP id x4-20020a05651c024400b00253ecada4eemr18710012ljn.21.1657016042713;
        Tue, 05 Jul 2022 03:14:02 -0700 (PDT)
Received: from [192.168.1.52] ([84.20.121.239])
        by smtp.gmail.com with ESMTPSA id i16-20020a2ea370000000b0025d0fbe3e46sm2004851ljn.13.2022.07.05.03.14.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Jul 2022 03:14:02 -0700 (PDT)
Message-ID: <9b3864e7-b6d9-8601-989a-50ac4db32f7c@linaro.org>
Date:   Tue, 5 Jul 2022 12:14:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 14/43] dt-bindings: phy: qcom,qmp-pcie: clean up clock
 constraints
Content-Language: en-US
To:     Johan Hovold <johan+linaro@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220705094239.17174-1-johan+linaro@kernel.org>
 <20220705094239.17174-15-johan+linaro@kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220705094239.17174-15-johan+linaro@kernel.org>
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

On 05/07/2022 11:42, Johan Hovold wrote:
> The PCIe PHY binding requires two, three or four clocks.
> 
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>  Documentation/devicetree/bindings/phy/qcom,qmp-pcie-phy.yaml | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 

Squash it.

Best regards,
Krzysztof
