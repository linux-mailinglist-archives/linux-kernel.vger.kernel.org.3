Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEB39505C29
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 17:58:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343696AbiDRQAn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 12:00:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240781AbiDRQAj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 12:00:39 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 462D3FD
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 08:57:59 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id r13so27612439ejd.5
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 08:57:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=JSWOMZN2s2Uc0MEkuAEzkTwIlDrpbxDUKksft1URO94=;
        b=YaonER1hHD5j2WB24Y1TDR5agDK/8GipcH6XQtLpJvLQUYyNs/yzLom/3nWNxnUo6q
         YqoyLmh7HQhRyrMnXAi48T0lw0hyJ92orPa7RZ+4tKjzhdsxzZLw7tbWAUyiNRmIRdCk
         Kw6xbsaLrC1/cYPgAYj2xML93L6Pgg4nis5VkTFvSbh72lVU9wNKBK1ew1k6WfvBdIm3
         vzy0138x4ewlUmiH8I+HFmylHN0q/nshWvsx6vVHZ9ahWWj/8jsZ5ye36orkaELgOqDL
         gAw7BGV6QVkY9ZszGIFam5A1qUQ0fBKv15tMF+8zuIMV1a6DjZcdd8Xl2j78WE+qtpAU
         BSAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=JSWOMZN2s2Uc0MEkuAEzkTwIlDrpbxDUKksft1URO94=;
        b=FXOqNtpcc+HEd1PKUs11PykVlnb/6XumH657t+dixAspmfDW/exk3gacs18g5HsBYX
         efWFE6/OH4Lq57MKaaueB2GvJ0tpVqbZKY7bCJck9Q+d9bl+tTE6IeblcxHvlWMFr8vn
         GMcKXzdVWSRHcGXjKh3gzKpiu7Hk6PuqrokzCUJabnskQ5R3gDnyHAvstHYK05OyjLkp
         2PG3oI1gcUqE4ed/jjtOJ6u5xFY1YDH1eGyZf/CJ9n4sxNpAPo6vSUHMgBbumomeYgwR
         23+1wOmIpR8GH1oYgJVOXo2GnkVIJZRng4omv3C03vEdqH1sQ5MxQCqv0At2yDW9clw3
         RVcQ==
X-Gm-Message-State: AOAM533Q04g1grYTjEwImK7J+teI4j3AaeQ4WgP3Py3Z4s6nBz1FSMLF
        6AYWXaBjyZe4kXJZWtGxj9l1Sw==
X-Google-Smtp-Source: ABdhPJzbfk8QTJK5jVB6BLByUTxvMVPAib1GsPEBJahAxLMAbDnMR0ih2p6z1HqOoX7v85bcyO5p2Q==
X-Received: by 2002:a17:907:1b06:b0:6e7:f58a:9b91 with SMTP id mp6-20020a1709071b0600b006e7f58a9b91mr10073346ejc.291.1650297477805;
        Mon, 18 Apr 2022 08:57:57 -0700 (PDT)
Received: from [192.168.0.217] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id gq5-20020a170906e24500b006e87644f2f7sm4661020ejb.38.2022.04.18.08.57.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Apr 2022 08:57:57 -0700 (PDT)
Message-ID: <195bc220-05c1-d216-6596-0a54c177c5a6@linaro.org>
Date:   Mon, 18 Apr 2022 17:57:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [RFC/RFT 6/6] arm64: dts: rockchip: Add PCIe v3 nodes to
 BPI-R2-Pro
Content-Language: en-US
To:     Frank Wunderlich <linux@fw-web.de>,
        linux-rockchip@lists.infradead.org
Cc:     Frank Wunderlich <frank-w@public-files.de>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Johan Jonker <jbx6244@gmail.com>,
        Peter Geis <pgwipeout@gmail.com>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
References: <20220416135458.104048-1-linux@fw-web.de>
 <20220416135458.104048-7-linux@fw-web.de>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220416135458.104048-7-linux@fw-web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/04/2022 15:54, Frank Wunderlich wrote:

(...)

> +	pcie30_avdd1v8: pcie30-avdd1v8 {
> +		compatible = "regulator-fixed";
> +		regulator-name = "pcie30_avdd1v8";
> +		regulator-always-on;
> +		regulator-boot-on;
> +		regulator-min-microvolt = <1800000>;
> +		regulator-max-microvolt = <1800000>;
> +		vin-supply = <&vcc3v3_sys>;
> +	};
> +
> +	/* pi6c pcie clock generator feeds both ports */
> +	vcc3v3_pi6c_05: vcc3v3_pi6c_05-regulator {

No underscores in node names. Same in other places.


Best regards,
Krzysztof
