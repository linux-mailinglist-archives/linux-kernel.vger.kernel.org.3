Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87A0E5119C7
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 16:55:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236797AbiD0N5K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 09:57:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236768AbiD0N5H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 09:57:07 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A0133B54E
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 06:53:56 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id l18so3543587ejc.7
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 06:53:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=/VHZPsVMAFIMi2pBbLfD5fKKNKqKbuM/A2SGKvxDgK4=;
        b=AwyCfjozdBWESOd/ALQolQKJzimk9604uiUm6wDtCOrm5sOppI0nnP7ziMhAz/f51o
         yUoGs5n7teJKcGbtpp4NaCK1/YbXG4P0YRKx0GchwQ9vgRF3UzfbEWkpW6xKyra3pN1l
         PnkWJfEI6GymVqL/stEHO/IxUCTYRc23BDHctj09QFj9iz4132J3vnRtPknCK5c+jcpX
         LqdBOHmvHmX3UBdujsR9oaGfVGw6exZ+FyeGxLo3un9Y9FzaEGgaGIPtXu3p+HBW1Ko4
         xhja6WXow4QKqlI9wX3Qd7Z0kLokBkl8Z0hIyMTDjmsUsMc8TcluX6xUkaT8/fgTZJOm
         AGTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=/VHZPsVMAFIMi2pBbLfD5fKKNKqKbuM/A2SGKvxDgK4=;
        b=mC7+w3UST9WoXABo/rk818jStXbDZqhdBdp2qajwgF90dP+lae5/6QppG9hy1Ej3CA
         8ESUfNzhnhertmSKMp/E7uB/xVKeq12nU9Q6e+S5o3oXkcnuXcA2TWHekxaH4K9WHG/w
         ptkxVqmSHD8hPrG4qMpYIbGwVSrYLPvMJ9uoK0m2ndNK1aWjuKKMSf3XXykfGWhSP6WM
         sZ4/sfYjnhVLEI9YlsN24UolZ42dld790VZXFS5RR9F7q8FqBgZD4Av6fBhEFu/Jh8fw
         pKzjEBkNDjZItwHYSP2uqAcCsSgiE5byCRPc/XbvBVp2nTzpA7dytLD6htGNzUTXh65q
         fLbg==
X-Gm-Message-State: AOAM533Rt+06QM/WZ14C3B8t6I0xRzKYJxVurNKlfhGOjnpmGzfJyrAv
        h8WNPzTemxEfIzxpIsa0r34LYiFkRdAR2g==
X-Google-Smtp-Source: ABdhPJylNBSCvH5CoQ2choSP7+rTzl3z8DvUVHYaOOrw5yxaVm205jVSxTlZqO9OF2mULcAztWn0nw==
X-Received: by 2002:a17:907:7f0a:b0:6f3:9712:dfed with SMTP id qf10-20020a1709077f0a00b006f39712dfedmr14448010ejc.557.1651067634774;
        Wed, 27 Apr 2022 06:53:54 -0700 (PDT)
Received: from [192.168.0.154] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id jt24-20020a170906ca1800b006ef606fe5f2sm6762723ejb.61.2022.04.27.06.53.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Apr 2022 06:53:53 -0700 (PDT)
Message-ID: <51be638b-e12d-b9ae-c14b-f51e33d2503e@linaro.org>
Date:   Wed, 27 Apr 2022 15:53:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2 1/1] dt-bindings: nvmem: mediatek: Convert mtk-efuse
 binding to YAML
Content-Language: en-US
To:     "allen-kh.cheng" <allen-kh.cheng@mediatek.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Lala Lin <lala.lin@mediatek.com>,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        Chen-Yu Tsai <wenst@chromium.org>,
        Ryder Lee <ryder.lee@kernel.org>
References: <20220425084800.2021-1-allen-kh.cheng@mediatek.com>
 <20220425084800.2021-2-allen-kh.cheng@mediatek.com>
 <e64bdca8-7b18-b450-830c-ca07946a73fb@linaro.org>
 <9d65b713e3ffdd34dcca532c4c97fa98b124bde4.camel@mediatek.com>
 <0169c4ac-fdce-29b7-553a-14dc7df532d1@linaro.org>
 <a8e212a0e0449e015a33e76b320266376d4b9be6.camel@mediatek.com>
 <89609af9-5feb-0553-5e39-c97c4750b5a1@linaro.org>
 <33c754a7b6e4cd631bb2aeef002d34a6c25d6689.camel@mediatek.com>
 <0c63c24a-8014-2491-095c-77893d2141d9@linaro.org>
 <daca88d63fa844179a3d44affee124584353bec9.camel@mediatek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <daca88d63fa844179a3d44affee124584353bec9.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/04/2022 12:00, allen-kh.cheng wrote:
> I think there are two cases in mediatek efuse dirver now.
> 
> Case 1, 
> const: mediatek,efuse is deprecated.
> const: mediatek,mt8173-efuse is remained. All mediatek chipsets will
> use mediatek,mt8173-efuse as fallback.
> 
> Case 2,
> const: mediatek,efuse is deprecated.
> const: mediatek,mt8173-efuse is deprecated.
> 
> All mediatek chipsets(include ediatek,mt8173-efuse) will use
> mediatek,efuse as fallback.
> 
> Which one do you think is better?

Indeed, I forgot that mt8173 would also fallback to generic efuse.
Indeed let's go with case 2, so your proposal before was correct.


Best regards,
Krzysztof
