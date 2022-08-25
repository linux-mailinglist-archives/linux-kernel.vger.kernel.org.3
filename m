Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5AC65A152D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 17:05:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238176AbiHYPE7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 11:04:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242600AbiHYPEi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 11:04:38 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B07BCB777E
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 08:04:35 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id k17so10402607wmr.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 08:04:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=FjzfQgvp9Pt54PbuI+NrL+4+IIsBmjAlu5P//Rcqxr8=;
        b=W4RDP8KJqP48Z9qNlOeWmiPifiTsPzHAXkdP8Vn/obNsP5WU6TNCdwSnvxRiLesm6I
         uDrF/FAzWwGpvJJ4z6O31VFowRZY0oet/yZmZi0Qd1G8OPLQXyb6u6Yz+aZky7HWaxGa
         lwEyF666GErBM0pHd6T3diDRC+HSpHE4e0UJUkuQn2Udi9FubkZGO4dgeHrRieK5X7B5
         1ziTsch3E9h9GSIsP5Bjd9ivSDzeBkXv6Rq6AleqOc8I2EwwyBiXK4njSyfazrMm/qzi
         Y14lAYpYQraYdnrgaEYKX39AhQfaPGHe59qiCVbd74sld9MkkqeXZjjtJUk/776np0Ea
         /URQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=FjzfQgvp9Pt54PbuI+NrL+4+IIsBmjAlu5P//Rcqxr8=;
        b=6r1ebwuFmj1ogBlPEzqVx+LLNwNmGw+cREf2td7VPpVgGpWIHrJzxB1gbKAN7hefz5
         a6XtaZ1Pk8BiUr/Fn1rA/bSUqHajcQhQnTaPpJAfTGwKjtSbFblSkXSX5GNHm/0KPbXb
         3QNLLUAUFTebWO4Emg4WEHAkMrj2KiRKCYk5zEMkwzutNNV0+sKRiwWqKRPsTYh9k98O
         xRdMR52CnCvjqNQ+hgp+5tszn42Z9QHAA43EpHQAtdxvxfB4Po505ugpyPi75SZuA0D3
         xACZ9DWmaOcSxNMjKrTgh5jqqaQ2fwNvVyARm2ONslKOizvMhFduPKae6KaRVpnorxBR
         cpow==
X-Gm-Message-State: ACgBeo2Ok/yTLZbCmg4DTs2zTqGd0JJTcT/oJ94VD4v2V7Wc8xZzdzVJ
        51pwpW9NCYtDLI53yZLgYFo=
X-Google-Smtp-Source: AA6agR6g4f+/nbB5a2H60OA7LKWWU9LDI4eXIcuSltTLoDctj9q1XvjqBYoYfQIjU7evtlSeCAWh7g==
X-Received: by 2002:a05:600c:1c9a:b0:3a6:1c85:7a0c with SMTP id k26-20020a05600c1c9a00b003a61c857a0cmr2539978wms.155.1661439873552;
        Thu, 25 Aug 2022 08:04:33 -0700 (PDT)
Received: from [192.168.2.177] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id q11-20020a5d61cb000000b00223b8168b15sm19831396wrv.66.2022.08.25.08.04.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Aug 2022 08:04:32 -0700 (PDT)
Message-ID: <b0f6a3c6-8fef-8983-fb69-6157a9859afd@gmail.com>
Date:   Thu, 25 Aug 2022 17:04:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH v3,1/2] soc: mediatek: Add mmsys func to adapt to dpi
 output for MT8186
Content-Language: en-US
To:     =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@collabora.com>, xinlei.lee@mediatek.com
Cc:     chunkuang.hu@kernel.org, p.zabel@pengutronix.de, airlied@linux.ie,
        daniel@ffwll.ch, rex-bc.chen@mediatek.com,
        angelogioacchino.delregno@collabora.com, jason-jh.lin@mediatek.com,
        yongqiang.niu@mediatek.com, dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        Jitao Shi <jitao.shi@mediatek.com>
References: <1661236702-30682-1-git-send-email-xinlei.lee@mediatek.com>
 <20220823201758.ffbgb5t5odoicgir@notapiano>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20220823201758.ffbgb5t5odoicgir@notapiano>
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



On 23/08/2022 22:17, Nícolas F. R. A. Prado wrote:
> On Tue, Aug 23, 2022 at 02:38:22PM +0800, xinlei.lee@mediatek.com wrote:
>> From: Xinlei Lee <xinlei.lee@mediatek.com>
>>
>> Add mmsys function to manipulate dpi output format configuration for MT8186.
>>
>> Co-developed-by: Jitao Shi <jitao.shi@mediatek.com>
>> Signed-off-by: Jitao Shi <jitao.shi@mediatek.com>
>> Signed-off-by: Xinlei Lee <xinlei.lee@mediatek.com>
> 
> Reviewed-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> 

Patch looks fine, I'll wait for v4 as there is still some discussion on the DRM 
part. Please try to fix the threading problem you had in sending this series.

Thanks,
Matthias
