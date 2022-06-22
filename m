Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79D3D554B70
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 15:37:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352309AbiFVNhn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 09:37:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234818AbiFVNhm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 09:37:42 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 077912FE43
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 06:37:42 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id g27so16815714wrb.10
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 06:37:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=SpcFGJ6n0+SK7F+o6tdzT8HyM1K20g6VGm8Wi083pY8=;
        b=GE7NERFPHGya90Fo2c5HfH5TZdp/m3VdL8I9LBKctooLVvk4hWibY9l39gnm/B6/s9
         BaQoVzoYRFIwbgHXaGBGkGZ92S8R+XoJfXCL7zDEha0goU/bT47tn+2YNy9n1npfLHYn
         xtrvC2zzM4rvziWS7HJy0i4Eyra0hZai5beh92ZmgAvXk2BFHF30IRqLb8pD0qI98lI3
         QF4/yOpc1lMRu5fztaoLa2cRT37IztSjT0hWe7EjZRHic4DxObSFy4j9utAhuTmdNdfP
         fLrwicDzKqt1uHHX/9scFOI6B8Y925dC+NyS3b+6iRVQeY8kA5TMsEQ+ot4vSD+gQyZk
         WoFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=SpcFGJ6n0+SK7F+o6tdzT8HyM1K20g6VGm8Wi083pY8=;
        b=WNz3mRyW9QqZJlmaX17orA81e7NpK6Te8Bv/P8cH5xvMtfrhaAHAN1O9uh3aXklIuu
         rN2v4i6w80OAngEkN+f6mV3dRt2TW8nxvIn5QlFxC9kPZtW6wPKxnmr6YpJvQzmKDLJG
         2EElQL+pFaDgt1OERU7zkRJVK7qaz8r2rhNOJOH5xb7xqrpM25m17cwZamp49fhn19TR
         XXcxCHx/fZP46FbgOK0Md4UR4z2ejKtTt9AM0TvOneV4lrIjVi1a4vqdbl8yFzJsEiKE
         4GxdhETvjsXExCt/nvn9gdqC0xYpzrClKVlBXjaRsCjP++nCn0T6LH9FJi8zJIbwPcsK
         l9Fw==
X-Gm-Message-State: AJIora+XxXrFkdibLH5qmI5W36HO0wWR3EInDVaH6UnIjObahurmBnR7
        FBk/lmDoNY1O4l9LwfPAxsk=
X-Google-Smtp-Source: AGRyM1s8Wc+wSV56bWU8opXAUT9pn07peusKs6xuDTYBu+MG5ACKUa56p1zZ4q/LzYn0J19u3adbFw==
X-Received: by 2002:a5d:47a7:0:b0:218:5a5d:6c55 with SMTP id 7-20020a5d47a7000000b002185a5d6c55mr3394871wrb.192.1655905060476;
        Wed, 22 Jun 2022 06:37:40 -0700 (PDT)
Received: from [192.168.0.16] ([37.223.148.38])
        by smtp.gmail.com with ESMTPSA id z6-20020a5d4d06000000b0021a3dd1c5d5sm16631151wrt.96.2022.06.22.06.37.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jun 2022 06:37:39 -0700 (PDT)
Message-ID: <e09a4f5e-8fbf-be3b-85af-a6dad347f67f@gmail.com>
Date:   Wed, 22 Jun 2022 15:37:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: soc: mediatek: SVS: introduce MTK SVS engine
Content-Language: en-US
To:     "Colin King (gmail)" <colin.i.king@gmail.com>,
        Roger Lu <roger.lu@mediatek.com>
Cc:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Kevin Hilman <khilman@baylibre.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <7f995d57-c40b-6c32-e776-677ae1496769@gmail.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <7f995d57-c40b-6c32-e776-677ae1496769@gmail.com>
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

Hi Colin,

On 22/06/2022 14:02, Colin King (gmail) wrote:
> Hi,
> 
> static analysis on linux-next with clang scan-build has detected a null pointer 
> dereference in the following commit:
> 
> commit 681a02e9500073cd8b9c25a04f06166254b5a879
> Author: Roger Lu <roger.lu@mediatek.com>
> Date:   Mon May 16 08:43:07 2022 +0800
> 
>      soc: mediatek: SVS: introduce MTK SVS engine
> 
> 
> The issue is as follows:
> 
> static irqreturn_t svs_isr(int irq, void *data)
> {
>          struct svs_platform *svsp = data;
>          struct svs_bank *svsb = NULL;
>          unsigned long flags;
>          u32 idx, int_sts, svs_en;
> 
>          for (idx = 0; idx < svsp->bank_max; idx++) {
>                  svsb = &svsp->banks[idx];
>                  WARN(!svsb, "%s: svsb(%s) is null", __func__, svsb->name);
>                  spin_lock_irqsave(&svs_lock, flags);
>                  svsp->pbank = svsb;
> 
> 
> If svsb is null, then the WARN message will dereference it when printing 
> svsb->name.  Also, subsequent dereferences to sbsv will cause a null pointer 
> dereference, for example the svsp->pbank assignment.
> 
> Colin

The banks and bank_max are defined on a per SoC basis in the platform data [1]. 
The case that svsb is null would hint to a incorrect platform data. So I think 
that there is no real issue we need to fix.

Regards,
Matthias


[1] 
https://git.kernel.org/pub/scm/linux/kernel/git/matthias.bgg/linux.git/tree/drivers/soc/mediatek/mtk-svs.c?h=v5.19-next/soc#n2237
