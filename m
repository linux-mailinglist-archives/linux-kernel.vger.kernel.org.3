Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D28AC57849E
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 15:59:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235676AbiGRN7n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 09:59:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235669AbiGRN7h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 09:59:37 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03C431FCEB;
        Mon, 18 Jul 2022 06:59:37 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 04C2466015B2;
        Mon, 18 Jul 2022 14:59:34 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1658152775;
        bh=k4xbc/KxSu0t1ZuCXLylgktrPrf4etvCU4uHHfVpdvo=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=MSQPo+QJyrJGPQjPwq4PVuS8usKOjr0hRhGugecZWIPQD4L6WP6UFPX1u7R6MyM0s
         5a/lfRMZJBPiHj4UX2fDddUh/ZHOQuXBntdyOCBk+022s/FvtuzabMr0Aq7TYefGGj
         +HuXnJyaotczIGt4rYxWtkEm8AXuktNB+5ro0QFHTyYLqkM3MbpluhVsz5QnMr/xU/
         4oZtGAZjd7DLELZhXCjXy+PI/8i/r9faWKTV01ZZ9gWkfGwT20+IC0lkyXug5czaLI
         0m7vZZmTSLQe26iSolOJMnjqMntteCkxFk26LPF/poT/Rv8opk3mMV0cUkVHiMq2Z5
         7+5grMXlQU+ow==
Message-ID: <b2439e75-88a3-5f04-5fe6-b53e8d5232a7@collabora.com>
Date:   Mon, 18 Jul 2022 15:59:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] dt-bindings: display: mediatek: dpi: add power-domains
 property
Content-Language: en-US
To:     Allen-KH Cheng <allen-kh.cheng@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        CK Hu <ck.hu@mediatek.com>, Jitao shi <jitao.shi@mediatek.com>
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        hsinyi@chromium.org, fparent@baylibre.com,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20220718052217.29729-1-allen-kh.cheng@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220718052217.29729-1-allen-kh.cheng@mediatek.com>
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

Il 18/07/22 07:22, Allen-KH Cheng ha scritto:
> DPI is part of the display / multimedia block in MediaTek SoCs
> and is managed using power controller in some platforms. We add
> the power-domains property to the binding documentation.
> 
> Signed-off-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>

For the contents of this commit:

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


...but I'm not sure whether this one requires a Fixes tag (because, effectively,
the DPI hardware *requires* that power domain to get up) - and if it does,
which commit to reference: the first commit for this file is a TXT->schema
conversion, but the TXT didn't have power-domains as well.



Regards,
Angelo
