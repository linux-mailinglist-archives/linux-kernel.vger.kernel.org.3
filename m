Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB98A568B10
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 16:17:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233467AbiGFORg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 10:17:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232923AbiGFORb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 10:17:31 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BA1D1AF29;
        Wed,  6 Jul 2022 07:17:30 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id d16so15966811wrv.10;
        Wed, 06 Jul 2022 07:17:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=oBjTfdSvT6+YtSeTRdHKnKoOw+XuKEMSvxYcA1ivcKQ=;
        b=ScNTSzTZ43bEjkZfE92oTcQAP6gXZbZLcCw7IIVhNgSGDkhW8Sik3t4w/nHqscG+FM
         7H8zQnOXlPsQ7lFH/yIccetqoYONxKapCHHn16FOOOJ0Ll6v1muH0WtOSEse6oxl4rR/
         SIi57+De/Zzyg5wcXUk/zJCruld/3z6qNsog3EQJxTtm9N6JZoTClLIIgQHZz9EKKtLU
         4UVXKXIFiwWrxYi+z3IFgb6Njvhx3WfXEWEdu9wveYxl2YX6ucrSn090gKWim4fnedki
         WrJyZMB1rJeJ5B61+2pZA97RszQ2JnMU7fhWx2PtcmNHpGKmqnyLYPuc3+Bsgc2eOvWl
         vEVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=oBjTfdSvT6+YtSeTRdHKnKoOw+XuKEMSvxYcA1ivcKQ=;
        b=fcPWfVcrKRXD4W0ctXqeHNZMINtULyyESNiUQmxS3sIXMKIWAxVn5OsWUZgkqDgYb8
         Q9E7eJesty0biZH3gNnAxSGxUfzfBCu8ueWXgAANpci3zoPf/OcwC1mNf87aIjh3CBIt
         qVw68qh0f7PfOGKUGKkftj4sGu66u6uG8Yv1GlNHm8AH97gGHqaMMmepr3rO3k8hb4Tb
         Z6tcMYxubJAJ2mA3cY3zkAmSpzqzDybHzwslFMH/Ld1J/Avm5ubx/NHBzJUOT5Y96Ia/
         vHIqBH/fW547b5M63u/uNIowDFM0Z85qUhh81G4o+M2woBeA3pWUVz9hrXaIggzn3qwa
         QnDA==
X-Gm-Message-State: AJIora/L7qoVQ0lRyjQH2/LfOqbXG3ZxOKompSHXBubSmyAGokYWTfg4
        GTbOI439Ba+iO06wJGLX0k7udFn4XIzW2w==
X-Google-Smtp-Source: AGRyM1tVJy2MpNcYGjr+fAf+4MEWqrwAuT7nsZz4knx9ascE2+u/ba0RqCbDeLBIC0OuklmJHVMfrw==
X-Received: by 2002:a5d:6504:0:b0:21d:7376:6411 with SMTP id x4-20020a5d6504000000b0021d73766411mr8697884wru.512.1657117048804;
        Wed, 06 Jul 2022 07:17:28 -0700 (PDT)
Received: from [192.168.0.14] ([37.223.147.254])
        by smtp.gmail.com with ESMTPSA id h4-20020a5d4304000000b0021b829d111csm36607497wrq.112.2022.07.06.07.17.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Jul 2022 07:17:27 -0700 (PDT)
Message-ID: <8b70f376-5f83-a713-c5de-ed5bba68c937@gmail.com>
Date:   Wed, 6 Jul 2022 16:17:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 0/2] Add mt8186 mutex support for mdp3
Content-Language: en-US
To:     Allen-KH Cheng <allen-kh.cheng@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc:     Project_Global_Chrome_Upstream_Group@mediatek.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
References: <20220705122627.2273-1-allen-kh.cheng@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20220705122627.2273-1-allen-kh.cheng@mediatek.com>
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



On 05/07/2022 14:26, Allen-KH Cheng wrote:
> This series are based on matthias.bgg/linux.git, for-next and provide
> mt8186 mutex support for Media Data Path 3 (MDP3).
> 
> Allen-KH Cheng (2):
>    dt-bindings: soc: mediatek: add mdp3 mutex support for mt8186
>    soc: mediatek: mutex: add mt8186 mutex mod settings for mdp3

Whole series applied to v5.19-next/soc

Thanks

> 
>   .../bindings/soc/mediatek/mediatek,mutex.yaml |  1 +
>   drivers/soc/mediatek/mtk-mutex.c              | 23 +++++++++++++++++++
>   include/linux/soc/mediatek/mtk-mutex.h        |  2 ++
>   3 files changed, 26 insertions(+)
> 
