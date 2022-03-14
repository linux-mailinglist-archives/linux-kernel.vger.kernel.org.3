Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2EF54D7FC7
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 11:25:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234825AbiCNK0p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 06:26:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238514AbiCNK0e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 06:26:34 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24B83434A3;
        Mon, 14 Mar 2022 03:25:25 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 489EC1F43511
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1647253524;
        bh=tyJL5hF65QyMph+7DtjWZYFL2Qzea5pUr0xp38Yx7bo=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=V5Yw7/epWa0vrRb9G9PpmchU0FQS3UJZEMSFlkQ7E00UWWSNLN4lPorRW9TM2ocGN
         uVREdeLNVzGlQ/4jcIgogV0YLO1c7Gq0P/Sop1BW+tj2o6ChKUh3P3IuMxRQziIMcw
         2JuhmTnipYck0SlM4Lqxyj21lmX/Hkz66nk5TeYulwWV0E6U7CCkts6hQw2g5geiaW
         XlY7XEAyoqXVCNBy9aoH+rTUqHf/zIvBJE/cszbI32FtWdVxqog3eqJgCorgfNQ84M
         d2UdP7OmBTFGOyaTxt6pMHGORHjmNuFz15VmVMLdqbl0ykfRxyoSWmJY4iejHGiqAU
         XLJHe/VM9FhEQ==
Message-ID: <aaa158d8-767b-8a6e-b708-4bfe60dcb67b@collabora.com>
Date:   Mon, 14 Mar 2022 11:25:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [v3 14/19] dt-bindings: mediatek: mt8186: add audio afe document
Content-Language: en-US
To:     Jiaxin Yu <jiaxin.yu@mediatek.com>, broonie@kernel.org,
        robh+dt@kernel.org
Cc:     aaronyu@google.com, matthias.bgg@gmail.com, trevor.wu@mediatek.com,
        tzungbi@google.com, julianbraha@gmail.com,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        Rob Herring <robh@kernel.org>
References: <20220313151023.21229-1-jiaxin.yu@mediatek.com>
 <20220313151023.21229-15-jiaxin.yu@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220313151023.21229-15-jiaxin.yu@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 13/03/22 16:10, Jiaxin Yu ha scritto:
> Add mt8186 audio afe document.
> 
> Signed-off-by: Jiaxin Yu <jiaxin.yu@mediatek.com>
> Reviewed-by: Rob Herring <robh@kernel.org>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

> ---
>   .../bindings/sound/mt8186-afe-pcm.yaml        | 175 ++++++++++++++++++
>   1 file changed, 175 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/sound/mt8186-afe-pcm.yaml
> 


