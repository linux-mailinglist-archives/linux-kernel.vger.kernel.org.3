Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC6714BE8EF
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 19:06:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354029AbiBUJ6G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 04:58:06 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352387AbiBUJrY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 04:47:24 -0500
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A634424A8;
        Mon, 21 Feb 2022 01:19:38 -0800 (PST)
Received: by mail-lj1-x22e.google.com with SMTP id t14so13649512ljh.8;
        Mon, 21 Feb 2022 01:19:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=huPIGDsJDWnlkYGD8RjgTidc2vJbYvfd2l32RF6F7ME=;
        b=XHq3QluY2NVKJBoPyZ5hC8E9kHQvOAPPb8ZhyHDx1zhlAkNeBSQDU9oDMYEo9kLtj1
         9cXg34dwfdzJeRIGaVXIq3srnStQKw3QDXKQ1thq0Uc6l1XFZg/mZzpv6moP6tyl8vZ1
         gr+nNuiwanMDAssVdkEgx9KaXjFFvMWdGLLBJSOQYy2hv1mgqQLmpbD2vThAYB6uxphS
         gY3TtaGTMtam7ba1xHPA893XpvlEeTFewfs2YkAyUdpAH1Pp1SqlJ4GI/2fZMzRRvfX9
         gWdHZxniM+CkrZLLtz10wy918bnMFilflVU3jK9GI8aVxImTznpEv+nO78UKn11BNPWF
         8Szg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=huPIGDsJDWnlkYGD8RjgTidc2vJbYvfd2l32RF6F7ME=;
        b=F9z/78idZ0Pt1vW8eJNXJFcTWpMHuhScVbHFE/pqoRAYidGdVhuAxnx8QFR+5JiGkv
         afxYCTHPfz70mekNwJ9sT8qGAC+/+szsTs5SlApsF3gqj748vr+Clk8nlqzmCMWPlrzF
         Io/fgrt3tG0NX2+vtRpCjhTFMHg2jZ+orSZsT9zi43PYfWIDcQRRWVUJWjTVmeRzRTWN
         M5AjZ9NfR9XKcU4YUZTsP5q5IZ3UpNmnyhGkOLVBC4q3yB+tMd41wGrOcUtJN0OJndtA
         Kkqk9ZlsG4bX31DzBrhnwkH/aiMk9ZqEqUtYtp/+f6Dorz40R1600OENFjHS9eiDXwlz
         0+TA==
X-Gm-Message-State: AOAM530CI8H2IO+7gOMIsqis2Jwl9maKzVx0dOEdkyx8EvUkVi+rnMLU
        b5BTXVMtdlDpI8q3IBFslVk=
X-Google-Smtp-Source: ABdhPJxx4DFd3v22H/QNGr758lj+rOXO8wtuMl5kY/nQQ9qHtifRlgmAIpdT7UoX8ouAj3ynnDz2BA==
X-Received: by 2002:a2e:bd82:0:b0:241:130d:90b3 with SMTP id o2-20020a2ebd82000000b00241130d90b3mr13798892ljq.383.1645435176659;
        Mon, 21 Feb 2022 01:19:36 -0800 (PST)
Received: from [192.168.1.103] ([178.176.73.51])
        by smtp.gmail.com with ESMTPSA id a9sm795218lfl.180.2022.02.21.01.19.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Feb 2022 01:19:35 -0800 (PST)
Subject: Re: [PATCH v10 1/4] MIPS: Loongson64: dts: update the display
 controller device node
To:     Sui Jingfeng <15330273260@189.cn>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Roland Scheidegger <sroland@vmware.com>,
        Zack Rusin <zackr@vmware.com>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Andrey Zhizhikin <andrey.zhizhikin@leica-geosystems.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        "David S . Miller" <davem@davemloft.net>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Ilia Mirkin <imirkin@alum.mit.edu>,
        Qing Zhang <zhangqing@loongson.cn>,
        suijingfeng <suijingfeng@loongson.cn>
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org
References: <20220220145554.117854-1-15330273260@189.cn>
 <20220220145554.117854-2-15330273260@189.cn>
From:   Sergei Shtylyov <sergei.shtylyov@gmail.com>
Message-ID: <08abcb14-f1f6-8be5-6309-cd16e0578c05@gmail.com>
Date:   Mon, 21 Feb 2022 12:19:34 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20220220145554.117854-2-15330273260@189.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/20/22 5:55 PM, Sui Jingfeng wrote:

> From: suijingfeng <suijingfeng@loongson.cn>
> 
> The display controller is a pci device, its PCI vendor id is 0x0014
> its PCI device id is 0x7a06.
> 
> 1) In order to let the driver to know which chip the DC is contained
>    in, the compatible string of the display controller is updated
>    according to the chip's name.
> 
> 2) Add display controller device node for ls2k1000 SoC
> 
> Reported-by: Krzysztof Kozlowski <krzk@kernel.org>
> Signed-off-by: suijingfeng <suijingfeng@loongson.cn>
> Signed-off-by: Sui Jingfeng <15330273260@189.cn>
> ---
>  arch/mips/boot/dts/loongson/loongson64-2k1000.dtsi | 8 ++++++++
>  arch/mips/boot/dts/loongson/ls7a-pch.dtsi          | 7 ++-----
>  2 files changed, 10 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/mips/boot/dts/loongson/loongson64-2k1000.dtsi b/arch/mips/boot/dts/loongson/loongson64-2k1000.dtsi
> index 768cf2abcea3..af9cda540f9e 100644
> --- a/arch/mips/boot/dts/loongson/loongson64-2k1000.dtsi
> +++ b/arch/mips/boot/dts/loongson/loongson64-2k1000.dtsi
> @@ -209,6 +209,14 @@ gpu@5,0 {
>  				interrupt-parent = <&liointc0>;
>  			};
>  
> +			lsdc: display-controller@6,0 {

   Shouldn't the node name just be "display", according to the section 2.2.2
of the DT spec?

[...]
> diff --git a/arch/mips/boot/dts/loongson/ls7a-pch.dtsi b/arch/mips/boot/dts/loongson/ls7a-pch.dtsi
> index 2f45fce2cdc4..ec35ea9b2fe8 100644
> --- a/arch/mips/boot/dts/loongson/ls7a-pch.dtsi
> +++ b/arch/mips/boot/dts/loongson/ls7a-pch.dtsi
> @@ -160,11 +160,8 @@ gpu@6,0 {
>  				interrupt-parent = <&pic>;
>  			};
>  
> -			dc@6,1 {
> -				compatible = "pci0014,7a06.0",
> -						   "pci0014,7a06",
> -						   "pciclass030000",
> -						   "pciclass0300";
> +			lsdc: display-controller@6,1 {

   Same here...

[...]

MBR, Sergey
