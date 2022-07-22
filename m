Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E75F857E68A
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 20:31:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236187AbiGVSba (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 14:31:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236123AbiGVSb1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 14:31:27 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A0574BD17
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 11:31:26 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id t1so8923271lft.8
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 11:31:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=9SCgkhpR1gwZTptYihUGqwzKbmmTGiOXIX0CYL6DcXI=;
        b=jPv8b8NayyyQxrPCf3enmvAJpO89jGLY8oyMhvl2EXJY+Z5URRs9cgeAXIrRwuaeUJ
         pYL4TNa7NZBeC9vc7yyp/vuhlHMcyn8etiMmnjD/sZf6LBFP0yeFxvySmPo99Vmpfdqd
         qombMedSEkiGmVaIdxfnvlHAOPk2HrU9DSNYdOj/Bx6qaIUq/tywzJPDPTexh9twAu0y
         pjGwvQsjQ0EHaHMaTb1LpV6oUKwy3bZvPQl7Xu6RyVGcieMxtr6K052xFPGQXW2Yy7a5
         fGtvkSy6l2v3XkKYY7nkcdlXj+iS7jGnEkAVJyCWfjNyj4K73vNODihSQcaxtqHsGFK1
         NWAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=9SCgkhpR1gwZTptYihUGqwzKbmmTGiOXIX0CYL6DcXI=;
        b=HMvezuOXmvQ2trYyXYHevBTTF5yvCArYC9mziONfkIWc3yO2B5G99vX6ezGaLI98i1
         HsInGgp7LbznCNY4HokRliYIrx1R0bNJLRpEjEDMS9TmdQcaX7WafGRqG89CYCbVGbsZ
         +SCZvo2Y7INZ2E5r/MkLTwEVh1rkGQ1p6KHU9VtNnE5JkJwObk7HH/WPG9n58e9SC2Cf
         YcS8eqGlgDy4Vo/BUnU9gzTa4VGw5tNuG/pbBwHc8N/oTVyGdEDiXLluU1ECUj2KAz6C
         ws16rgTmq9Yjv9lOU1kbjO0x3Buw7KpO8zdo7HZe1MQo93kgUCgX9gOv1bFBYEZM6UDu
         WBDQ==
X-Gm-Message-State: AJIora/eK+/ztRyYI2mKqHCWQc3h9SDi1hBNdqwsIfkRP1JZL3fYtkcy
        7wQfPPG3jNwMxynXJIJTkd5K+g==
X-Google-Smtp-Source: AGRyM1sfNBcyc6UXdPT//1zUJD6mSdHqh81sH+J00pkzu7Z7brBLJm8sn3cK5BxTb7cFTpHnWm7lgw==
X-Received: by 2002:ac2:4c53:0:b0:489:d0b3:6b1d with SMTP id o19-20020ac24c53000000b00489d0b36b1dmr534960lfk.310.1658514684893;
        Fri, 22 Jul 2022 11:31:24 -0700 (PDT)
Received: from [192.168.10.173] (93.81-167-86.customer.lyse.net. [81.167.86.93])
        by smtp.gmail.com with ESMTPSA id c6-20020a056512324600b0048920833c25sm1181697lfr.197.2022.07.22.11.31.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Jul 2022 11:31:24 -0700 (PDT)
Message-ID: <afae04e0-76a3-1bcb-5b47-9944fa9ab2c0@linaro.org>
Date:   Fri, 22 Jul 2022 20:31:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 2/2] spi: npcm-pspi: Add NPCM845 peripheral SPI support
Content-Language: en-US
To:     Tomer Maimon <tmaimon77@gmail.com>, avifishman70@gmail.com,
        tali.perry1@gmail.com, joel@jms.id.au, venture@google.com,
        yuenn@google.com, benjaminfair@google.com, broonie@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org
Cc:     openbmc@lists.ozlabs.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20220722114136.251415-1-tmaimon77@gmail.com>
 <20220722114136.251415-3-tmaimon77@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220722114136.251415-3-tmaimon77@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/07/2022 13:41, Tomer Maimon wrote:
> Add Nuvoton BMC NPCM845 NPCM Peripheral SPI (PSPI) support.
> 
> Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
> ---
>  drivers/spi/spi-npcm-pspi.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/spi/spi-npcm-pspi.c b/drivers/spi/spi-npcm-pspi.c
> index 1668a347e003..7f2e4d1b0d43 100644
> --- a/drivers/spi/spi-npcm-pspi.c
> +++ b/drivers/spi/spi-npcm-pspi.c
> @@ -443,6 +443,7 @@ static int npcm_pspi_remove(struct platform_device *pdev)
>  
>  static const struct of_device_id npcm_pspi_match[] = {
>  	{ .compatible = "nuvoton,npcm750-pspi", .data = NULL },
> +	{ .compatible = "nuvoton,npcm845-pspi", .data = NULL },

The devices look compatible, so why not reusing 750 compatible and
adding more specific upfront only in the bindings instead?

Best regards,
Krzysztof
