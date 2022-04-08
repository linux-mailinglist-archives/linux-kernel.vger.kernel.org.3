Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0959A4F9705
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 15:39:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236465AbiDHNjj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 09:39:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236375AbiDHNjT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 09:39:19 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AEC821B438;
        Fri,  8 Apr 2022 06:37:07 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 3DEA71F471A6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1649425026;
        bh=FGjuCWGQ9jUthcWsjwUcuDe1wUQb4jK/2mMR918IOWk=;
        h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
        b=gygc5Hyaix9uFuueIfXkfNoZ+isEvBff0k3gF/8MVaMiw/BGfQ9rX0Yo6nelONr+e
         o6AvqkNfuEuGN2+eaBCCVvtkxyBHY9cFOjwyp7yw9mSxBiCFZwC1cKbfITHQ75f9y/
         NUiYXJ9cMoNQhgZ8dPvGkotspoDIC4OmA/oDWO9pqQMeX32QL2+VntSrv3vNgFiL3i
         k8KyMa+1Ezu1pSkDa863VXrl5p4d3eFjNKV1pHWAHyneSDYgKDGS/hNGePdlAOC/1H
         vonMk+y7w5wTZ8PqBKDmdXaoYAu7WSgwB8RJR5sNC1jBhJlA4WujUscJqA+KI02wIl
         phcGPUHWrPkOw==
Message-ID: <5f788a8f-7092-19ca-8499-d3626c4a386d@collabora.com>
Date:   Fri, 8 Apr 2022 15:37:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH V2 12/15] cpufreq: mediatek: Use maximum voltage in init
 stage
To:     Rex-BC Chen <rex-bc.chen@mediatek.com>, rafael@kernel.org,
        viresh.kumar@linaro.org, robh+dt@kernel.org, krzk+dt@kernel.org
Cc:     matthias.bgg@gmail.com, jia-wei.chang@mediatek.com,
        roger.lu@mediatek.com, hsinyi@google.com, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20220408045908.21671-1-rex-bc.chen@mediatek.com>
 <20220408045908.21671-13-rex-bc.chen@mediatek.com>
Content-Language: en-US
In-Reply-To: <20220408045908.21671-13-rex-bc.chen@mediatek.com>
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

Il 08/04/22 06:59, Rex-BC Chen ha scritto:
> From: Jia-Wei Chang <jia-wei.chang@mediatek.com>
> 
> Two or more clients may use the same regulator, and it could cause the
> issue of high-freqeuncy-low-voltage.
> To prevent this, we use maximum voltage in mtk_cpu_dvfs_info_init().
> 
> Signed-off-by: Jia-Wei Chang <jia-wei.chang@mediatek.com>

Is this happening for proc-supply (proc_reg)?
...because it looks like it is, so you should send this commit separately
and with an appropriate Fixes: tag.
