Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CE7856A62C
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 16:52:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236216AbiGGOwR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 10:52:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236209AbiGGOvS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 10:51:18 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1E0531DEE;
        Thu,  7 Jul 2022 07:50:47 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id m6-20020a05600c3b0600b003a0489f412cso1043667wms.1;
        Thu, 07 Jul 2022 07:50:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=zKCQPtlV/zp+9AxyutmXUkykhKgpm+t7LU8VMAQOZXo=;
        b=EBJoSIWSMNh7Q1ibq+I4sYH0CrcGDJBR7HCFsUv3WlC6lIeY+WB0iD1pZHLWb5hEYg
         5oqhc10dDEvdDxWkISeBeVwaC00jPuQ2y4i2S4X/deZg2PRdyztDaHCmgc4XkoNnHPdU
         0zrAezlOOkUNUpMt+vInfnHF+UPKzZR6VK11mkt1xOrjDbDyaJmSQcmnDbUnNAd2WCaZ
         1xhm07yun2rNWjUM8ridi0XFR6SiPbEaV6U7ef/YsAnydnkrhBpLUwerTNKcNPaSaRGo
         mn7N0pWFXGLMB8XhfqCS0MLZtgW8jpiIvbjGd7/WaMJlyhL4H75btFIyDomTkOJ7Rbtd
         UqUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=zKCQPtlV/zp+9AxyutmXUkykhKgpm+t7LU8VMAQOZXo=;
        b=L4pXUdqlTy9UV7So//e8Oy6y775BdXwjaRGwUyylzKlPsgXCEQFNlHmHqjPuShFE6y
         I+Bzb8Q4hIE08m9l5UqXsYxipNF3LBD0OcfcR/QrgBDriycr8sPjVQJmJS52eIU2igfq
         3Qn5hV2FKMc/7FF79B/PrC8/KJ91afGsb6gNBDQHIHo/H8EktRmydm8rHryaPSKqIjdu
         AMp80/MNdQuwK8xJTKoLvRPJ86RVCMmw/Uyyr0clus+fdSYFQt/mSvpiQ69rTKDeRePT
         zy4BUGYtnHQ6bzOkastmSp6Vc8nkK4/cgZtyY3QxxU3lQpA5OKSEn6VQk9JORh0IFX0h
         2qMg==
X-Gm-Message-State: AJIora+5l9QceaJbeGMOqMx0r94S6pUTi+s4rPRi5Z/6h9FEkuAmg9us
        zXTY8hUOG23uemmTvK+a6VxAHZ4BIPJz0Q==
X-Google-Smtp-Source: AGRyM1tbSjA0Rr6Nv9IbQQWPXRgiLpd2Jgw9p/RhFNjcuTYsVoEOhwrw3W1uyeQOYlyX7Q3o45E0JA==
X-Received: by 2002:a05:600c:3b87:b0:3a2:c7c1:a89 with SMTP id n7-20020a05600c3b8700b003a2c7c10a89mr5051361wms.159.1657205446330;
        Thu, 07 Jul 2022 07:50:46 -0700 (PDT)
Received: from [192.168.2.177] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id n35-20020a05600c3ba300b003a039054567sm29099955wms.18.2022.07.07.07.50.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Jul 2022 07:50:45 -0700 (PDT)
Message-ID: <de6412d4-732c-79cf-ac00-e0fccee44270@gmail.com>
Date:   Thu, 7 Jul 2022 16:50:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v3] arm64: dts: mt8173: Fix elm panel DT node
Content-Language: en-US
To:     Pin-Yen Lin <treapking@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc:     Hsin-Yi Wang <hsinyi@chromium.org>,
        Eizan Miyamoto <eizan@chromium.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
References: <20220621091854.1904372-1-treapking@chromium.org>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20220621091854.1904372-1-treapking@chromium.org>
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



On 21/06/2022 11:18, Pin-Yen Lin wrote:
> Move the panel DT node under `aux-bus` node, so it won't use the buggy
> `ps8640_bridge_get_edid` to get the display modes. Also, change the
> compatible string from "lg,lp120up1" to "edp-panel", so the panel-edp
> driver gets the displays modes from the EDID instead of using the
> predefined display mode (`lg_lp129qe_mode`) in the driver, which is
> actually not working.
> 

Do we need a fixes tag here? I'm not quite sure if we fix an upstream bug here, 
to be honest.

Regards,
Matthias

> Signed-off-by: Pin-Yen Lin <treapking@chromium.org>
> ---
> 
> Changes in v3:
> - Include more details in the commit message.
> 
> Changes in v2:
> - Remove the Fixes tag because this change is not compatible with the
>    old kernel versions.
> 
>   arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi | 26 +++++++++++---------
>   1 file changed, 14 insertions(+), 12 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi b/arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi
> index 9c75fbb31f98..1e0802a6f6d2 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi
> @@ -90,18 +90,6 @@ volume_up {
>   		};
>   	};
>   
> -	panel: panel {
> -		compatible = "lg,lp120up1";
> -		power-supply = <&panel_fixed_3v3>;
> -		backlight = <&backlight>;
> -
> -		port {
> -			panel_in: endpoint {
> -				remote-endpoint = <&ps8640_out>;
> -			};
> -		};
> -	};
> -
>   	panel_fixed_3v3: regulator1 {
>   		compatible = "regulator-fixed";
>   		regulator-name = "PANEL_3V3";
> @@ -282,6 +270,20 @@ ps8640_out: endpoint {
>   				};
>   			};
>   		};
> +
> +		aux-bus {
> +			panel {
> +				compatible = "edp-panel";
> +				power-supply = <&panel_fixed_3v3>;
> +				backlight = <&backlight>;
> +
> +				port {
> +					panel_in: endpoint {
> +						remote-endpoint = <&ps8640_out>;
> +					};
> +				};
> +			};
> +		};
>   	};
>   };
>   
