Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B02EA50B786
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 14:40:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1447610AbiDVMne (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 08:43:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234044AbiDVMnb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 08:43:31 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47FBE13F97;
        Fri, 22 Apr 2022 05:40:37 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 01B831F467B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1650631235;
        bh=iPTlbvyMx1d7Mrt1YDijPEDXZRJjSVW/eJXTWZlURgI=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=FMiMQJrjHDXURWqTZZjn93rQIMl+5Yuzz+Tv9HnSkAHtSnldGOUrxG22nM/2m3Sy9
         0kq4f+BM/HZntwLE6mR9Q1eX+pA/8ohtuQmmZhItTgahx+eVLUp/FvKKoaXVWLm1Uu
         1Krkr554fJc+3KvsBhOX0v6eK1awjt5M6YhZBNHfpJFmr2fxLv5J3+5FrVX+U3XNqB
         1OS5pyimSsjEGFADcla8eG0DO7cVkRYm+TpcjrwjemLjd4BnxTlba/dIkrtawtQrFT
         UUlwoYCtuvVxPwg8kQ3B1FOKX/zYkeDwL8AmQeg/M1j4IIIiXGs0+Ep9vNSX8wuhbb
         vPvitMbwo3m/g==
Message-ID: <b1367db8-7cbb-557d-495a-863f9c98babf@collabora.com>
Date:   Fri, 22 Apr 2022 14:40:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] drm: msm: fix error check return value of
 irq_of_parse_and_map()
Content-Language: en-US
To:     cgel.zte@gmail.com, robdclark@gmail.com, sean@poorly.run,
        dmitry.baryshkov@linaro.org
Cc:     quic_abhinavk@quicinc.com, airlied@linux.ie, daniel@ffwll.ch,
        swboyd@chromium.org, quic_mkrishn@quicinc.com, vulab@iscas.ac.cn,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Lv Ruyi <lv.ruyi@zte.com.cn>, Zeal Robot <zealci@zte.com.cn>
References: <20220422085211.2776419-1-lv.ruyi@zte.com.cn>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220422085211.2776419-1-lv.ruyi@zte.com.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 22/04/22 10:52, cgel.zte@gmail.com ha scritto:
> From: Lv Ruyi <lv.ruyi@zte.com.cn>
> 
> The irq_of_parse_and_map() function returns 0 on failure, and does not
> return an negative value.
> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Lv Ruyi <lv.ruyi@zte.com.cn>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
