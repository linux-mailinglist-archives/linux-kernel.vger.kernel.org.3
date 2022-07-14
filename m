Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61BB1574893
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 11:22:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238178AbiGNJWn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 05:22:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237841AbiGNJWR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 05:22:17 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B3B124BF3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 02:19:30 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id t25so1789818lfg.7
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 02:19:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=7QxUW5JMlP7swDnKQEo+sHfu77Q/PjxZ/uJIQjymj+A=;
        b=GJo55pzcoqaMBfitY8O5/LH4SNF1gDtDM0JsAgkTFil8+G1dr4nroUct1DckujY4yy
         eyUjFhJMEIAmgwP/xY6CdRWAEe2s+viuOvp8wbP9GyxBdVmlQuSPvRL/M88csbvsEJm7
         p87qmSS/or/EU4On0QdCniSvQFoNJyuZxvgNTP1PQDlStyar5yeAycYYYx27T0WO70VD
         440Qv6PB2ZEWkiQMjOZDPN1K338Z18TxLKWGDdq8CK0K5H6A9zHZd7cB/tj0emVFCLuf
         I+dF2Hqbi61GSTgXCB/Ka/eKgGUGg2kgUXm1nUcAKSF/HF61aTV2jjuFNSa/o7myobwd
         g+Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=7QxUW5JMlP7swDnKQEo+sHfu77Q/PjxZ/uJIQjymj+A=;
        b=SL5NvBA8KfUcHpOsYdB2MLTcmTnMW69OQPh7ilk1xprSkgqZKblE9NqVbpPQ1M5ciV
         2dmVat5R/WNwAJowYDMZK+/MpfgWy+dq6YpKMMFJPvyPCFbG3Rin1ktriw68pu8xm+x1
         9xxRh4Fer/o680goDNB6DlXT5LzroEsB+y2vPIqTSd0OHhaxylNHx6Zc7ER6fB0huVfr
         enH1xw5RR322R70zaZ20Wa7jkv1a/nJvbAFou8rB6W80YeMv/4csQV7PP7YJMTH/uVl1
         kx670DVqU4XW7YkpaQ0FqL34ZxHBm4Cp6v2xjsiEdmIcVyMmpzBr6reQyGPh8PfvhF/L
         GTZQ==
X-Gm-Message-State: AJIora/irPVpWMjLJTUTdjfYDfDYtHkOF3m7cPI4bOLgM8FphCl+2X2U
        6+j1Dd/cVlwrCelKLbbc8dAEGA==
X-Google-Smtp-Source: AGRyM1uqSRcNrXIWIdcfwf9tIvKqf3frD5YHCR/8Kn7uL8tqp0xj+ZmXyCUNNLyjPIxc9dcE9oXkdQ==
X-Received: by 2002:a05:6512:2610:b0:47f:74dc:3205 with SMTP id bt16-20020a056512261000b0047f74dc3205mr4404989lfb.429.1657790368758;
        Thu, 14 Jul 2022 02:19:28 -0700 (PDT)
Received: from [10.0.0.8] (fwa5da9-171.bb.online.no. [88.93.169.171])
        by smtp.gmail.com with ESMTPSA id l23-20020a2e5717000000b0025d519d0609sm183071ljb.44.2022.07.14.02.19.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Jul 2022 02:19:28 -0700 (PDT)
Message-ID: <0d626c44-001a-dd1a-4255-966a3f53f79e@linaro.org>
Date:   Thu, 14 Jul 2022 11:19:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 15/30] dt-bindings: phy: add QMP UFS PHY schema
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
 <20220707134725.3512-16-johan+linaro@kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220707134725.3512-16-johan+linaro@kernel.org>
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
> The QMP PHY DT schema is getting unwieldy. Break out the UFS PHY
> binding in a separate file.
> 
> Add an example node based on a cleaned up version of sc8280xp.dtsi.
> 


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
