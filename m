Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F065A5A4FA0
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 16:51:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230179AbiH2Ou7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 10:50:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229783AbiH2Ou4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 10:50:56 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8301B8A7ED;
        Mon, 29 Aug 2022 07:50:55 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id v16so7776271wrm.8;
        Mon, 29 Aug 2022 07:50:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=145gOx86toxQClz74kJe2cl51jbo56v2bZWCBfLvedQ=;
        b=B5he0l1NJFsAgePzHNhCVPDO2fy1g3NhcfJGseemre59ndFS6y61LR6DcTjGcrgmdo
         ECBwnGuLuzwBTtq3IZ28HPY4s0dTrIk21F8ZYQPsHabpRhzbPhdKtUwSsMXgXbN6JYUv
         ScNzIlKtaVKsItAVP04255Lx3W8Zqqc58MywaWSYNRv0pcOMiEONyRwE0pRBsXU7q2YC
         jKg+hri79GrV8N2uQFutbuhUy4HhCJZq4UcrVWlLHalo6slkhKTNE6Hovk+AkjMvQaa8
         5zLQhWcvLOMSf9HMOdpdQEaOrhQmOLYYvFWcETi/eogaptjlhmkWQflMW96IbPUDKTnV
         F36Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=145gOx86toxQClz74kJe2cl51jbo56v2bZWCBfLvedQ=;
        b=Uesyu1bFmN6fAovSz9w2W6woaMaRxz4CjRBo0uihFps/n9G34M+/ehA48lfLFhtk7s
         RuPrKo6xxTEDKMCMQ25KQ2/jEyyLpeF1Ds+FUT3qhbYknYpjMfhU5ri8hVUzKQlhxjZz
         Q0uptOxnhyA+7yq93FdrTkzPtPjeuDtpZs8pkGannpDnpWCRlnX5Bemmk9hMhSVm95CP
         Pkfo/2QClfuBXTzhzoVJmJcY73haBujq1xs/ffTPALKUUzuQGQAP5570rcYLVbQspT5V
         ny36IynGnUsEzemD2Mz/3txVIFrGgWxm2saEJfPY5ln+4pq6ZzQxJSQMVp0P/zuFmpGS
         mqAQ==
X-Gm-Message-State: ACgBeo2rAfsl6OvBTQD4xtdQhHOCDfSuCodlaRymNVb9Mjo8tu9zQI8I
        QJST6nWdfaulHPmcSRlT1lw=
X-Google-Smtp-Source: AA6agR72nddPfdDk/RdTmQ8R/2eOxuvH8F7fe3aQN3rrRmg8l2imUWwdU7Z5hPjZ73Uy8vf5OGQdBQ==
X-Received: by 2002:a05:6000:1863:b0:225:8a83:fbea with SMTP id d3-20020a056000186300b002258a83fbeamr6698535wri.277.1661784654126;
        Mon, 29 Aug 2022 07:50:54 -0700 (PDT)
Received: from [192.168.0.30] ([47.62.125.55])
        by smtp.gmail.com with ESMTPSA id b2-20020adff902000000b00226dfac0149sm1036095wrr.114.2022.08.29.07.50.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Aug 2022 07:50:53 -0700 (PDT)
Message-ID: <cd178f8c-76f0-4494-71c4-a658ee517b70@gmail.com>
Date:   Mon, 29 Aug 2022 16:50:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH v3 0/5] Complete driver nodes for MT8192 SoC
Content-Language: en-US
To:     Allen-KH Cheng <allen-kh.cheng@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Project_Global_Chrome_Upstream_Group@mediatek.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        Chen-Yu Tsai <wenst@chromium.org>
References: <20220712114046.15574-1-allen-kh.cheng@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20220712114046.15574-1-allen-kh.cheng@mediatek.com>
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

Whole series applied.
Thanks!

On 12/07/2022 13:40, Allen-KH Cheng wrote:
> This series are based on matthias.bgg/linux.git, for-next.
> 
> I remove vcodec lat and core nodes PATCH from series and will comfirm
> clocks usage then resend PATCH.
> 
> Also should reference below PATCH for dsi in chunkuang.hu/linux.git
> dt-bindings: display: mediatek: dsi: Convert dsi_dtbinding to .yaml
> 
> changes since v2:
>   - add mmsys #reset-cells PATCH
>   - add missing fallback compatible
>   - add display aliases
>   - remove vcodec lat and core nodes PATCH
> 
> changes since v1:
>   - add Reviewed-by Tag
>   - rename dsi-phy from dsi-dphy
>   - add missing power-domains in disp mutex
>   - Add remove mt8192 display rdma compatible PATCH in series
>   - use "mediatek,mt8183-disp-rdma" as fallback
>   - remove mediatek,larb from rdma node
>   - remove syscon-dsi and add power-domains in dsi
>   - add reset property in dsi and mt8192-resets.h
>   - correct Typo: s/ndoe/node in commit message
> 
> Allen-KH Cheng (5):
>    arm64: dts: mt8192: Add pwm node
>    arm64: dts: mt8192: Add mipi_tx node
>    arm64: dts: mediatek: Add mmsys #reset-cells property for mt8192
>    arm64: dts: mt8192: Add display nodes
>    arm64: dts: mt8192: Add dsi node
> 
>   arch/arm64/boot/dts/mediatek/mt8192.dtsi | 188 +++++++++++++++++++++++
>   1 file changed, 188 insertions(+)
> 
