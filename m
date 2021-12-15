Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FECF475B16
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 15:52:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243527AbhLOOwb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 09:52:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243504AbhLOOw2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 09:52:28 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBA69C061574;
        Wed, 15 Dec 2021 06:52:27 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id e24so17898574lfc.0;
        Wed, 15 Dec 2021 06:52:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=LO1x8iedEbzMXD8iaeIwOohPXHwNbM9LQL7gCPHHVok=;
        b=QjCUIXRCRUhvXqnKy2b8cNhuz/nNrXo5BUbNtoRem0OJ9o0sDFziIeI0nM9+uK+hcK
         Lk6cnre1LKuPsyuTqfLgm2xJqWBma9a50yGZ3La2W7UCq+8QKlX1WYbQ9h/DF7410ywZ
         Z2mOBO4RKMt0UOXbAAa+bNvv6+qh73eVixLAMrSjQ7x9+bt96Sa6MgrWCTREama5SCXt
         XIGiYjsarVgwWQNRNOp4LuXJ9p3NscZ8NjLxn5q8HwpNz1BiP2vn4XSsJl+UtU/6MNjl
         //4DzHEBpiJbbJk6IRbYZ5se4wsOhnG4cAFLaDjGlyuymRWgciF1Yg93Tzdk1eEjnfoa
         fftg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LO1x8iedEbzMXD8iaeIwOohPXHwNbM9LQL7gCPHHVok=;
        b=KxRUSHnaxQV6KVyEMegSs3uA7K1nIM/QLxB9BK1+KKOyyPDW2x5YJ47TbONEy6XBz8
         CwI5WpjZDz7nPbBGzH4TAdADW2Sda6KqCUMNlV1WNU/puYZmv2wCbHOgZnSbwQ/XdQE7
         xaM0uROhgJUT4QtD7evD9Hbs5tN0W6m+kdxlqWSMj3w1wsFLGRrbWXkcbbZvrMIbFqZn
         u0XzVMySuiNQfGvrxIyZ1/WyeFJhEn/RLgBOOpDrGnOS5fGg9VTC5O9gmSePn2k+UD75
         7bqTLvCl78kRV3uDjoPM0SRh0omNnrBBjYqA/mk4+dWq+FNN/uxN5gGD+AGAs7gOBMpS
         Dk5g==
X-Gm-Message-State: AOAM533Bghsz9IVirp70iZq+WaagIYxtmDVRKTRnLBh6PqbBY0f8uJcL
        PPVV9k+y1E/6XLNGbnoiB8GCxzagdcI=
X-Google-Smtp-Source: ABdhPJz7DCXQh8+Cu8E5eqzQJ7mTCbxRpntVNjHf/gwJg9yeA17TYw04B0ceWbFDaA2+uDWbbc7l4Q==
X-Received: by 2002:a19:761a:: with SMTP id c26mr10205200lff.584.1639579945929;
        Wed, 15 Dec 2021 06:52:25 -0800 (PST)
Received: from [192.168.2.145] (94-29-63-156.dynamic.spd-mgts.ru. [94.29.63.156])
        by smtp.googlemail.com with ESMTPSA id b7sm353091lfb.224.2021.12.15.06.52.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Dec 2021 06:52:25 -0800 (PST)
Subject: Re: [PATCH v6 11/28] ARM: tegra: Add device-tree for ASUS Transformer
 Infinity TF700T
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Jonathan Hunter <jonathanh@nvidia.com>,
        David Heidelberg <david@ixit.cz>,
        Svyatoslav Ryhel <clamor95@gmail.com>,
        Anton Bambura <jenneron@protonmail.com>,
        Antoni Aloy Torrens <aaloytorrens@gmail.com>,
        Nikola Milosavljevic <mnidza@outlook.com>,
        Ion Agorria <ion@agorria.com>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        Ihor Didenko <tailormoon@rambler.ru>,
        Andreas Westman Dorcsak <hedmoo@yahoo.com>,
        Maxim Schwalm <maxim.schwalm@gmail.com>,
        Raffaele Tranquillini <raffaele.tranquillini@gmail.com>,
        Jasper Korten <jja2000@gmail.com>,
        Thomas Graichen <thomas.graichen@gmail.com>,
        Stefan Eichenberger <stefan.eichenberger@toradex.com>,
        Stefan Agner <stefan@agner.ch>,
        Peter Geis <pgwipeout@gmail.com>, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20211211211412.10791-1-digetx@gmail.com>
 <20211211211412.10791-12-digetx@gmail.com> <Ybn1Ne2aGfsablwQ@orome>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <02d7e9a9-6999-cccd-aea2-d069c759cd56@gmail.com>
Date:   Wed, 15 Dec 2021 17:52:24 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <Ybn1Ne2aGfsablwQ@orome>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

15.12.2021 17:01, Thierry Reding пишет:
> On Sun, Dec 12, 2021 at 12:13:55AM +0300, Dmitry Osipenko wrote:
> [...]
>> +		i2c@1 {
>> +			reg = <1>;
>> +			#address-cells = <1>;
>> +			#size-cells = <0>;
>> +
>> +			dsi-bridge@7 {
>> +				compatible = "toshiba,tc358768";
>> +				reg = <0x7>;
>> +
>> +				#address-cells = <1>;
>> +				#size-cells = <0>;
>> +
>> +				clocks = <&tc358768_osc>;
>> +				clock-names = "refclk";
>> +
>> +				reset-gpios = <&gpio TEGRA_GPIO(N, 6) GPIO_ACTIVE_LOW>;
>> +
>> +				vddc-supply = <&vdd_1v2_mipi>;
>> +				vddio-supply = <&vdd_1v8_vio>;
>> +				vddmipi-supply = <&vdd_1v2_mipi>;
>> +
>> +				ports {
>> +					#address-cells = <1>;
>> +					#size-cells = <0>;
>> +
>> +					port@0 {
>> +						reg = <0>;
>> +
>> +						bridge_input: endpoint {
>> +							remote-endpoint = <&dpi_output>;
>> +							data-lines = <24>;
>> +						};
>> +					};
>> +
>> +					port@1 {
>> +						reg = <1>;
>> +
>> +						bridge_output: endpoint {
>> +							remote-endpoint = <&panel_input>;
>> +						};
>> +					};
>> +				};
>> +
>> +				/*
>> +				 * Panasonic VVX10F004B00 or HYDIS HV101WU1-1E1
>> +				 * LCD SuperIPS+ Full HD panel.
>> +				 */
>> +				panel@1 {
>> +					compatible = "panasonic,vvx10f004b00";
>> +					reg = <1>;
>> +
>> +					power-supply = <&vdd_pnl>;
>> +					backlight = <&backlight>;
>> +
>> +					port {
>> +						panel_input: endpoint {
>> +							remote-endpoint = <&bridge_output>;
>> +						};
>> +					};
>> +				};
> 
> make dtbs_check complains about this and says that panel@1 (as well as
> #address-cells and #size-cells) are not allowed here. And indeed the
> binding for the Toshiba bridge doesn't mention them here.
> 
> Do we need this here or should this be moved to the top level to fix
> those warnings? I guess what you're doing above is describe a DSI bus
> created by the DSI bridge, which also makes sense, so another
> alternative would be to fix up the binding and let it accept those
> properties.

Toshiba bridge binding is incomplete. David has patch for that [1], I
don't think that it was sent out yet.

[1]
https://github.com/okias/linux/commit/0875230062294b6db17f395ced0a8384a4c1cfc7

