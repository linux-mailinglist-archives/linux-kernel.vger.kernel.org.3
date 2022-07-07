Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0C61569D43
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 10:26:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235042AbiGGIXH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 04:23:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229827AbiGGIWv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 04:22:51 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 129CDC4;
        Thu,  7 Jul 2022 01:22:50 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id b26so25232868wrc.2;
        Thu, 07 Jul 2022 01:22:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=qhGXVYTI3y8DQIyLbAUR63DvhKZD5q4V66nvFencTLk=;
        b=JANdJtCKSYGSLRjWg5hHnlbZIlWenXHZf7OwKO/iz4ZkE0C5zRGbauFi2RFsendG3S
         CuWitByG9S1tvGSCsJtTdPl/JvlumojnNy0sWeZimrn8deIg3HrFj46zlFlT+UwaEmgS
         9iMqLbiYuDldjB4x3ah17Kt+SxJ2mZovhXphhZMpnMnNdwiaK1zpQuKLfKXjOh1q/OaU
         PxX7spWKgC4hZMXDQTHvS6sFBVoRExNYSEwWBy1C/kEEtdID92rGO5eeQ5yaLwgh9Hc/
         4a5IG7ax2SPiET044buBxgqeM/J/+miTPgJJSvY3WwX4MNEBjRjGo/FgFS0SjcXRXgfz
         M4/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=qhGXVYTI3y8DQIyLbAUR63DvhKZD5q4V66nvFencTLk=;
        b=6lhmX3ZjTT1vjxyzPDhUn8xEnqxzUgSg5E2GqcdZ8VO1fyRiDKDrrB32TICwkYgdUR
         z+JggmjIxc+IpHpGnaZVh4FIz2n4ykMnACT9pIHQmQDswE/gaVgIiV5qxPiUJkyvFwlX
         ri9Bt4milSOtX4sdeDLMk/Ujf+HWiVos5xgm1lGkZuKHHUsKmAIWolMxIZtrs6wR3TBZ
         Uc1HFCDNtoQLeibMhA6zECf2lGXH12UTsZ233Sd29FyZgLq24NDL9dPMht5S8BTcYK/j
         niQW03lzB/V4a6rHb7s9Cq1I5g5pYNIBaIR6P4AkqZRJP7W2QTCJ/I0OtQ56oIsyObKj
         zvsQ==
X-Gm-Message-State: AJIora/F6dl1N+HU7GMMGr4PqOadjhBfu8vt/8+2FcQdpPLQspkAqKf7
        9fHMBx6C0B+Ne/yyjsSlxOU=
X-Google-Smtp-Source: AGRyM1sHiG77D0vjoRwIBlJ8Gd7/ObAkRjVGUunFWo8VBLXawqC8R+7+zUbbAO8F9/OrcLlvKKY6Xg==
X-Received: by 2002:a05:6000:1689:b0:21d:22d0:8e5e with SMTP id y9-20020a056000168900b0021d22d08e5emr41859376wrd.574.1657182168406;
        Thu, 07 Jul 2022 01:22:48 -0700 (PDT)
Received: from [192.168.2.177] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id 22-20020a05600c029600b003a2b8461ddbsm8424500wmk.41.2022.07.07.01.22.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Jul 2022 01:22:47 -0700 (PDT)
Message-ID: <a0059fb3-c734-84eb-88ee-e0d34fcbca1b@gmail.com>
Date:   Thu, 7 Jul 2022 10:22:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 0/2] Allow getting regulator on MFG for multiple SoCs
Content-Language: en-US
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, robh+dt@kernel.org
Cc:     krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        wenst@chromium.org
References: <20220623123850.110225-1-angelogioacchino.delregno@collabora.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20220623123850.110225-1-angelogioacchino.delregno@collabora.com>
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



On 23/06/2022 14:38, AngeloGioacchino Del Regno wrote:
> This is one of the steps to enable DVFS with the Panfrost driver:
> since Panfrost is already enabling the (required) MFG power domains
> and since the mtk-pm-domains driver is already responsible for
> actually enabling the SRAM PDN, it makes sense to make sure that
> the VSRAM supply is ON when trying to reset/enable the SRAM.
> 
> For this reason, the MTK_SCPD_DOMAIN_SUPPLY flag was added to one
> more MFG domain, ensuring that the SRAM is actually powered and
> also not relying on the bootloader leaving this supply on; on the
> other hand, this is also making possible to avoid setting a
> sram-supply on the GPU node, making devfreq happy about having
> only one supply and finally allowing DVFS to happen.
> 
> If no domain-supply is declared in devicetree, mtk-pm-domains driver
> probe will anyway keep going, so this is not breaking old devicetrees.
> 
> No side effects either when this supply is declared for both a MFG
> domain and Panfrost together.
> 
> This series has no dependencies.

Both patches applied, thanks!

> 
>   Changes in v2:
>    - Squashed all mtXXXX-pm-domains.h changes in one patch
> 
> AngeloGioacchino Del Regno (2):
>    soc: mediatek: mtk-pm-domains: Allow probing vreg supply on two MFGs
>    arm64: dts: mediatek: mt8183-kukui: Assign sram supply to mfg_async pd
> 
>   arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi | 4 ++++
>   arch/arm64/boot/dts/mediatek/mt8183.dtsi       | 2 +-
>   drivers/soc/mediatek/mt8183-pm-domains.h       | 1 +
>   drivers/soc/mediatek/mt8186-pm-domains.h       | 2 +-
>   drivers/soc/mediatek/mt8192-pm-domains.h       | 2 ++
>   drivers/soc/mediatek/mt8195-pm-domains.h       | 2 +-
>   6 files changed, 10 insertions(+), 3 deletions(-)
> 
