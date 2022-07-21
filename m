Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D530757C701
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 10:58:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232724AbiGUI6o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 04:58:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232684AbiGUI6k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 04:58:40 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F318735A8;
        Thu, 21 Jul 2022 01:58:38 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id bk26so1262869wrb.11;
        Thu, 21 Jul 2022 01:58:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=8QFedzwg4Z3Bt4Cl0NrBaPQTB9ve87kp9+ryMOTjPwQ=;
        b=hqYc50/ygMFmNqDMaBxEUXZIqcngF9VA2CxW4pjNqMyxin1dlJwJBqen+MAu6VaR2r
         uY09io+notR681tLTLwivZ8mYtCy4ogEm3fo/oxcwhcJYnzix/8/q5OVcHD+KSYOjODM
         Bpn7RnnbptJ1AVKdIWmUXx7yN3VreevV5GWnMHHw0XtHbxXbVFTRwYmmgPHsQ/JX2FGb
         NJzJWxvxtbrpe4Sx7PosKz2SlFKazByZ2Gpx/nFORw5wKJ2Qz53bHD8AH4VaA70O1e53
         yYMug24BGa6UuKwhjSEOMQs4Ibeqk2X3KVEUbJn543rsSeBsRGQsTh6GWMxtpEFRVPTe
         OZeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=8QFedzwg4Z3Bt4Cl0NrBaPQTB9ve87kp9+ryMOTjPwQ=;
        b=ycPNEydnd/9RbFBOIpuB1+YTZKG4LuyJv0ZZS1c57xEr8bkMhQEavI+1N4KSmuNvYD
         iyKfYwM+uW+ct7NfPcfPAVm7248tLk98MwihFjzlIzphuzi25PWSdWF3vdYx2l8i7VFS
         fj/zyaYOV0imOoy4IBCj4av5X8+tfd3gdikr4YWWD82BOS0G8YkDEHvd2jyiU3ct5U0S
         ct/e2XvsnoJL8H18i1NmtfbpZLEWn3TXB6x3NfzCXGWm9ugyzofGyOH4v4WNnhrIjvCQ
         W461t3xLOk8pDj8HzvdK3Wg11BkJiUxN8S1Eiawg7muawS/DJzvImxDUtqPIuua9Js4n
         qZbQ==
X-Gm-Message-State: AJIora/p9GI5tw5JgujPFW7PXHXcLvYUgvanHVP3XpVpFZAMPQcWmOMe
        oARc5bGiffbf6kOEn6kcjiY=
X-Google-Smtp-Source: AGRyM1s/+WRL6EVdc4FhHYS+vntbkQFrNJ6oMEWZO1WIgvLT4FOsRXWPvITE1MwEgF+Pn5dN8AH/Mg==
X-Received: by 2002:adf:a51a:0:b0:21d:86b9:f41e with SMTP id i26-20020adfa51a000000b0021d86b9f41emr33877852wrb.217.1658393917102;
        Thu, 21 Jul 2022 01:58:37 -0700 (PDT)
Received: from [192.168.1.145] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id j23-20020a05600c1c1700b003a32251c3f9sm5887572wms.5.2022.07.21.01.58.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Jul 2022 01:58:34 -0700 (PDT)
Message-ID: <59dd19f6-8e20-56d6-506a-93656bf15138@gmail.com>
Date:   Thu, 21 Jul 2022 10:57:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 1/4] dt-bindings: thermal: mediatek: add binding
 documentation for MT8365 SoC
Content-Language: en-US
To:     Amjad Ouled-Ameur <aouledameur@baylibre.com>
Cc:     rafael@kernel.org, fparent@baylibre.com, amitk@kernel.org,
        daniel.lezcano@linaro.org, devicetree@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-pm@vger.kernel.org,
        robh+dt@kernel.org, rui.zhang@intel.com
References: <20220720181854.547881-1-aouledameur@baylibre.com>
 <20220720181854.547881-2-aouledameur@baylibre.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20220720181854.547881-2-aouledameur@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 20/07/2022 20:18, Amjad Ouled-Ameur wrote:
> From: Fabien Parent <fparent@baylibre.com>
> 
> Add the binding documentation for the thermal support on MT8365 SoC.
> 
> Signed-off-by: Fabien Parent <fparent@baylibre.com>
> Acked-by: Amjad Ouled-Ameur <aouledameur@baylibre.com>

I suppose you wanted to add Signed-off-by here, at least get_maintainers.pl 
doesn't list you.

Apart from that:
Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>

> ---
>   Documentation/devicetree/bindings/thermal/mediatek-thermal.txt | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/thermal/mediatek-thermal.txt b/Documentation/devicetree/bindings/thermal/mediatek-thermal.txt
> index 5c7e7bdd029a..ba4ebffeade4 100644
> --- a/Documentation/devicetree/bindings/thermal/mediatek-thermal.txt
> +++ b/Documentation/devicetree/bindings/thermal/mediatek-thermal.txt
> @@ -14,6 +14,7 @@ Required properties:
>     - "mediatek,mt2712-thermal" : For MT2712 family of SoCs
>     - "mediatek,mt7622-thermal" : For MT7622 SoC
>     - "mediatek,mt8183-thermal" : For MT8183 family of SoCs
> +  - "mediatek,mt8365-thermal" : For MT8365 family of SoCs
>     - "mediatek,mt8516-thermal", "mediatek,mt2701-thermal : For MT8516 family of SoCs
>   - reg: Address range of the thermal controller
>   - interrupts: IRQ for the thermal controller
