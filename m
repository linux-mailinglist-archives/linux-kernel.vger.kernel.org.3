Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B0B34FA6D2
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 12:43:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241337AbiDIKpE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 06:45:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230356AbiDIKpD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 06:45:03 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1426DFB5
        for <linux-kernel@vger.kernel.org>; Sat,  9 Apr 2022 03:42:56 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id lc2so1239722ejb.12
        for <linux-kernel@vger.kernel.org>; Sat, 09 Apr 2022 03:42:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=ijd95dt6s3s+0p47bWaAfIjaq9k8EmWtzflrGL7OleU=;
        b=bNqB0Yq5OxBBujdEXQlvbmX/xmYst+e1wdlTr2Zro8lZuJVwjpWo+yg8iVON4py8m/
         n9CgTSVWcDV/sxMYeWVQ2Oxh8HAycdA+7S4O6OvdW4cpqCQkCPM5LdaQukZA66PXMdQG
         ti4rlsFJToPO9K3SblU5U3PDCA80GSreZ1fXb3cjwaAsoCek8DrH1YjNFzTsh5GGnUAk
         svOCRqepr5jvXZbvgHaOFasF4CWgX+M4VAIuXuKSR+XBXqxLWXxRXxVn/GA77DPEgT+9
         Bm7YsqCOVxDBo/t+fCO0dopGhBq1eluEo4dJ+p1w9ZNaAU/wopEwhMi1Lj2LFNH07+W+
         BjHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ijd95dt6s3s+0p47bWaAfIjaq9k8EmWtzflrGL7OleU=;
        b=hYN73OMEZPSa+zgJOMiUObZgb1xxohalAY6lTzg3OJbmkyT99HSaptc+d01LtUHK0S
         Ohcb2+3u3meAgjBn9ybVz7K69rEU4l4zDToOICd3lP8j6zPdpTaYiUfFFKvZK5z/3OUB
         w1eke7B8ytV8eW5n2FF8k/tjjIYPrSAi8AYF2Vt+0doOsBrtm0mylqg9m/687nQscX6N
         pZqyg2Is8lR8NcNQZNzb8AU+7wIb6yJWrGQu0LxoFF8tPO9lhmVnB/Tg1N0kDescSPxu
         D6/mvT0mE8m8KuemxA2Ngk5rkm6CbHkBxOorGz8HJVmX2DlHoiYL89CfDocAeD0Bqlbj
         NNkA==
X-Gm-Message-State: AOAM533nhBV1fKk67jQ0m2lYgdzOwHkUqbu9fK2+JcuS3UlBq0+U4y6L
        AsB6uU/0j9HNmAdy3GL2hz0k/g==
X-Google-Smtp-Source: ABdhPJzY3jtlSetQ7/sUPkfs0zTjBlNU8oXNLY/DXJ81h7kOq3SYJzZLL/J3TsjJxNWgk8GT1Thdgw==
X-Received: by 2002:a17:907:2d27:b0:6e8:3ea6:7645 with SMTP id gs39-20020a1709072d2700b006e83ea67645mr11175076ejc.727.1649500975309;
        Sat, 09 Apr 2022 03:42:55 -0700 (PDT)
Received: from [192.168.0.188] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id r11-20020a1709064d0b00b006e87938318dsm158946eju.39.2022.04.09.03.42.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 09 Apr 2022 03:42:54 -0700 (PDT)
Message-ID: <7dc8b66d-0569-183a-554c-4a0d273bbf0b@linaro.org>
Date:   Sat, 9 Apr 2022 12:42:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 2/2] arm64: dts: imx: Add i.MX8M Plus Gateworks gw7400 dts
 support
Content-Language: en-US
To:     Tim Harvey <tharvey@gateworks.com>
Cc:     Device Tree Mailing List <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>
References: <20220407210411.8167-1-tharvey@gateworks.com>
 <20220407210411.8167-2-tharvey@gateworks.com>
 <be7fd7be-c65a-215c-df96-5a6eed52b5e7@linaro.org>
 <CAJ+vNU1D5GowKH97mpS+zT97XTavbKfijt6P8KEHN8-DD+gtYA@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAJ+vNU1D5GowKH97mpS+zT97XTavbKfijt6P8KEHN8-DD+gtYA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/04/2022 17:52, Tim Harvey wrote:
>>> +     pps {
>>> +             compatible = "pps-gpio";
>>> +             pinctrl-names = "default";
>>> +             pinctrl-0 = <&pinctrl_pps>;
>>> +             gpios = <&gpio1 12 GPIO_ACTIVE_HIGH>;
>>> +             status = "okay";
>>
>> No need for status.
> 
> ok. What is the best way to know if a binding uses status or not?
> 
> Documentation/devicetree/bindings/net/fsl,fec.yaml for example does
> not mention it uses status, yet it does.

status is not part of binding at all. All nodes have by default
status=okay, just the DTSI disables many of them. Therefore you need to
add status=okay only to these which are explicitly disabled.

Best regards,
Krzysztof
