Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61A1D578463
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 15:53:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235566AbiGRNxl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 09:53:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235550AbiGRNxi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 09:53:38 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE76227FDD
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 06:53:34 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id e28so19420885lfj.4
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 06:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=6/DcKl1792dtFraiyvZ692Ib84+Yi+4Ulxn0Vh9//vc=;
        b=adf7fKMxBuELaUr2WN93cCfzLwvAYLCSxArs7AO+ItT6SAVQJjfqXVZ6xkpW0xpkKo
         On5VqFStvsWGBQOGKJZQ7dLaBgOWAEZQ1ln9tRYix8ijrghu8R9X0wF26Iemn7lRv1UR
         JU4jQ6RpcMZ1YJ3iqD98dn0Gj9oL4LkJVchdcAXwLw3UmGrv38tllSQatCxZyLdY/TFG
         XlzM91z8J7cQNV1JdadJSE/R1I5akBQLQWQVvSCZ1N5YESUD32HcFx4TGEpLgefyGFoP
         dLOr+pELGuaDGzuiqcBfzujdTZh67+MpQOpx73gRJe4YjU9RNocEz/kTAhi9aEUaDcFw
         c45g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=6/DcKl1792dtFraiyvZ692Ib84+Yi+4Ulxn0Vh9//vc=;
        b=NfcrSfyPwVrTjA+filF/WYK/qprLbQ2Ia5grGxMSNBvx84oA9glCftGUYxZ6YsTlH6
         h2G9t4C/IpnAvvM/66gs+YrByaZLZfzVzSukHkGg3C+Xsmgw6kdzHPhswiY0NT5Trnlj
         XglgVoIP/67Yq1g3MLyF+3kdY5nE/Lac2n/FWSk1ZQK6beRm3sIdQyO3Sz8kBajA3zSf
         FmSBMK1GbVD2Haddy/+qeGcJV8g2K1aQutDGgqdK+RFrxTv4sdOnyazRGDzP+AAJrMnQ
         n1ghWiQIreBw++IKBByosnu6gZxHszQu1MIKcK47t66JHKN1PKnQ5+wTWAXoQ/fP/DxC
         OH4w==
X-Gm-Message-State: AJIora/gONLzWvDEvHJgebGIKtt9z+MCH76xdvHbWpllS4zYyoKZhztb
        3gt7oymwDsQT/7HQEG5CQkOBuQ==
X-Google-Smtp-Source: AGRyM1vlH8y6dxxb5A3iLBYGqYkrcDCTAdlap219dHfRtUb7BZ/CdexwgBbf1qAUdAng6pNUPijgsQ==
X-Received: by 2002:a05:6512:3d28:b0:489:fd63:f9c9 with SMTP id d40-20020a0565123d2800b00489fd63f9c9mr14550160lfv.96.1658152413217;
        Mon, 18 Jul 2022 06:53:33 -0700 (PDT)
Received: from [192.168.115.193] (89-162-31-138.fiber.signal.no. [89.162.31.138])
        by smtp.gmail.com with ESMTPSA id c24-20020ac25f78000000b00477c164293csm2601359lfc.79.2022.07.18.06.53.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Jul 2022 06:53:32 -0700 (PDT)
Message-ID: <f3082ae0-4d1d-e5a0-909a-5daa798ab7fe@linaro.org>
Date:   Mon, 18 Jul 2022 15:53:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 1/1] dt-bindings: iio: adc: add compatible for mt8188
Content-Language: en-US
To:     Hui Liu <hui.liu@mediatek.com>, jic23@kernel.org, lars@metafoo.de,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com
Cc:     srv_heupstream@mediatek.com, zhiyong.tao@mediatek.com,
        guodong.liu@mediatek.com, johnson.wang@mediatek.com,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20220718123930.24373-1-hui.liu@mediatek.com>
 <20220718123930.24373-2-hui.liu@mediatek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220718123930.24373-2-hui.liu@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/07/2022 14:39, Hui Liu wrote:
> From: "Hui.Liu" <hui.liu@mediatek.com>
> 
> This commit adds MediaTek mt8188 auxadc in dt-binding documentation.

Do not use "This commit/patch".
https://elixir.bootlin.com/linux/v5.17.1/source/Documentation/process/submitting-patches.rst#L95


Best regards,
Krzysztof
