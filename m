Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEAEA589E6E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 17:13:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239442AbiHDPNc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 11:13:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239674AbiHDPNJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 11:13:09 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9E3F61B2D
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 08:12:34 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id u1so20985669lfq.4
        for <linux-kernel@vger.kernel.org>; Thu, 04 Aug 2022 08:12:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=flkVgJSkLgJ6BOpNMmZn044hSm3xppsdwA5+7hs10Sw=;
        b=VoNdeeXAdgGXCwnYXIP0vshrJlTj60Rj0SlnPnxPXaKKWiUFheu9gCKm8hfkKqss4q
         uYQzS3hcLbXxbCwFsFCrf6KwE5Yi2bWFe7YoI0UIhgzlrMqmbNYlgjbPE+tHi/0JDK8p
         Jx2NKK6q8R9eW80z/ftc4GQg5ypo3E0oKACcSRzK1M/qfq4McC0vPWDXWfaldPwFvaGP
         R7o4j4FZvOjyxtuiNODfEQ3DyTbxyLjW921OdjA2jHLFmdZL3bpldBpuQQYSIwifglt+
         ByaQjKOzWHbsGOd6yPtP/Byff7IzkdG3a1TVnSONhRzjxJTK66sDwmzeIBw1LJrSNzGw
         Sp5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=flkVgJSkLgJ6BOpNMmZn044hSm3xppsdwA5+7hs10Sw=;
        b=14wilhm7WyPABVmGLFeQkrk/iuu6KqThf0TgQ07Dwm0pn22Fn9I9E9dCXmfdieJaZQ
         LJaI95VZ/QKPlTLa1X3SNTeeh9QkDRp9DmZqNVvBzZK3HVC9YKu9wbekJkXea54mnoY2
         91wVx13iCILgLlmHe9sS3Ye717NAf4csVCDPCAZF/7kVH52TxIo+wFVqD/pFFN218U9c
         oBTugIlKLSVyf98VgYSFN2KPKzorIAA1O5X+nWDrnxL3lQImi7NFsHBXkUABMrCznApG
         J5DXH79iIdOLmfVd7NEJtXfkVozaZePPohXvfCpJ6xX6TVj+4idySXTXpP5rcC8W/yIu
         IPgw==
X-Gm-Message-State: ACgBeo2K56R79xQ7Y1/sEXecXm/a4LtrmQrrVeavdiYrWebN+Lji+goR
        RWpz0tPBVHIn155Gf6DTmKTHoA==
X-Google-Smtp-Source: AA6agR4xRfdJNey5VDI+Z+Ke7JJhcpNk9MMKaJuqCPEr/8M6Ybdcf7CJcsxxJBA11P5XBB6r/pHgyA==
X-Received: by 2002:a05:6512:2202:b0:48a:1153:d3a0 with SMTP id h2-20020a056512220200b0048a1153d3a0mr798559lfu.423.1659625953271;
        Thu, 04 Aug 2022 08:12:33 -0700 (PDT)
Received: from [192.168.1.6] ([77.222.167.48])
        by smtp.gmail.com with ESMTPSA id 11-20020a05651c128b00b0025e51a00a5asm156500ljc.41.2022.08.04.08.12.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Aug 2022 08:12:31 -0700 (PDT)
Message-ID: <96e66425-ff2a-4640-8b96-48fa39943bf9@linaro.org>
Date:   Thu, 4 Aug 2022 17:12:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v5 02/20] dt-bindings: memory: mediatek: Update condition
 for mt8195 smi node
Content-Language: en-US
To:     Tinghan Shen <tinghan.shen@mediatek.com>,
        Yong Wu <yong.wu@mediatek.com>, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lee Jones <lee@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        MandyJH Liu <mandyjh.liu@mediatek.com>
Cc:     iommu@lists.linux.dev, linux-mediatek@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20220804021553.14867-1-tinghan.shen@mediatek.com>
 <20220804021553.14867-3-tinghan.shen@mediatek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220804021553.14867-3-tinghan.shen@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/08/2022 04:15, Tinghan Shen wrote:
> 
> It's because the 'mediatek,mt8195-smi-sub-common' compatible incorrectly
> matches the 'else' conditions for gen2 HW without gals.
> 
> Rewrite the 'else' condition to specifically identify the compatibles
> that utilizing gen2 HW without gals.
> 
> Signed-off-by: Tinghan Shen <tinghan.shen@mediatek.com>
> Reviewed-by: AngeloGioacchino Del Regno
>  <angelogioacchino.delregno@collabora.com>

Unfortunately, your patches got corrupted.


Best regards,
Krzysztof
