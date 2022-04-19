Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23D9250712F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 16:58:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345937AbiDSPAo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 11:00:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244673AbiDSPAi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 11:00:38 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 224343B026;
        Tue, 19 Apr 2022 07:57:54 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id n126-20020a1c2784000000b0038e8af3e788so1675626wmn.1;
        Tue, 19 Apr 2022 07:57:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=VSfNNxCMPbot3TUeMFQDYDmYhnDExeycdgTmMkPBSiw=;
        b=K89+PXfaCFu09OY7bsgh+7qQX9SHhTwwKvG8GnMvsy4nm507xqyK3sHZ67MuOBouWK
         4rkUK91/51WwE/E/BbtbqNlYpk2W+/m+3Chgf1DgQ/4ZxSP0s1wqpSXNl7+UdgoWj+Xs
         DJy4bCzYn6/vlOL+ZNY9yNQOs/kv50OdjLzRncPuI5wSrw+ftTvwxvHd1FHSO3Lksu+l
         gBhsZjxwGFJya6sN2Lt1XOMX7olBrNleXGG5RLgiKeUMjp6130k6KNYzjV95UMRI84s7
         H+NLnzuto2Whpp86h7jTvQ96wMZQqVnrQDa2fWzSRA2L9LVCV6/K5Tlwf7tuM/Cl+x+g
         jazw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=VSfNNxCMPbot3TUeMFQDYDmYhnDExeycdgTmMkPBSiw=;
        b=PYHIOx0iUuZUYCAZGjcjEN1S97gv7502HEsoozFCy41M+raaeUg1aMFGV5UXUW58WJ
         TsmiBIHM2hSODmaUSt7quLt+qQZ/7mcxp9SDvX0vUbz+IMS/kckEO4HUJEathddwEBK+
         ZNNkNORH4N9E1GCmHKwsbMDLbZgAF7Mkdy1cSBpqom/I2lXkiar3CwVdfUbaTa16XdRX
         3JccoShIuUt+PgblZyleWaTgvWhp+2MZ3sQOUv1cPyC+U5X2mNgvhlEj8xGIcyDuRnGN
         7qxpwEDwykf+tT15GOyU+HNi2D4r3LpY5pyTrWYWyfOKeFlHRSryB4SCcd56eaTxP11O
         /t8A==
X-Gm-Message-State: AOAM530LYwcQ6FHPFJz9V3gzT1QkKt44YJ88OqoB72iiW5exWO1ql0Uo
        emedofRjXZzqm86VWTu4KlsKaYg6gDo=
X-Google-Smtp-Source: ABdhPJwGtnkzLvabPxjsO/IdFw1I83x6czWqIQw5VNsuYzxUmENRbL2f1OWVQ5C8fTTybXwA29UdQg==
X-Received: by 2002:a05:600c:2197:b0:38e:b80c:526a with SMTP id e23-20020a05600c219700b0038eb80c526amr19889290wme.76.1650380272642;
        Tue, 19 Apr 2022 07:57:52 -0700 (PDT)
Received: from [192.168.2.177] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id o10-20020a5d47ca000000b0020a992ce36esm4933973wrc.1.2022.04.19.07.57.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Apr 2022 07:57:51 -0700 (PDT)
Message-ID: <db521557-09ea-2c34-24e5-3bf71961b4fe@gmail.com>
Date:   Tue, 19 Apr 2022 16:57:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 2/5] dt-bindings: arm: mediatek: mmsys: add mt8195 SoC
 binding
Content-Language: en-US
To:     Rex-BC Chen <rex-bc.chen@mediatek.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, chunkuang.hu@kernel.org,
        p.zabel@pengutronix.de
Cc:     airlied@linux.ie, angelogioacchino.delregno@collabora.com,
        jason-jh.lin@mediatek.com, nancy.lin@mediatek.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20220419033237.23405-1-rex-bc.chen@mediatek.com>
 <20220419033237.23405-3-rex-bc.chen@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20220419033237.23405-3-rex-bc.chen@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 19/04/2022 05:32, Rex-BC Chen wrote:
> From: "jason-jh.lin" <jason-jh.lin@mediatek.com>
> 
> In the SoC before, such as mt8173, it has 2 pipelines binding to one
> mmsys with the same clock driver and the same power domain.
> 
> In mt8195, there are 4 pipelines binding to 4 different mmsys, such as
> vdosys0, vdosys1, vppsys0 and vppsys1.
> Each mmsys uses different clock drivers and different power domain.
> 
> Since each mmsys has its own mmio base address, they could be identified
> by their different address during probe time.
> 
> Signed-off-by: jason-jh.lin <jason-jh.lin@mediatek.com>
> Reviewed-by: CK Hu <ck.hu@mediatek.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Applied, thanks

> ---
>   .../devicetree/bindings/arm/mediatek/mediatek,mmsys.yaml         | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.yaml b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.yaml
> index 6c2c3edcd443..6ad023eec193 100644
> --- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.yaml
> +++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.yaml
> @@ -31,6 +31,7 @@ properties:
>                 - mediatek,mt8183-mmsys
>                 - mediatek,mt8186-mmsys
>                 - mediatek,mt8192-mmsys
> +              - mediatek,mt8195-mmsys
>                 - mediatek,mt8365-mmsys
>             - const: syscon
>         - items:
