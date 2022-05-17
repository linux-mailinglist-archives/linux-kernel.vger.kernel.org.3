Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C42E4529F6B
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 12:29:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344230AbiEQK3h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 06:29:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344021AbiEQK3d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 06:29:33 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92437C1;
        Tue, 17 May 2022 03:29:31 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id k126-20020a1ca184000000b003943fd07180so1015572wme.3;
        Tue, 17 May 2022 03:29:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Vxisw3Hi44x5twaMivDjLGFhUD0fUbxKpcmcLxOdkIw=;
        b=e/qh6WLxUTS+sXD6t/Mhvgl+X9qerZPVQ2gX4wXKahJJrVmDQ2z1lFt/r8dvU+xlDh
         yboCALSNrqACdnL3x5d6WZO2R0BjYwqr+zmLSQVILMXypRqhiC9Eir6lGEr5QH/+qdkX
         JtOUZVBVu7GVl8QbFNo8rMX3JYoV4CPZMxjW2mvRbFtvetfULTJwG2dZej9uTj/VpP/7
         Jv9W/nQGsF4cFKUHT7zWsz6d4aQa02PY4INtnUHWGO48joLipKxTctp8kSDJVkU7jm5p
         jtGrqVqrkFpRw8vpvvmlYFSOL7IlrApUu3GfD1R7SoJOuu+2nnE7+40/drHmKe6tJF5M
         oloQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Vxisw3Hi44x5twaMivDjLGFhUD0fUbxKpcmcLxOdkIw=;
        b=6+VDpNlRO2Q0BG9Eg+5W4VLSLkdP4hazJiuz5REOLScvqdcBnZ7KTWM07uKmxO3HRp
         tJKCa1jVETS8pObgZZUHXalLUePimxf2f0et8pLRdaS5aCLH4F7rbXsB3Yfs4ybG8P8N
         LRSoV5pGV2OyneeD5afRCV30gm6Qh1RbDEvahxaFYPSWazjWkusT0sC4gt/Xr3oVocTs
         ySVxr/KHGAixiEOtioweO4jmN0EmPiOWpotbrptC5gSe2aeZ0K8yn0PhpUlOCSydZ+5w
         6xkeQBgrLhTP3NmZTbc/9wMRw8oZA54jbuPGQ6AqyqpqbEJ5S5WV2CSPjX8PKm4os3fe
         8Rqw==
X-Gm-Message-State: AOAM530aDip7Xn2hGYYNwoCWexd9JxRWnIiCyoYefSGpgz2pLFVFZ0OS
        xtx6NSl8ObwzwghaOQjEtdE=
X-Google-Smtp-Source: ABdhPJxeHmi/dJgRvCtWQ+8Nrr79od0BB1V9M9NaLxo9VbirJO3YvMd+eVgoytq9QwTzYynRNSCbHw==
X-Received: by 2002:a1c:f30b:0:b0:37b:b5de:c804 with SMTP id q11-20020a1cf30b000000b0037bb5dec804mr31022786wmq.166.1652783370091;
        Tue, 17 May 2022 03:29:30 -0700 (PDT)
Received: from [192.168.2.177] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id m29-20020a05600c3b1d00b0039429bfebebsm2204390wms.3.2022.05.17.03.29.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 May 2022 03:29:29 -0700 (PDT)
Message-ID: <96742ddc-5989-2538-a5f8-4b3ce637ecb7@gmail.com>
Date:   Tue, 17 May 2022 12:29:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v4] pwrap: mediatek: fix FSM timeout issue
Content-Language: en-US
To:     Zhiyong Tao <zhiyong.tao@mediatek.com>, lee.jones@linaro.org,
        robh+dt@kernel.org, lgirdwood@gmail.com, broonie@kernel.org,
        eddie.huang@mediatek.com, a.zummo@towertech.it,
        alexandre.belloni@bootlin.com, fshao@chromium.org
Cc:     srv_heupstream@mediatek.com, hui.liu@mediatek.com,
        tinghan.shen@mediatek.com, hsin-hsiung.wang@mediatek.com,
        sean.wang@mediatek.com, macpaul.lin@mediatek.com,
        wen.su@mediatek.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20220513034356.5268-1-zhiyong.tao@mediatek.com>
 <20220513034356.5268-2-zhiyong.tao@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20220513034356.5268-2-zhiyong.tao@mediatek.com>
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



