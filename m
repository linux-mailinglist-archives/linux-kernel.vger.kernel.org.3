Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E95094E644A
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 14:45:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350557AbiCXNrD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 09:47:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350545AbiCXNrA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 09:47:00 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECE138A332;
        Thu, 24 Mar 2022 06:45:27 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id r7so5597805wrc.0;
        Thu, 24 Mar 2022 06:45:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=U7jmus7Yb7ewckakdZbh+zrWRQeITS2RgbYv0Y67GWg=;
        b=gzHv0VLCXVWV0ZR+pCDVaifTnt2xvMAdsFsl8w95DSMoJ1T88SULhHElQ3awS6JOH1
         sAFiTPyF02A/wK2lu1bQb1bf4lnj1/zLSVUpQGtrMXE2E9dneE9FTM9qWreuF+J3Cq9q
         BzUWsRPeyzFoZYCpgumVyP8iZPXtIXqgb3Mh4BI2J8t2PfBZTRt9UfssZC8wsDofuitm
         LgkpIt4SKY9dQMQKmgw72tdk/Nj0sECr9/oPpt24kF81aKDglAJW+SM4dHY3QWZ/yuF1
         8r7aAD4B21oEKH6GP+w4RMXsb/qPzi8BMzBlBE087j7aeuNlNq1iWsd5gvEx5GO3V1sE
         02aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=U7jmus7Yb7ewckakdZbh+zrWRQeITS2RgbYv0Y67GWg=;
        b=0NEaPorxlbhAjrYiN6xqZkBVgODiVPQq9KKvhVvqek2ResHO5SrT6dHrpo5EDlK5id
         +R6nJ0tZJlkKRPUjLbEf2xdTxYsBBf/2vIme7Ns2TLwzJE3QkRo/BaCWvfAz0kWK9Bdj
         XMr5/kMMXylG9PKtGolDogr+ksBOsSiYX5b/Boc5AJXQ6R9QtOS6dBU0eWeANEnCDPXx
         FHzSwPdlNSDzS1n5AdchxgkELtVFhfPkbx5DD4a5jAkvZ4avBvAmxHilI9da8lMRjX3R
         QOoz6ScF9m+81eU5wetWeBiwaCs2fwsIrBJihNBV8gQXMBMmFl0Qc/e2r+iMslKh0/FQ
         ZUYw==
X-Gm-Message-State: AOAM5304WpMrVtXf9QofnOOfGmV536lh1Ji7RU5WSP7IvVJu7Gc2Erjx
        Q+Yup/MmC8E7AxuoY09+7k0=
X-Google-Smtp-Source: ABdhPJwf4ibqJhrkQ5dOYOJhnioj0+pyney17DM0J3kvZXrLHu4gfZbmJD51e6lLA6BntW7PkBExfg==
X-Received: by 2002:adf:f943:0:b0:203:b456:c71d with SMTP id q3-20020adff943000000b00203b456c71dmr4678340wrr.568.1648129526345;
        Thu, 24 Mar 2022 06:45:26 -0700 (PDT)
Received: from [192.168.0.32] ([137.101.87.65])
        by smtp.gmail.com with ESMTPSA id n37-20020a05600c3ba500b0038cc9d6ff5bsm2343196wms.4.2022.03.24.06.45.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Mar 2022 06:45:25 -0700 (PDT)
Message-ID: <cc81f13f-fc83-d45d-4936-bec8ee58ba93@gmail.com>
Date:   Thu, 24 Mar 2022 14:45:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v4 06/22] arm64: dts: mt8192: Add xhci node
Content-Language: en-US
To:     Allen-KH Cheng <allen-kh.cheng@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Project_Global_Chrome_Upstream_Group@mediatek.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        Chen-Yu Tsai <wenst@chromium.org>,
        Ryder Lee <ryder.lee@kernel.org>,
        Hui Liu <hui.liu@mediatek.com>
References: <20220318144534.17996-1-allen-kh.cheng@mediatek.com>
 <20220318144534.17996-7-allen-kh.cheng@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20220318144534.17996-7-allen-kh.cheng@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 18/03/2022 15:45, Allen-KH Cheng wrote:
> Add xhci node for mt8192 SoC.
> 
> Signed-off-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Applied, thanks!

> ---
>   arch/arm64/boot/dts/mediatek/mt8192.dtsi | 24 ++++++++++++++++++++++++
>   1 file changed, 24 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8192.dtsi b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> index 28b93b76fe17..6bc36a4076f4 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> @@ -10,6 +10,7 @@
>   #include <dt-bindings/interrupt-controller/arm-gic.h>
>   #include <dt-bindings/interrupt-controller/irq.h>
>   #include <dt-bindings/pinctrl/mt8192-pinfunc.h>
> +#include <dt-bindings/phy/phy.h>
>   #include <dt-bindings/power/mt8192-power.h>
>   
>   / {
> @@ -718,6 +719,29 @@
>   			status = "disabled";
>   		};
>   
> +		xhci: usb@11200000 {
> +			compatible = "mediatek,mt8192-xhci",
> +				     "mediatek,mtk-xhci";
> +			reg = <0 0x11200000 0 0x1000>,
> +			      <0 0x11203e00 0 0x0100>;
> +			reg-names = "mac", "ippc";
> +			interrupts-extended = <&gic GIC_SPI 97 IRQ_TYPE_LEVEL_HIGH 0>;
> +			interrupt-names = "host";
> +			phys = <&u2port0 PHY_TYPE_USB2>,
> +			       <&u3port0 PHY_TYPE_USB3>;
> +			assigned-clocks = <&topckgen CLK_TOP_USB_TOP_SEL>,
> +					  <&topckgen CLK_TOP_SSUSB_XHCI_SEL>;
> +			assigned-clock-parents = <&topckgen CLK_TOP_UNIVPLL_D5_D4>,
> +						 <&topckgen CLK_TOP_UNIVPLL_D5_D4>;
> +			clocks = <&infracfg CLK_INFRA_SSUSB>,
> +				 <&infracfg CLK_INFRA_SSUSB_XHCI>,
> +				 <&apmixedsys CLK_APMIXED_USBPLL>;
> +			clock-names = "sys_ck", "xhci_ck", "ref_ck";
> +			wakeup-source;
> +			mediatek,syscon-wakeup = <&pericfg 0x420 102>;
> +			status = "disabled";
> +		};
> +
>   		nor_flash: spi@11234000 {
>   			compatible = "mediatek,mt8192-nor";
>   			reg = <0 0x11234000 0 0xe0>;
