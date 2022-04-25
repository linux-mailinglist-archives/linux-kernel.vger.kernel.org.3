Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1600250DB70
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 10:42:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237123AbiDYIou (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 04:44:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237117AbiDYIop (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 04:44:45 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAB7082D3A
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 01:41:39 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id bv19so28192839ejb.6
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 01:41:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=+pzRVC0gT9zFiZtrDMedaHXZTcAEp3gFNZ9jUtyJUSY=;
        b=gcfVAfz/SAa5L6EAzl0d7kO/pyYnSWLEY6OCjuijoNMVR99RSWK9cVFketV78ewi1H
         Ew0QpplSg3Y4hSY4ba2DbNsv6o5V+71OlPeDcLKm2YIMA5XS42Ip/OZzBNJ+jbyUIDOT
         snK3oFi0DQz4OfeKc0usAxbgN8t+KohsIfgiZnkAAXCQA6HRVBIVOaC/Xm2zM/2Ebdhh
         vcTiT0uaEYLi8y7pL3L1SLnqMPCjU9o0GVqoSatDU3ljfwmxf0Gd9w+Fe0Qcg6XOZzJJ
         Se1aoaTJ0DeTwQA9oaDBdfM1XMGOrIAySC8azw4lJtpiQ94CU1UcxeDntWJ0IPZ99BnA
         SUUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=+pzRVC0gT9zFiZtrDMedaHXZTcAEp3gFNZ9jUtyJUSY=;
        b=mYYDRWeAYF70n3CUOwNSNiy1dEiQc8djFB8aMzooK1VdADpqQyyvhLbVbMeuwjgcB2
         V2LwvvcY+m8YRNF1vxBjA2T0Xy38oyBez3AhTd6qcrCVuxNtzVLoK2MTY1bPojgKY2EZ
         Nr/BH7O3se1MqBa//r/IrdxN+UX8I0RXFseBt6FNGpYwqS+aXv6xjtvHGbK5LU4FVBAg
         qTN4CcYfnyWpTXgOC7TvBQe8jL5gOStMO9abMqSSF8G/4a3IFCM2izQVj+M1Q8+Wv4xq
         T2jYKtcZUUpXokQ1xHmDcxolbAEfBwCxaW3PNPQmf5L7rQ0Mo5/eNYJNCWdOfydINT7a
         TnAA==
X-Gm-Message-State: AOAM531gfuUZJHXDLB6sKIDGe/5YIQHaCbkeLVCz9bGAYY2mvwihJbo5
        QDTghpzDHwR5iAPa1OBEeeDL0w==
X-Google-Smtp-Source: ABdhPJzUz/psaa+nbuSchDlMQ1Kx2x7dlomMaZKQcYPZHDJjZTlyyQ5QQ+jEZR6VnuzLVIoagHwRiw==
X-Received: by 2002:a17:907:3d94:b0:6f3:8b47:cd95 with SMTP id he20-20020a1709073d9400b006f38b47cd95mr5577978ejc.134.1650876097639;
        Mon, 25 Apr 2022 01:41:37 -0700 (PDT)
Received: from [192.168.0.240] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id bq23-20020a056402215700b0041d8fcac53asm4302602edb.23.2022.04.25.01.41.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Apr 2022 01:41:37 -0700 (PDT)
Message-ID: <9f5fafe8-c032-2aac-185b-8ecb5c52f363@linaro.org>
Date:   Mon, 25 Apr 2022 10:41:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2 3/3] dt-bindings: arm: mediatek: infracfg: Convert to
 DT schema
Content-Language: en-US
To:     Yassine Oudjana <yassine.oudjana@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Sam Shih <sam.shih@mediatek.com>, Ryder Lee <ryder.lee@kernel.org>,
        devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Yassine Oudjana <y.oudjana@protonmail.com>
References: <20220424084647.76577-1-y.oudjana@protonmail.com>
 <20220424084647.76577-4-y.oudjana@protonmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220424084647.76577-4-y.oudjana@protonmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/04/2022 10:46, Yassine Oudjana wrote:
> From: Yassine Oudjana <y.oudjana@protonmail.com>
> 
> Convert infracfg bindings to DT schema format. Not all drivers
> currently implement resets, so #reset-cells is made a required
> property only for those that do. Using power-controller in the
> example node name makes #power-domain-cells required causing
> a dt_binding_check error. To solve this, the node is renamed to
> syscon@10001000.
> 
> Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
> ---
>  .../arm/mediatek/mediatek,infracfg.txt        | 42 ----------
>  .../arm/mediatek/mediatek,infracfg.yaml       | 81 +++++++++++++++++++
>  2 files changed, 81 insertions(+), 42 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,infracfg.txt
>  create mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,infracfg.yaml
> 
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