On 13/05/2022 05:43, Zhiyong Tao wrote:
> From: "Zhiyong.Tao" <zhiyong.tao@mediatek.com>
> 
> Fix pwrap FSM timeout issue which leads the system crash on GFX VSRAM
> power on.
> The crash log:
> [ 3986.543401] mediatek-drm-dp 1c500000.edp_tx: drm_helper_hpd_irq_event
> [ 3986.670756] vsram_others: is_enabled() failed: -ETIMEDOUT
> [ 3986.670765] mali 13000000.mali: Power on reg 1 failed error = -110
> [ 3986.670768] ------------[ cut here ]------------
> [ 3986.670770] unbalanced disables for vsram_others
> [ 3986.670783] WARNING: CPU: 7 PID: 4125 at drivers/regulator/core.c:2761 _regulator_disable+0x194/0x1a0
> [ 3986.670785] Modules linked in: rfcomm algif_hash algif_skcipher af_alg veth uinput btusb btmtk btintel btbcm btrtl xt_cgroup bluetooth uvcvideo videobuf2_vmalloc ecdh_generic ecc mtk_vcodec_dec mtk_vcodec_enc mtk_mdp3 v4l2_h264 mtk_vcodec_common videobuf2_dma_contig mtk_vpu videobuf2_memops v4l2_mem2mem xt_MASQUERADE videobuf2_v4l2 videobuf2_common cros_ec_rpmsg mtk_scp mtk_rpmsg rpmsg_core mtk_scp_ipi ip6table_nat fuse 8021q iio_trig_sysfs cros_ec_sensors cros_ec_lid_angle cros_ec_sensors_core industrialio_triggered_buffer kfifo_buf cros_ec_sensorhub mt7921e mt7921_common mt76_connac_lib lzo_rle mt76 lzo_compress mac80211 cfg80211 zram r8152 mii joydev
> [ 3986.670830] CPU: 7 PID: 4125 Comm: mali-cmar-backe Not tainted 5.10.78-CL2781499-v287 #1 b899b40a63da40d4767c6c0e96b6700d2f3eb242
> [ 3986.670832] Hardware name: MediaTek Tomato board (DT)
> [ 3986.670835] pstate: 60400009 (nZCv daif +PAN -UAO -TCO BTYPE=--)
> [ 3986.670838] pc : _regulator_disable+0x194/0x1a0
> [ 3986.670840] lr : _regulator_disable+0x194/0x1a0
> [ 3986.670842] sp : ffffffc016203a10
> [ 3986.670843] x29: ffffffc016203a10 x28: ffffffb7c3186b28
> [ 3986.670846] x27: 0000000000000002 x26: fffffffffffffdc8
> [ 3986.670848] x25: ffffffc017225000 x24: ffffffb7c0e94880
> [ 3986.670851] x23: ffffffb7c31840f0 x22: ffffffd6b4f3e275
> [ 3986.670853] x21: ffffffb7c3181a00 x20: ffffffb7c27e7800
> [ 3986.670855] x19: ffffffb7c27e7800 x18: 00000000ffff0a10
> [ 3986.670857] x17: 0000000000000020 x16: 00000000000000ec
> [ 3986.670860] x15: ffffffd6b44fa17c x14: 0000000000000003
> [ 3986.670862] x13: 0000000000000004 x12: 0000000000fd8318
> [ 3986.670864] x11: c000000100029ccd x10: 00000000ffffffff
> [ 3986.670866] x9 : 7dd6d080afd6f400 x8 : 7dd6d080afd6f400
> [ 3986.670868] x7 : 0000000000000000 x6 : ffffffd6b5459f0c
> [ 3986.670871] x5 : ffffffc016203a58 x4 : 0000000000000000
> [ 3986.670873] x3 : ffffffc016203668 x2 : ffffffc016203670
> [ 3986.670875] x1 : 0000000100029ccd x0 : 0000000000000024
> [ 3986.670878] Call trace:
> [ 3986.670880]  _regulator_disable+0x194/0x1a0
> [ 3986.670883]  regulator_disable+0x4c/0x8c
> 
> Add a usleep delay to avoid busy read for the H/W status.
> If (time_after()) be turn first, it maybe cause the system behavior
> crash problem like above. so we change it after sleep delay.
> 
> Fixes: 1f022d84bd19 ("soc: mediatek: Add PMIC wrapper for MT8135 and
> MT8173 SoCs")
> 
> Signed-off-by: Zhiyong.Tao <zhiyong.tao@mediatek.com>

I prefer the solution send by Angelo on this:
https://lore.kernel.org/linux-mediatek/a8bd608c-d94c-f4a2-e3b1-3381c9098caf@gmail.com/T/#m44170235be954f39bafc404b266d2c5b59dd4853

Please feel free to provide feedback on this.

Regards,
Matthias

> ---
>   drivers/soc/mediatek/mtk-pmic-wrap.c | 8 ++++++--
>   1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/soc/mediatek/mtk-pmic-wrap.c b/drivers/soc/mediatek/mtk-pmic-wrap.c
> index 952bc554f443..f9e7c2f35157 100644
> --- a/drivers/soc/mediatek/mtk-pmic-wrap.c
> +++ b/drivers/soc/mediatek/mtk-pmic-wrap.c
> @@ -4,6 +4,7 @@
>    * Author: Flora Fu, MediaTek
>    */
>   #include <linux/clk.h>
> +#include <linux/delay.h>
>   #include <linux/interrupt.h>
>   #include <linux/io.h>
>   #include <linux/kernel.h>
> @@ -1197,10 +1198,13 @@ static int pwrap_wait_for_state(struct pmic_wrapper *wrp,
>   	timeout = jiffies + usecs_to_jiffies(10000);
>   
>   	do {
> -		if (time_after(jiffies, timeout))
> -			return fp(wrp) ? 0 : -ETIMEDOUT;
>   		if (fp(wrp))
>   			return 0;
> +
> +		usleep_range(10, 11);
> +
> +		if (time_after(jiffies, timeout))
> +			return fp(wrp) ? 0 : -ETIMEDOUT;
>   	} while (1);
>   }
>   
