Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 377645B1B15
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 13:15:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230188AbiIHLPA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 07:15:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230108AbiIHLOv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 07:14:51 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB90C33E25
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 04:14:48 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id s15so19479647ljp.5
        for <linux-kernel@vger.kernel.org>; Thu, 08 Sep 2022 04:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=Rl5eBRjVMIfBFMNhgiMgpTHOyqMi/gFtjav/siqbg5c=;
        b=WTg9aG4AzDMi0Q7cADc+b4QdQGc5LBmrXMLkEFgfxX6soYvyl6QXho9+lbC5TsVZWI
         9ktpj88zxEhY2f5uKp5p9SsEfOq87C1CcoEdXcJrin1w2R6/tenO0S2FBIxmwD2gxEpu
         nMSuYmHG8hsCCWYMTcHMmvEqnsXagq1DgSL5tB8blpJZLXuL75Lu2jHUCKwqs9xP/gNo
         etHeQjWcZgfqzbQ5HD0ljOU44AaXOOzZsgEi7G4gn/7yj9R4rLw2nFSETOdMl2khHv6A
         H1dIBLOFxKOAkJtnsVXRPmQJAiO+rOSI2X48BMF+j6OUz9s9/GZgclosyRhaZEGLRWHb
         rdag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=Rl5eBRjVMIfBFMNhgiMgpTHOyqMi/gFtjav/siqbg5c=;
        b=ATk39PR5EguIedkQUzHarX09eqVYUAdLvDsFZ6XbSZg3+7UlBi6LSuU3bhU2Stw5fc
         cV/LRN9M7w4UjQnQbZu9aqUwz7YEBpPCdtufFq50k34QYN435w3yx75bu/wKD8Bo/7Fh
         EyHFRxZZG4q8JbWhG1osLh5iyeJ/GE3sTR1uFFB6dupNnjqx9vSIRYr/m5r3BDEkiFbC
         v2TYmF/tRjkNLMw/hDoduNeQcqqz28bcGmhZJiqAdT38eX+pVfbooqd8jTQiOema6xD3
         V7cJs53t9v3wcigsdiwb9qGsYDYWpGBhzjGQuADFIXUfML/ldEObBw8dBTraROGQ68Jk
         Ntew==
X-Gm-Message-State: ACgBeo1lbBjTr+fGSz7NRn237D/OEeMIxBsi3Ay0S+t6jtWE5yllGG1Z
        5ulg7xkMeL+zc8o/BwNA2dGI6w==
X-Google-Smtp-Source: AA6agR4z5wi0efa/Fv9BjzVLS5RePp44A7tbdiGNCs3gHxPAQwi1JvV7Brlx7I2QndRlJsG3vyAAsQ==
X-Received: by 2002:a2e:98d1:0:b0:263:76b4:5dc4 with SMTP id s17-20020a2e98d1000000b0026376b45dc4mr2221209ljj.460.1662635687241;
        Thu, 08 Sep 2022 04:14:47 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id p7-20020a05651211e700b0049487818dd9sm2986214lfs.60.2022.09.08.04.14.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Sep 2022 04:14:46 -0700 (PDT)
Message-ID: <169beab2-141a-82c8-9205-76ba85e0e8d1@linaro.org>
Date:   Thu, 8 Sep 2022 13:14:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH 3/4] pinctrl: qcom: spmi-gpio: Add compatible for PM7250B
Content-Language: en-US
To:     Anjelique Melendez <quic_amelende@quicinc.com>, agross@kernel.org,
        bjorn.andersson@linaro.org, linus.walleij@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org
Cc:     konrad.dybcio@somainline.org, linux-arm-msm@vger.kernel.org,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jishnu Prakash <quic_jprakash@quicinc.org>,
        David Collins <quic_collinsd@quicinc.org>
References: <20220907201528.9351-1-quic_amelende@quicinc.com>
 <20220907201528.9351-4-quic_amelende@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220907201528.9351-4-quic_amelende@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/09/2022 22:15, Anjelique Melendez wrote:
> From: Jishnu Prakash <quic_jprakash@quicinc.org>
> 
> Add support for qcom,pm7250b-gpio variant.
> 
> Signed-off-by: Jishnu Prakash <quic_jprakash@quicinc.org>
> Signed-off-by: David Collins <quic_collinsd@quicinc.org>
> Signed-off-by: Anjelique Melendez <quic_amelende@quicinc.com>
> ---


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
