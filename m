Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E788D4D97DA
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 10:39:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346695AbiCOJkr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 05:40:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233221AbiCOJkp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 05:40:45 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA94A3BF87;
        Tue, 15 Mar 2022 02:39:33 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 65A1D1F436D5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1647337172;
        bh=/omHuW1SBHtv3icmbq+E6xjfrNJbrtd1dBgkplAsHXM=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=fPqGt4lG/y1cdMJv/FxZOzqQGn3I2ukezczjNlal/QNlmVFwYBjY+tWMbv0BY0VO8
         v0Av7diONYTnTW/u3eVVi4WGvNCJ9z7g5WtRmoCjj/7Lrqly/6tUye0FqQvZpZhenv
         NITjYji4vkUY9bl+dXKuSF9BV42Nu8dSA9CNdKxy/2qt8LNdgeybpkAtGYnW+S5by9
         H4vj365CYfPE1W5n+L+d/4YJK3VKjjuubSWZaqckTrO+t72v2q6d5P19bvN2jzjTa9
         tQ51+K0WHdE8tnGaIghot81smD0eitUHtw2REmRM/Jdk/hwB6hdQ3TcyFoc5OTYyi6
         gvwHzDqpyzbVA==
Message-ID: <49e44863-af2d-84e8-dc97-795740864aba@collabora.com>
Date:   Tue, 15 Mar 2022 10:39:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH V4 3/6] spi: mediatek: add ipm design support for MT7986
Content-Language: en-US
To:     Leilk Liu <leilk.liu@mediatek.com>, Mark Brown <broonie@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        linux-mediatek@lists.infradead.org
References: <20220315032411.2826-1-leilk.liu@mediatek.com>
 <20220315032411.2826-4-leilk.liu@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220315032411.2826-4-leilk.liu@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 15/03/22 04:24, Leilk Liu ha scritto:
> this patch add the support of ipm design.
> 
> Signed-off-by: Leilk Liu <leilk.liu@mediatek.com>

Sorry for the double email, the first one was sent from the wrong address.

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

> ---
>   drivers/spi/spi-mt65xx.c | 102 +++++++++++++++++++++++++++++++++------
>   1 file changed, 87 insertions(+), 15 deletions(-)
> 

