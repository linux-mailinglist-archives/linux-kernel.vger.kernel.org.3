Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2495529EDE
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 12:11:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343763AbiEQKLv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 06:11:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343782AbiEQKKs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 06:10:48 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C30804BBA8;
        Tue, 17 May 2022 03:09:28 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id t6so24033416wra.4;
        Tue, 17 May 2022 03:09:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=t4zPUKpv7XaTfwCy6u8+Y9X67AplsbkFXvPulu0ea1U=;
        b=aEs+kBHg2LKI6or1oWTOXdLQLX5BKJra6ZJ/JQVkHM6rAssedHYEsM5LLwYPaUnEW1
         Er8hzUj6HM+y4+yiwXyGVakR9K1eW0wFG7ntWYX5PrRIhZBrwU73bj12BVqv7NW1xe73
         rziM/EwhIps3HhQpVH3xaVdy9KwZFJThIxS8WO2QzKsRYwexHJQ5FVMx/yzgcCpRvCX3
         /cEjZ9eofAuUBTLY2ZjgATPazGtrs7j+Kro5NGKhNPAU9Qsj1jj4Xk0gUlM5P2xco1/S
         iWjuFJt8aUKqornzfztDZjF2cIMAHiiJJ4upNIaJSphy/O4g63nrhNzt3IXXaiTJKFZi
         6qgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=t4zPUKpv7XaTfwCy6u8+Y9X67AplsbkFXvPulu0ea1U=;
        b=shN6m1f3JJttSDu5wdr946HWluh2OFbBAFh9tBuq4FG3LbQzU5KSdwT58xFjR4+Wv9
         zUD7UaewMcUtFMzs4nI2y8P3m2HpBn04FWBeuHyoaHsZU6nYRRzBUUT0KpB0CAID39Yv
         kLVZXSwi/SMkYaNl5j3CMYMc1aJlY5Q4nUKORHiRW8O8O2uqzJ5s2fj3CnK0jcLZS7dB
         EzLKFQ/+vYSwZIRZabIVu2J4vRg4qU+esPhAh+bGYAIk0QGVew549YLABwGv8Cv3hpx+
         oVdH63EU3kwu/TyO/pdxgP+KiHUczJDWi5pncUKQI2zF/0X0vZv0eOljPi3pwH7PKsO8
         3fFg==
X-Gm-Message-State: AOAM532gMOeY859zNspEHeWvJXSon/DOjtgzNSwjdVjnwtXljpFv5+0w
        ZLbGNQW4Qd4I8dEbJ5HrHKM=
X-Google-Smtp-Source: ABdhPJzK4FAOgEnNQs53gtSOtT0Y8b5G++nzf2lJHnk/cY7kMsd4pENS/ntIKs/HT0Xr5wKaUtO4JA==
X-Received: by 2002:a5d:6989:0:b0:20d:b25:f5 with SMTP id g9-20020a5d6989000000b0020d0b2500f5mr6372658wru.616.1652782167330;
        Tue, 17 May 2022 03:09:27 -0700 (PDT)
Received: from [192.168.2.177] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id s7-20020a05600c29c700b003942a244ec2sm1443015wmd.7.2022.05.17.03.09.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 May 2022 03:09:26 -0700 (PDT)
Message-ID: <3e9f0936-efee-cedf-6e2b-4dd9de79fc4e@gmail.com>
Date:   Tue, 17 May 2022 12:09:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v7 0/3] cpufreq: mediatek: Cleanup and support MT8183 and
 MT8186
Content-Language: en-US
To:     Rex-BC Chen <rex-bc.chen@mediatek.com>, rafael@kernel.org,
        viresh.kumar@linaro.org, robh+dt@kernel.org, krzk+dt@kernel.org
Cc:     jia-wei.chang@mediatek.com, roger.lu@mediatek.com,
        hsinyi@google.com, khilman@baylibre.com,
        angelogioacchino.delregno@collabora.com, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20220516111130.13325-1-rex-bc.chen@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20220516111130.13325-1-rex-bc.chen@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 16/05/2022 13:11, Rex-BC Chen wrote:
> Cpufreq is a DVFS driver used for power saving to scale the clock frequency
> and supply the voltage for CPUs. This series do some cleanup for MediaTek
> cpufreq drivers and add support for MediaTek SVS[2] and MediaTek CCI
> devfreq[3] which are supported in MT8183 and MT8186.
> 

Series applied to v5.19-next/dts64

Thanks!

> Changes for v7:
> 1. Drop all drviers patches because they are all accepted.
> 2. Correct clock/clock-name for cci in dts.
> 
> Changes for v6:
> 1. Reorder patches in this series.
> 2. Add a new patch to do unregister platform device.
> 3. Modify drivers from maintainer's advice.
> 
> Reference series:
> [1]: V1 of this series is present by Jia-Wei Chang.
>       https://lore.kernel.org/all/20220307122151.11666-1-jia-wei.chang@mediatek.com/
> 
> [2]: The MediaTek CCI devfreq driver is introduced in another series.
>       https://lore.kernel.org/all/20220425125546.4129-1-johnson.wang@mediatek.com/
> 
> [3]: The MediaTek SVS driver is introduced in another series.
>       https://lore.kernel.org/all/20220420102044.10832-1-roger.lu@mediatek.com/
> 
> Rex-BC Chen (3):
>    arm64: dts: mediatek: Add opp table and clock property for MT8183
>      cpufreq
>    arm64: dts: mediatek: Add MediaTek CCI node for MT8183
>    arm64: dts: mediatek: Add mediatek,cci property for MT8183 cpufreq
> 
>   arch/arm64/boot/dts/mediatek/mt8183-evb.dts   |  36 +++
>   .../arm64/boot/dts/mediatek/mt8183-kukui.dtsi |   4 +
>   arch/arm64/boot/dts/mediatek/mt8183.dtsi      | 286 ++++++++++++++++++
>   3 files changed, 326 insertions(+)
> 
