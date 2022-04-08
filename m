Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 987C54F9272
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 12:01:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234121AbiDHKDi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 06:03:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234084AbiDHKDc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 06:03:32 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2873E26558;
        Fri,  8 Apr 2022 03:01:27 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 2C7A21F46D05
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1649412085;
        bh=H48V/pdViwo1p4zdgSuQJNP0nt+xojqU1ZySQizv8TA=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=e+OwaoM0/W425yMTI5CiDoCZ2qF4wxgsbTPnDsjRfoWZspx1u5BLH7u3Km871jNEG
         L4cybVNSOkyyskB9p5pTI6tNLYKQ59q48+IlDyI3qQC2cagfvteklRJBKrPSYYPGrU
         ojvfbobYyK6exslPlXMMBsNKap1o9DbsBJAur0vvYCBkmKzcBpx4FqPLC+/rks8On/
         8oOlFArZ9jrqzgnvekz0cXfpXd4s/kxsys1/yhytnzSdA0L2p3y39IG4uv7I+avuq7
         7yOVOw3jLdlMWZ4iDOMmkadY3qhb7seD+TMjw/3uO11aGeME37oS+sZpJaE3zBK89B
         k11ozMdvSfgNA==
Message-ID: <90bea01f-aad1-6150-4d51-0c51bcb48d09@collabora.com>
Date:   Fri, 8 Apr 2022 12:01:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [v10 2/4] ASoC: mediatek: mt8192: refactor for I2S3 DAI link of
 speaker
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
 <20220408060552.26607-3-jiaxin.yu@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220408060552.26607-3-jiaxin.yu@mediatek.com>
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
> rt1015(p) codecs from the speaker-codecs property in the devicetree and
> wire them to the I2S3 backend, instead of hardcoding the links and
> selecting through the compatible.
> 
> Signed-off-by: Jiaxin Yu <jiaxin.yu@mediatek.com>
> Reviewed-by: Tzung-Bi Shih <tzungbi@kernel.org>
> Reviewed-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> Tested-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

