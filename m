Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B89F257C6A3
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 10:41:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232477AbiGUIls (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 04:41:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232508AbiGUIl3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 04:41:29 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3CD3FE3;
        Thu, 21 Jul 2022 01:41:28 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id F009466019C1;
        Thu, 21 Jul 2022 09:41:26 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1658392887;
        bh=DgHftiCEhCQJ15Wj0pfslx32ViPF5o7q5eIFrCJ9Eys=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=cgPJfcrRWP5XcReCy6+E6h3yIgSJNMxdS7TenuM2bsD0EBVO2hxzKP3CZVyleS9QS
         /QE4Tf1wXjQ+gweV+kBgRKPRxbmEHvdIVZ3nQ9SRp6fZ5OBCGaoEmBE+dcFF/DEefO
         FNjvhELXOl2tiOiVrlLBo5nBUkTqR6+opAVfssV7WHl7TjyDHkee7VrFP1Z4imAiP5
         +NwVhrY4LyXpE2Dzp99JhV7jvLY67pZpqFphoK83GbU9397MN1/3B7a2w8bhom92NH
         YxLdk6YKeqx5UI3CAB4F+vChZHNz6tbm+MMXNB3CzN6nnOSUpUAa8kJ0tjVL2i1rJJ
         8p/x5ma5cCMuQ==
Message-ID: <ff169a88-250c-1e21-b65d-bc92fad20f79@collabora.com>
Date:   Thu, 21 Jul 2022 10:41:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v1 5/6] arm64: dts: mediatek: mt8183: add keyboard node
Content-Language: en-US
To:     Mattijs Korpershoek <mkorpershoek@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        Fabien Parent <parent.f@gmail.com>, devicetree@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        Fabien Parent <fparent@baylibre.com>,
        linux-arm-kernel@lists.infradead.org
References: <20220720-mt8183-keypad-v1-0-ef9fc29dbff4@baylibre.com>
 <20220720-mt8183-keypad-v1-5-ef9fc29dbff4@baylibre.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220720-mt8183-keypad-v1-5-ef9fc29dbff4@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 20/07/22 16:48, Mattijs Korpershoek ha scritto:
> From: Fabien Parent <fparent@baylibre.com>
> 
> MT8183 has an on-SoC keyboard controller commonly used for volume
> up/down buttons.
> 
> List it in the SoC dts so that boards can enable/use it.
> 
> Signed-off-by: Fabien Parent <fparent@baylibre.com>
> Signed-off-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

