Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BFD2559A51
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 15:27:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231948AbiFXN1V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 09:27:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbiFXN1T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 09:27:19 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70F0C53A4B
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 06:27:17 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id o8so3160543wro.3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 06:27:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=zWXXv2xfX+nkxMjOUNSHqEiFkW+UBo+JFZKk6soP/kc=;
        b=uGlffrhFEfJvrJLAbxs99jYoSIG6r+vrcnUhYGQ77KCoa60uiixo2PtDjOK49BJUvk
         SjVBNUqqtlmWj+KE0yMmHsNcmgfxzutbMBfShyUnG2RIEHd0z6piFMKI16MlhpzdT7+/
         CdaVphHc2+BrEx/7J2q21fax5Ek4PqsRlfY7UreC12zx99xEeBGfJEsv50ARqukmP1ud
         m6nQD2KYDXLiE6KPehCAuQmmfihGciJUZQSt1q5uub0WJSPD5WPb0vaGwOgKZbEvNbxS
         +pxNLXdSQnX+Vr1pL4gkLA8kipTXlDPJib/y1uDW1drFWUeDDSGfkywcwn5oQhFrs8Kq
         /gbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=zWXXv2xfX+nkxMjOUNSHqEiFkW+UBo+JFZKk6soP/kc=;
        b=Aog/IeSurW86bnJN69Qs+d56rU33tYGwsgLfmXljnuxzJlFRIfHfSqS2awv++A0XIq
         Kz8xlB3h+uobJcctyltVybjqVbzpEAkFbnZC6BJOrFj4x9q5UwW89Jfs1CBB+jUCqI/6
         FUNoUG8LfYAjfZtl4B7tDKZ8pQcTiSZLVRs7nat+eYRK2MNP8QAZ5O632uTzLoCcRmGT
         j0Fq4woHWf0WSkRJOCuKCnjbEm4YUrYHX6UnJkRU+gg82aDHV7rOIEFktdXkNbWVE+TQ
         mGtBpNo3YIYNztB1/v7GKZaNfWYkBrSB/bkdh+Kx5+lzFOy/jYue6x955nsYytDkt7+h
         1lcw==
X-Gm-Message-State: AJIora/p7LH7nHQJrPy97shsOt7w8mG5AcdDCJFrf70kx9DeO6mlX0+O
        c9jFjF+995xbWbOINpPtHlvhnw==
X-Google-Smtp-Source: AGRyM1t/ztNcjWHSThDemc1hDzpBMj4/Q0wX6RuHmfYrc/gRO/S83SWB+S0wY81Wi0jJ1cWdECwWYQ==
X-Received: by 2002:a05:6000:1a41:b0:20e:687f:1c3 with SMTP id t1-20020a0560001a4100b0020e687f01c3mr13063677wry.415.1656077235868;
        Fri, 24 Jun 2022 06:27:15 -0700 (PDT)
Received: from ?IPV6:2001:861:44c0:66c0:3816:2b77:7cfb:ba54? ([2001:861:44c0:66c0:3816:2b77:7cfb:ba54])
        by smtp.gmail.com with ESMTPSA id z24-20020a1c4c18000000b0039db31f6372sm6663231wmf.2.2022.06.24.06.27.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Jun 2022 06:27:15 -0700 (PDT)
Message-ID: <5f1bd986-e193-b147-8322-3a0bf14fc373@baylibre.com>
Date:   Fri, 24 Jun 2022 15:27:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v7 5/5] mtd: rawnand: meson: not support legacy clock
Content-Language: en-US
To:     Liang Yang <liang.yang@amlogic.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        linux-mtd@lists.infradead.org
Cc:     kernel test robot <lkp@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        Victor Wan <victor.wan@amlogic.com>,
        XianWei Zhao <xianwei.zhao@amlogic.com>,
        Kelvin Zhang <kelvin.zhang@amlogic.com>,
        BiChao Zheng <bichao.zheng@amlogic.com>,
        YongHui Yu <yonghui.yu@amlogic.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220624131257.29906-1-liang.yang@amlogic.com>
 <20220624131257.29906-6-liang.yang@amlogic.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Organization: Baylibre
In-Reply-To: <20220624131257.29906-6-liang.yang@amlogic.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 24/06/2022 15:12, Liang Yang wrote:
> meson NFC driver use common clock interfaces. so the test robot report
> some errors once using the legacy clock with HAVE_LEGACY_CLK on.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Liang Yang <liang.yang@amlogic.com>
> ---
>   drivers/mtd/nand/raw/Kconfig | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mtd/nand/raw/Kconfig b/drivers/mtd/nand/raw/Kconfig
> index 67b7cb67c030..0ff86ca5932d 100644
> --- a/drivers/mtd/nand/raw/Kconfig
> +++ b/drivers/mtd/nand/raw/Kconfig
> @@ -395,7 +395,7 @@ config MTD_NAND_STM32_FMC2
>   
>   config MTD_NAND_MESON
>   	tristate "Support for NAND controller on Amlogic's Meson SoCs"
> -	depends on ARCH_MESON || COMPILE_TEST
> +	depends on ARCH_MESON || COMPILE_TEST || COMMON_CLK

This should be :
	depends on COMMON_CLK && (ARCH_MESON || COMPILE_TEST)

>   	select MFD_SYSCON
>   	help
>   	  Enables support for NAND controller on Amlogic's Meson SoCs.

Neil
