Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CB555663F7
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 09:26:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230082AbiGEHV5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 03:21:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbiGEHVx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 03:21:53 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F329111143
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 00:21:51 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id bk26so1110997wrb.11
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jul 2022 00:21:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:cc:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=jup5yi9H7xUYGePSxxyktmglyW6uLEzBdr9VBRZBloA=;
        b=LzyC1BslQcQDLwEh59d9Kfgx2N20Ze+0hRqNNCPsWakeskMfJdQfZpxWmWtA34cHFT
         xgCbDp7n8a0oIe1/vz3FeCy7qd2GKvBrFEX5HnGSTOq894MfppO6OOXFxL50ATudJ0ea
         tH+jsB5hb0v8JAIY4Rsu5CU+G+t1QEmxZcWmjjq24GmMTpjESFqyUWsldy7IJplbglH/
         ti0+hHwePBRCkv5Or5A+COl332Bv+lcii5owVjP+aoAZACzXkasK1qn1yTg/dQC92eow
         oSM6DubSDEGR6PpxG6rZqbXCngI43E7+/GP1u1ILKaDV5vj7DiM7BnrlteJAEG0kTz8h
         tOGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:cc:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=jup5yi9H7xUYGePSxxyktmglyW6uLEzBdr9VBRZBloA=;
        b=0UwBF+iRTlGJXaGJLCDt5H33LHxf6acEDVGWnv7e3zIgUVBX4BIaMRXwHV1CvI1lrd
         spTBXEDhr6SOjm1j8bfQi0n7Nrr/oWc4FgLx4h0H1aWSMd9YlGWaqoFJmtg0wJei33Ac
         cclvru2Kcss+R/mki9/wxcf23sO/I3Wh7pnJosqfWbjzvUaS4smD7PzUM1/vgrzCf+wy
         8Qm3wL+7iAud6yv2NdL7m2zizOO0Hwx/lxx9zPqvsi1cOKva7Z8nOi4UDnPz6cwtZPk1
         e8HVa5obmb+fq+bC/TE0dNOHcH3Val+UgL7dXnlGAs7RIhH9NINTT6Do424Wc3rJBYPv
         urng==
X-Gm-Message-State: AJIora8a+XOnpieQrXxSkEGT7EQDvrGe2SPREfFDJVtVvUY0dwwI2aie
        ts1xLdw1JYgDdSMFSor8MPAbalUlyGtIU5rc
X-Google-Smtp-Source: AGRyM1smRihRT50fdOIiQfU+V8EUtDDGx/W73L/08nARMlYF5jSo5SQ5+guiRsMa9ttFJ2BN1YUJJQ==
X-Received: by 2002:a5d:598e:0:b0:21d:37df:3f2e with SMTP id n14-20020a5d598e000000b0021d37df3f2emr25254699wri.451.1657005710509;
        Tue, 05 Jul 2022 00:21:50 -0700 (PDT)
Received: from ?IPV6:2001:861:44c0:66c0:3c4f:78be:dc90:14f9? ([2001:861:44c0:66c0:3c4f:78be:dc90:14f9])
        by smtp.gmail.com with ESMTPSA id r16-20020a05600c35d000b003a0375c4f73sm22157331wmq.44.2022.07.05.00.21.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Jul 2022 00:21:50 -0700 (PDT)
Message-ID: <e2746084-ee88-7dc6-afd5-0d0dca4723c4@baylibre.com>
Date:   Tue, 5 Jul 2022 09:21:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH] phy: amlogic: phy-meson-axg-mipi-pcie-analog: Hold
 reference returned by of_get_parent()
Content-Language: en-US
To:     Liang He <windhl@126.com>, kishon@ti.com, khilman@baylibre.com,
        jbrunet@baylibre.com, martin.blumenstingl@googlemail.com,
        linux-phy@lists.infradead.org
References: <20220705021526.281441-1-windhl@126.com>
Cc:     "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From:   Neil Armstrong <narmstrong@baylibre.com>
Organization: Baylibre
In-Reply-To: <20220705021526.281441-1-windhl@126.com>
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

+ linux-amlogic, linux-arm-kernel, linux-kernel

On 05/07/2022 04:15, Liang He wrote:
> We should hold the reference returned by of_get_parent() and use it
> to call of_node_put() for reference balance.
> 
> Fixes: 8eff8b4e22d9 ("phy: amlogic: phy-meson-axg-mipi-pcie-analog: add support for MIPI DSI analog")
> Signed-off-by: Liang He <windhl@126.com>
> ---
>   drivers/phy/amlogic/phy-meson-axg-mipi-pcie-analog.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/phy/amlogic/phy-meson-axg-mipi-pcie-analog.c b/drivers/phy/amlogic/phy-meson-axg-mipi-pcie-analog.c
> index 1027ece6ca12..a3e1108b736d 100644
> --- a/drivers/phy/amlogic/phy-meson-axg-mipi-pcie-analog.c
> +++ b/drivers/phy/amlogic/phy-meson-axg-mipi-pcie-analog.c
> @@ -197,7 +197,7 @@ static int phy_axg_mipi_pcie_analog_probe(struct platform_device *pdev)
>   	struct phy_provider *phy;
>   	struct device *dev = &pdev->dev;
>   	struct phy_axg_mipi_pcie_analog_priv *priv;
> -	struct device_node *np = dev->of_node;
> +	struct device_node *np = dev->of_node, *parent_np;
>   	struct regmap *map;
>   	int ret;
>   
> @@ -206,7 +206,9 @@ static int phy_axg_mipi_pcie_analog_probe(struct platform_device *pdev)
>   		return -ENOMEM;
>   
>   	/* Get the hhi system controller node */
> -	map = syscon_node_to_regmap(of_get_parent(dev->of_node));
> +	parent_np = of_get_parent(dev->of_node);
> +	map = syscon_node_to_regmap(parent_np);
> +	of_node_put(parent_np);
>   	if (IS_ERR(map)) {
>   		dev_err(dev,
>   			"failed to get HHI regmap\n");

