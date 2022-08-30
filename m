Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21B375A5D51
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 09:49:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230426AbiH3HtU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 03:49:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231237AbiH3HtQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 03:49:16 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C6B1CCD60;
        Tue, 30 Aug 2022 00:49:16 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 686806601F01;
        Tue, 30 Aug 2022 08:49:14 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1661845755;
        bh=ZtcFXim2qq7Y5hMJ+YdDBhB84JBbL99ub5L+GYg2dh8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=LFeLUho0SjjplBBxWPqOqI+WNcbEf0dHrzy9EW7kzePaGPZJ5CsFWprHVa8eLbDu9
         HhHz9tKLM64lYNcTcW9yP0h1EpdbsmCoIjcrg90kCKS0+oYS2UWwZuK1ptqH4BIwBA
         JdDkLMB8o+w63OOGvzREOnwD3alI16HCrwDhRIV1UOr3ZbxmF0zylfdsUgZlnxAXBZ
         LmeEcNRw+VVKc3AP0S30IdLAs6nO7NkkA+4RYT2iyrbWjnLxftsC5kgk8RcYi+cYKf
         xW4gK1ntZMvCPPupmrb/YrgZ9AayF4/fMZuM2tij6FOqnCzZpV3nH9Ae6FJUbgcijt
         B/WQ+7RYucKIg==
Message-ID: <a209aea3-bf23-4670-91d0-e7f41ac57833@collabora.com>
Date:   Tue, 30 Aug 2022 09:49:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 3/3] arm64: dts: Modify gamma compatible for mt8195
Content-Language: en-US
To:     "zheng-yan.chen" <zheng-yan.chen@mediatek.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        "Jason-JH . Lin" <jason-jh.lin@mediatek.com>,
        Singo Chang <singo.chang@mediatek.com>,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20220830063929.13390-1-zheng-yan.chen@mediatek.com>
 <20220830063929.13390-4-zheng-yan.chen@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220830063929.13390-4-zheng-yan.chen@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 30/08/22 08:39, zheng-yan.chen ha scritto:
> Modify gamma compatible for mt8195.
> 
> Fixes: 16590e634f1d ("arm64: dts: mt8195: Add display node for vdosys0")
> Signed-off-by: zheng-yan.chen <zheng-yan.chen@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

