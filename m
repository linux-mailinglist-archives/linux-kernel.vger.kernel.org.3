Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7317559745
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 12:03:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231142AbiFXKCb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 06:02:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230521AbiFXKCX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 06:02:23 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 766347A1AC
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 03:02:21 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id ge10so3642741ejb.7
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 03:02:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=GtDx/4MtrxYt8hYrk4oMF8kIZqBnmvODq04HfBb169o=;
        b=EPz+7sJNDH++V1yMWLrc5mRkOsO+NqZvLBrjqveEPoRRpCThZZ41cOoejZek82+QIG
         28oBv6aGSlevvdxpkzAkvGzcY201imYWhlJNA5NPN/m/8oVaPWKug7D1CfKK5p14lz55
         QffaEfY+Y4qMXPxB1unyi1u8N9j+/oWBz86a0NptnrYcqC0/eNqg04+K8wUCbeMzYdbd
         GKmEV6EeeXdzPfmU6cAv14I0z3c8CIK8QUt7x3COZTbu11U1q0p/q8r+5Xmrpth5PUnh
         VVO2uDmWpLrqkcL+bp5CZJkgvJYl9JM6P22l9/2AL9SIT3Mzf3uyf3FQsdeWRsijrCKz
         kLfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=GtDx/4MtrxYt8hYrk4oMF8kIZqBnmvODq04HfBb169o=;
        b=QKqtCaQt8jJqmTSA01utTANjbroQi/acBkJuxOmu0vxIHBUzm/3sxDtl8iV8LHRbG3
         DfPv6vurKWR0yqywY+TBDHGu1/I86ok5HfxoL7d1K40eIieWwnnvBIHRFln+9GZ0xqH/
         KpgMJd1JLRsmtA2H/GejbOslgkwpBLj6LYmTEfrnER8d0RIbTTfEyRY/JFgU1mg+M6c7
         7aOIVE695TmZYV/83ARIW3OKbkvkvfdn4iKlQhhlAy1bBl/e7zmBYV6Yf5qatDRVpR2b
         raYkI2UM5nPfiuPsnz8JtTegZLZfe1+wsRgVlRoCdAWGXASEbzmXSDleGi4JrYE6aySm
         cHOg==
X-Gm-Message-State: AJIora+JLttzMMSGxZLx+aOPghFf+MGePSUCT6nxdvPRaZfdNL3dXC3C
        eASiQvUboO2l9arSkvYly/txRw==
X-Google-Smtp-Source: AGRyM1sefjpiKJ7ux0kcypv9fmdJCP+pCzqZ3OVhjn3YCPERtUsWGvmVzsziW2GqNk3WP0rJOKi51A==
X-Received: by 2002:a17:906:5047:b0:710:456a:695e with SMTP id e7-20020a170906504700b00710456a695emr12397953ejk.433.1656064940041;
        Fri, 24 Jun 2022 03:02:20 -0700 (PDT)
Received: from [192.168.0.234] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id uz12-20020a170907118c00b00711aed17047sm850487ejb.28.2022.06.24.03.02.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Jun 2022 03:02:18 -0700 (PDT)
Message-ID: <5a19a73a-e81a-8f7e-e26c-6c1d8e8331a4@linaro.org>
Date:   Fri, 24 Jun 2022 12:02:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v2] dt-bindings: mmc: mtk-sd: Set clocks based on
 compatible
Content-Language: en-US
To:     =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@collabora.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc:     kernel@collabora.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Wenbin Mei <wenbin.mei@mediatek.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-mmc@vger.kernel.org
References: <20220623154038.771874-1-nfraprado@collabora.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220623154038.771874-1-nfraprado@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/06/2022 17:40, Nícolas F. R. A. Prado wrote:
> The binding was describing a single clock list for all platforms, but
> that's not really suitable: mt2712 requires an extra 'bus_clk' on some
> of its controllers, while mt8192 requires four different extra clocks.
> The rest of the platforms can share the same 3 clocks, with the third
> being optional as it's not present on all platforms.
> 
> Move the clock definitions inside if blocks that match on the
> compatibles. In practice this gets rid of dtbs_check warnings on mt8192,
> since the 'bus_clk' clock from mt2712 is no longer expected on this
> platform.

And now we see that you introduce incompatible change and ABI break.
This should not be combined with that patch but instead separate patch
explaining why ABI break is ok.

Best regards,
Krzysztof
