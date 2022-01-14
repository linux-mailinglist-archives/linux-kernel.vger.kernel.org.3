Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 424F74905F5
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 11:32:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238641AbiAQKba (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 05:31:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233539AbiAQKb2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 05:31:28 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E764C061574;
        Mon, 17 Jan 2022 02:31:28 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id g81-20020a1c9d54000000b0034cd1acd9b5so481946wme.1;
        Mon, 17 Jan 2022 02:31:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:content-language:to:cc
         :references:from:subject:in-reply-to:content-transfer-encoding;
        bh=drzE6YehBAfCGTYeantFOUyrCID0+zzbF12IY9CFxQU=;
        b=UsHAOnftmCpjQS/OuNWUiYgvd7+GGI/3R5IkZpLRWZ8K7UCklqlJCeUomcEY44dnbt
         NMgY/zUrPvahx3gssaevse2KppcEe+b19m1UfgYZh/tIcFztpd4mo6147HLRcx2kzZMW
         C6fCjG6wzM3apbi+ayP2pvhlbcBZfS96FDE62pBoJX6vexu2r0QRlRauqzZ2sUqOLOSj
         50IEoNuO7SHvH1hvgb96hjPjZITzaCX+g/D7f03uBs4WXoZeAwZouFNZP5ravrW6ojvx
         hBQusJHloYz1q5Bk3bpVhZ31CYE4WivdbvW+h39rsWKKxkwBxMRXQKRGVnK1klcGoeBi
         b5gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:subject:in-reply-to
         :content-transfer-encoding;
        bh=drzE6YehBAfCGTYeantFOUyrCID0+zzbF12IY9CFxQU=;
        b=L9YHa2IeHZpmJeVmLI7jKlnFueeTnTf0cz2hesnvMVqxRlIJqQJ3IY2gkEggGx+3Oq
         gQ79zfykJrkDRpjt83nOBI5CSgGUUDuENCXS+sJ4jSz/nkdaVaOlAfYqEJzAl+eEBtCu
         LSvCVijZXQrOGeXh3xTrumXiBA7zebbLMsgOqSYKSGonbGF73xk7dI6vNwtATrsG5/Kg
         qFfzKXxEqWlakCNoTlWhqnQ4o0QI7f2tG58QdMCAOBHoJLStdOpsAwYn4pSpdH7LdwSB
         oOJZ+UqtNGMF6tshCL5rLfaiTQunvQ0ibdm3zY9aAPd2Utpe81afTBqHYLIh0mV8nnRE
         9f/w==
X-Gm-Message-State: AOAM532YksN7W+ikRd593JAFpv3V8wekQ9m1PyGT7yqFA1Gu1V+I2KbG
        fsnOy41DK7r/hqPzEuoIVbPZPWIAbxk=
X-Google-Smtp-Source: ABdhPJzPgzWevB3vn/b9crfzsgD7xhyUdvEZ8B8T4+GHOzdrlM6GpVQRKNrcl/xex+H0dhGUZ3EGfg==
X-Received: by 2002:a5d:47ad:: with SMTP id 13mr19798499wrb.545.1642415486661;
        Mon, 17 Jan 2022 02:31:26 -0800 (PST)
Received: from [192.168.0.14] ([37.223.145.74])
        by smtp.gmail.com with ESMTPSA id b15sm9890257wrr.50.2022.01.17.02.31.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Jan 2022 02:31:26 -0800 (PST)
Message-ID: <9949a1f7-1ed5-a137-c7b9-2ef8d8e1caf8@gmail.com>
Date:   Fri, 14 Jan 2022 16:46:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Content-Language: en-US
To:     Johnson Wang <johnson.wang@mediatek.com>, robh+dt@kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        angelogioacchino.delregno@collabora.com,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20220107104633.7500-1-johnson.wang@mediatek.com>
 <20220107104633.7500-2-johnson.wang@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Subject: Re: [PATCH v2 1/2] soc: mediatek: pwrap: add pwrap driver for MT8186
 SoC
In-Reply-To: <20220107104633.7500-2-johnson.wang@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 07/01/2022 11:46, Johnson Wang wrote:
> MT8186 are highly integrated SoC and use PMIC_MT6366 for
> power management. This patch adds pwrap master driver to
> access PMIC_MT6366.
> 

It seems this new arbiter is significantly different from the version 1. Please 
explain that in the commit message.

> Signed-off-by: Johnson Wang <johnson.wang@mediatek.com>
> ---
>   drivers/soc/mediatek/mtk-pmic-wrap.c | 72 ++++++++++++++++++++++++++++
>   1 file changed, 72 insertions(+)
> 
> diff --git a/drivers/soc/mediatek/mtk-pmic-wrap.c b/drivers/soc/mediatek/mtk-pmic-wrap.c
> index 952bc554f443..78866ebf7f04 100644
> --- a/drivers/soc/mediatek/mtk-pmic-wrap.c
> +++ b/drivers/soc/mediatek/mtk-pmic-wrap.c
> @@ -30,6 +30,7 @@
>   #define PWRAP_GET_WACS_REQ(x)		(((x) >> 19) & 0x00000001)
>   #define PWRAP_STATE_SYNC_IDLE0		BIT(20)
>   #define PWRAP_STATE_INIT_DONE0		BIT(21)
> +#define PWRAP_STATE_INIT_DONE0_V2	BIT(22)

That's a strange name, does it come from the datasheet description?

>   #define PWRAP_STATE_INIT_DONE1		BIT(15)
>   
>   /* macro for WACS FSM */
> @@ -77,6 +78,8 @@
>   #define PWRAP_CAP_INT1_EN	BIT(3)
>   #define PWRAP_CAP_WDT_SRC1	BIT(4)
>   #define PWRAP_CAP_ARB		BIT(5)
> +#define PWRAP_CAP_MONITOR_V2	BIT(6)

Not used capability, please delete.


Regards,
Matthias
