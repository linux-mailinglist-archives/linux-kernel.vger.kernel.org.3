Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93F5C5B1DF8
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 15:07:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232130AbiIHNHT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 09:07:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231549AbiIHNHO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 09:07:14 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A35BAC00E1
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 06:07:07 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id w8so27559169lft.12
        for <linux-kernel@vger.kernel.org>; Thu, 08 Sep 2022 06:07:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=5u6/MtXpxn1tTwAaduJUsG0IZt/fBpU15ZKPc1fiE2o=;
        b=ehPfB6s0nVoR+tfYmVzHTZew8S0nkhf/njyDNfgALVDMbGOdgHuGGmQui0Pd7WnIsF
         I3JDjrelF0pvS8dBTeBTtCZc8FneI1LHcuAFJCg8RicNTf6nRpUjcfWcM0AR0EpgScdJ
         yvtWWmj6+anIcTY/ll1vMJZV+kHOAn+Bso7lm/mzGAZKtTDAdHRmZzAglSa9AOo/5Lgv
         ftsdKfEsM8lFNMy8ljTbmhzHftdY9nEWVi0dkpR1/FoN2XMM3756dODbS4srP5aCoeko
         JN0omm9q5QGOZhll2wwXkOHiCqv66gb6+/Ad+QJz5I62NEGPizwF0b+PJmcqGwlIHj4I
         JExA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=5u6/MtXpxn1tTwAaduJUsG0IZt/fBpU15ZKPc1fiE2o=;
        b=Au2XoW3Z0TkcvD7Y6tJIcoE5uPZR16nGYnMtDbYrDQOnAmA0RKb4Kcoghwt00FTik5
         rjwbuHHiGA9s4cyHLmosEorm61xpLbXJDMd5+gYyelAqltVCNLQL88I65eyd/VaM6jJx
         bbLsuuEScj7KYBzi4odvXcr0B8ECJ8wY6mst2f9MTagZOvFIibQJ8Mr0mp1D5y+96bfE
         usw+wtoaKNmlArJ99JbdAuYZKoaC8UKZlJIvBt+mXi5R8dz2OiTr+wjYSSQy4VycAaqL
         iSPcsBX27mptgufhP470Id3d/SKh/n7QsONpmBlrB5/ioemDUYvoYpHTG4Vr6LGGbmX9
         L/qA==
X-Gm-Message-State: ACgBeo3zedByMEil1Wcze5DDNFBQfZQY6qGUJt9MD3kaZ1MrIwVe8eJ1
        8+O7i6DtZ8n6nz1E3ReBI0tE545tZK4qBg==
X-Google-Smtp-Source: AA6agR6wXnCQ6Vkqjjc03U6QxWxuJlZ7Fdfx0r4tDx4eRfk3Kfg7iqmZkdEZRBaoTN09hgyUFzPdFQ==
X-Received: by 2002:a05:6512:10d0:b0:494:7811:e673 with SMTP id k16-20020a05651210d000b004947811e673mr2559502lfg.400.1662642426042;
        Thu, 08 Sep 2022 06:07:06 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id a25-20020a196619000000b00497cb9f95a0sm319728lfc.51.2022.09.08.06.07.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Sep 2022 06:07:05 -0700 (PDT)
Message-ID: <603072dc-3595-ed54-53de-e88a0579d78f@linaro.org>
Date:   Thu, 8 Sep 2022 15:07:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v2 2/6] dt-bindings: mediatek: modify VDOSYS0 mmsys device
 tree Documentations for MT8188
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
 <20220906084449.20124-3-nathan.lu@mediatek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220906084449.20124-3-nathan.lu@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/09/2022 10:44, nathan.lu wrote:
> From: Nathan Lu <nathan.lu@mediatek.com>
> 
> modify VDOSYS0 mmsys device tree Documentations for MT8188.


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
