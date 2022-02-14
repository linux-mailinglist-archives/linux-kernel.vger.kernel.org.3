Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A47474B4B1F
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 11:40:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233702AbiBNKcn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 05:32:43 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346380AbiBNKaP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 05:30:15 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DED0370CC1;
        Mon, 14 Feb 2022 01:59:02 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 06CD51F43053
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1644832741;
        bh=OaINPsaheT6XUF0+hFr141uKFbMlStd2byNaS6I2GKs=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=fGemg3CLB1WP8e5KYjv0QDiN8sv7DuAdkLeRWz7Svak1RqzeSREYL4mIrBDLKFNAb
         i2cRTKJ+Gsl0Pj6yAAo8qxpzXg6Ns+FtuXmeFkOINlU+b3WDFaiFxijoiHtts1W0Gn
         uWqtFsbSGDqHe4VVhmjEgtxP+36lok5C8WKldI3eP3+GfKkddyCh9wxBIzZuqSb+Rv
         hRgNp3dTgwu0Tgsma0i7nNkgNMfhwK+7LRB+9XWbcJSlzebKyS+YfUIoEehQZVgjb9
         dlGDbTEeU9eeF/c6B6ZYYwdugaIaayKPqDdRn5tdOByWmUIE87AvmpiydgZko+gpak
         70qs8d1QAkefg==
Message-ID: <87db864e-fc74-189a-a665-bf51db8b5321@collabora.com>
Date:   Mon, 14 Feb 2022 10:58:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v4 1/3] dt-bindings: pinctrl: mt8186: add pinctrl file and
 binding document
Content-Language: en-US
To:     Guodong Liu <guodong.liu@mediatek.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sean Wang <sean.wang@kernel.org>
Cc:     Sean Wang <sean.wang@mediatek.com>, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20220214030631.4969-1-guodong.liu@mediatek.com>
 <20220214030631.4969-2-guodong.liu@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220214030631.4969-2-guodong.liu@mediatek.com>
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

Il 14/02/22 04:06, Guodong Liu ha scritto:
> 1. This patch adds pinctrl file for mt8186.
> 2. This patch adds mt8186 compatible node in binding document.
> 
> Signed-off-by: Guodong Liu <guodong.liu@mediatek.com>
> ---
>   .../bindings/pinctrl/pinctrl-mt8186.yaml      |  302 +++++
>   include/dt-bindings/pinctrl/mt8186-pinfunc.h  | 1174 +++++++++++++++++
>   2 files changed, 1476 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/pinctrl/pinctrl-mt8186.yaml
>   create mode 100644 include/dt-bindings/pinctrl/mt8186-pinfunc.h
> 
> diff --git a/Documentation/devicetree/bindings/pinctrl/pinctrl-mt8186.yaml b/Documentation/devicetree/bindings/pinctrl/pinctrl-mt8186.yaml
> new file mode 100644
> index 000000000000..582d131af4e3
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pinctrl/pinctrl-mt8186.yaml

...snip...

> diff --git a/include/dt-bindings/pinctrl/mt8186-pinfunc.h b/include/dt-bindings/pinctrl/mt8186-pinfunc.h
> new file mode 100644
> index 000000000000..dcff86201a61
> --- /dev/null
> +++ b/include/dt-bindings/pinctrl/mt8186-pinfunc.h
> @@ -0,0 +1,1174 @@
> +/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
> +/*
> + * Copyright (C) 2021 MediaTek Inc.
> + * Author: Guodong Liu <Guodong.Liu@mediatek.com>
> + *
> + */
> +

Hello,
I've just noticed that we have a typo here....

You wrote "MT8168", but this should be "MT8186" instead; please fix it.

P.S.: I'm sorry for not seeing that before!

> +#ifndef __MT8168_PINFUNC_H
> +#define __MT8168_PINFUNC_H
> +

..snip..

> +
> +#endif /* __MT8168-PINFUNC_H */

Thank you,
Angelo
