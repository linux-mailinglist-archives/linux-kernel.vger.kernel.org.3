Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21D014D1A35
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 15:17:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238276AbiCHOSb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 09:18:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235123AbiCHOSX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 09:18:23 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B55B2F2;
        Tue,  8 Mar 2022 06:17:26 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id u1so28746010wrg.11;
        Tue, 08 Mar 2022 06:17:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=V8TIHc0j5BWltEXkyzmvOawt/D8EVJ6xLmc2G9cv1xY=;
        b=K4mICRpvPbg4yfk1/E03sYIpk212hPRiJBfYlEqJWOqDQD0I1S4dC+Lb9H2kmvCuO2
         y9PR2ugdSdc9C69y5TRmJ23a+wY5+uJInO+y8614FH1gLjK0WYe8sJ5mQiWgkw4EdVFc
         oasQc05uCh50MLN2NaKDTj7KDaIz8yv5BmB/sLv+YyxYGpSVGgIGgAwk/J8umYukIg/c
         d4UJSdEg2FvqE27PF3Jm4nKcZJY9YMcX+wC8oNanxi9PVyCrcmG3HDGAaZQG0++izngK
         91pvCR3JbVz6fLNzVp49gK7qe2f+jgSn14f2EUtlKR6loZY+ftJhoaWiRIq4bVQurVAJ
         2zxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=V8TIHc0j5BWltEXkyzmvOawt/D8EVJ6xLmc2G9cv1xY=;
        b=Z2znSSIMp24HDDor9Q0i+k65bV8qwzk59c5TdD0qlgqYkc9Tm9dJH2t6DzoNofC6BR
         vp0bf65MEDj7qU6AMl5YJtY7a6ZitQtXom9ASX2df6289bUDdwsLhmIlZ8a3fKrhhb1/
         xsCwtqcLp+H6wDRmyyoFRbCO0hkKiZVg83lwtHKCyOw4ZRAz1gPrYNqDllB1PJeNw1zD
         qHQtkkAul3RxM00dczvkskbd3W/npJ40GnkQYxwtfN+F02M7pMpwgNHMDJXeNgicrDHC
         b5CGdpO0aoi85iwixUfWXCeM9hJMj3nXd+0F1SvKlui2V2d3UMJGg8ttnBlUniVKjEbd
         BsYw==
X-Gm-Message-State: AOAM530iI1UsY02ahjfoA9pZRymrBEen6J8X4LR818U4vXpRIZzlSF0Q
        tb/O1yHb229Ir3rflpcmKko=
X-Google-Smtp-Source: ABdhPJxmSrGi9ymzbuPvYZowQx0hfPeyCWJrAyYDfaErh/FqxdYePSY4ti4PFua0HMh9SPgP45MVUA==
X-Received: by 2002:a5d:6251:0:b0:1ea:9412:fc8b with SMTP id m17-20020a5d6251000000b001ea9412fc8bmr12140763wrv.657.1646749044470;
        Tue, 08 Mar 2022 06:17:24 -0800 (PST)
Received: from [192.168.2.177] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id l13-20020a5d4bcd000000b001f0620ecb3csm12818160wrt.40.2022.03.08.06.17.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Mar 2022 06:17:23 -0800 (PST)
Message-ID: <709dcead-8f00-3bd1-dbfe-0d1f6c228260@gmail.com>
Date:   Tue, 8 Mar 2022 15:17:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 2/2] Revert "arm64: dts: mt8183: jacuzzi: Fix bus
 properties in anx's DSI endpoint"
Content-Language: en-US
To:     Robert Foss <robert.foss@linaro.org>, airlied@linux.ie,
        daniel@ffwll.ch, robh+dt@kernel.org,
        laurent.pinchart@ideasonboard.com, xji@analogixsemi.com,
        hsinyi@chromium.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Chen-Yu Tsai <wenst@chromium.org>, arnd@arndb.de,
        =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@collabora.com>
References: <20220308094911.2680291-1-robert.foss@linaro.org>
 <20220308094911.2680291-3-robert.foss@linaro.org>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20220308094911.2680291-3-robert.foss@linaro.org>
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



On 08/03/2022 10:49, Robert Foss wrote:
> This reverts commit 32568ae37596b529628ac09b875f4874e614f63f.
> 
> Signed-off-by: Robert Foss <robert.foss@linaro.org>
> Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

Acked-by: Matthias Brugger <matthias.bgg@gmail.com>

> ---
>   arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi.dtsi | 2 --
>   1 file changed, 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi.dtsi b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi.dtsi
> index e8f133dc96b95..8f7bf33f607da 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi.dtsi
> @@ -171,8 +171,6 @@ port@0 {
>   
>   			anx7625_in: endpoint {
>   				remote-endpoint = <&dsi_out>;
> -				bus-type = <5>;
> -				data-lanes = <0 1 2 3>;
>   			};
>   		};
>   
