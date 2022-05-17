Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32BA9529DF9
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 11:27:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241841AbiEQJ0z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 05:26:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244910AbiEQJ0D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 05:26:03 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8782F63B3
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 02:26:00 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id p5-20020a1c2905000000b003970dd5404dso938849wmp.0
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 02:26:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=06jX5oM1pbrHg2MBJo6W7Zu02wl9+arnjb2IAQnMBQk=;
        b=J1Re9Rs2D/LAUT3V+4+0jhTu4OmDIZ777QSntqeveesTBy+YlotZ/BBaTB/xsvIGe7
         NxcCgkWwoC+GMi7beQRHzOweBMAH692/1pqXCiHJkPSc0iK0S9rGoROgKPjj9cBYXQ1Q
         M3cg8UR4J/kAEq71Qr+SYhN7LJCt4JTt5f++IjvxPF/ZHz5EFmD7PDssm/Y41eXf+Y1x
         ee92i0OZ2ZPs+3hVoJioy2jmMSiSRmtzKYo6ThBmEKL2hG3aKMaXjNFGUa7EFMfwWElS
         VgEhyIpGr0yn6/U//E0usxufvnTarjMVBHvJh2eCG3vkJjZGsXuppWeUkoVEh77CVlYR
         8uYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=06jX5oM1pbrHg2MBJo6W7Zu02wl9+arnjb2IAQnMBQk=;
        b=Jm5aH51IRyJPqUAffRZKKeoENjSIdt9JJ0z224WuKAWEjJ92vwTEexhQ1U/nx4lJ0F
         mieuygBkiGWDjS6bDqVLJnUGYB5k/OlNmmqfdJSC3B8j+x7EYgNtpDaJKvlTPIrGJCm5
         hfZacWITgvjuRL/U0xgDK8l8lUvOjHYfkmP/71QqfKj+DUk9Qm6azyTA/HmqowuyRCcd
         rzUoHPXt3TNo5M1oOYvwYAp55NKU9cn5KtKl5CBZszb4OgwN8i6YTBflanZKWrLQXHzO
         3PkycxYH+SYeQ7kGZVZ8kXTL+Pp3GRJSOd4wFMrj8XBJtLRXlvFnJdiZ2Iu8FNAcK7O4
         Lr1w==
X-Gm-Message-State: AOAM5325fRHYLUYjvOE4vCioSz0Kbqgm3VZZb1/VWqYX21re8WzUVgm5
        n3OUJGVWTuVezgeiyOaZoEU=
X-Google-Smtp-Source: ABdhPJwDHJKzA2ux3G7PusJSgIbAZKZYv8tU4/dzL2F1MzBuDBOV69Nz9zMNKiZEGD/39AH5FwnhHw==
X-Received: by 2002:a05:600c:4f8f:b0:394:85c3:cf9 with SMTP id n15-20020a05600c4f8f00b0039485c30cf9mr20424125wmq.125.1652779558963;
        Tue, 17 May 2022 02:25:58 -0700 (PDT)
Received: from [192.168.2.177] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id f13-20020adfc98d000000b0020c5253d8desm12078391wrh.42.2022.05.17.02.25.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 May 2022 02:25:58 -0700 (PDT)
Message-ID: <f8acbc75-970c-62fb-ad0d-914e512104a7@gmail.com>
Date:   Tue, 17 May 2022 11:25:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v3 1/5] soc: mediatek: pwrap: Use readx_poll_timeout()
 instead of custom function
Content-Language: en-US
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        nfraprado@collabora.com, rex-bc.chen@mediatek.com,
        zhiyong.tao@mediatek.com
References: <20220516124659.69484-1-angelogioacchino.delregno@collabora.com>
 <20220516124659.69484-2-angelogioacchino.delregno@collabora.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20220516124659.69484-2-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 16/05/2022 14:46, AngeloGioacchino Del Regno wrote:
