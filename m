Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BE184F9274
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 12:01:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234164AbiDHKDn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 06:03:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231820AbiDHKDg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 06:03:36 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F0FE25D;
        Fri,  8 Apr 2022 03:01:32 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 5045B1F46D04
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1649412091;
        bh=FqAvt8ypfsA4NVC3NbXVr4Xzdu/Pk9xlB69DZ7giK+I=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=QPIy9xooIHcG5c9g9Fx6s0BO7NaFy/BEHV7pyH2cPBuyyl/xQ5oRBeR/kaR1xy4kO
         xQcw5RhPJc65peVUt+wiM7WB/aFJlSy5dHF/u7GzjT8JIadxaKQZpzc8cuBYHIFXIe
         m6eEkdwhRCGZY9rRs3cYPOEJgROePqI/3gMfBw7grVIwmSupEo+S0eAn2rrmF3Nr3T
         mli8YOjg/vLkAc5u1wOpRwZ0oEHDiJ1/Xkd/9nRq+sTHXgs4pcLddp2pGufVB8DZo8
         tlQ6hCgRNaD2HXk6E/PDxk8jKjnLKOcFmsLJ4Rsl6904IL5jcZeHyzo8Q8baVFbJDh
         Xu7W/pSB5kcNw==
Message-ID: <ca885fc0-d67a-b2f7-454b-c8e65ee5ce1d@collabora.com>
Date:   Fri, 8 Apr 2022 12:01:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [v10 3/4] ASoC: mediatek: mt8192: refactor for I2S8/I2S9 DAI
 links of headset
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
 <20220408060552.26607-4-jiaxin.yu@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220408060552.26607-4-jiaxin.yu@mediatek.com>
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
> As part of the refactoring to allow the same machine driver to be used for
> the rt1015(p) and rt5682(s) codecs on the MT8192 platform, parse the
> rt5682(s) codec from the headset-codec property in the devicetree and wire
> it to the I2S8 and I2S9 backends.
> 
> Signed-off-by: Jiaxin Yu <jiaxin.yu@mediatek.com>
> Reviewed-by: Tzung-Bi Shih <tzungbi@kernel.org>
> Reviewed-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> Tested-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>


Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
