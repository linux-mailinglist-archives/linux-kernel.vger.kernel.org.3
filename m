Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 041D6519C05
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 11:37:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347637AbiEDJlA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 05:41:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245591AbiEDJk0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 05:40:26 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2FC226564;
        Wed,  4 May 2022 02:36:50 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 1B0EB1F44761
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1651657009;
        bh=7vMV83riab//ztpkWA1Ve1xv8JZ97Ulw/BxrBxOF+0A=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=bC9csRZGUw2FlsRfuX8zn7yt63zBFyHioHxzNj7l9WXIaPE9d4bzp2oVI44+enkKB
         9Y2GFiqtBuUApLk0WmANFpZB+oK8eXuXoUkMv1KoyVsZRaelXDc1YERglB8x8nk9Ya
         l3nm+8ejSfZdcfBQHcXpe0ISHb/hmvfDmjU7CBcmQGKViSCkyFp2mFSOECPHctmJfU
         2Zqckg2hxX5UBBjSXOD0HCnA5TG77QjFvGLlw29kmYBV2aBWifiF2dKaMzzVW0Bsv5
         FYc8EgKX5lcxoa0KPTiCgG4KdXs0S9gE63klnWO4fP4UKfvV832msTCeWqNEH7PQ/Y
         GG+bwiE6Z4mRA==
Message-ID: <276ef83c-c824-3874-c36e-4d422794d7dc@collabora.com>
Date:   Wed, 4 May 2022 11:36:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 1/2] dt-bindings: soc: mediatek: devapc: Add bindings for
 MT8186
Content-Language: en-US
To:     Rex-BC Chen <rex-bc.chen@mediatek.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com
Cc:     neal.liu@mediatek.com, runyang.chen@mediatek.com,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20220429065429.7957-1-rex-bc.chen@mediatek.com>
 <20220429065429.7957-2-rex-bc.chen@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220429065429.7957-2-rex-bc.chen@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 29/04/22 08:54, Rex-BC Chen ha scritto:
> Add the dt-binding to support MT8186 devapc.
> 
> Signed-off-by: Rex-BC Chen <rex-bc.chen@mediatek.com>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

