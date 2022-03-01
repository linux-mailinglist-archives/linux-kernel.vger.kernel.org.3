Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C60F4C8718
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 09:50:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233592AbiCAIvS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 03:51:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233587AbiCAIvN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 03:51:13 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B7E589305;
        Tue,  1 Mar 2022 00:50:32 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id bk29so1960758wrb.4;
        Tue, 01 Mar 2022 00:50:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=oD6gFetTiTBneW7pHAfdFCO02Wc1Qh+YwGAvSeqNhkA=;
        b=O1Al/ityd/j4DM8wDxgNp7nZUpj9pXSlJwbBGevPpfQyeOON0PTJXEd0k2wmTUlRie
         uZqWfhY0fbVTps0FePeqG1CSjnSD1QOBgLHw90pehhEcmFC4zcfJ9kFegQCCEIwGmeIh
         03+LcSwxUUrjrBo6Mw8je/5/F3DIfrwmRnQ8MiyD4+CW1vEFEiyxZNFJ7VSBQQUDcDY1
         M3XnIvPyuEO7lNZ0jVWxQB8uO+R4l+aW1+Dg5DpIXebNFpQWFhkY1MPy0iKTqSvZ/YXa
         SYWxObUzHMqwUjYVYdHS4E3zduVYBZ1RDR9PFzQ9n8IgNCdawuWTYmjUVT04X69Jlrv+
         Z3Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=oD6gFetTiTBneW7pHAfdFCO02Wc1Qh+YwGAvSeqNhkA=;
        b=1l7o/w6vUSFiDL2uz7+ZSnW/8MpnzmB6D+kMWclo50K/AQrmRDObW1EltasdAlnc2S
         l+ad6VXbv5W2W4pBqVhCnrdZ75xyvWLsUhAZKPO2P6WG5VKFtP2R3swcg0FI2JpxFE+5
         VLJiRpjWb52m9nIol0UZ2dNGlylMaLFz+kHI4XuW1gVJLFfbrM4Ny8i7+NR4xm+ZzHEL
         jsO7grnyxichSs1wQNO9SxSA2H25EyZWX3G0pwLke+8aSydXjzJEMgEwrSnPWKOMKa5H
         yU7mTTVbWCH3bQSyevwj5T7ZF/TBhslNI735nKcjCA6ht/TAHj0AkdjVFzIOxE90KFn8
         Xy7A==
X-Gm-Message-State: AOAM5300c2uSzBQWsYCfznVdtGvqEAYzL82zEY3gOQLslKhmXhvelut8
        Mw+Wswa1sPdgEw8QbV6SppE=
X-Google-Smtp-Source: ABdhPJxoDFCuwAc5cGM+VSc2wggf07/VDWjHulbCWtHzrMe1a+pYmYQNLrCmat8HM6MVG8ac5xTI1w==
X-Received: by 2002:adf:e74a:0:b0:1ed:f95e:dc6d with SMTP id c10-20020adfe74a000000b001edf95edc6dmr17857402wrn.191.1646124630721;
        Tue, 01 Mar 2022 00:50:30 -0800 (PST)
Received: from [192.168.2.177] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id az11-20020a05600c600b00b003820f5c48e9sm787434wmb.38.2022.03.01.00.50.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Mar 2022 00:50:30 -0800 (PST)
Message-ID: <1940523d-4d98-b467-f518-7d5735e043e4@gmail.com>
Date:   Tue, 1 Mar 2022 09:50:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 1/2] arm64: dts: mediatek: update mt7986a memory node
Content-Language: en-US
To:     Sam Shih <sam.shih@mediatek.com>, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     John Crispin <john@phrozen.org>, Ryder Lee <ryder.lee@kernel.org>
References: <20220119123537.9968-1-sam.shih@mediatek.com>
 <20220119123537.9968-2-sam.shih@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20220119123537.9968-2-sam.shih@mediatek.com>
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



On 19/01/2022 13:35, Sam Shih wrote:
> This patch updates the format of memory node in DT based on
> maintainer comments in the following thread:
> https://lore.kernel.org/all/bc0a9df0-8ba0-76ed-4522-43a3082f42b4@gmail.com/
> 
> Signed-off-by: Sam Shih <sam.shih@mediatek.com>

Applied both with slightly better commit message. Please help the maintainer by 
providing verbose commit message.

Regards,
Matthias

> ---
>   arch/arm64/boot/dts/mediatek/mt7986a-rfb.dts | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt7986a-rfb.dts b/arch/arm64/boot/dts/mediatek/mt7986a-rfb.dts
> index 5cd760abff51..21e420829572 100644
> --- a/arch/arm64/boot/dts/mediatek/mt7986a-rfb.dts
> +++ b/arch/arm64/boot/dts/mediatek/mt7986a-rfb.dts
> @@ -19,7 +19,8 @@ chosen {
>   		stdout-path = "serial0:115200n8";
>   	};
>   
> -	memory {
> +	memory@40000000 {
> +		device_type = "memory";
>   		reg = <0 0x40000000 0 0x40000000>;
>   	};
>   };
