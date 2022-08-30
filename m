Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 677135A5EED
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 11:11:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230464AbiH3JKx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 05:10:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230056AbiH3JKv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 05:10:51 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DB3E979E8
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 02:10:50 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id y10so7506865ljq.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 02:10:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=+vFCSexr76HlBCHcrQn/vIs9359eDZxRFYJurz0HFmo=;
        b=CnU/2NHU+5ZWMnfhlGMXRn7vd0rQke55CYHYd58495fnKVaXeP96TZWwX3JyiBzaAo
         tLa1EeOJ5RW6ctdcTRSEo3eXTALArkmWt6QIRzQv11DAXQWF6g90wcU4FLVaZwkdi1Pi
         uOZpDqJ48USDbihnJ+aAYdqMWtptMbU8/4tukJW5RQqjTnL0XKLDhC13VAObrjnIuJO9
         28/UNhVbLU90yiRpL1sjPdMXj7a91Ey1HdW7lB6r7PAVJZcC4BhPX0oR8c5pA0DUSflv
         +9TaVFt7v0YhmhuOIvkVmdHaUHIt8l+CyqgX+mLkxqQ0ya58BSGwjvQ9ab1+nitEB3Ny
         sZwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=+vFCSexr76HlBCHcrQn/vIs9359eDZxRFYJurz0HFmo=;
        b=BNSBOsV8Nx0GOpTGtjXOz7eur6xHpbheeT3L6p3/nFfmJZUJFkf5JQHmPmp8pdbFz6
         q//FAS+6Zw7vwXpPudbWabACXjcB1/fdoar7VVVDg017jIN/Q2mL2C+oqyOx7bX78B8o
         f8V6skWobi41Z82Flf5WmnS+O049rk7m41MpT15JJa0FW+bNDGE1gRQFLRrL8Rayan77
         E+5Ic3jyPBgYinILY9KcBQkVlk1NsbTlq2rb9sZeT24YqI6FDNGhO4g+8Jm/yh53sn6s
         EmuBJoEB4/Oua3GAGE/Fy5n/3/MVhFHJzwpJD+blaQjF0anIYmu216W675wIJxmP23Zj
         S6PA==
X-Gm-Message-State: ACgBeo2Dime04IKcnOrHw37unPvKBSB/mUO7DvPwc7ZKST2WvOHwmUUD
        hAqTk2NA6V8f3bBvtO8wthnHHA==
X-Google-Smtp-Source: AA6agR7NEeEYYtmJpkCNYve98HSAgJWirTpD5nfKvslXsBiBWZAoj/T37NsmSWSobBGbte7eVK4Vig==
X-Received: by 2002:a2e:534e:0:b0:261:d1b5:dbca with SMTP id t14-20020a2e534e000000b00261d1b5dbcamr6223939ljd.187.1661850648437;
        Tue, 30 Aug 2022 02:10:48 -0700 (PDT)
Received: from [192.168.28.124] (balticom-73-99-134.balticom.lv. [109.73.99.134])
        by smtp.gmail.com with ESMTPSA id t11-20020a2e8e6b000000b0025ebaef9570sm1684850ljk.40.2022.08.30.02.10.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Aug 2022 02:10:47 -0700 (PDT)
Message-ID: <23d2764d-17da-5d26-29ed-0b1f5418d004@linaro.org>
Date:   Tue, 30 Aug 2022 12:10:46 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v2 1/3] dt-bindings: mediatek: Add gamma compatible for
 mt8195
Content-Language: en-US
To:     "zheng-yan.chen" <zheng-yan.chen@mediatek.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        "Jason-JH . Lin" <jason-jh.lin@mediatek.com>,
        Singo Chang <singo.chang@mediatek.com>,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20220830063929.13390-1-zheng-yan.chen@mediatek.com>
 <20220830063929.13390-2-zheng-yan.chen@mediatek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220830063929.13390-2-zheng-yan.chen@mediatek.com>
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

On 30/08/2022 09:39, zheng-yan.chen wrote:
> mt8195 uses 10bit-to-12bit gamma-LUT, which is not compatible with
> current 9bit-to-10bit gamma-LUT.
> 
> This patch thus add constant compatible for mt8195, which means that
> mt8195 should only use specified mt8195 gamma driver data.
> 
> Also, delete related compatible from enum, to ensure that
> mt8195 will not accidentally get others' gamma driver data and thus
> cause fatal error.
> 
> Fixes: a79257bae9bf ("dt-bindings: display: mediatek: add mt8195 SoC binding for vdosys0")
> Signed-off-by: zheng-yan.chen <zheng-yan.chen@mediatek.com>
> ---
>  .../devicetree/bindings/display/mediatek/mediatek,gamma.yaml   | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,gamma.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,gamma.yaml
> index a89ea0ea7542..fbd7b9664a78 100644
> --- a/Documentation/devicetree/bindings/display/mediatek/mediatek,gamma.yaml
> +++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,gamma.yaml
> @@ -25,11 +25,12 @@ properties:
>            - const: mediatek,mt8173-disp-gamma
>        - items:
>            - const: mediatek,mt8183-disp-gamma
> +      - items:
> +          - const: mediatek,mt8195-disp-gamma

This is one item, so not a list. With all such cases this should be
dedicated enum.

Best regards,
Krzysztof
