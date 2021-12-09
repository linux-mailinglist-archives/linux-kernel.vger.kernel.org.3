Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CCAF46EA87
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 16:03:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239134AbhLIPGm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 10:06:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238885AbhLIPGl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 10:06:41 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFB5DC061746
        for <linux-kernel@vger.kernel.org>; Thu,  9 Dec 2021 07:03:07 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 21AC61F46A88
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=collabora.com; s=mail;
        t=1639062186; bh=LS0EtBmRDedhXVuSLcQh/ApTJ6Q0/81sv/fT8nF/E2A=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=FVQCvQU/ydG/1xPks0xTHe4YTI6ldXkUGCqp/nhiwH+WXIcssx2UXBmo0ErJ1JUmV
         GZiwTWw7vbGlex5aQ8q7htE9wfnUc0jHc91QayQ145xc7ysgx5xNqQqO6fvvuTRmC3
         dMEQ1VNpaVBCtXYSmCls0iuC/6Go45BgAVf5nQxe095oaKDPZ45xf9J92aH7Yn3rQS
         bfIq3Q/PzcFJBoncX7fv7dGTTBIczrtI44xSzPXYDR680dFEk1xld1XkvkZaGcF7Xf
         tweztMKaS+EiqfKJRJsaitD/m1PFzG3kRO1RomKim+oLQt0Au8qO8Wi/7XeXRkUqqM
         BPT2t07WchLBw==
Subject: Re: [PATCH] ASoC: mediatek: assign correct type to argument
To:     Jiaxin Yu <jiaxin.yu@mediatek.com>, broonie@kernel.org,
        matthias.bgg@gmail.com, alsa-devel@alsa-project.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     tzungbi@google.com, trevor.wu@mediatek.com, yc.hung@mediatek.com,
        kernel test robot <lkp@intel.com>
References: <20211209073224.21793-1-jiaxin.yu@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Message-ID: <2733d82a-38f7-d5fc-416c-2bfe5dc91a12@collabora.com>
Date:   Thu, 9 Dec 2021 16:03:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211209073224.21793-1-jiaxin.yu@mediatek.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 09/12/21 08:32, Jiaxin Yu ha scritto:
> Fix the following sparse warning: (new ones prefixed by >>)
>>> sound/soc/mediatek/mt8192/mt8192-mt6359-rt1015-rt5682.c:370:33:
>       sparse: sparse: incorrect type in argument 3 (different base types)
>     sound/soc/mediatek/mt8192/mt8192-mt6359-rt1015-rt5682.c:370:33: sparse:
>       expected unsigned int to
>     sound/soc/mediatek/mt8192/mt8192-mt6359-rt1015-rt5682.c:370:33: sparse:
>       got restricted snd_pcm_format_t [usertype]
> 
> Correct discription of format, use S32_LE and S24_LE to distinguish the
> different 32bit.
> 
> Signed-off-by: Jiaxin Yu <jiaxin.yu@mediatek.com>
> Reported-by: kernel test robot <lkp@intel.com>
> Reviewed-by: Tzung-Bi Shih <tzungbi@google.com>


Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
