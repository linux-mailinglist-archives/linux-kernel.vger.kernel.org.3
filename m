Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4240057BCC9
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 19:37:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241244AbiGTRhX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 13:37:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241318AbiGTRhS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 13:37:18 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0274A6FA0A
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 10:37:15 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id bf9so31375210lfb.13
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 10:37:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=7p5oDc+MTWM6fmNdT6fee7WsO1neY6yG3oroC+2SKog=;
        b=uBBjW1voxPKnjiUwz44hW4y0OUzcyPskpYpLmma9r982TTBOidFXfWEVU/AY1oGo/r
         BsSVH+28HZVm32tdTVBKorY9Xws+xoppKV8+DAEf2CF+HAWKQpNa+GST9Fj2MhscSFfB
         8IxE+rxjV/kcsEx7dsy1pSqzPDlRQTK0W425ZB2gM+fpTrZKtlJ3PU+1ep9pa3/JbJ9R
         QZYNPPMzEmWE6OkbS8MzRVsrJb9rD72jjGe9stQu0AAvWsB8BQ+XJyKjhBCuDiEjNt9W
         8KkmsZZVaqswHQJOg/lSN3BuT1XY8E69JTp33XS7s3m897Uv20neR+x+UnCch2PwB2hD
         /qYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=7p5oDc+MTWM6fmNdT6fee7WsO1neY6yG3oroC+2SKog=;
        b=vJKZ8V5cU/IMyZMF84eBdYgwPAWZUR/0BbBRZpuR++hwz+0bAOZ6prXk8ZkHi3sBNe
         DF4SmSsOKQlqxCxxMLLimsqW1I2OFnepnkQ4YzF54LwWDU2gC/HxVD780DOb8Pl4J5G1
         ltF9KvFufkPCVEkIsI1nx8M1UNnEu41iR1YxtrpzZYN1fHdipr8mXkkwyUn5n8XMtAR9
         ERKBjIvLIgYuHxfHR0ZkocmyFpcideyAseFfUj87qeetA1StMacjh06YJoypnuYAO0a6
         EMchIsYELQLs+zrGtFE/2qnVY2BSZM1+ZHRDFqe4jX0GG59oRwUmWeR0TywmpLhwkrYt
         lJdw==
X-Gm-Message-State: AJIora8A/hZaqc3+6uvwZsujlCGwyJlWU7U1JdRipcSijUMiLAhjlfwT
        UgGye6mG/qluG+F6ifjaCWlhjQ==
X-Google-Smtp-Source: AGRyM1v2HimajV1UlLGM1askxczmPNc2mGqOexFrLo7JMSfp0SaXQyHids9tDu8eFzlC2wiwqbwLCw==
X-Received: by 2002:a05:6512:b2a:b0:48a:2aaf:2ad3 with SMTP id w42-20020a0565120b2a00b0048a2aaf2ad3mr13421059lfu.552.1658338633301;
        Wed, 20 Jul 2022 10:37:13 -0700 (PDT)
Received: from [192.168.115.193] (89-162-31-138.fiber.signal.no. [89.162.31.138])
        by smtp.gmail.com with ESMTPSA id f14-20020ac2498e000000b00488d1acb7b0sm3910823lfl.130.2022.07.20.10.37.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Jul 2022 10:37:12 -0700 (PDT)
Message-ID: <68a30bbd-5f9d-17d2-59fa-7b0da06ee877@linaro.org>
Date:   Wed, 20 Jul 2022 19:37:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v3 06/21] dt-bindings: power: mediatek: Add bindings for
 MediaTek SCPSYS
Content-Language: en-US
To:     Lee Jones <lee.jones@linaro.org>,
        Tinghan Shen <tinghan.shen@mediatek.com>
Cc:     Yong Wu <yong.wu@mediatek.com>, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        MandyJH Liu <mandyjh.liu@mediatek.com>, iommu@lists.linux.dev,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20220720123023.13500-1-tinghan.shen@mediatek.com>
 <20220720123023.13500-7-tinghan.shen@mediatek.com>
 <YtgDu70Lpl/uPOkf@google.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <YtgDu70Lpl/uPOkf@google.com>
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

On 20/07/2022 15:31, Lee Jones wrote:
> On Wed, 20 Jul 2022, Tinghan Shen wrote:
> 
>> The System Control Processor System (SCPSYS) has several power
>> management related tasks in the system. Add the bindings for it.
>>
>> Signed-off-by: Tinghan Shen <tinghan.shen@mediatek.com>
> 
> Why have you ignored my review comments from v2?

If you refer whether the binding is needed at all, then the answer is
yes, because this is not simple syscons but a device with children,
which we want to parse/match.

Anyway Tinghan should respond to you about way how he proceeds...

Best regards,
Krzysztof
