Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E34450B2C0
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 10:21:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1445110AbiDVIYG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 04:24:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1444806AbiDVIX5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 04:23:57 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10C9E52B0D;
        Fri, 22 Apr 2022 01:21:05 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id EE91B1F46408
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1650615663;
        bh=6GDE5GL5KCBI5XfEVRdtC/piNEJkhyMxk2/3f9Ecc8E=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=KL2qVbH/rQ2F1j1SK9HSKegv6K5JwRTxwXUwWmbiEyXdVY8n89NVTaWZEyHYxStX/
         dDy51YxgEtnMis3zEY3+whSDInWvP+j1CxPgOql8cRJcaJ8biK5vwhD/DXk5SwRonr
         kl+vA/weEx8GrZhwX6nf+y/Aj/zVvCX67IJ5y+5BL0EY+IMARmzHuW0Y1d+pq128JM
         ZJqloQ5q/z410s8JW//+Yvk62ulMQyKYHepAHqdgIIAT887I2PtLwG1F5uQcQz/Hh6
         e/z1Axtzz3ncBEEhNxVxqepGJrjC2bS8C1pl+LbfWFhwsU4ya41M2KMNSWm+YgtG/6
         MPTWez6SJDJ6g==
Message-ID: <0b246114-e200-8866-748b-2d04f507d292@collabora.com>
Date:   Fri, 22 Apr 2022 10:21:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH V4 07/14] cpufreq: mediatek: Add .get function
Content-Language: en-US
To:     Rex-BC Chen <rex-bc.chen@mediatek.com>, rafael@kernel.org,
        viresh.kumar@linaro.org, robh+dt@kernel.org, krzk+dt@kernel.org,
        matthias.bgg@gmail.com
Cc:     jia-wei.chang@mediatek.com, roger.lu@mediatek.com,
        hsinyi@google.com, khilman@baylibre.com, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20220422075239.16437-1-rex-bc.chen@mediatek.com>
 <20220422075239.16437-8-rex-bc.chen@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220422075239.16437-8-rex-bc.chen@mediatek.com>
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

Il 22/04/22 09:52, Rex-BC Chen ha scritto:
> From: Jia-Wei Chang <jia-wei.chang@mediatek.com>
> 
> We want to get opp frequency via opp table. Therefore, we add the function
> "mtk_cpufreq_get()" to do this.
> 
> Signed-off-by: Jia-Wei Chang <jia-wei.chang@mediatek.com>
> Signed-off-by: Rex-BC Chen <rex-bc.chen@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


