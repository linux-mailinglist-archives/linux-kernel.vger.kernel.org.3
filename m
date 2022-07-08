Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F07F156B436
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 10:13:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237685AbiGHILs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 04:11:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237303AbiGHILp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 04:11:45 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E75F47E034
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 01:11:44 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id p18so7354580ilm.4
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jul 2022 01:11:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=D0Qf6XYpQVz6j4kI9S9/dfIfwmKCeXho7yxm3tWLHDw=;
        b=a8PcvC8T4pJniQ7yqIayMgWH+3gEkHFNYRNhxRMkOr+jhG/UVyB81CyvGH1U4WYubR
         kpQ6Xx8kAmsRhSqkwvV2Wmt1lbaLqIT2v8NsFZiAJfZYikttPD39vSH//rSSnRJNKWvP
         Fd4GpgmjsxOTqwJVm5oWb5g1hbTgrTWJmgv1ydYr/5ZIGUfX/Ra4U9VsVHtVb3hTNdC0
         Ba3uPYLrjTDGkbr9WrQnt3A/kHsQWVzo7qPGW7Xl3yeTNshhdwpBPg/bkWBk8iaMDxys
         n64woJm5X85Tw/NZHT+GJG3SJJ0xSGbjYzuTIWnKfkKwxKgVg1VaWrTs9U4crZuba7d/
         LIWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=D0Qf6XYpQVz6j4kI9S9/dfIfwmKCeXho7yxm3tWLHDw=;
        b=6FgxwMW7U4mBQfc5JtMDqtIobyCNBViEC8YmejaVqHWqoBM+Vs4Yb3gg1pq4g8fiMp
         ti1LuqtCnh63wyQ5gkLC5V6PVysIGBS0DKcGTSYH5NIkuR3Wm3RPnJdbLETJxBzEY+9E
         MHz7MDSCbB60s0Vp3EMWMF0XF6yArUctWypcSxTRJYsJe/W/Fjs75bylZMCiygUlm87K
         jrg0opGJ70Jsts7t9nIxwFapc0eyI86UuJI+Ubd8uBr0BAoOyEJ08mHjZpd66OvalA9h
         jfeD6iT+uBHDRPN2jg3QFKjAhtisl7+QewWiiGbBMwsDCC1oOYXVw+C7ZdANmYUvj9Sc
         zrUg==
X-Gm-Message-State: AJIora+hn0rryx8pwlA+IlPp0sFQ0kYjVeA/buAzlie4INlJP5sseWt/
        kgUIzgfcyGax4CGrX6n+ZMY=
X-Google-Smtp-Source: AGRyM1v57jK2+8qNDptU7lzeTTrC2OcvyKTWnuxBMkLgal9tNGKAfuHo96gs8C1loeyjFe61SHiZww==
X-Received: by 2002:a05:6e02:1848:b0:2da:af35:e7c3 with SMTP id b8-20020a056e02184800b002daaf35e7c3mr1352620ilv.265.1657267904342;
        Fri, 08 Jul 2022 01:11:44 -0700 (PDT)
Received: from [192.168.1.145] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id z62-20020a0293c4000000b0033f258426c0sm960209jah.108.2022.07.08.01.11.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Jul 2022 01:11:43 -0700 (PDT)
Message-ID: <624e365e-0f00-9640-74a7-c16e7c7d3469@gmail.com>
Date:   Fri, 8 Jul 2022 10:11:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] ASoC: mediatek: mt8186: Remove condition with no effect
Content-Language: en-US
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Zhongjun Tan <hbut_tan@163.com>, lgirdwood@gmail.com,
        broonie@kernel.org, perex@perex.c, tiwai@suse.com,
        jiaxin.yu@mediatek.com, tanzhongjun@coolpad.com,
        colin.king@intel.com
Cc:     alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220708024651.42999-1-hbut_tan@163.com>
 <ee0d9788-b742-21bb-9cc5-7b729897408b@collabora.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <ee0d9788-b742-21bb-9cc5-7b729897408b@collabora.com>
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



On 08/07/2022 10:01, AngeloGioacchino Del Regno wrote:
> Il 08/07/22 04:46, Zhongjun Tan ha scritto:
>> From: Zhongjun Tan <tanzhongjun@coolpad.com>
>>
>> Remove condition with no effect
>>
>> Signed-off-by: Zhongjun Tan <tanzhongjun@coolpad.com>
>> ---
>>   sound/soc/mediatek/mt8186/mt8186-dai-adda.c | 2 --
>>   1 file changed, 2 deletions(-)
>>
>> diff --git a/sound/soc/mediatek/mt8186/mt8186-dai-adda.c 
>> b/sound/soc/mediatek/mt8186/mt8186-dai-adda.c
>> index db71b032770d..6be6d4f3b585 100644
>> --- a/sound/soc/mediatek/mt8186/mt8186-dai-adda.c
>> +++ b/sound/soc/mediatek/mt8186/mt8186-dai-adda.c
>> @@ -295,8 +295,6 @@ static int mtk_adda_pad_top_event(struct 
>> snd_soc_dapm_widget *w,
>>       case SND_SOC_DAPM_PRE_PMU:
>>           if (afe_priv->mtkaif_protocol == MTKAIF_PROTOCOL_2_CLK_P2)
>>               regmap_write(afe->regmap, AFE_AUD_PAD_TOP, 0x39);
>> -        else if (afe_priv->mtkaif_protocol == MTKAIF_PROTOCOL_2)
>> -            regmap_write(afe->regmap, AFE_AUD_PAD_TOP, 0x31);
> 
> I think that this needs some clarification from MediaTek: was 0x31 a typo here?
> 

Looks like the write is covered by the else case already, so we don't need the 
else if here. In any case commit message could be improved.

Regards,
Matthias

> Regards,
> Angelo
> 
>>           else
>>               regmap_write(afe->regmap, AFE_AUD_PAD_TOP, 0x31);
>>           break;
> 
> 
