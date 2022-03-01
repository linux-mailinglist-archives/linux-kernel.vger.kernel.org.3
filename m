Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B8854C8695
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 09:34:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233463AbiCAIeu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 03:34:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233407AbiCAIeg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 03:34:36 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B58CB31215
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 00:33:55 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id m6so1977688wrr.10
        for <linux-kernel@vger.kernel.org>; Tue, 01 Mar 2022 00:33:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=sSORGTi0IoA/DfZkQJS5hbRydSHYhg9vgr1wsIug+aQ=;
        b=ja8zfW7ZO8t42SOrxjYk/1g1OiNSp6I3dw6entoB8N01FASu2pCL58f84IP5GU0V60
         mpJiaHLcQoMKYglRXYwoMgKufxHd1Rt05Gh3UXxHz6Gg02tgfH4xG7lkJG8QftbNUCY6
         dKMnOZ/I8ZT2FsKNSO6yUJRJ3A3khe7zKm2R6aN+OXT3k3fHDQFe8p9qtHvo+kepXOyk
         Cv9dAdehjwlAxdT6W6ulfXGR0L8HeeUm+ivjepPX/ibULH+1yKvQsUKggFOizYZ8uDYp
         3SiILaMfiNVIroJxUT7jxmpWl29BV6GFnms25HfRp6AvuuxncqOhVtHqx0dnDPfvnW24
         H4Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=sSORGTi0IoA/DfZkQJS5hbRydSHYhg9vgr1wsIug+aQ=;
        b=RWeJcgmu3dSX71RNuOSX2l/4Vmd4ST2j5HC9uaUWr7CsXwYEXyZUWw73Ygg6eT+3gz
         9mDYv5cmu1wJjMtXrNLESOrFG1Vl5siLkMeLWX5rMadDaviUzn9vt58cP0QJ4dV8es7L
         muaw7H8Cbbv6+xlczsOXj7USWykVuBIjjKkrnYLoWTNGri74Yf52lBw5cPXiqg2kbeWC
         EwXz5JcyrHpJMzNrJZJGrSxm4JH20NaO27Us2td6yU6R/g31W0ICPVKGcX+TOepSKUKp
         qXNzJ+PdGGWA3JKrTgmM/uJMYEC9vk8cHnVTW4VsGPxy4zrCNraAVx56YNy6DC4guUdn
         VCow==
X-Gm-Message-State: AOAM531BfazjRdOcN0i8X21skdA79xbWafbDwxuw0x1ozIQmqXG8LK7s
        AiSoD85lt5QGK99ktmcho28=
X-Google-Smtp-Source: ABdhPJxtzVKIx0WMPTgOyRFRV+vczvtzK4cPKqRKOBPW2MGsNpFQqh2cqt61LACCM47DKeJhbom5ew==
X-Received: by 2002:a5d:6885:0:b0:1ed:c0bc:c205 with SMTP id h5-20020a5d6885000000b001edc0bcc205mr18801977wru.683.1646123634238;
        Tue, 01 Mar 2022 00:33:54 -0800 (PST)
Received: from [192.168.2.177] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id m12-20020a7bcb8c000000b003811afe1d45sm1700654wmi.37.2022.03.01.00.33.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Mar 2022 00:33:53 -0800 (PST)
Message-ID: <09ce5aab-0cc6-5903-8238-551085abd739@gmail.com>
Date:   Tue, 1 Mar 2022 08:35:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2,0/2] Add mmsys reset control for MT8186
Content-Language: en-US
To:     Rex-BC Chen <rex-bc.chen@mediatek.com>
Cc:     chunkuang.hu@kernel.org, jitao.shi@mediatek.com,
        xinlei.lee@mediatek.com, angelogioacchino.delregno@collabora.com,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20220217082626.15728-1-rex-bc.chen@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20220217082626.15728-1-rex-bc.chen@mediatek.com>
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



On 17/02/2022 09:26, Rex-BC Chen wrote:
> v2:
> 1. Change variable type from unsigned int to u16.
> 
> v1:
> 1. Add a new variable in mmsys driver data to control different register
>     offset for different SoCs.
> 2. Add MT8183 reset register offset.
> 3. Add mmsys reset control for MT8186.
> 
> This series is based on mmsys patch for MT8186 on [1].
> [1]: https://patchwork.kernel.org/project/linux-mediatek/patch/20220216084831.14883-4-rex-bc.chen@mediatek.com/
> 
> Rex-BC Chen (2):
>    soc: mediatek: mmsys: add sw0_rst_offset in mmsys driver data
>    soc: mediatek: mmsys: add mmsys reset control for MT8186
> 
>   drivers/soc/mediatek/mt8183-mmsys.h | 2 ++
>   drivers/soc/mediatek/mt8186-mmsys.h | 2 ++
>   drivers/soc/mediatek/mtk-mmsys.c    | 7 +++++--
>   drivers/soc/mediatek/mtk-mmsys.h    | 3 +--
>   4 files changed, 10 insertions(+), 4 deletions(-)
> 

Series applied, thanks!
