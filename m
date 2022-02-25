Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39A5F4C4AF2
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 17:36:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243063AbiBYQhQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 11:37:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243090AbiBYQhN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 11:37:13 -0500
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com [IPv6:2607:f8b0:4864:20::c32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CB7A2118D5;
        Fri, 25 Feb 2022 08:36:41 -0800 (PST)
Received: by mail-oo1-xc32.google.com with SMTP id u47-20020a4a9732000000b00316d0257de0so6897618ooi.7;
        Fri, 25 Feb 2022 08:36:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Dec347SrLgLC0WzRa99gVMTjXKUpk4Dvu/3QxlLX+o8=;
        b=nvww4HMzNa6UycY1GsxwFWPWcM8UpfXCl2UfRTrLIhK88PagqbSGkxKg+8i77qgZZZ
         xeWoZjKtihIEhJaLW4InwiPD7yaniXPiF6Dg3mcOSTRkVA9kKC24v2IwMfPNiWwUgs5F
         xjStS4WqjZy4xo1NGL11Z8kZlbK9EJM6rBvB5WypPGCKD78ATM65zcoEX4LNu42t5OV+
         TQtPqz/Uhe7lCandWDzCXTywQytdQVv2Ae+irpuovJVVi/76MKUPtu9duX7C4W6UYNdy
         dVd65bg3aeFjIHpflgAWayYB0MOeVYc2FRRPFtW3uk31IsLv3+J26tj0aCo7mVU0DM6/
         SrZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Dec347SrLgLC0WzRa99gVMTjXKUpk4Dvu/3QxlLX+o8=;
        b=fbQG5hzTcgFQDx7F7kDmdUqXCIpzVbYBImMHRJQ2Mr32Ff10mjGGB9ivasi90JXB7q
         cqsxcJpPgQMKOS827CWrxlHOWbVYwqpsNYGXI9n7Y3yW+ucmApTAmDDdTOHJe9dio1C3
         XwHDHUUkcADABrsZqWwx+f3+XD6rKHqxcdnXRL0YwdaJrRKrJa+Z2DANqnPyiiZP+zb0
         yLgxZTOYEAnX9iEdNErPWPI+958m+9iefbs5JcYFQQzvUgGCH6y/YpsCRW/6a5ebtKhv
         16rqqIyELrE/SnaFupQqevwGHaDIIpgB/0O2Wx1Pvck3YXuprpCMT14eli2kL2KtCw0i
         KSGA==
X-Gm-Message-State: AOAM533YJvylNFKXRNOweqPyRQ/DkCgn1rpuSA/R+2a5sabjeURnvRQB
        /wmJUT7j2knyUeQqTjwr0m4=
X-Google-Smtp-Source: ABdhPJyxqhDz+2w1gzC/91KjRDvnzqhF1bQndLV6JOsMPUvDBDCfL5o+OiSGr/Y56tpLQ++UJpUE4A==
X-Received: by 2002:a05:6870:971f:b0:d6:c8bf:43fe with SMTP id n31-20020a056870971f00b000d6c8bf43femr1648758oaq.258.1645807000840;
        Fri, 25 Feb 2022 08:36:40 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id t7-20020a9d5907000000b005afa4058a4csm1384070oth.1.2022.02.25.08.36.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Feb 2022 08:36:40 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <6e3a67fc-6030-540d-ff97-13ce0a147992@roeck-us.net>
Date:   Fri, 25 Feb 2022 08:36:38 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 1/4] dt-bindings: watchdog: Add compatible for MediaTek
 MT8186
Content-Language: en-US
To:     Rex-BC Chen <rex-bc.chen@mediatek.com>, wim@linux-watchdog.org,
        matthias.bgg@gmail.com, robh+dt@kernel.org, p.zabel@pengutronix.de
Cc:     runyang.chen@mediatek.com, linux-watchdog@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20220216014505.28428-1-rex-bc.chen@mediatek.com>
 <20220216014505.28428-2-rex-bc.chen@mediatek.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20220216014505.28428-2-rex-bc.chen@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/15/22 17:45, Rex-BC Chen wrote:
> Add dt-binding documentation of watchdog for MediaTek MT8186 SoC.
> 
> Signed-off-by: Rex-BC Chen <rex-bc.chen@mediatek.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   Documentation/devicetree/bindings/watchdog/mtk-wdt.txt | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/watchdog/mtk-wdt.txt b/Documentation/devicetree/bindings/watchdog/mtk-wdt.txt
> index 0114871f887a..74db01e3658b 100644
> --- a/Documentation/devicetree/bindings/watchdog/mtk-wdt.txt
> +++ b/Documentation/devicetree/bindings/watchdog/mtk-wdt.txt
> @@ -15,6 +15,7 @@ Required properties:
>   	"mediatek,mt7629-wdt", "mediatek,mt6589-wdt": for MT7629
>   	"mediatek,mt7986-wdt", "mediatek,mt6589-wdt": for MT7986
>   	"mediatek,mt8183-wdt": for MT8183
> +	"mediatek,mt8186-wdt", "mediatek,mt6589-wdt": for MT8186
>   	"mediatek,mt8516-wdt", "mediatek,mt6589-wdt": for MT8516
>   	"mediatek,mt8192-wdt": for MT8192
>   	"mediatek,mt8195-wdt", "mediatek,mt6589-wdt": for MT8195

