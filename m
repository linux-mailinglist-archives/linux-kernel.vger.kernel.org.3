Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31E4A50A4DA
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 17:58:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1390389AbiDUQAH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 12:00:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1390416AbiDUP76 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 11:59:58 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B0DF47ADC
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 08:57:08 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id h25so1291387wrc.13
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 08:57:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=VnNLAyze2JE7XuuKoj/51ytXs6NGyhHmfp21Cyl9MmA=;
        b=VO8awK3lGiGnHhWrqCQnGID1R8HC8MQlHxQoJMuxKp0mpRHZoF0BNkq6Xy3Blqbeuw
         tMXT4+xCkRY3OjIwsxv4rb78IDf3C6/GRo6TvkJRp6/xNIDITda9NJDg9v9tjw1blF8E
         8TnG5qrVwmyBzjygQfhwxiUt9myM525OXWtxQKh/DyzHujOn+MuN50X85+IoXpEgqIe8
         tCic3jWveRtB4r0HKXQpcABwHD/v/dwbzTjNKcobp9I7bX6N+2o/KZj+wuizWNq2wtvz
         cAEsxTGl+hWKYe2t2QmZrzmLZOYbpSJPVJ+EKwHqmT9K6074g3UEg9sGC4c2cuBy4kao
         uaLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=VnNLAyze2JE7XuuKoj/51ytXs6NGyhHmfp21Cyl9MmA=;
        b=BcfdOTO2HNS1ulBp9pWmsTwYKtXbtbe8/Q33bJaH7WZvZZEp+wYhr8t4RYFhMG79bA
         QNNG18YcJb5MNRL9OyE00qhs/L5NAjc1SrMnjIl4ep6tR0Nb3dAb6b3G+OH65XW8+3Fq
         YmxXzfWq4Pgx1GONDgWn9oBpHX4F7wIsxgpTNMT01YuGZT7RXjw0MP5JRFygrUyRL3m8
         IGNMo44mnyrZnOhxPaIm1tdSUKcfQ5JzAfOqsKrrbJxwv5u+Z+xTI8VT1dtlcEPetlUM
         IB6CYkJjVZHgduaRr7itDw2VySnTaFQEgLDlrU95e7irLnnPjseR/wnxqimCpBx1wSz7
         KGFA==
X-Gm-Message-State: AOAM532BLyIzXJhmUrzXvuyk0qKhl7bDlRtArsnc1bqLhpxiXEX1Au3o
        Zlq3H2KYGPou2BbCLtKvLlrCeQ==
X-Google-Smtp-Source: ABdhPJy0Bo28YBoXAWWYAZsWUoDBNtieLbnxM8RQ1LgV+c29fVCI3LPxSZ/+9rsggw7Jk/R66nt7xw==
X-Received: by 2002:adf:90e9:0:b0:204:2ee:7d5 with SMTP id i96-20020adf90e9000000b0020402ee07d5mr312461wri.536.1650556627033;
        Thu, 21 Apr 2022 08:57:07 -0700 (PDT)
Received: from localhost ([2a01:cb19:85e6:1900:e19f:c42c:d783:89c1])
        by smtp.gmail.com with ESMTPSA id b5-20020adfd1c5000000b0020a7954a974sm3117739wrd.34.2022.04.21.08.57.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 08:57:06 -0700 (PDT)
From:   Mattijs Korpershoek <mkorpershoek@baylibre.com>
To:     Fabien Parent <fparent@baylibre.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Fabien Parent <fparent@baylibre.com>, linux-input@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/7] Input: mtk-pmic-keys: add field to store if PMIC
 has key release IRQs
In-Reply-To: <20220415153629.1817202-6-fparent@baylibre.com>
References: <20220415153629.1817202-1-fparent@baylibre.com>
 <20220415153629.1817202-6-fparent@baylibre.com>
Date:   Thu, 21 Apr 2022 17:57:05 +0200
Message-ID: <87fsm6zay6.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On ven., avril 15, 2022 at 17:36, Fabien Parent <fparent@baylibre.com> wrote:

> The MT6358 PMIC is not the only PMIC to have release IRQs. In order to
> support more PMIC that supports release IRQs, such as MT6357, MT6359,
> and possibly others, let's add some field in the platform data to
> indicate whether a PMIC support release keys.
>
> Signed-off-by: Fabien Parent <fparent@baylibre.com>

Tested-by: Mattijs Korpershoek <mkorpershoek@baylibre.com> # on mt8183-pumpkin 

> ---
>  drivers/input/keyboard/mtk-pmic-keys.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/input/keyboard/mtk-pmic-keys.c b/drivers/input/keyboard/mtk-pmic-keys.c
> index a0da644fe93d..609b87afd020 100644
> --- a/drivers/input/keyboard/mtk-pmic-keys.c
> +++ b/drivers/input/keyboard/mtk-pmic-keys.c
> @@ -53,6 +53,7 @@ struct mtk_pmic_keys_regs {
>  struct mtk_pmic_keys_pdata {
>  	const struct mtk_pmic_keys_regs keys_regs[MTK_PMIC_MAX_KEY_COUNT];
>  	u32 pmic_rst_reg;
> +	bool has_key_release_irqs;
>  };
>  
>  static const struct mtk_pmic_keys_pdata mt6397_pdata = {
> @@ -83,6 +84,7 @@ static const struct mtk_pmic_keys_pdata mt6358_pdata = {
>  		MTK_PMIC_KEYS_REGS(MT6358_TOPSTATUS,
>  				   0x8, MT6358_PSC_TOP_INT_CON0, 0xa),
>  	.pmic_rst_reg = MT6358_TOP_RST_MISC,
> +	.has_key_release_irqs = true,
>  };
>  
>  struct mtk_pmic_keys_info {
> @@ -319,7 +321,7 @@ static int mtk_pmic_keys_probe(struct platform_device *pdev)
>  			return keys->keys[index].irq;
>  		}
>  
> -		if (of_device_is_compatible(node, "mediatek,mt6358-keys")) {
> +		if (mtk_pmic_keys_pdata->has_key_release_irqs) {
>  			keys->keys[index].irq_r = platform_get_irq_byname(pdev,
>  									  irqnames_r[index]);
>  
> -- 
> 2.35.2
