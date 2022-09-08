Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60C445B1DF1
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 15:07:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232116AbiIHNHC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 09:07:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231908AbiIHNG7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 09:06:59 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60C4DAD99B
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 06:06:54 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id z25so27654774lfr.2
        for <linux-kernel@vger.kernel.org>; Thu, 08 Sep 2022 06:06:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=gOAXxPoSqwbSOG0ofk9DT91+7QBHKnohIB4quLfJkAk=;
        b=i+RfaVmr6TwYbrjKu2rs37bY30XQzhyA7yLm4s9A22Uu+/HQYoKfOy5Q03iILzxn65
         6NjhMKI92f/OlDQunY7TBeXo9SKKxkIw89N/07527phtr5Bp1ly67fDqatRR5S9spGBN
         mdYeT6DfN5K1a+fvCDD+94yXS/UAH2WXTnxZ17VjF6pW7Akk0qHnlLc+QKVHKiMFcrpP
         cPkFIMjqdfzWFGWn0ymj4wGf5NIFAvG+Z2078mv7kYKNBZtPQ9rAz86zbmlHA8F0U7Uz
         sb8k649vh0kUt6smBTqEHiugCuLgC4ZnJcji4aaAL/hQBUkyYZQv6DD7FWW4YpSYMHeJ
         mbRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=gOAXxPoSqwbSOG0ofk9DT91+7QBHKnohIB4quLfJkAk=;
        b=mUDjJaNFbBuMuVLaDawtjx+XmZpxoZ0UcyT9GlsVESGYpTz6CwdxglURsDYsy1jyuu
         tL0dwiFitxJnPH0+8HGwkoNRWthFOAsoLkrAttKAopc1IYkGU/z3PSGibltOJlO7kSGX
         USZ1/8TluPlPy4h8lu9xKI3QNN0cDGMWjLBy4kM2gf5MYezi1HFm7g/WRIPfquaCD6NW
         BWDIFpHxW4RZTp9pBCL0+s059z5sEdFwXlSQ5O1Ij1S8HhuvM90UcQbNI7ZltHTqsRhj
         Xw4u/LR7/8XhHP040CWI93Of0stcJqLW35YmfJrVrThGJXsAjnmwRLvakdoEKdsn8skt
         XyGw==
X-Gm-Message-State: ACgBeo19+Jklb0Y+GsASJAGm3/R9zdIbAO2awNV0M9d6UWTP7YHOmhyj
        xILMilDGiBqqaOYNC37LDFiR6A==
X-Google-Smtp-Source: AA6agR7AH0qv7axgXMrX7mRX46ybs/CgAIoyHustwbaI5FQqFhUa2Ora0+qrERSUdxYriHwxcymxYg==
X-Received: by 2002:a05:6512:3f90:b0:48a:826d:f727 with SMTP id x16-20020a0565123f9000b0048a826df727mr2541872lfa.281.1662642412767;
        Thu, 08 Sep 2022 06:06:52 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id v7-20020a2e9247000000b00264bb2351e8sm1623322ljg.7.2022.09.08.06.06.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Sep 2022 06:06:52 -0700 (PDT)
Message-ID: <cfa357f6-ac12-c391-b3a4-0175167dd358@linaro.org>
Date:   Thu, 8 Sep 2022 15:06:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v2 1/6] dt-bindings: mediatek: modify VDOSYS0 display
 device tree Documentations for MT8188
Content-Language: en-US
To:     "nathan.lu" <nathan.lu@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     "jason-jh . lin" <jason-jh.lin@mediatek.com>,
        CK Hu <ck.hu@mediatek.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Rex-BC Chen <rex-bc.chen@mediatek.com>,
        Moudy Ho <moudy.ho@mediatek.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, wsd_upstream@mediatek.com,
        lancelot.wu@mediatek.com,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20220906084449.20124-1-nathan.lu@mediatek.com>
 <20220906084449.20124-2-nathan.lu@mediatek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220906084449.20124-2-nathan.lu@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/09/2022 10:44, nathan.lu wrote:
> From: Nathan Lu <nathan.lu@mediatek.com>
> 
> modify VDOSYS0 display device tree Documentations for MT8188.
> 
> Signed-off-by: Nathan Lu <nathan.lu@mediatek.com>
> ---


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
