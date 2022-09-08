Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A57785B1DFF
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 15:08:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232135AbiIHNIJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 09:08:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231899AbiIHNII (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 09:08:08 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79A99E1251
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 06:07:33 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id m15so7937915lfl.9
        for <linux-kernel@vger.kernel.org>; Thu, 08 Sep 2022 06:07:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=hkN5lSEGT0XqyIIogV66h42SfZYhfXdkQkWQQNDRmT8=;
        b=OnaGsfvOCLtQSBc0ze/XDCrjMs3fvJ8z2lVuT/jXY3Zah6Btqr6O8o+Y/xzaDCsGFQ
         aNTn+Tad04itVfSFKUheRnqoKDIPvs74oU2qn5UXwtbVp9MdLGGK6UrfiaX6oPKzYM8L
         iYiuJO/B/2FMpIuTMicaPRvUzM4uu8CFTorze+v9/JExL4YuwKOPfuy6SmY9LzTKN3CC
         pOusfnV2vFIqyVn2EG9BhUNURJE49a21kmlxwOCnqQMWVvSI4x43iNTbzaWm6ldSo8Ko
         WQZV7wfAXQ5YPo0rxq7Unw5lA+FF7KNsezgXrt5Tt4RBUggcRZQtMFdwwyg+X23ERZoC
         FFug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=hkN5lSEGT0XqyIIogV66h42SfZYhfXdkQkWQQNDRmT8=;
        b=o8roVQjTY9OX2kc+NoKqCTaU9gexWxO02s+Lm3B77z/dWjGCzxD3FYSEXF02eCCelV
         5Mx7jgR8we7sa2IAiRF2tM7SBcDpx93sTtiHfs2xuLQ3YUmaQv2BlP5U/K07WO34tJAV
         gpCzEUFLZ3AqB4fN7S5OcS8QebSEKW/IYcrM33VAmgriIyEXyE2mzUGepVQM+70J47UE
         KFxneOcshC5kARfuQUGCr9MPYzKkYqDVQh1G0aOb9YVuxd96ynlZpfrfctBr36RjAb7y
         ny3+yhko79sF/9xLHSwgKE3HquOQUEqKzb6bJTb7ZE+gWvqbLyI+A2Wkx6iOWqSviOPK
         WGfQ==
X-Gm-Message-State: ACgBeo106fQJCk/E8XYRUKiKok31qsxdd71w9ccSMpzqu5s+8/SgWOuz
        TqbxIzoLqhM+AnuMi7xfqtUdrA==
X-Google-Smtp-Source: AA6agR57T3t8+MMpI2KHy8mvLQohvoJxFPM7ZK6FI697GqmZFiRdAtbnPNIFqulD/7k9bQHxePp8gA==
X-Received: by 2002:ac2:5107:0:b0:497:adac:7305 with SMTP id q7-20020ac25107000000b00497adac7305mr1643133lfb.32.1662642451447;
        Thu, 08 Sep 2022 06:07:31 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id o10-20020ac25e2a000000b004976809d6a7sm1697850lfg.283.2022.09.08.06.07.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Sep 2022 06:07:30 -0700 (PDT)
Message-ID: <55f76b33-fa27-d8bd-8fe2-9aaeacf2c9f9@linaro.org>
Date:   Thu, 8 Sep 2022 15:07:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v2 3/6] dt-bindings: mediatek: modify VDOSYS0 mutex device
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
 <20220906084449.20124-4-nathan.lu@mediatek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220906084449.20124-4-nathan.lu@mediatek.com>
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
> modify VDOSYS0 mutex device tree Documentations for MT8188.
> 
> Signed-off-by: Nathan Lu <nathan.lu@mediatek.com>


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
