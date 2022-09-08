Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D43C5B1B7F
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 13:33:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231372AbiIHLcb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 07:32:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231249AbiIHLc2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 07:32:28 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79841CEB1B
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 04:32:27 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id y18so4769630ljh.12
        for <linux-kernel@vger.kernel.org>; Thu, 08 Sep 2022 04:32:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=0pPaTE7+rTEQhYbrukWxQzGd1k1hoKVerCCdYWXc3XY=;
        b=yRb08wNixx7dxR5s0MVCYiHAOQTE/8GAdPoWH81JxDGWK/y47WR8xqSeBN2dpOC4uS
         QM4GJgrxdzSFwuBuG+iW+WC9A4X8ebN9w93aWc3Hkgl/N5jj9wK2PEQO/JxNoKKN3GWK
         WqR2RhScBkyrk3OMnPYBOKPyUFqG7ozTYe+9srWmhbyzfD1gpZ39eirhK1FOiuEzCl55
         Fw6G5cDiTbYRq3s353RzlBPYGZTgP04IkBNkJjLKAQFLk5ljo0+JvS96LkFHtcAqzudF
         tPrI85TlCI8dFeKS4kU7xq64zv+Sov6lNVooaCBilF088BnytbdX2IJ+wIy7n7CRxVhj
         9qBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=0pPaTE7+rTEQhYbrukWxQzGd1k1hoKVerCCdYWXc3XY=;
        b=G8TuXgyuotS9Ee4MFXWfwNLlBVSJMxDbEelsHyIDGeISi/wgv9EEXpuQs5XsxoFxPO
         7ZR4otmS3/Cabd1/Bwp1MSsL+4roQqG69MBkv0NaBDxZcgUbGkl0X1mzNfAgIS0w+ikc
         RQXWAQ/5Ks0EdbLhNm5lHmLDAuSv+BRq/AzugQB6olv2A68c93FYb0i5MAWu1+HR15FJ
         T8X66s3zdpFBWI2TvAl1Sh1MLsnObvbAPjYRUtGS1GkBMmreUeCeKkw8+oVr2CicT2zh
         VJICfFsVmQhuJXNvr6MnYcHBa7wJR3aONgc68zqv0dyZ09o+UILSO1eIhKxd0tpbkOcs
         lBDw==
X-Gm-Message-State: ACgBeo0/xFJidVqn55hnMbNk0g2tbTMxACU7Zueph5jL+HrtuomzpW4z
        1PXaYuM0jit2AqlNqdApezG2btK21cHx7Q==
X-Google-Smtp-Source: AA6agR7NtIwbPiok7Z34Q3UGjd8MuNuJBW5nPc1K3U1TM97DmobqBGc5R7i2jKq/7LB+eRKNLLYwnA==
X-Received: by 2002:a2e:a801:0:b0:261:91a3:bc44 with SMTP id l1-20020a2ea801000000b0026191a3bc44mr2295872ljq.497.1662636745890;
        Thu, 08 Sep 2022 04:32:25 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id z4-20020a056512370400b00498f1eddad0sm126675lfr.122.2022.09.08.04.32.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Sep 2022 04:32:25 -0700 (PDT)
Message-ID: <1b50e92f-09ee-2f84-447e-01ff5b914e7c@linaro.org>
Date:   Thu, 8 Sep 2022 13:32:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v2 1/3] dt-bindings: riscv: starfive: Add StarFive
 VisionFive V1 board
Content-Language: en-US
To:     Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Michael Zhu <michael.zhu@starfivetech.com>,
        Drew Fustini <drew@beagleboard.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Conor Dooley <conor.dooley@microchip.com>
Cc:     devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com
References: <20220902100806.2378543-1-cristian.ciocaltea@collabora.com>
 <20220902100806.2378543-2-cristian.ciocaltea@collabora.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220902100806.2378543-2-cristian.ciocaltea@collabora.com>
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

On 02/09/2022 12:08, Cristian Ciocaltea wrote:
> Document the compatibles for StarFive VisionFive V1 SBC [1].
> The board is based on the StarFive JH7100 SoC.
> 
> [1] https://github.com/starfive-tech/VisionFive
> 
> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> ---


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
