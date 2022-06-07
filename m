Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C253653F6EF
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 09:12:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237502AbiFGHMm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 03:12:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237277AbiFGHMj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 03:12:39 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3D5464D9
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 00:12:34 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id p5-20020a1c2905000000b003970dd5404dso9009931wmp.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jun 2022 00:12:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=hV9ibKa+5FNAjQgy5QNiMgxjWN0tLjtbBZr6sMB8+Q8=;
        b=zvk7iA/34h/WCj5IyLEzFyarVpBveV+Ub4CzbBtdV7qFdQFCeBaBVp1VyjjmZfZ06M
         PbeRy2dP5bbH0dZRJUpHdmRTPoO3RzyEZNMmRdyhOFIXO6wsci8zXehtX2EKqFRk94Sz
         yGLX4rOgtCxD9W3RPr8Fw5CHA/8Inl6ERNabJW9gKsmrbDYVCL78/DG/CXz76EBS4Xmj
         3hQ3Uf6GckYlGgHHDLzfxVy1U9elpvnYxH7FnzFhKuWRR2jYqMmqHMMheB+LHviI7YUN
         MyNkrXn9Qu+mBs7z2/YWm23lEqtem7Iqk+n3hZNYnSaky9CX5WiL62yeReaMwEDvARUo
         VVNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=hV9ibKa+5FNAjQgy5QNiMgxjWN0tLjtbBZr6sMB8+Q8=;
        b=ex5z1nDg2KiDdEuf61hE+Ju3OBeCjuFvu7+2VzrR+9ATlrUlAJm9qQpJybB1eM+j2n
         wA1GC9qXdy0T1q/xVB05N4DqiVaB9p9y5s61WrhPhrudNnJuxGRJl1CcFYU5BadG0LZV
         Mt3mgApvJcXCy+m9p/Pt+Aq+Wcek0ctwDjudXwIqN46zXKa/Sa+L+F6evoAuK0OkiqzJ
         C9cOlAO9ILS0AUfAlxMspaAF3g/M4Jo7RfEhE7Hhp6bIVopl8jgOLB32MGUdG+FK8u3t
         evmnQKjgj8+106VpLHv79Av08bUFhiWWmWk5rHJLEJR9G170kSBn+DxoAeSOwZ90iiSx
         /hIA==
X-Gm-Message-State: AOAM5333k8Vmkny9Sg6QvVw8OL6OcPEZTA5FWzFfwz2SS41y5j4rhuHq
        Y/xO/UuLhySEeY7whhCFnaT/Jw==
X-Google-Smtp-Source: ABdhPJzlssNl6pDyIvExhHNcmbJ/WP0P23bmwp4ZRY1qET14Oc7c06VwNQoOLjo6L5f2tNzIkvpUkw==
X-Received: by 2002:a05:600c:3513:b0:39c:2a32:37a6 with SMTP id h19-20020a05600c351300b0039c2a3237a6mr25770455wmq.161.1654585953165;
        Tue, 07 Jun 2022 00:12:33 -0700 (PDT)
Received: from ?IPV6:2001:861:44c0:66c0:87c5:1f51:1550:2ebc? ([2001:861:44c0:66c0:87c5:1f51:1550:2ebc])
        by smtp.gmail.com with ESMTPSA id h4-20020adffd44000000b002102d4ed579sm17017696wrs.39.2022.06.07.00.12.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jun 2022 00:12:32 -0700 (PDT)
Message-ID: <791b3e4e-7348-997a-0ead-136739ec10bf@baylibre.com>
Date:   Tue, 7 Jun 2022 09:12:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v6 5/5] mtd: rawnand: meson: not support legacy clock
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
References: <20220607064731.13367-1-liang.yang@amlogic.com>
 <20220607064731.13367-6-liang.yang@amlogic.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Organization: Baylibre
In-Reply-To: <20220607064731.13367-6-liang.yang@amlogic.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 07/06/2022 08:47, Liang Yang wrote:
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
> index 67b7cb67c030..5169412a4af4 100644
> --- a/drivers/mtd/nand/raw/Kconfig
> +++ b/drivers/mtd/nand/raw/Kconfig
> @@ -395,7 +395,7 @@ config MTD_NAND_STM32_FMC2
>   
>   config MTD_NAND_MESON
>   	tristate "Support for NAND controller on Amlogic's Meson SoCs"
> -	depends on ARCH_MESON || COMPILE_TEST
> +	depends on ARCH_MESON || COMPILE_TEST || !HAVE_LEGACY_CLK

I think depending on CCF would be better than excluding legacy clock.

>   	select MFD_SYSCON
>   	help
>   	  Enables support for NAND controller on Amlogic's Meson SoCs.

Neil
