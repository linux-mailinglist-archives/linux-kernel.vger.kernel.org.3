Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C1064E92E3
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 12:57:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235017AbiC1K70 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 06:59:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240419AbiC1K7Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 06:59:25 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0357454FB4;
        Mon, 28 Mar 2022 03:57:45 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id h23so19771195wrb.8;
        Mon, 28 Mar 2022 03:57:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=GGvSFlPXU872KWgGig8qcLQpk/W2IByUtUFzj9tQrwE=;
        b=AA55u6uE5y4cKgL4pCCZV88DledptqdMiXNeg8qobCmiht5JRGekM6Ndl/JKoKZo90
         YXdYQai7+hqxjNkVcyqQLQC/T3Q17krM4q6gJGOTi3X8WLGum74tp8hoTM0lKa5E0Ldk
         83Uk3MOK4vo72r0btFuWz5nBX7+QmJCSb5NT34lLPl5JSHpwn5FhH0Ds0cdZUO+aXpc/
         +FoWBf/BJJS6pyEgAp35Mw5gLRdGx+b/pBH4Y7oh5L+SAJxEilAjSmUREZAYdyysLE5r
         FeTbq1CeU8+yan26uhIGV4ko5g0xveeDXIYRWhVvZKuMtZWiSRM/1C19GNzeBO8mDY8l
         A6hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=GGvSFlPXU872KWgGig8qcLQpk/W2IByUtUFzj9tQrwE=;
        b=XQ/QepoumhyFcdU7w+4jYFDPzDlLAJ/wPomYXP+dfXpQsSGIF0jTPycUtBEQCpI20+
         cTYIFxrILFcJ4Gc/rjcLbX5jNOC0qdoae4VTw8NaVSQ2T1j+vJcTZa9Sc0/ZIZ60/ymJ
         paMK/kBTozjTh5rQtnbikqtZ9KPtAuxpmVA9WfDkIY/4Fdd/eoq2RKC0Ws5t0UJixj3E
         Oc9fgYsF86PjT1bzpXHzLAAr7x/ie/oNLycQXVKrxDcD7nPwMmWwnryq/ti2eo/2Turj
         hsMGKbB4CWUIUT+woI/bRE1I7FgDLKcecWcL/wYM2LDWyrHSWhIns9kUYDUu0iz8uuty
         Dosg==
X-Gm-Message-State: AOAM53265tqjhPAaown9hKj+RAJWZdGCgy+fJXEIq26m9YazUGJ0KDm+
        djYk7d+H1KrVywIWDWlXbOI=
X-Google-Smtp-Source: ABdhPJxH6AnH4UIVT8ZaKUAIGV7UzNt4wvXzbencOS83G8zgcWCHLqOF/SpFWk2ojiP9ntq09Pg/NQ==
X-Received: by 2002:adf:ebc7:0:b0:1ee:945a:ffb4 with SMTP id v7-20020adfebc7000000b001ee945affb4mr23153658wrn.641.1648465063551;
        Mon, 28 Mar 2022 03:57:43 -0700 (PDT)
Received: from [192.168.0.32] ([137.101.87.65])
        by smtp.gmail.com with ESMTPSA id y11-20020a056000168b00b002041af9a73fsm13920567wrd.84.2022.03.28.03.57.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Mar 2022 03:57:42 -0700 (PDT)
Message-ID: <b6f3be8a-6582-0cb5-5563-58f87e265bd6@gmail.com>
Date:   Mon, 28 Mar 2022 12:57:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v4 19/22] arm64: dts: mt8192: Add the mmsys reset bit to
 reset the dsi0
Content-Language: en-US
To:     Allen-KH Cheng <allen-kh.cheng@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Project_Global_Chrome_Upstream_Group@mediatek.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        Chen-Yu Tsai <wenst@chromium.org>,
        Ryder Lee <ryder.lee@kernel.org>,
        Hui Liu <hui.liu@mediatek.com>
References: <20220318144534.17996-1-allen-kh.cheng@mediatek.com>
 <20220318144534.17996-20-allen-kh.cheng@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20220318144534.17996-20-allen-kh.cheng@mediatek.com>
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



On 18/03/2022 15:45, Allen-KH Cheng wrote:
> Reset the DSI hardware is needed to prevent different settings between
> the bootloader and the kernel.
> 
> Signed-off-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>

Applied thanks

> ---
>   include/dt-bindings/reset/mt8192-resets.h | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/include/dt-bindings/reset/mt8192-resets.h b/include/dt-bindings/reset/mt8192-resets.h
> index be9a7ca245b9..764ca9910fa9 100644
> --- a/include/dt-bindings/reset/mt8192-resets.h
> +++ b/include/dt-bindings/reset/mt8192-resets.h
> @@ -27,4 +27,7 @@
>   
>   #define MT8192_TOPRGU_SW_RST_NUM				23
>   
> +/* MMSYS resets */
> +#define MT8192_MMSYS_SW0_RST_B_DISP_DSI0			15
> +
>   #endif  /* _DT_BINDINGS_RESET_CONTROLLER_MT8192 */
