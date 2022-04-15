Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A44E502857
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 12:32:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352322AbiDOKfN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 06:35:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240535AbiDOKfL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 06:35:11 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FB1BDF35;
        Fri, 15 Apr 2022 03:32:44 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 528AC1F47E6A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1650018763;
        bh=o3B0CJoa73EGtPrdPd8q/dHzTCP0JQ19PFMotaGHh2Q=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=YqgqgY818zgL/yZrmonREhd9kAKts0WzHOubFJUu6GJkIk56jwELmHZwGW5VYtRyN
         vk20W1Xz3jFZrrMXKKDlutccF5JiELA6uk2VtqhTeWAQpcHMlooYZnKuqHZdAKu0aI
         roIEvtF1YVIzj0EkC02uolZ1tMmxsSmUEZoUgr2MFmt0PpA5HONPJ3JFmBkrhUnrjx
         iLqX24u0djPJhCFfXhV2wg6BbnUdVRpjxLePK9fu95GRGHWrZu2cTd6k4ILRikTXTO
         fy3juF6JCaeYmbnKptYT/3SK+dqUws7nHZhwuaHwAmkv0KbVPW5IIUgWZVfCCi5b+W
         GMe2ZE3qfHHUw==
Message-ID: <387ede3f-20be-cb84-f343-f68c75eaf5fd@collabora.com>
Date:   Fri, 15 Apr 2022 12:32:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v19 10/10] soc: mediatek: remove DDP_DOMPONENT_DITHER enum
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
 <20220415083911.5186-11-jason-jh.lin@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220415083911.5186-11-jason-jh.lin@mediatek.com>
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
> After mmsys and drm change DITHER enum to DDP_COMPONENT_DITHER0,
> mmsys header can remove the useless DDP_COMPONENT_DITHER enum.
> 
> Signed-off-by: jason-jh.lin <jason-jh.lin@mediatek.com>

Can you please fix the commit title with:
soc: mediatek: remove DDP_DOMPONENT_DITHER from enum

that "from" is important, as you're not removing *an enum*, but *from an enum*.

After that:

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Thanks!
Angelo
