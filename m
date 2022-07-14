Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB9E85748D1
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 11:27:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232888AbiGNJ1D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 05:27:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237987AbiGNJ0c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 05:26:32 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2860B38A9
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 02:25:34 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id n18so1845526lfq.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 02:25:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=G4SHg0v0UTb3/wETQ9utchWc9oSi737vagHnYZzNcEw=;
        b=UJosXSDIOCQA7CkfHPIk2bFFsaniJh806Rdc+4td/6efm/F2x6bc3R55hxcASp6xE3
         dssT7wZsAC7leRWDQccu9BJzy7qRRpTat5Yd0n57bc/IeHc2dY1eh/EYztXAyeQ4HJVb
         HG4t7yhI0gWLcZJzQf1fwWoubI+NisWFwBvJhzcdA49YL4WAN8nlqwFJftVqjrlW652O
         yovL8Bppc6/qJzzH/O6rzCntep+1VbeYhRWaKmjVWXRqLN5SjF5e/cwRMC31XZJKVWxE
         h17p0U+6GgnDHT/4EFr8TWcAu+4gFFePea91v55PVpyg0fgT95pHkUzAzQaWD8XjOLyB
         vogQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=G4SHg0v0UTb3/wETQ9utchWc9oSi737vagHnYZzNcEw=;
        b=YJjNmDSviSOmRtHP/8bW1LbxMlDr1RGXMOvO9d7+D5XHQ/L+dGwly7/+CkE6vApvvi
         7DzrvB2h7TvAJcJhX4IzVigry6KncLkq78C3cFHMFl11yxG0E+3hvC7Pk9ZQPHJgFDhI
         kVWmCL2uxs/gN620nLN+r4Ow8ku/uoSoOpFrzi4KIsxeoGXphlf3MVKPtQcXzX3X8RUy
         +ZsQuX8tFmR/ZI9bsbRMeSiT1cSom012vr8tKQxrIRbUJVdBWEUQoUMktFiiCuh1uaUW
         JgLwVew8s+wepqoY+ReV5CdYppBxaUOvT7D6XMLIu3m9U1FgDGB6yhwusvvlthUGR/Hh
         Pixg==
X-Gm-Message-State: AJIora8hT5j21TQJuteVhY09dbeO12lZ8BrmWfjasjccOnqawLaN26nT
        Ki8LgNrIK7JTPTZcnxktIWVktg==
X-Google-Smtp-Source: AGRyM1ua6lLzYbEzTJQNV0u3KzfC8NiZH61p3CYrMfOwp61n3WD6zdS8uA7jQ6LgHPcEUmLg9bK8Bw==
X-Received: by 2002:ac2:5590:0:b0:489:f4a2:5526 with SMTP id v16-20020ac25590000000b00489f4a25526mr5095824lfg.116.1657790732574;
        Thu, 14 Jul 2022 02:25:32 -0700 (PDT)
Received: from [10.0.0.8] (fwa5da9-171.bb.online.no. [88.93.169.171])
        by smtp.gmail.com with ESMTPSA id s10-20020a2e2c0a000000b0025d70efeaaasm184639ljs.75.2022.07.14.02.25.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Jul 2022 02:25:32 -0700 (PDT)
Message-ID: <8e564b29-50e2-aa83-7a21-f28d37b384d3@linaro.org>
Date:   Thu, 14 Jul 2022 11:25:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 22/30] dt-bindings: phy: qcom,qmp-usb: add missing
 qcom,sc7180-qmp-usb3-phy schema
Content-Language: en-US
To:     Johan Hovold <johan+linaro@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220707134725.3512-1-johan+linaro@kernel.org>
 <20220707134725.3512-23-johan+linaro@kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220707134725.3512-23-johan+linaro@kernel.org>
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

On 07/07/2022 15:47, Johan Hovold wrote:
> The "qcom,sc7180-qmp-usb3-phy" compatible is apparently used to describe
> a combo PHY where only the USB part is used. Specifically, only a single
> reset is used.
> 
> 4ad7d7eeed3a ("dt-bindings: phy: qcom,qmp-usb3-dp: Add support for SC7180")
> 94c34600b617 ("dt-bindings: phy: qcom,qmp-usb3-dp-phy: move usb3 compatibles back to qcom,qmp-phy.yaml")
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
