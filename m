Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4106A5A26EB
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 13:34:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236397AbiHZLcx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 07:32:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245527AbiHZLcm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 07:32:42 -0400
Received: from mail-sz.amlogic.com (mail-sz.amlogic.com [211.162.65.117])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9CC1DB7F2;
        Fri, 26 Aug 2022 04:32:39 -0700 (PDT)
Received: from [10.28.39.83] (10.28.39.83) by mail-sz.amlogic.com (10.28.11.5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Fri, 26 Aug
 2022 19:32:37 +0800
From:   Huqiang Qin <huqiang.qin@amlogic.com>
Subject: Re: [PATCH] arm64: dts: meson-s4: include meson-s4-gpio.h
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <narmstrong@baylibre.com>, <khilman@baylibre.com>,
        <jbrunet@baylibre.com>, <martin.blumenstingl@googlemail.com>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Message-ID: <e32a8c39-1e47-cad1-e093-2cabb2dd37a4@amlogic.com>
Date:   Fri, 26 Aug 2022 19:32:37 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.28.39.83]
X-ClientProxiedBy: mail-sz.amlogic.com (10.28.11.5) To mail-sz.amlogic.com
 (10.28.11.5)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On 2022/8/25 20:02, Krzysztof Kozlowski wrote:
> Why? We can see what you did here, but commit msg should explain why you
> do it...

Sorry, I didn't describe this commit message clearly.

In the future, meson-s4.dtsi will have some nodes that need
to use the meson-s4-gpio.h file.

e.g.
	(1) Bluetooth enable pin:
		bt_en-gpios = <&gpio GPIOX_17 GPIO_ACTIVE_HIGH>;
	(2) Audio mute pin:
		spk_mute-gpios = <&gpio GPIOH_8 GPIO_ACTIVE_LOW>;
	(3) ...

So, this patch was born.

Best regards,
Huqiang

