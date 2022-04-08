Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F3434F96D5
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 15:37:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236326AbiDHNir (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 09:38:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236319AbiDHNin (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 09:38:43 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D58E21DF852;
        Fri,  8 Apr 2022 06:36:40 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id AF90D1F471A3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1649424999;
        bh=mcsTuGw+kqSCbcjLj4LQCiC8TSeDD6UUMcJeBsddAOE=;
        h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
        b=VA2KDfkjEr8yx8pXPggNq5KeFFaZaf7BaqynZNYvOtJUAvixxHvqocVvPsHnrPiHg
         LkMuZl3Unqa6UT6dVS3uUvKxyJnCcY4c1z2h0wdgIBR3weAzYhTAawJa+Yyn7k7Y8e
         057zXg6ZxZLrmXdB+V5lw+sDFAk7N9jv9w/D61QSwmDG8TCtpOqlLyvdYyRwldXpgX
         2eN7ysWCfZ566OOHyFiD5MF8SVMDo7YJIVo3iYRt0/EvAOl+IIdCS0I40Ani/JNfhl
         Dxic2Ehde1YvzcoSPbcxJt0Jh4RBA/auKGShX22StvnZX6BsGFnyMrYnlPJ6ZQP2yt
         EpP4Zfw4CTpzA==
Message-ID: <68de368b-d39a-4e55-9ae9-67d6f0ac7705@collabora.com>
Date:   Fri, 8 Apr 2022 15:36:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH V2 03/15] cpufreq: mediatek: Cleanup variables and error
 handling in mtk_cpu_dvfs_info_init()
To:     Rex-BC Chen <rex-bc.chen@mediatek.com>, rafael@kernel.org,
        viresh.kumar@linaro.org, robh+dt@kernel.org, krzk+dt@kernel.org
Cc:     matthias.bgg@gmail.com, jia-wei.chang@mediatek.com,
        roger.lu@mediatek.com, hsinyi@google.com, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20220408045908.21671-1-rex-bc.chen@mediatek.com>
 <20220408045908.21671-4-rex-bc.chen@mediatek.com>
Content-Language: en-US
In-Reply-To: <20220408045908.21671-4-rex-bc.chen@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 08/04/22 06:58, Rex-BC Chen ha scritto:
> From: Jia-Wei Chang <jia-wei.chang@mediatek.com>
> 
> - Remove several unnecessary varaibles in mtk_cpu_dvfs_info_init().
> - Unify error message format and use dev_err_probe() if possible.
> 
> Signed-off-by: Jia-Wei Chang <jia-wei.chang@mediatek.com>
> Signed-off-by: Rex-BC Chen <rex-bc.chen@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

