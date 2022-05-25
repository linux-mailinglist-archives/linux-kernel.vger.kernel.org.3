Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC0EA533A6E
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 12:08:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241990AbiEYKIi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 06:08:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240367AbiEYKIc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 06:08:32 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBAAC8FF90;
        Wed, 25 May 2022 03:08:30 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 968391F44BDB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1653473309;
        bh=f7K6y+dJjMBoG72vq/rLJZEBSpBO8+vaOYzhtZ/0Lls=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=KMyTR4v/JWGVhJKk8F7Kdw/mFlyVJgFd4MfDTQIIS7bjrD53k8B3IpL0ilhdwuPS8
         hdm4xxgCAWA8PaU5bE9mLyfPPO1XBZWqYpHt1ZZuDYqvBynJfAVQhTJOFP04DvutTt
         6eE528/1CT/39gQnZP+PsH3AYSohwz6tk+QEzFrMqkXTzDKrjVFaLmuf73Xvn4q6eg
         YwXptzgTCh2d3GMQQh5soNMjNe9tSOqQxAhchyITrk+m9GRLVdSECYZ3R/U3o9xrO/
         PMapcVFMXP3AZ0/2/cqdonoKvv/DkHkul+lKDM27wDMcsGXBeQwF1e3Y3JBJmBsRBU
         h6NY3FQroIg0w==
Message-ID: <79863f1b-7bdd-61c7-2209-23011d8e1558@collabora.com>
Date:   Wed, 25 May 2022 12:08:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v21 00/25] Add MediaTek SoC DRM (vdosys1) support for
 mt8195
Content-Language: en-US
To:     Rex-BC Chen <rex-bc.chen@mediatek.com>,
        "Nancy.Lin" <nancy.lin@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>, wim@linux-watchdog.org,
        linux@roeck-us.net
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "jason-jh . lin" <jason-jh.lin@mediatek.com>,
        Yongqiang Niu <yongqiang.niu@mediatek.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        dri-devel@lists.freedesktop.org, llvm@lists.linux.dev,
        singo.chang@mediatek.com,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20220512053128.31415-1-nancy.lin@mediatek.com>
 <8c6ceb14be7e53a7dab9d6f045a48deaef54f683.camel@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <8c6ceb14be7e53a7dab9d6f045a48deaef54f683.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 18/05/22 04:47, Rex-BC Chen ha scritto:
> On Thu, 2022-05-12 at 13:31 +0800, Nancy.Lin wrote:
>> The hardware path of vdosys1 with DPTx output need to go through by
>> several modules, such as, OVL_ADAPTOR and MERGE.
>>
>> Add DRM and these modules support by the patches below:
>>
>> Changes in v21:
>> - fix reviewer comment
>>    - fix rdma and ethdr binding doc and dts
>>

..snip..

> 
> Hello Matthias,
> 
> Could you also spare some time to give us some suggestion for the mmsys
> and mutex patches of this series?
> If we can improve anything, we can do it before 5.19.
> Thanks for your big support!
> 
> BRs,
> Rex
> 

Even though there may be something to further improve, keep in mind that we're
already at v21... that's... a lot of versions, and vdosys0/1 are practically
tied together even though they're coming from two different engineers.

I can confirm that this entire stack works on the new HW as intended and that
there's no regression on older ones, so on all patches you can add my:

[Tested on MT6795, MT8173, MT8192, MT8195]
Tested-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


.... BUT! ....


This series won't apply cleanly anymore on next-20220525 (same for vdosys0,
already pinged Jason about it) because of the commits adding support for MT8186,
so *please rebase this series once again*.


Cheers,
Angelo
