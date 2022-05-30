Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB77453754B
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 09:24:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233085AbiE3Gpv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 02:45:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233070AbiE3Gpk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 02:45:40 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEFCD62136
        for <linux-kernel@vger.kernel.org>; Sun, 29 May 2022 23:45:38 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id er5so12181957edb.12
        for <linux-kernel@vger.kernel.org>; Sun, 29 May 2022 23:45:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=FLJL2D8Dx7Tyt86DdBtAMqIZq8SNfuE+dWPYeFGkTfs=;
        b=f1xR2DvOZhRt7C5tSQmUhawYZYcYaBmxwZwEgGstqKcCpcBjVG2BjewIjwiFeiQC+L
         5eDA/J1lHJYLz90usmQE3wvsx+pwUiPGzLttz+RXVqRsAg9dJbikL1Tk+SZkqBJ/naDV
         C5cUXGMAiDIyOu48QMVkPfJeWmIUig5DFcKZeRw9hwheXz6P/oWQdut4SrtuZ2qZwZZk
         RlV3g/EcTD882muYX7YQTnKtmjMi6wkvH7i5A1C7YRk85xzeCZcATCC/mbXPlecmCsUw
         5fOvVO+IC/ymcbb22mr22uTi+UYiisplED62u9eGsFbIsN2jr/sKHgiFNq7NhL+wz7L6
         NzXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=FLJL2D8Dx7Tyt86DdBtAMqIZq8SNfuE+dWPYeFGkTfs=;
        b=kgjMU0tAlPoQhWCTZJJMNgBp4OqNUEJT1aVOYfcMcpAv1U76/D+gro0whjFO2BcWaW
         J4RcBt/cFZajhybHDi3pJOR70lYhtdm1XlAbK6WLdmdFR/SNR3qU9faueJOkU/NItHPB
         uXq+fHQDgPBXpn1YYVy9QNSzK4IZ53x1KYtkQFuIdTLoBNTbeoFDrJpYtnjpOPcxRdmh
         YgxwdN+CyF42dZ2DsTnzxOb3Wfeo0cLURdgyaLJDwaUW1iR6mxcGUsePPoAe928Yupio
         G7Vk9KM5tIRgkdCkzpj8FNWvj5FN0PC+ulROQAUI6KLV+RH1fwR1hvOYVALBSO/ZADmj
         +/oQ==
X-Gm-Message-State: AOAM531afOH9FhyEJd/gzOE8CCJXYQJJn7cNWrQb/znDxeLqKJhOYfWb
        T4CPDgRrdh+MkTEJoycjjO90tw==
X-Google-Smtp-Source: ABdhPJyVEtMm+uckMguWGF9dAMS/FwmQv03qwQc6wZP9jNE7jgTHj58YImOhNt11R9DrYvAJ50iqwQ==
X-Received: by 2002:a05:6402:542:b0:42d:c7d6:4121 with SMTP id i2-20020a056402054200b0042dc7d64121mr7808041edx.302.1653893137505;
        Sun, 29 May 2022 23:45:37 -0700 (PDT)
Received: from [192.168.0.179] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id gt2-20020a170906f20200b006ff01fbb7ccsm3712756ejb.40.2022.05.29.23.45.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 29 May 2022 23:45:37 -0700 (PDT)
Message-ID: <d96f0a19-7421-d731-082c-388f980c61bc@linaro.org>
Date:   Mon, 30 May 2022 08:45:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH V2 2/7] dt-bindings: soc: add i.MX93 mediamix blk ctrl
Content-Language: en-US
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, sboyd@kernel.org,
        mturquette@baylibre.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de
Cc:     aisheng.dong@nxp.com, l.stach@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Peng Fan <peng.fan@nxp.com>
References: <20220526123411.270083-1-peng.fan@oss.nxp.com>
 <20220526123411.270083-3-peng.fan@oss.nxp.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220526123411.270083-3-peng.fan@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/05/2022 14:34, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Add DT bindings for i.MX93 MEDIAMIX BLK CTRL.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
