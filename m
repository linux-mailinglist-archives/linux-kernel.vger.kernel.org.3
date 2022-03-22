Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB69C4E45B8
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 19:08:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240190AbiCVSJq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 14:09:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236572AbiCVSJo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 14:09:44 -0400
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D86165D13;
        Tue, 22 Mar 2022 11:08:16 -0700 (PDT)
Received: by mail-ej1-f45.google.com with SMTP id dr20so37415001ejc.6;
        Tue, 22 Mar 2022 11:08:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:from
         :subject:content-language:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=xklhjzZKzADY2xRK99pbIfVzHLVmN5wMRTs9ZPfdbng=;
        b=WsNBOrifNwv/I038wgPe5EYzd30do0PnzUKANhA40zPTxqqc3H1gnkxqhDiX+dH8z7
         9OQpnBLd+IjVrDDE04iyYfbk9rUn28y+oT1QrLhW+Z1n04ZJpayxiOeqZYxrwgxKB3DI
         /UUfebykAJq7LYMlR84IL4TfNF8XFNwWGfOUuwf9tvMWocZV7hVAUp5iU7wxia4uYmzK
         YEDdGjuu7Zsh+wh8vZoI5TXRJ3bH0JAZrPH17u4toZn8jAIzV3erqkwOIKXSe+JSzFms
         t/fYjMy8fpaF4Ucz75LZ0Pa2W3n/sDOLRW0+bXQy86+kW2DSli63T9zD6f3oN57blHWQ
         A0QQ==
X-Gm-Message-State: AOAM530K6j+PoNmp8aAh2ImOi57CHD+41bxYD8ZoUA5pjuXY7gE3ZNLg
        zeTSGcnr9TtyHH5LZGtiecs=
X-Google-Smtp-Source: ABdhPJxUAx4IdVJWahehxkglRm1NqufvIFeuOA2YpXQp/NK47AD8PHQ9rSGI79bpqQ4VfewQip7ZhA==
X-Received: by 2002:a17:906:58cd:b0:6df:f5f8:3037 with SMTP id e13-20020a17090658cd00b006dff5f83037mr13658660ejs.531.1647972494886;
        Tue, 22 Mar 2022 11:08:14 -0700 (PDT)
Received: from [192.168.0.17] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.googlemail.com with ESMTPSA id l20-20020a1709062a9400b006ce71a88bf5sm8516663eje.183.2022.03.22.11.08.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Mar 2022 11:08:14 -0700 (PDT)
Message-ID: <a8eb005e-3fa4-ef60-c94c-5a6decb7a5df@kernel.org>
Date:   Tue, 22 Mar 2022 19:08:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
From:   Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH v3 1/2] dt-bindings: phy: mediatek: Add YAML schema for
 PCIe PHY
Content-Language: en-US
To:     Jianjun Wang <jianjun.wang@mediatek.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chen-Yu Tsai <wenst@chromium.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     Wei-Shun Chang <weishunc@google.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        rex-bc.chen@mediatek.com, randy.wu@mediatek.com,
        jieyy.yang@mediatek.com, chuanjia.liu@mediatek.com,
        qizhong.cheng@mediatek.com, jian.yang@mediatek.com
References: <20220322024705.9665-1-jianjun.wang@mediatek.com>
 <20220322024705.9665-2-jianjun.wang@mediatek.com>
In-Reply-To: <20220322024705.9665-2-jianjun.wang@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/03/2022 03:47, Jianjun Wang wrote:
> Add YAML schema documentation for PCIe PHY on MediaTek chipsets.
> 
> Signed-off-by: Jianjun Wang <jianjun.wang@mediatek.com>
> ---
>  .../bindings/phy/mediatek,pcie-phy.yaml       | 75 +++++++++++++++++++
>  1 file changed, 75 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/mediatek,pcie-phy.yaml
> 


Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>


Best regards,
Krzysztof
