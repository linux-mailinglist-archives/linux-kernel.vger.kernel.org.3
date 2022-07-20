Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2560157BCDD
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 19:39:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235327AbiGTRja (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 13:39:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230202AbiGTRj2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 13:39:28 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCD337098F
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 10:39:26 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id y11so31465065lfs.6
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 10:39:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=aeyafCkyinZJZTTcPy1wEfXMzXWZcIm0MV4FRs14iJQ=;
        b=zreXvg79hkBxKuShfS2H1ZVu3CjpX0spc5x+RYWSF3KMxuyjz5fLD7BBgfbuNGIvaN
         a2Wol5GaBcqFJs24Or/Cx8yVs8kKCzk2Q2Q+Kbw4VACBuD0IgavdZPfksPMWyjvHRkA3
         Xtom3dAIkGJ5NScEK9Dlt+XbFEMBKHcftw6XKQlhV5SMy5nxSAzs47rcxyG3JKnh9vEl
         /OKrKhIMKbRVpK72I4APWWgYq4traCLcCWzFv5auA0G14VIFu2oCCHlZ6ikxN3c33nsV
         XkKmrckQcwEb+7CWFRCHpGWzPJugLd1eKmVhWrUCUnW87mf1rv/60AlQED8RF/yHnS9t
         ELtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=aeyafCkyinZJZTTcPy1wEfXMzXWZcIm0MV4FRs14iJQ=;
        b=nQT4MQIE0ih6dZdF4BTg0KyTKD3xXB5G1ouscnzjA+VRhw8s3NJPW+egyWo/KLKXaU
         qLuFPzAqlYEdTWiNFYj7hbE483kdv5V6PXYXxO8E20ODMoPGT1E13oU/mHyHB/HbS77u
         JW21HkRSl/rBXUBvCFLJsIC7JrYhnikd0KqtSI+ohX352DlvzV69Ov7vjSzQzbTVQ8dp
         7lv1CIByzQ2aIh3fAs+OnCT1zUNfvwarkXp2FL7sCsfwELzepK5bl+dfLz+1w97sBils
         UsPx+qVPOwOioWJXjWmFs174YGzYaQom8AUsF5GrMtTj11qLzWPbmIuqtoxQZIsTjmys
         NO+w==
X-Gm-Message-State: AJIora+Xyh9huMwvUSvWSgSuGU648X0xVBiD3eBUKafR42st7k7Rm2hw
        Akrpy6UmMYMBtjn720drHoeWRA==
X-Google-Smtp-Source: AGRyM1tlok4eLvijqT1LvZXgtABKbS0mRRyNVkb8xzG9GzfNEkfDR+8raI0dXp18XCp0w8HM7jBCAA==
X-Received: by 2002:a05:6512:410:b0:489:d17a:b2c0 with SMTP id u16-20020a056512041000b00489d17ab2c0mr21052431lfk.493.1658338765232;
        Wed, 20 Jul 2022 10:39:25 -0700 (PDT)
Received: from [192.168.115.193] (89-162-31-138.fiber.signal.no. [89.162.31.138])
        by smtp.gmail.com with ESMTPSA id z13-20020a19504d000000b00489e64dcf75sm3940177lfj.204.2022.07.20.10.39.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Jul 2022 10:39:24 -0700 (PDT)
Message-ID: <085a003e-576d-b39a-60ce-ca8f53c89d43@linaro.org>
Date:   Wed, 20 Jul 2022 19:39:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v3 08/21] arm64: dts: mediatek: Update mt81xx scpsys node
 to align with dt-bindings
Content-Language: en-US
To:     Tinghan Shen <tinghan.shen@mediatek.com>,
        Yong Wu <yong.wu@mediatek.com>, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lee Jones <lee.jones@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        MandyJH Liu <mandyjh.liu@mediatek.com>
Cc:     iommu@lists.linux.dev, linux-mediatek@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20220720123023.13500-1-tinghan.shen@mediatek.com>
 <20220720123023.13500-9-tinghan.shen@mediatek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220720123023.13500-9-tinghan.shen@mediatek.com>
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

On 20/07/2022 14:30, Tinghan Shen wrote:
> Update scpsys nodes using simple-mfd in mt81xx SoC devicetree
> to align with the bindings.

"Update" is not accurate enough description. The same in commit title.
It answers "why" you are doing it, but does not answer what exactly you
are changing here and what is the effect. IOW, you need to explain the
true logic behind it - 10006000 is not power domain provider etc.

> 

Best regards,
Krzysztof
