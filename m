Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BA3A519B6A
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 11:17:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343699AbiEDJVV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 05:21:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347039AbiEDJUs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 05:20:48 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84F7525C4A;
        Wed,  4 May 2022 02:16:18 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id DAB721F41569
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1651655777;
        bh=Dotfy/ZpuAnemLKpN+RhtuMzzTxRdF3JKSnpuEWgFvU=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Ele/+rUhfYGdPpKz37ZSGAZweUB5eRLht1elQek2Ls7Uk7ScaKdHq4oOJZokMNng8
         E4aWPmwyZJIGro0rORFHegX8UpQyy2V66mWC9jH8mKLvBfpryzsLanzVZ6zlz6sPZv
         H04TXYArsclMV61Qmn4JLcfYl7xQNH2r9U0p7CA4nhBRvKk+RGqa1FIIaJyHJqWoMb
         oEBE2/98U70CrgAdbBH+ZmJaNy0RRxgtv2gZCkfy0UMoxcu1wo6GtJx2dKvmMvMmBQ
         aTdlEKhOIqSm1CCyQkF18ye+o1+fzC4SE7Egd3pSbp3rcILsWinVQXIrjPYB64s9Hi
         4pU26qtXcrSbw==
Message-ID: <b2bebf6d-a1e5-e998-0f75-17c84b7dbbdc@collabora.com>
Date:   Wed, 4 May 2022 11:16:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v20 06/25] soc: mediatek: add mtk_mmsys_update_bits API
Content-Language: en-US
To:     "Nancy.Lin" <nancy.lin@mediatek.com>,
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
References: <20220504091440.2052-1-nancy.lin@mediatek.com>
 <20220504091440.2052-7-nancy.lin@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220504091440.2052-7-nancy.lin@mediatek.com>
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

Il 04/05/22 11:14, Nancy.Lin ha scritto:
> Add mtk_mmsys_update_bits API. Simplify code for update  mmsys reg.
> It is a preparation for adding support for mmsys config API.
> 
> Signed-off-by: Nancy.Lin <nancy.lin@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


