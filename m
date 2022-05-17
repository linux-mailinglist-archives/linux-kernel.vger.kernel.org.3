Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE01B52A378
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 15:33:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347858AbiEQNd0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 09:33:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236174AbiEQNdX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 09:33:23 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CDD342A09;
        Tue, 17 May 2022 06:33:23 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 445A01F4405C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1652794401;
        bh=cx1hTNJ0Ru+529Hy8oVuqWz9XxAPU7ZBoyO0Pt8qPnY=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=cP30jv+yJP/108pNL4W2mQ+sAYRgXswkGZm+3/iNe+X73PIRX0E8LuqN1Lzt548j1
         Jlw0Tp0c2hdO3qA+EoKnzWtq1WLnxtJWajUiBTsB+oWnN7yMpPgqj+mGdpJRRorq00
         /c/9Y9Jrvut5q1lOac7jY9Tcx5RAZ8f4bMiUO5ejqVpTuOyJWauB+h8oPHKFXbak2G
         +CWZB2RaV6oCm8ZLL/OGgP1IRPns/kuJAR9aEUhBUCO4Web8po/r3adDWi/xefeSLn
         ujGUlQrRolZl3y4vpmWT8QDhyS5LCJCi6gkxbpcDvdeNCUbwwB29PhtAtgnAcq0Sye
         esOP5a5u9UcUw==
Message-ID: <b06c93e0-5638-7a53-ccee-5c81a4ddc46b@collabora.com>
Date:   Tue, 17 May 2022 15:33:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH -next] cpufreq: mediatek: fix error return code in
 mtk_cpu_dvfs_info_init()
Content-Language: en-US
To:     Yang Yingliang <yangyingliang@huawei.com>,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
Cc:     rex-bc.chen@mediatek.com, jia-wei.chang@mediatek.com,
        khilman@baylibre.com, viresh.kumar@linaro.org
References: <20220517133450.2266243-1-yangyingliang@huawei.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220517133450.2266243-1-yangyingliang@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 17/05/22 15:34, Yang Yingliang ha scritto:
> If regulator_get_voltage() fails, it should return the error code in
> mtk_cpu_dvfs_info_init().
> 
> Fixes: 0daa47325bae ("cpufreq: mediatek: Link CCI device to CPU")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>

Thanks!

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
