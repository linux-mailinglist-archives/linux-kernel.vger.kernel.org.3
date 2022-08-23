Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4250359E60A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 17:33:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243307AbiHWPcg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 11:32:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242197AbiHWPcI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 11:32:08 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 943BC250DAC
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 04:17:52 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id m5so8544645lfj.4
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 04:17:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=p/Y+SW+sDFQrxU5iGkzgHTDP+ZT5UJ6i53/083eyQJg=;
        b=MrDQbeNHyc+pRDxnzFQ91jU42y8YNo4YNnlkpgLoQaXpcv1pX5XNX4Ql8pN9555LXy
         Ko2Ml8/H09TKZPX7AuENC8+/Vgftma2mrEv/Jn/vII69uueY29XIsrqc65IcC2uA3pMA
         6OXK4J602Y6PV57CqlfT0ZjquvSfL/HvjizICTyTDgFOA5zBQkChkyn4CyTPCIKt6ZdZ
         JeNr1LUxwfKESCglpaPg3wPK3/DnoX5wOgqOuxc94JLgBpy2VGmfMk5gLb1hoddHCgFi
         JRnhj09DhvvzKsOSTnbjMXApY1lujQJxBRTQM3Vk2XbYEZwiv3w/0C56k+esW1JNjvy1
         s4tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=p/Y+SW+sDFQrxU5iGkzgHTDP+ZT5UJ6i53/083eyQJg=;
        b=ywZmfu6wLW1pCUtpzKtVbcOJuUtx2omYL/WQmBPzmWNV2oiUh53B5n1kNvNQTqrSfm
         mhnDwOQEVTOTe8Wjc9g9HLewtzrYdLzH/oSrD0xo406BP58OYu+NYhKUS6mnhfkgRG3V
         NHGgPtiXIc3EBooyFQUJMzT01NsdVkz2TM1AKUWvY1HHOgwWm75oMIyrMYTe6HF0auSV
         DXmwZjdJAfL1kmwaaLG7f22DlO4C0BFnbwHr//bguslM40cHvqN4iTVtg+LLDfaYiT9Z
         mSGCs6QBidUoMrGbecHTKZExzm/glWlqvUcjOkSQ2WK4JwSqejyDaSZ53cAUAPRmwuij
         qc0w==
X-Gm-Message-State: ACgBeo1xBJbjnbRupxVjt1ZrvAkB4zHhT0EgoLHkWrvNZqdM2Zs8XOJB
        l4Q9wzV3dM7nZwFTN0YPqN7mxA==
X-Google-Smtp-Source: AA6agR7tqyK85+2o04GF7PJMNhOl687ZeYth/rV5QHCEWVFSRi8/kChXM1q2ei8VMMBa3JjYccngJw==
X-Received: by 2002:a05:6512:1315:b0:492:cbc8:e10d with SMTP id x21-20020a056512131500b00492cbc8e10dmr6406997lfu.41.1661253470590;
        Tue, 23 Aug 2022 04:17:50 -0700 (PDT)
Received: from [192.168.0.11] (89-27-92-210.bb.dnainternet.fi. [89.27.92.210])
        by smtp.gmail.com with ESMTPSA id z20-20020a056512371400b0048b27af9505sm1508855lfr.213.2022.08.23.04.17.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Aug 2022 04:17:49 -0700 (PDT)
Message-ID: <6ffc497c-5717-cdce-d338-65a8f00624d1@linaro.org>
Date:   Tue, 23 Aug 2022 14:17:48 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 1/2] dt-bindings: soc: mediatek: add mt8188 svs
 dt-bindings
Content-Language: en-US
To:     "jia-wei.chang" <jia-wei.chang@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Roger Lu <roger.lu@mediatek.com>,
        Kevin Hilman <khilman@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        hsinyi@google.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
References: <20220823091346.519-1-jia-wei.chang@mediatek.com>
 <20220823091346.519-2-jia-wei.chang@mediatek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220823091346.519-2-jia-wei.chang@mediatek.com>
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

On 23/08/2022 12:13, jia-wei.chang wrote:
> From: Jia-Wei Chang <jia-wei.chang@mediatek.com>
> 
> Add mt8188 svs compatible in dt-bindings.
> 
> Signed-off-by: Jia-Wei Chang <jia-wei.chang@mediatek.com>


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
