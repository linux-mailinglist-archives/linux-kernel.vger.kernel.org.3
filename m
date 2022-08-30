Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3A305A5D16
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 09:37:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231167AbiH3Hh0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 03:37:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231175AbiH3HhX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 03:37:23 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23C4DC59DB
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 00:37:22 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id e13so12077328wrm.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 00:37:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=Zq/iNvuZhFEDaN8OcO2RvNrASLMMDALVcl47N1W89K8=;
        b=mM5BtaTFWnCSIbgfMpWPjN6/DwGilpiMK4Qx1PL06CO0hoIUzF7ZY5tzk05mSm7x0z
         DC/F5QA0AVUFg4q4dut6BcqqbZk1pmnI9wggVHnMhBBeKKakOtkAtGdoeowDaeQACyDv
         tHP0lwKyqurExWG+0XKGPlrjiBfAiTL5XqSRV2LZp2Y1diY/NFSEon6nNFGXxBwKjawQ
         2ypNSehU85aQBZ7EU0B0XCc+2PfAHkVrQs934MCU05CkWdvaHym6sXbiHkp5NQvq3Rkq
         Z+77B9hScl9uaYAnxID6PAPETGK6LWXQlyHpMkY1u/ji63iOKuugZ47wSrtGy7aRoptH
         nfgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=Zq/iNvuZhFEDaN8OcO2RvNrASLMMDALVcl47N1W89K8=;
        b=4Pv9MQcmJhpV//0g2idgo4HSwpeT3Sltk4EuVXor3j1HG1tIJHAZEPSAQ6pb5wRJHV
         qiCDXwnz9EStVyACuy05da2Mmlod8TkDMyiKm6YNQ+lZbbY28zouFumkqsi9WGGj6Biv
         lW50oSemKiuZPgcrlOLqQo95AhIAL5PqjR0JiqkB/PsQckZ+jfOoYNhu9fF99K2DxVdG
         +J7luSqoDrAodRC2L2OJNjNM8kVujnHiZi7e71FsZZSaHU/nC2pSayr3w5eGDkt1+37v
         xsdLGTtbXM484egpvrb+NTClE99AdaGuD5qb4KM7e0gYW1X7aI6+SuxnFk/IrLFLMgFI
         rHug==
X-Gm-Message-State: ACgBeo2Td6LM4zJMlukQfYVt5VVHLPiUCPx0Hm8QKEGfFv1tKW7eH30Q
        KtQcm7DcrQ1vbGo2iSy0tMZz+cKK9yQ=
X-Google-Smtp-Source: AA6agR7838HEKDFv8SDR/C0DqIiWeOv2e48jy1bxo8YFxdmdRF2Vl1V9xjSqWzmOdDEXu2QYvR6ybg==
X-Received: by 2002:a05:6000:1f8c:b0:225:3bea:1ac9 with SMTP id bw12-20020a0560001f8c00b002253bea1ac9mr8275179wrb.65.1661845040671;
        Tue, 30 Aug 2022 00:37:20 -0700 (PDT)
Received: from [192.168.2.177] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id g13-20020adfe40d000000b002252751629dsm8871598wrm.24.2022.08.30.00.37.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Aug 2022 00:37:19 -0700 (PDT)
Message-ID: <5a8a2b0d-fa7c-e8c6-bb04-152f8c17aa76@gmail.com>
Date:   Tue, 30 Aug 2022 09:37:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH] soc: mediatek: mtk-svs: Explicitly include bitfield
 header
To:     =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@collabora.com>
Cc:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, kernel@collabora.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
References: <20220829204439.3748648-1-nfraprado@collabora.com>
Content-Language: en-US
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20220829204439.3748648-1-nfraprado@collabora.com>
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



On 29/08/2022 22:44, Nícolas F. R. A. Prado wrote:
> Commit a92438c5a30a ("soc: mediatek: mtk-svs: Use bitfield access macros
> where possible") introduced the use of FIELD_GET and FIELD_PREP macros,
> which are defined in the bitfield header. Add an explicit include for it
> so we're sure to have the symbols defined independently of the config.
> 
> Fixes: a92438c5a30a ("soc: mediatek: mtk-svs: Use bitfield access macros where possible")
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> 
> ---
> 
>   drivers/soc/mediatek/mtk-svs.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/soc/mediatek/mtk-svs.c b/drivers/soc/mediatek/mtk-svs.c
> index 64dba9f830f3..f67f3e971653 100644
> --- a/drivers/soc/mediatek/mtk-svs.c
> +++ b/drivers/soc/mediatek/mtk-svs.c
> @@ -3,6 +3,7 @@
>    * Copyright (C) 2022 MediaTek Inc.
>    */
>   
> +#include <linux/bitfield.h>
>   #include <linux/bits.h>

What do we need the bits.h for?

Regards,
Matthias

>   #include <linux/clk.h>
>   #include <linux/completion.h>
