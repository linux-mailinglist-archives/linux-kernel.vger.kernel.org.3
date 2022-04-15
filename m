Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E94350285A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 12:33:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352341AbiDOKfa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 06:35:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234985AbiDOKf1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 06:35:27 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD7E6BBE35;
        Fri, 15 Apr 2022 03:32:59 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id D30FB1F47E6A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1650018778;
        bh=PusWeJyfelc4rfVn7gOGkQ7kuEx7Hrcz3WTXt8Ey8L0=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ckhrRylc/UTSgvMkkm0H3vUvmwHOwtr9KqhZQphh5cY9omGVjk/7fb6hbOZRSDbmZ
         /ZS0eO0GC1KOjl5b5vKFUxDOcxo3gjga06JSHTMA/nIQ7134imG3YjJ5oV4CUVE5t6
         Lhdvy3ruRrW2xcV/69esiO31cDid+w5uVV3U3fXHHetKVF+CjAbkeHC3M2xgwv3twG
         eHYg6z5RYXTKh5XE5bGV8JcIfQPn1CmTE/gfQi+xTMOwyNAUA9v9f75hpY2mex523U
         JXT6k8UHaqljI511CqduDUCZu1UOpF+f5krcYSvc7N+20g5FEcjNdRYuwPwGQY/fGt
         jcUzXAH8lczoA==
Message-ID: <45b11fdc-4b81-86eb-81ce-ef9e32faa51f@collabora.com>
Date:   Fri, 15 Apr 2022 12:32:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v19 08/10] soc: mediatek: add DDP_DOMPONENT_DITHER0 enum
 for mt8195 vdosys0
Content-Language: en-US
To:     "jason-jh.lin" <jason-jh.lin@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>
Cc:     CK Hu <ck.hu@mediatek.com>, Nancy Lin <nancy.lin@mediatek.com>,
        Singo Chang <singo.chang@mediatek.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20220415083911.5186-1-jason-jh.lin@mediatek.com>
 <20220415083911.5186-9-jason-jh.lin@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220415083911.5186-9-jason-jh.lin@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 15/04/22 10:39, jason-jh.lin ha scritto:
> The mmsys routing table of mt8195 vdosys0 has 2 DITHER components,
> so mmsys need to add DDP_COMPONENT_DITHER1 and change all usages of
> DITHER enum form DDP_COMPONENT_DITHER to DDP_COMPONENT_DITHER0.
> 
> But its header need to keep DDP_COMPONENT_DITHER enum
> until drm/mediatek also changed it.
> 
> Signed-off-by: jason-jh.lin <jason-jh.lin@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

