Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A6BC4EB0B1
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 17:31:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238736AbiC2PdU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 11:33:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238675AbiC2PdD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 11:33:03 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63609111DEE
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 08:31:20 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id lr4so27487651ejb.11
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 08:31:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=svO6+p4lvUcLP2B5A8gd9KTlZ89bA7C5UIQa69nPz94=;
        b=S7Q+7tEyKS92vmJzQdbwJTIdwM8IUJZQqVH5F4vBdWTA+Iss96J8tWXkSBxADDUrfJ
         MIV/aD22mrVCWixSz0ZY+tAddVj1ZD2+/5+cY7+pKABkqYfcr9x2TEeWsY1u5qEoI3p5
         0rO0GU6t600WtUbDmO8lViKU9N6ApTLH7pTQ+2+qSnu8CLGnkIFAn9BuU2xyVEFbnV1V
         fDb8N62cIeygJH0mIScVDbQj5lHkEno/K9WR2/v87tPyhfnU7HCyf3EGqd7ydY6STih+
         dAzq+6RgEt1E3lak7pN1y6qANgoEpLPPoxrpX/geH4Pu+Pv7IR26P7NZy+HPgIfS1dm2
         tcbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=svO6+p4lvUcLP2B5A8gd9KTlZ89bA7C5UIQa69nPz94=;
        b=EyxdwQpLfyxjwPPodYCpTE01h5HFXU91ivlvUgUSYefIlbcfMLK8npFllpS+BW+73Y
         Is1FsXOjuaSjEHeO40fM+B9GqzQLqZuGCkpDuO295qOVByhDl49NM501XnRXeiiqBxzZ
         yk+xO78WUyuKtMblUqfMvs2nGvHIv+gvdPBll99lm3+erspVd/5FdXYNSzWIhBd7UF0/
         P2VBp8Fc2hfOnSybC0eCTyL6pIlV7kv5VnovPX6egTTK0FJ+i/nQ+C0JInk/1Ge6h74y
         dxpFCrBX3sEo2CatvWiKGuCpNbfhT5ut0nbzuHQMqy+Am21K8x9Ry+vrh0YbUKJopHyJ
         AtDg==
X-Gm-Message-State: AOAM533R16Ebt/rypTvQFe/k40iLE9hYfecHc4yttM5RhOk8IJlr1H8S
        kpFRCvVx+mIoxWE1Xmhs7nSLsA==
X-Google-Smtp-Source: ABdhPJyGbtpxFR4x01t7rTmHja9jPNp0Yhgf4v5BkuuQlt7LhCL0joyVH5KU90NB9zFEtkwk7g2rVg==
X-Received: by 2002:a17:907:62a2:b0:6e0:e201:b94e with SMTP id nd34-20020a17090762a200b006e0e201b94emr19225728ejc.730.1648567878997;
        Tue, 29 Mar 2022 08:31:18 -0700 (PDT)
Received: from [192.168.0.162] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id c2-20020aa7d602000000b0041997b3ce40sm7143124edr.86.2022.03.29.08.31.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Mar 2022 08:31:18 -0700 (PDT)
Message-ID: <f5bec960-3424-dd21-71fc-cab3a427cdb9@linaro.org>
Date:   Tue, 29 Mar 2022 17:31:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 1/6] dt-bindings: clock: fix some conversion style
 issues for rockchip, rk3399-cru.yaml
Content-Language: en-US
To:     Johan Jonker <jbx6244@gmail.com>, heiko@sntech.de,
        zhangqing@rock-chips.com
Cc:     robh+dt@kernel.org, krzk+dt@kernel.org, mturquette@baylibre.com,
        sboyd@kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220329150742.22093-1-jbx6244@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220329150742.22093-1-jbx6244@gmail.com>
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

On 29/03/2022 17:07, Johan Jonker wrote:
> With the conversion of rockchip,rk3399-cru.txt a table with external clocks
> was copied. Make it a bit cleaner by aligning the columns. Also fix
> a description. Phrases start with a capital.
> 
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
> ---
>  .../bindings/clock/rockchip,rk3399-cru.yaml        | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
