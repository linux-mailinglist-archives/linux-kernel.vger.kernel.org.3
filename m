Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF2F74F9277
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 12:02:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234175AbiDHKDs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 06:03:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234101AbiDHKDh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 06:03:37 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 493F7120AE;
        Fri,  8 Apr 2022 03:01:34 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 711501F46D05
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1649412093;
        bh=7NGSuo4Sc3q7d+xEOL+gCuZe8DYDWsEbLcdLWfuCj9I=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=JxcO36VmnJPCLOLcyirJ48rdA8J1Gy93FP8p7ew06GuDciO5pj3p+5yjfd/VgFyNf
         fB3zwg1o7CBqPqDV11/Jg3p2t0pqRD7WHS3NXe3476+ti6gJmpNqDXnDP8gcDi8xx+
         Nw/H5hhpQJnE6qKWQmWRCFuGxvVvc8IqB4H8K6y3KaxEeZh0sxet79Ye2cVJ79E6Cq
         HSSp6JCE8ML4aA0vKpze42X1qA1mHjF4LT2byKPpog94zHIypR2JiPYgvDy28RfKwP
         1WSEJB60U5gJRYxl8wPdrrpWJwRsjxiIxHS/VcJqFk++49D3SVnxhlefn9hEJfPwt2
         GFxXISHXBDiZQ==
Message-ID: <118239ae-e1c9-2f72-4a4f-26a5523755bb@collabora.com>
Date:   Fri, 8 Apr 2022 12:01:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [v10 4/4] ASoC: mediatek: mt8192: support rt1015p_rt5682s
Content-Language: en-US
To:     Jiaxin Yu <jiaxin.yu@mediatek.com>, broonie@kernel.org,
        robh+dt@kernel.org, nfraprado@collabora.com, tzungbi@google.com
Cc:     aaronyu@google.com, matthias.bgg@gmail.com, trevor.wu@mediatek.com,
        linmq006@gmail.com, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        Tzung-Bi Shih <tzungbi@kernel.org>
References: <20220408060552.26607-1-jiaxin.yu@mediatek.com>
 <20220408060552.26607-5-jiaxin.yu@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220408060552.26607-5-jiaxin.yu@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 08/04/22 08:05, Jiaxin Yu ha scritto:
> Add support for using the rt5682s codec together with rt1015p on
> mt8192-mt6359 machines. All configurations are shared with the rt5682
> codec variant, so simply select the SND_SOC_RT5682S config to ensure the
> codec is present and set the correct card name. The codec will be linked
> to by pointing to it in the headset-codec property in the devicetree.
> 
> While at it, also create macros for the names of the different codec
> variants supported by this driver, as well as rename occurrences of
> rt1015p_rt5682 to rt1015p_rt5682x, since they are shared between rt5682
> and rt5682s.
> 
> Signed-off-by: Jiaxin Yu <jiaxin.yu@mediatek.com>
> Reviewed-by: Tzung-Bi Shih <tzungbi@kernel.org>
> Reviewed-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> Tested-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>


Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