> Function pwrap_wait_for_state() is a function that polls an address
> through a helper function, but this is the very same operation that
> the readx_poll_timeout macro means to do.
> Convert all instances of calling pwrap_wait_for_state() to instead
> use the read_poll_timeout macro.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> Reviewed-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> Tested-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> ---
>   drivers/soc/mediatek/mtk-pmic-wrap.c | 60 +++++++++++++++-------------
>   1 file changed, 33 insertions(+), 27 deletions(-)
> 
> diff --git a/drivers/soc/mediatek/mtk-pmic-wrap.c b/drivers/soc/mediatek/mtk-pmic-wrap.c
> index bf39a64f3ecc..54a5300ab72b 100644
> --- a/drivers/soc/mediatek/mtk-pmic-wrap.c
> +++ b/drivers/soc/mediatek/mtk-pmic-wrap.c
> @@ -13,6 +13,9 @@
>   #include <linux/regmap.h>
>   #include <linux/reset.h>
>   
> +#define PWRAP_POLL_DELAY_US	10
> +#define PWRAP_POLL_TIMEOUT_US	10000
> +
>   #define PWRAP_MT8135_BRIDGE_IORD_ARB_EN		0x4
>   #define PWRAP_MT8135_BRIDGE_WACS3_EN		0x10
>   #define PWRAP_MT8135_BRIDGE_INIT_DONE3		0x14
> @@ -1241,27 +1244,14 @@ static bool pwrap_is_fsm_idle_and_sync_idle(struct pmic_wrapper *wrp)
>   		(val & PWRAP_STATE_SYNC_IDLE0);
>   }
>   
> -static int pwrap_wait_for_state(struct pmic_wrapper *wrp,
> -		bool (*fp)(struct pmic_wrapper *))
> -{
> -	unsigned long timeout;
> -
> -	timeout = jiffies + usecs_to_jiffies(10000);
> -
> -	do {
> -		if (time_after(jiffies, timeout))
> -			return fp(wrp) ? 0 : -ETIMEDOUT;
> -		if (fp(wrp))
> -			return 0;
> -	} while (1);
> -}
> -
>   static int pwrap_read16(struct pmic_wrapper *wrp, u32 adr, u32 *rdata)
>   {
> +	bool tmp;
>   	int ret;
>   	u32 val;
>   
> -	ret = pwrap_wait_for_state(wrp, pwrap_is_fsm_idle);
> +	ret = readx_poll_timeout(pwrap_is_fsm_idle, wrp, tmp, tmp,

hm, if we make the cond (tmp > 0) that would help to understand the code. At 
least I had to think about it for a moment. But I leave it to you if you think 
it's worth the effort.

Regards,
Matthias

> +				 PWRAP_POLL_DELAY_US, PWRAP_POLL_TIMEOUT_US);
>   	if (ret) {
>   		pwrap_leave_fsm_vldclr(wrp);
>   		return ret;
> @@ -1273,7 +1263,8 @@ static int pwrap_read16(struct pmic_wrapper *wrp, u32 adr, u32 *rdata)
>   		val = (adr >> 1) << 16;
>   	pwrap_writel(wrp, val, PWRAP_WACS2_CMD);
>   
> -	ret = pwrap_wait_for_state(wrp, pwrap_is_fsm_vldclr);
> +	ret = readx_poll_timeout(pwrap_is_fsm_vldclr, wrp, tmp, tmp,
> +				 PWRAP_POLL_DELAY_US, PWRAP_POLL_TIMEOUT_US);
>   	if (ret)
>   		return ret;
>   
> @@ -1290,11 +1281,14 @@ static int pwrap_read16(struct pmic_wrapper *wrp, u32 adr, u32 *rdata)
>   
>   static int pwrap_read32(struct pmic_wrapper *wrp, u32 adr, u32 *rdata)
>   {
> +	bool tmp;
>   	int ret, msb;
>   
>   	*rdata = 0;
>   	for (msb = 0; msb < 2; msb++) {
> -		ret = pwrap_wait_for_state(wrp, pwrap_is_fsm_idle);
> +		ret = readx_poll_timeout(pwrap_is_fsm_idle, wrp, tmp, tmp,
> +					 PWRAP_POLL_DELAY_US, PWRAP_POLL_TIMEOUT_US);
> +
>   		if (ret) {
>   			pwrap_leave_fsm_vldclr(wrp);
>   			return ret;
> @@ -1303,7 +1297,8 @@ static int pwrap_read32(struct pmic_wrapper *wrp, u32 adr, u32 *rdata)
>   		pwrap_writel(wrp, ((msb << 30) | (adr << 16)),
>   			     PWRAP_WACS2_CMD);
>   
> -		ret = pwrap_wait_for_state(wrp, pwrap_is_fsm_vldclr);
> +		ret = readx_poll_timeout(pwrap_is_fsm_vldclr, wrp, tmp, tmp,
> +					 PWRAP_POLL_DELAY_US, PWRAP_POLL_TIMEOUT_US);
>   		if (ret)
>   			return ret;
>   
> @@ -1323,9 +1318,11 @@ static int pwrap_read(struct pmic_wrapper *wrp, u32 adr, u32 *rdata)
>   
>   static int pwrap_write16(struct pmic_wrapper *wrp, u32 adr, u32 wdata)
>   {
> +	bool tmp;
>   	int ret;
>   
> -	ret = pwrap_wait_for_state(wrp, pwrap_is_fsm_idle);
> +	ret = readx_poll_timeout(pwrap_is_fsm_idle, wrp, tmp, tmp,
> +				 PWRAP_POLL_DELAY_US, PWRAP_POLL_TIMEOUT_US);
>   	if (ret) {
>   		pwrap_leave_fsm_vldclr(wrp);
>   		return ret;
> @@ -1344,10 +1341,12 @@ static int pwrap_write16(struct pmic_wrapper *wrp, u32 adr, u32 wdata)
>   
>   static int pwrap_write32(struct pmic_wrapper *wrp, u32 adr, u32 wdata)
>   {
> +	bool tmp;
>   	int ret, msb, rdata;
>   
>   	for (msb = 0; msb < 2; msb++) {
> -		ret = pwrap_wait_for_state(wrp, pwrap_is_fsm_idle);
> +		ret = readx_poll_timeout(pwrap_is_fsm_idle, wrp, tmp, tmp,
> +					 PWRAP_POLL_DELAY_US, PWRAP_POLL_TIMEOUT_US);
>   		if (ret) {
>   			pwrap_leave_fsm_vldclr(wrp);
>   			return ret;
> @@ -1388,6 +1387,7 @@ static int pwrap_regmap_write(void *context, u32 adr, u32 wdata)
>   
>   static int pwrap_reset_spislave(struct pmic_wrapper *wrp)
>   {
> +	bool tmp;
>   	int ret, i;
>   
>   	pwrap_writel(wrp, 0, PWRAP_HIPRIO_ARB_EN);
> @@ -1407,7 +1407,8 @@ static int pwrap_reset_spislave(struct pmic_wrapper *wrp)
>   		pwrap_writel(wrp, wrp->master->spi_w | PWRAP_MAN_CMD_OP_OUTS,
>   				PWRAP_MAN_CMD);
>   
> -	ret = pwrap_wait_for_state(wrp, pwrap_is_sync_idle);
> +	ret = readx_poll_timeout(pwrap_is_sync_idle, wrp, tmp, tmp,
> +				 PWRAP_POLL_DELAY_US, PWRAP_POLL_TIMEOUT_US);
>   	if (ret) {
>   		dev_err(wrp->dev, "%s fail, ret=%d\n", __func__, ret);
>   		return ret;
> @@ -1458,14 +1459,15 @@ static int pwrap_init_sidly(struct pmic_wrapper *wrp)
>   static int pwrap_init_dual_io(struct pmic_wrapper *wrp)
>   {
>   	int ret;
> +	bool tmp;
>   	u32 rdata;
>   
>   	/* Enable dual IO mode */
>   	pwrap_write(wrp, wrp->slave->dew_regs[PWRAP_DEW_DIO_EN], 1);
>   
>   	/* Check IDLE & INIT_DONE in advance */
> -	ret = pwrap_wait_for_state(wrp,
> -				   pwrap_is_fsm_idle_and_sync_idle);
> +	ret = readx_poll_timeout(pwrap_is_fsm_idle_and_sync_idle, wrp, tmp, tmp,
> +				 PWRAP_POLL_DELAY_US, PWRAP_POLL_TIMEOUT_US);
>   	if (ret) {
>   		dev_err(wrp->dev, "%s fail, ret=%d\n", __func__, ret);
>   		return ret;
> @@ -1570,6 +1572,7 @@ static bool pwrap_is_pmic_cipher_ready(struct pmic_wrapper *wrp)
>   static int pwrap_init_cipher(struct pmic_wrapper *wrp)
>   {
>   	int ret;
> +	bool tmp;
>   	u32 rdata = 0;
>   
>   	pwrap_writel(wrp, 0x1, PWRAP_CIPHER_SWRST);
> @@ -1624,14 +1627,16 @@ static int pwrap_init_cipher(struct pmic_wrapper *wrp)
>   	}
>   
>   	/* wait for cipher data ready@AP */
> -	ret = pwrap_wait_for_state(wrp, pwrap_is_cipher_ready);
> +	ret = readx_poll_timeout(pwrap_is_cipher_ready, wrp, tmp, tmp,
> +				 PWRAP_POLL_DELAY_US, PWRAP_POLL_TIMEOUT_US);
>   	if (ret) {
>   		dev_err(wrp->dev, "cipher data ready@AP fail, ret=%d\n", ret);
>   		return ret;
>   	}
>   
>   	/* wait for cipher data ready@PMIC */
> -	ret = pwrap_wait_for_state(wrp, pwrap_is_pmic_cipher_ready);
> +	ret = readx_poll_timeout(pwrap_is_pmic_cipher_ready, wrp, tmp, tmp,
> +				 PWRAP_POLL_DELAY_US, PWRAP_POLL_TIMEOUT_US);
>   	if (ret) {
>   		dev_err(wrp->dev,
>   			"timeout waiting for cipher data ready@PMIC\n");
> @@ -1640,7 +1645,8 @@ static int pwrap_init_cipher(struct pmic_wrapper *wrp)
>   
>   	/* wait for cipher mode idle */
>   	pwrap_write(wrp, wrp->slave->dew_regs[PWRAP_DEW_CIPHER_MODE], 0x1);
> -	ret = pwrap_wait_for_state(wrp, pwrap_is_fsm_idle_and_sync_idle);
> +	ret = readx_poll_timeout(pwrap_is_fsm_idle_and_sync_idle, wrp, tmp, tmp,
> +				 PWRAP_POLL_DELAY_US, PWRAP_POLL_TIMEOUT_US);
>   	if (ret) {
>   		dev_err(wrp->dev, "cipher mode idle fail, ret=%d\n", ret);
>   		return ret;
