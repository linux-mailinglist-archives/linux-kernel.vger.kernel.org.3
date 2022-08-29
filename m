Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 335585A41F7
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 06:35:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229646AbiH2Efe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 00:35:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbiH2Efc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 00:35:32 -0400
Received: from mail-sz.amlogic.com (mail-sz.amlogic.com [211.162.65.117])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABED9205D0;
        Sun, 28 Aug 2022 21:35:28 -0700 (PDT)
Received: from [10.28.39.83] (10.28.39.83) by mail-sz.amlogic.com (10.28.11.5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Mon, 29 Aug
 2022 12:35:26 +0800
From:   Huqiang Qin <huqiang.qin@amlogic.com>
Subject: Re: [PATCH v2] arm64: dts: meson-s4: include meson-s4-gpio.h
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <narmstrong@baylibre.com>, <khilman@baylibre.com>,
        <jbrunet@baylibre.com>, <martin.blumenstingl@googlemail.com>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Message-ID: <e0f479d3-744c-9eae-e1fb-1a617c806890@amlogic.com>
Date:   Mon, 29 Aug 2022 12:35:26 +0800
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

On 2022/8/27 1:40, Krzysztof Kozlowski wrote:
> Then the header should be added when the need is implemented. Do not add
> unused headers to files.

I understand, thank you very much.

Best regards,
Huqiang

