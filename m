Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57DD64C694B
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 12:03:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233446AbiB1LDz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 06:03:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230405AbiB1LDx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 06:03:53 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59B351E3E2;
        Mon, 28 Feb 2022 03:03:14 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id d28so14808499wra.4;
        Mon, 28 Feb 2022 03:03:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Zbcz7VnvPXSNCztHz9sMRX7epSbG59XZn9pyu61UWHk=;
        b=Oxj8JHlRz2mdVmoqigS0luCtmjoUGIdmOc0RrlMqAcNJkhut3cfH0O2mrE/ZN35eRA
         VJuMEYvoFGx3i6hUlAg9fNUzhIxxOX6t9Dknps+IjiCb1Nx5UamllnjQ/a4Es/oJ0MN/
         0gN1bg1skzYA+O+aGmN1eNJntgiA4r3vUMPtDYDE9F48W9BanaHaPErQ1DcKjaclTMkj
         jnrBkH0t/aYm1I8A3mgzP1WAG567o0wVuGR40v2RaLbN8akGMFYBAT8PwIpDSLCrD0U+
         my3H+o+iwrO4pyNafLkILq2XPN2ucabzpReR9CV8mW58yAKTRzMSYKjqdp30wWeaq4jp
         sQwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Zbcz7VnvPXSNCztHz9sMRX7epSbG59XZn9pyu61UWHk=;
        b=Kl3ezIa5O47RBy73exErUJh3nJy0xN6OCgWcTyLThE4b53kNnu8PM86VPem3oadD4Y
         shdTm8PGPFR3uO4kexFzN35bmO9wA/tRQm+SuPCkasCOcfcMK0ejMM2Q2fu+NroF8vum
         shOH2HVJwGPS8V2b+VI38bIS4mzeeObyOF4RDX7mSBON2d0+gMsLXvToinpndHWYTma/
         wfcOzCOX5NgYAY5ZrDWejdO9f+CZwTwj4o/vM89UZ/f37/xxXn38ccaPS7+jCsG6WrRi
         WieTPaa4I23FOeJpY4XH27Xscw4hQKMtvy8/n/bJKRtbMyMEkQBoAmW4HrH/3C/u9XHn
         x4CA==
X-Gm-Message-State: AOAM5331ccPTGGLS29Rxm0JrHFGYz9LbokFVYM5s5aIta3oXeZ8rH7dW
        MxyL7fyvATWzecaoZNh63F0=
X-Google-Smtp-Source: ABdhPJyoSngUdbBN26xRaezsM/eDpcmtYGFW89dx6ojT/oBJ2L/ABdocEt8cEWhHXD5mzfXcpXS/dw==
X-Received: by 2002:adf:ea44:0:b0:1ef:6f00:cf47 with SMTP id j4-20020adfea44000000b001ef6f00cf47mr11507757wrn.460.1646046192880;
        Mon, 28 Feb 2022 03:03:12 -0800 (PST)
Received: from [192.168.0.14] (static-63-182-85-188.ipcom.comunitel.net. [188.85.182.63])
        by smtp.gmail.com with ESMTPSA id z5-20020a05600c0a0500b0037fa93193a8sm12557012wmp.44.2022.02.28.03.03.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Feb 2022 03:03:12 -0800 (PST)
Message-ID: <2f2d2d0f-3854-501d-e6dd-146f64d726d6@gmail.com>
Date:   Mon, 28 Feb 2022 12:03:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [v7 0/5] Mediatek MT8195 power domain support
Content-Language: en-US
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        Enric Balletbo Serra <eballetbo@gmail.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org,
        srv_heupstream@mediatek.com,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20220130012104.5292-1-chun-jie.chen@mediatek.com>
 <319d7236-292c-787f-4578-bffe75e33ba1@collabora.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <319d7236-292c-787f-4578-bffe75e33ba1@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 15/02/2022 10:06, AngeloGioacchino Del Regno wrote:
> Il 30/01/22 02:20, Chun-Jie Chen ha scritto:
>> This patch series adds power domain support for MT8195
>> and is based on 5.17-rc1.
> 
> Hello Matthias,
> 
> this series has been tested for a while on multiple MediaTek platforms, hence
> new versions will not be necessary.
> 
> Can you please pick it for v5.18?

Whole series applied,

Thanks!

Matthias

> 
> Thank you,
> Angelo
> 
>>
>> change since v6:
>> - rebase to 5.17-rc1
>>
>> change since v5:
>> - rebase to 5.16-rc1
>> - add domain capacity in mfg power domain
>>
>> change since v4:
>> - rebase to 5.15-rc1 (fix conflict at patch 4 in this series)
>> - change license
>>
>> change since v3:
>> - remove redundant bus protection steps
>> - remove unused power domain
>>
>> change since v2:
>> - move modification of wakeup capacity to single patch
>>
>> reason for resend v2:
>> - miss patch version in series
>>
>> changes since v1:
>> - fix signed-off name
>> - describe more detail in patch 3
>> - move modification of removing redundant macro to single patch
>>
>> Chun-Jie Chen (5):
>>    dt-bindings: power: Add MT8195 power domains
>>    soc: mediatek: pm-domains: Add wakeup capacity support in power domain
>>    soc: mediatek: pm-domains: Remove unused macro
>>    soc: mediatek: pm-domains: Move power status offset to power domain
>>      data
>>    soc: mediatek: pm-domains: Add support for mt8195
>>
>>   .../power/mediatek,power-controller.yaml      |   2 +
>>   drivers/soc/mediatek/mt8167-pm-domains.h      |  16 +-
>>   drivers/soc/mediatek/mt8173-pm-domains.h      |  22 +-
>>   drivers/soc/mediatek/mt8183-pm-domains.h      |  32 +-
>>   drivers/soc/mediatek/mt8192-pm-domains.h      |  44 +-
>>   drivers/soc/mediatek/mt8195-pm-domains.h      | 613 ++++++++++++++++++
>>   drivers/soc/mediatek/mtk-pm-domains.c         |  12 +-
>>   drivers/soc/mediatek/mtk-pm-domains.h         |   8 +-
>>   include/dt-bindings/power/mt8195-power.h      |  46 ++
>>   include/linux/soc/mediatek/infracfg.h         |  82 +++
>>   10 files changed, 862 insertions(+), 15 deletions(-)
>>   create mode 100644 drivers/soc/mediatek/mt8195-pm-domains.h
>>   create mode 100644 include/dt-bindings/power/mt8195-power.h
>>
> 
