Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 106B05531B5
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 14:12:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349541AbiFUMMC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 08:12:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350346AbiFUMLx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 08:11:53 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EF6D2B273;
        Tue, 21 Jun 2022 05:11:52 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 6EAB166017A0;
        Tue, 21 Jun 2022 13:11:50 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1655813511;
        bh=3DNZncrYFTRRbUO04o6Ge6N5kK8kJIUMsdhLMMKQi+4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=lafu2kFH4eYbRD042lfKr6WjPY9d7n5gsArkZVhHroikIBxBjeglJNt3unTNUTWDd
         ocncTNUaP7weV5RCq7rWmSBlOw9uSw7Sdz8PHpsnfgUJMSPZPNfZtoCwV7ttbCAMQv
         R3lVliXvnCZvdStXdTxpVS5cuBZYbHAFOE2GITuwOwMfWDsjIgnNC+5KQxER1vWKDm
         nn9j1+K7Qc+sG4KyKy1fu4go62OMLWEbL7kH/Eybs5ZK57J5i5UwOj/K57OlRS7Hwg
         +gIVxd7ZQPzcOx+Icd6RC9e4uEua/Z6+f7WJHG+48AtPmK96Nj6CsQ/X++ikufnylO
         OfL/AfdBi4XQA==
Message-ID: <f590a525-2ae8-ef78-6c47-dce91e4e7f7e@collabora.com>
Date:   Tue, 21 Jun 2022 14:11:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v13 02/14] drm/mediatek: dpi: Add kernel document for
 struct mtk_dpi_conf
Content-Language: en-US
To:     Bo-Chen Chen <rex-bc.chen@mediatek.com>, chunkuang.hu@kernel.org,
        p.zabel@pengutronix.de, daniel@ffwll.ch, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        airlied@linux.ie
Cc:     msp@baylibre.com, granquet@baylibre.com, jitao.shi@mediatek.com,
        wenst@chromium.org, ck.hu@mediatek.com,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20220621113732.11595-1-rex-bc.chen@mediatek.com>
 <20220621113732.11595-3-rex-bc.chen@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220621113732.11595-3-rex-bc.chen@mediatek.com>
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

Il 21/06/22 13:37, Bo-Chen Chen ha scritto:
> This driver will support dp_intf and there are many configs between dpi
> and dp_intf. Therefore, we will add many configs in "struct mtk_dpi_conf".
> To let this structure more readable, we add this kernel doc.
> 
> Signed-off-by: Bo-Chen Chen <rex-bc.chen@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

