Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7ABE4574902
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 11:30:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238316AbiGNJaK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 05:30:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238306AbiGNJaC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 05:30:02 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99904193C7
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 02:29:35 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id u13so1840518lfn.5
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 02:29:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=9aRuDO2xu3uEUhtB2rstHvLVmhOqmSOwO7/lZnxmiVA=;
        b=Vmf9eyIWaxYLzmHExTCdwdyIYyFIlfShBDODMddmLuANgF04h9TU7NZYXrILhVNByo
         jaAyOsAbSl/A1Uranca3SwVNh4Q2iVVX7jk3nw7RX7j/Osi1v05UBj/KbDCEMx8DeRmk
         UxXKdCV7iIzqV4MuTyLLNPUqnF0uD5YjdyYK/35sAkyxk3OIFLy2CSreZjqsTOBnPm+A
         zGPwpo9r+l8ZVu40Ni+1V5tKzSpwAkuLt7fSG2KWw++FXO8h5+oWxIGcYa29M8OExfcm
         J/4SsVs0t98V5TfyrbXCHOcin5aYXpsUP5PZdaVgh99icABEYlCX2ckCdwN/AGaTjmXw
         1ACA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=9aRuDO2xu3uEUhtB2rstHvLVmhOqmSOwO7/lZnxmiVA=;
        b=55qbNdYj15w3yWjAwgbqTgaoIA3mBroLUEdEFkPQjD2CTifN+bwHBHuoy/uUqMxm0z
         jNf6fvI07qCbChbxwo0uPWFcRbXunN4ACp/XrTyjgojAQ6ksYiAEuZnTaENk8ij/0N/Z
         KjQvtFWburiDUp/QbpfqAVZcc6H4sXoCfABdDRfaZRFEV4XDr0440cryt6jU4Votmtkg
         Ak7Se2D6hnnJWQPucLRThuWxvl8dKQjnH32Q1D7RwoPKzEpEmr2nAKZhoGEZZz6AWksU
         DyD5fSrdcEN2XPjboEhIh5JXsPfOZpvAyKIXahMPjbVYdnL2cmIBNAGHgQpdI3XvC1ng
         HkCg==
X-Gm-Message-State: AJIora+8a6FgI7+wm1pC3ubLU5Vb3hOnIsbDNuIwG88/zeAp6R7MZxBS
        PbY+zztVCOjmLuST9ImjRlc6xw==
X-Google-Smtp-Source: AGRyM1sfQu/wZaBqHV3s/t7/E7EL2TZdxlYu2+iw7eKvNtwNVGZhnaHGY1iVLXilX3JsOcRp7SAA3g==
X-Received: by 2002:a05:6512:c07:b0:489:fe21:3a22 with SMTP id z7-20020a0565120c0700b00489fe213a22mr4886632lfu.482.1657790973673;
        Thu, 14 Jul 2022 02:29:33 -0700 (PDT)
Received: from [10.0.0.8] (fwa5da9-171.bb.online.no. [88.93.169.171])
        by smtp.gmail.com with ESMTPSA id g6-20020a0565123b8600b00489e7550cc9sm259998lfv.98.2022.07.14.02.29.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Jul 2022 02:29:32 -0700 (PDT)
Message-ID: <e4fedc46-85f3-ee76-343d-d0236b64ec5c@linaro.org>
Date:   Thu, 14 Jul 2022 11:29:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 27/30] phy: qcom-qmp-combo: drop pipe clock lane suffix
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
 <20220707134725.3512-28-johan+linaro@kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220707134725.3512-28-johan+linaro@kernel.org>
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

On 07/07/2022 15:47, Johan Hovold wrote:
> The pipe clock is defined in the "lane" node so there's no need to keep
> adding a redundant lane-number suffix to the clock name.
> 
> Update driver to support the new binding where the pipe clock name has
> been deprecated by instead requesting the clock by index.
> 
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>  drivers/phy/qualcomm/phy-qcom-qmp-combo.c | 4 +---


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
