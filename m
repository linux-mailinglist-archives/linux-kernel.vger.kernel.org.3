Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0778584548
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 20:08:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230505AbiG1RyV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 13:54:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbiG1RyU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 13:54:20 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4508274CCA
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 10:54:19 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id y11so3916009lfs.6
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 10:54:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=6MfQt0pBWorRlsAFP8DPl6zHr8P3SDh0xwaF66hHtuo=;
        b=PSOOhlr1VTqdPCNhNjATTulVhMqFIJ6P/zYsu6rgIGU/c4tXgbVS3GqXW64iQEF2Wz
         XskiPlFCCSrbuQaBpbciOiaIgIawF8aZA0SM3KUIzRyWV5iIJ9tMSfIsOT/Jr9Hw34nd
         o7hmXIByqyAhsTgTsdsjmWVaZR/P0w6byYToDcktZpMea+RWSixBTrgYZIP5fm8+Z1N3
         SEkduZvIeY2mI5HJ6CehwsTdX26ZHau9Cx7/PL0NmY/sOB+GKEFlODaAcky7Wb8DwYW6
         D13neg0HcS00D+iP+q4jb6E8YfwhtQFX9RFwrUdng04m25TR9pJ54HHvwERqKBPzEig+
         VJ1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=6MfQt0pBWorRlsAFP8DPl6zHr8P3SDh0xwaF66hHtuo=;
        b=abqpARmijhuu5PCFwGKhsz5MiPingOXsX5PBklW2NxO1cZ9uSTQjZyXiUT196ywT5Y
         AlWWSxeiHeVM4lp5sIX0i0f80y55m0SgJqWX3Uk9XFDB4QdUIu8wJtGy+wuUMSMWq56K
         DC6sTlhbUu/IafAMVg1udksVBnzeQo5ImCVbuU5GI30e4ZQg5nbtfX98X3N9AziMI4wb
         JH4ufR5m6UWE81t1eu+LVKXC4jETRXF6rUV3l352V1T7FO2MXgsEikzA5LhYgVsK2sKD
         E5revaO6ONxz6dFrwgmhcsEukSo5Sn2Rgfwbg4qgg60wXVKUoNXsVB2BnVmjLroWYr/+
         i00A==
X-Gm-Message-State: AJIora8ZY334Y9byzYfkevj0Zo77QbN5Mkv2LljwtcE9Ade2TNUIkVCO
        r12EfKKKDWhLxiY/ac1wId8Ztw==
X-Google-Smtp-Source: AGRyM1uC9AUPOcDFCyJbmlXK6r4q8xIOp/Zk9fpaBMmiBcH1i15Ev3nqouRr0FKDDD/Eu3JOB5MlwA==
X-Received: by 2002:a05:6512:2622:b0:481:5b17:58e7 with SMTP id bt34-20020a056512262200b004815b1758e7mr3513lfb.600.1659030857234;
        Thu, 28 Jul 2022 10:54:17 -0700 (PDT)
Received: from [192.168.3.197] (78-26-46-173.network.trollfjord.no. [78.26.46.173])
        by smtp.gmail.com with ESMTPSA id b3-20020a056512304300b0048a7ebb3151sm292023lfb.181.2022.07.28.10.54.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Jul 2022 10:54:13 -0700 (PDT)
Message-ID: <2640c637-68c7-641d-9b15-c57bdd5adca2@linaro.org>
Date:   Thu, 28 Jul 2022 19:54:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v3] arm64: dts: mt8173-oak: Switch to SMC watchdog
Content-Language: en-US
To:     Pin-yen Lin <treapking@chromium.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Eizan Miyamoto <eizan@chromium.org>,
        Evan Benn <evanbenn@chromium.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
References: <20220728153913.2652153-1-treapking@chromium.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220728153913.2652153-1-treapking@chromium.org>
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

On 28/07/2022 17:39, Pin-yen Lin wrote:
> Switch to SMC watchdog because we need direct control of HW watchdog
> registers from kernel. The corresponding firmware was uploaded in
> https://review.trustedfirmware.org/c/TF-A/trusted-firmware-a/+/3405.
> 
> Signed-off-by: Pin-yen Lin <treapking@chromium.org>
> ---
> 
> Changes in v3:
> - Remove /delete-node/ and create a new node for SMC watchdog.
> 
> Changes in v2:
> - Move the modifications to mt8173-elm.dtsi and add some comments.
> 
>  arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi b/arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi
> index e21feb85d822..fc8203297bac 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi
> @@ -161,6 +161,19 @@ hdmi_connector_in: endpoint {
>  			};
>  		};
>  	};
> +
> +

Why?

> +	smc_watchdog {

No, you need to read the comment you receive one more time. So to be
clear: "watchdog"



Best regards,
Krzysztof
