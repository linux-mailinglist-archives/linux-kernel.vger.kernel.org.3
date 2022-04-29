Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99DAC514A8A
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 15:31:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235357AbiD2NfA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 09:35:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229673AbiD2Ne6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 09:34:58 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C9336EC74;
        Fri, 29 Apr 2022 06:31:40 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 4CA7F1F4658D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1651239099;
        bh=uvUnG6SlX1gGcWQAJOz8DPjd6t96tfmGQyIl0sM6fu4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=RXuBOWXMODTLX89Onn14gvnX//JsqGDiXZ0epAVc3+VtKm5AZ3J9XLRo96qvV6lCm
         0KvhB7qlRkRyR4YxcEe5X/NKjj2kj2WH8mS4wQ1fmQN+B8VygH+D97VHfWBjAq2lqc
         nu+nQkqL61QEYW+5cPOkIGmi2GyorxakBtjzYB89+nacx0b3meTUfbzd/ZMUpSNR9a
         L2mWvHOCa9jHqsZ0eedgyXDCt7HHA7N8JlGj/rbzTG2gqtBrVlaGh2+2DBbReM71az
         gmLUGtgtnOz3eldKXKz5a6dqOhXuCAOvqKvQVekasGwmC4SSHETrdljN/l6+VeWamj
         q4sJ/EQ962UXw==
Message-ID: <6c99b872-6092-4271-467c-788a781110a4@collabora.com>
Date:   Fri, 29 Apr 2022 15:31:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2 1/2] dt-bindings: ARM: Mediatek: Remove msdc binding of
 MT8192 clock
Content-Language: en-US
To:     matthias.bgg@kernel.org, mturquette@baylibre.com, sboyd@kernel.org
Cc:     allen-kh.cheng@mediatek.com, weiyi.lu@mediatek.com,
        chun-jie.chen@mediatek.com, linux-kernel@vger.kernel.org,
        ikjn@chromium.org, miles.chen@mediatek.com, robh+dt@kernel.org,
        linux-mediatek@lists.infradead.org,
        krzysztof.kozlowski+dt@linaro.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        devicetree@vger.kernel.org
References: <20220429123133.28869-1-matthias.bgg@kernel.org>
 <20220429123133.28869-2-matthias.bgg@kernel.org>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220429123133.28869-2-matthias.bgg@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 29/04/22 14:31, matthias.bgg@kernel.org ha scritto:
> From: Matthias Brugger <matthias.bgg@gmail.com>
> 
> The msdc gate is part of the MMC driver. Delete the binding description
> of this node.
> 
> Signed-off-by: Matthias Brugger <matthias.bgg@gmail.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

