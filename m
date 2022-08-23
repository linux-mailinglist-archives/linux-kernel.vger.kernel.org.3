Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F041059D76F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 11:59:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351691AbiHWJkG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 05:40:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351066AbiHWJjL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 05:39:11 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EF6098C81
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 01:41:05 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id m3so13035905lfg.10
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 01:41:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=W0I5qGBRorIzU4/M9Z2JKZBtnIIxK+lV/fotyWPu8eo=;
        b=YfivAOPyp/S0t3HR39n5l6tvClobRS3WjgJLwTgsVGDusGuqa7DeH4gqCzzVzFxepy
         OW9z5QACGE6BtNdpfnV1/HM8WsRwMVBLMh7YHcIyDUF2/MY8bcVlCehu+nEIZUAsWx9c
         fkwMmvwOK97l7bl4OC/J8rsmNB/AQuWLY4nvO6ILnWgRoezZMuVZ3kY822corbLuFOpD
         UYCZ+XlyG4PQbltck8mA2bLjjbXpqsDw1J5IxUXZd+hrmHOhLc70LrN2dJXq+xs6XeFw
         ThxIm7/BGfRz9voj2AhZY9VnjvoLi91SlfokA7MoysD+QWK15MHumcudOkm1Oi0A03xn
         Fw8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=W0I5qGBRorIzU4/M9Z2JKZBtnIIxK+lV/fotyWPu8eo=;
        b=7iZccmghhGbEvC90gQKxKjZ6T2uWkuyvs6f/RmvekDtnKMps7B+0PLFvpZcC+KTUsR
         bF2iJW8WSuvoQehjM5v+nPaF/83n+FR9d3HUs6qa9yUYX7WBRvPIYMYKUrcNgn7V1S5L
         xXnSchwv7aDpy9wFiqRh4p7v+iFYI2bI5LKtOVakDHgeTSn6Cs0L4eOh9D6/V/o1fUqh
         Vdv/3H76EtDTc4LAQb6yosclMQ7LNFisEDMcg6LqIVls/No8c8Vt7jV7S7yrzaGmu8In
         uzerVcu5+SzOytJeNLmsIYmntBg2//RvEuBRNjaI9WQsrZUBtY+qS44USUtetsGCG5Fh
         QlPg==
X-Gm-Message-State: ACgBeo27UK5BuWnY+CxUQCF+OpRcauV7Mxxik5jk2SxVWWqpsTPXL10n
        KTebMuvB9MYjjxIZWHkOO6L4fg==
X-Google-Smtp-Source: AA6agR5+rUJS0PTf+2wjIEbj+myfHGedVpyDY4058HVzXxye9slAAObIkitw5XGxHJ1FVj4NKKE3Hg==
X-Received: by 2002:a05:6512:118d:b0:492:da96:689 with SMTP id g13-20020a056512118d00b00492da960689mr4163856lfr.244.1661244020402;
        Tue, 23 Aug 2022 01:40:20 -0700 (PDT)
Received: from [192.168.0.11] (89-27-92-210.bb.dnainternet.fi. [89.27.92.210])
        by smtp.gmail.com with ESMTPSA id t20-20020a2e8e74000000b0025e1ec74e25sm2247874ljk.43.2022.08.23.01.40.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Aug 2022 01:40:19 -0700 (PDT)
Message-ID: <39f63588-bc88-a716-bc66-7f93c4aabc56@linaro.org>
Date:   Tue, 23 Aug 2022 11:40:18 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 3/3] arm64: dts: Modify gamma compatible for mt8195
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
References: <20220822091945.21343-1-zheng-yan.chen@mediatek.com>
 <20220822091945.21343-4-zheng-yan.chen@mediatek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220822091945.21343-4-zheng-yan.chen@mediatek.com>
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

On 22/08/2022 12:19, zheng-yan.chen wrote:
> Modify gamma compatible for mt8195.
> 
> Signed-off-by: zheng-yan.chen <zheng-yan.chen@mediatek.com>
> 
> ---
>  arch/arm64/boot/dts/mediatek/mt8195.dtsi | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8195.dtsi b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
> index a50ebb5d145f..8504d01b103a 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8195.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
> @@ -2021,8 +2021,8 @@
>  			mediatek,gce-client-reg = <&gce0 SUBSYS_1c00XXXX 0x5000 0x1000>;
>  		};
>  
> -		gamma0: gamma@1c006000 {
> -			compatible = "mediatek,mt8195-disp-gamma", "mediatek,mt8183-disp-gamma";
> +		gamma0: disp_gamma@1c006000 {

No, really, no.

Not explained in commit msg, violates naming convention, violates coding
style, not related to the patch at all.

Best regards,
Krzysztof
