Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F9FB50C8EC
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 12:06:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234785AbiDWKFO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Apr 2022 06:05:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234784AbiDWKFK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Apr 2022 06:05:10 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D27A164BE0
        for <linux-kernel@vger.kernel.org>; Sat, 23 Apr 2022 03:02:12 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id e30so9617730eda.0
        for <linux-kernel@vger.kernel.org>; Sat, 23 Apr 2022 03:02:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=uqE7a6NJksxPmKfzuWRUDmngu5kb3QY06IS1kPuThog=;
        b=OWyA8ayOnnz0c4VI2geFsTqnyMCItptx/7wv0v/tek0PEXrCmUYF3JIVQb5zLXi7IY
         SbwZXVb/wDioA5ErPtuiBlr4CLqoeSaEM9LdPJfK9iPakx2nsXAJ7OYmE0zEeo9YDj2d
         3+Bab24AOkc1EtSCmz60kfvj5gmNgFp3AU9Y9z6smztj1R1zZs3SwEIS3+rhIToWCpQw
         czSZd4Y34U1Z3wAynQ+Q9t8FxppNgnXLyy5NmY7W3Ae8Qv8+/dmn6euqMDoPEL0re4us
         rpHTtqj6vaX9Hhovku1oB2Ak9xA/fM3PGkb2RBuO+7k6rCRKUMfasbt1cZv4TGhKg6A+
         AC2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=uqE7a6NJksxPmKfzuWRUDmngu5kb3QY06IS1kPuThog=;
        b=8QatHuf4L8vKdMFghi4VGrw1FruUCO8ecjKlDFuHipLc6HIirdMZjeeHoFbUTm8MZT
         C6QFmkvL/KknyY3emwbk5s5tuKITQnO6REp72DSQG8x+mGsYzaOKuatdDf0BQXaVArWj
         r/KhmNs7a7cIsx4T9PLhF6xgrUpaSDh8/ESP0HtbsUxfOcp462FK6QAZHUkZo/H+WlAn
         cyaovXUH0xcoFvozTcXmC/Fq8ZU6FqHQFp1QHLHbmO+VK9om44T1cA1VrgEOF7wL6Mq4
         stwOybUgX4rtv3jqzD80CXCRDVB4psMMX+9vuBw5FB8E29SeYLIFRuk1W5Kfcp7n9mzh
         zRbw==
X-Gm-Message-State: AOAM532fxHhn7OA8Nq7Yx948MYq09cdefTi+uP/a7ymUo8NstdE0VcCt
        NM4n+q8zQDmsyDSv0nxdqJSfbg==
X-Google-Smtp-Source: ABdhPJy7Ddg//+iDPT658Yo6Ea3cxkifJPDk7IA+q5X6EDHLQgp8JwphTJgQjeDhHSZ/o1+6vwj8VA==
X-Received: by 2002:a50:c014:0:b0:41d:5ee9:f354 with SMTP id r20-20020a50c014000000b0041d5ee9f354mr9313054edb.257.1650708131502;
        Sat, 23 Apr 2022 03:02:11 -0700 (PDT)
Received: from [192.168.0.234] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id g1-20020a170906348100b006efc26c7b1dsm1497164ejb.195.2022.04.23.03.02.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 23 Apr 2022 03:02:10 -0700 (PDT)
Message-ID: <6ea4657a-042e-9a2e-fff1-f13a578fdf13@linaro.org>
Date:   Sat, 23 Apr 2022 12:02:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCHv1 11/19] dt-bindings: pinctrl: rockchip: add rk3588
Content-Language: en-US
To:     Sebastian Reichel <sebastian.reichel@collabora.com>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@lists.collabora.co.uk,
        kernel@collabora.com
References: <20220422170920.401914-1-sebastian.reichel@collabora.com>
 <20220422170920.401914-12-sebastian.reichel@collabora.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220422170920.401914-12-sebastian.reichel@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/04/2022 19:09, Sebastian Reichel wrote:
> Add compatible string for rk3588 pin controller. No other changes
> are required, since the new controller can use the old binding.
> 
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>



Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
