Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A572599BBA
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 14:17:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348902AbiHSMQG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 08:16:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348546AbiHSMQD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 08:16:03 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F170DFBA4D
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 05:16:01 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id a9so5858078lfm.12
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 05:16:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=iRQAht+syD+WoClHi+abQcpzAmB47QGZmxwK52W8goQ=;
        b=gAnalwOyubLu6+wLXJWbeHG2l/u2fmMgVQ9Vpx1zAjL7bFzAM5ZzxJQcJDTeot4yn+
         i1AJkCiTdquYltpTVt2ufhmroC5Uj/FxxUY6TdC9cKeyHf3f/ViVjSeGky44Bm+U7x03
         7UcAcO4Ol3ry4gVYmwiLyIvga5mk111OYk+z1mTQjAUBS8QbknoRSmXCcSeqxp3J4BAM
         lGS55fHy2ePWP/sOp3TCd1gTP+zRBRsgcPLcehqXQBBqRL8CghXkoR/xGnXewBmiDEEG
         oqeNqSFRTsqamvLgd0nUvdFvmZ0A8GCy2DBVQx14FWpRe3kQcv0YPrMQacMchQJe6X1b
         96MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=iRQAht+syD+WoClHi+abQcpzAmB47QGZmxwK52W8goQ=;
        b=O55yijnzT60v0kN1/8SVok4NuNTOFm5W21NA/Aw+8nRRMb1dMzIeeLcYdlQ12eo26D
         ZZrdNL5Csw4TMhS+b+dgQAV+Za3NTra2isSHmgvNwj/0N7oOTGkIReKo/FOMGfh5GZNk
         gxcTw1by4ntVGSLF5TDhadv1AnLkiLE1A3CLWWW9N0mUxCndcBOTnDX95FC/Ja6vYbIE
         p000XEi3eNrbAE8R41W5a/I/24scvzTYTyJjjD9wIcZ9Z3s457i/HxZLxfpBM9WP6tB0
         eaFE+4cvp4rF1HasSEoTUT8WG2dsTnRill1+5NewONdLYY1S3KFV0Sid9AhJPE/33wgs
         CmZg==
X-Gm-Message-State: ACgBeo2uKp0z/tJjTF+s9uP7IUcgmvG3USYqriupjEACXH1DimG0qvI6
        nR3s61X9rmQkJJfHiu+iVrKnjQ==
X-Google-Smtp-Source: AA6agR6ZzDgldit3bbnQaHeffN9D/ccyNG3aT6Z0pYd8NszNFSXmXT7adl+3BQtJYB1uFOadxcnBlQ==
X-Received: by 2002:ac2:5e75:0:b0:492:c50a:3a89 with SMTP id a21-20020ac25e75000000b00492c50a3a89mr1449763lfr.68.1660911360346;
        Fri, 19 Aug 2022 05:16:00 -0700 (PDT)
Received: from ?IPV6:2001:14bb:ac:e5a8:ef73:73ed:75b3:8ed5? (d1xw6v77xrs23np8r6z-4.rev.dnainternet.fi. [2001:14bb:ac:e5a8:ef73:73ed:75b3:8ed5])
        by smtp.gmail.com with ESMTPSA id t14-20020a2e8e6e000000b00261af4754bbsm594964ljk.41.2022.08.19.05.15.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Aug 2022 05:15:59 -0700 (PDT)
Message-ID: <438da392-f419-ad76-7e91-aa4aab36e12c@linaro.org>
Date:   Fri, 19 Aug 2022 15:15:58 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 2/7] dt-bindings: phy: mediatek,tphy: add property to set
 pre-emphasis
Content-Language: en-US
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Eddie Hung <eddie.hung@mediatek.com>
References: <20220819091344.2274-1-chunfeng.yun@mediatek.com>
 <20220819091344.2274-2-chunfeng.yun@mediatek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220819091344.2274-2-chunfeng.yun@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/08/2022 12:13, Chunfeng Yun wrote:
> Add a property to set usb2 phy's pre-emphasis.
> 
> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> ---
>  Documentation/devicetree/bindings/phy/mediatek,tphy.yaml | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/phy/mediatek,tphy.yaml b/Documentation/devicetree/bindings/phy/mediatek,tphy.yaml
> index 848edfb1f677..aee2f3027371 100644
> --- a/Documentation/devicetree/bindings/phy/mediatek,tphy.yaml
> +++ b/Documentation/devicetree/bindings/phy/mediatek,tphy.yaml
> @@ -219,6 +219,13 @@ patternProperties:
>          minimum: 1
>          maximum: 15
>  
> +      mediatek,pre-emphasis:
> +        description:
> +          The selection of pre-emphasis (U2 phy)
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        minimum: 1
> +        maximum: 3

Instead of hard-coding register values in bindings, you should rather
describe here feature/effect. If it is in units, use unit suffixes. If
it is some choice, usually string enum is appropriate.

Best regards,
Krzysztof
