Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EACE5973CA
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 18:12:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240883AbiHQQKI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 12:10:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240892AbiHQQJq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 12:09:46 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAD939C2C9;
        Wed, 17 Aug 2022 09:09:35 -0700 (PDT)
Received: from notapiano (unknown [70.107.189.129])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 5EF6F660184A;
        Wed, 17 Aug 2022 17:09:32 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1660752574;
        bh=e/Of4jtD4ScJ5WePhgSWEAVJX0lhg7eBLY1bsDyCvTA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ctwVd0yGuilnyXL+Huj1WqffMGwtY9wmtAQMlBsoYakIjyqjlPw2XVzYVMaNNmauo
         VKPLLIeLzFSWdt0EYUhQ3NCV4Q2zanjViWw8aQlaaladQLlWDcWlF67VG4w7So7apY
         5r0FuSqQ34y+rjfKpboGh/PHS/ErUjzVLqCg3nEQwxeJmRD76riNuS3R6wCs6Us4iM
         Te7AQyuGVWUi32v7YVmRQ1Ix9SCBCbLtHKSfsBPNgzsQ9j3w8N8cmg0Jur8nmrPUFL
         YbFhhv14NXg1tQKH918xRqOF6Y8INxlbFf/f3IAPDvUrEkvTiww4C6CD/Q2ZcUPqKm
         4v8F+6Pe8AoXQ==
Date:   Wed, 17 Aug 2022 12:09:28 -0400
From:   =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado 
        <nfraprado@collabora.com>
To:     Allen-KH Cheng <allen-kh.cheng@mediatek.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        angelogioacchino.delregno@collabora.com,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        Chen-Yu Tsai <wenst@chromium.org>,
        Guodong Liu <guodong.liu@mediatek.com>
Subject: Re: [PATCH v2] dt-bindings: pinctrl: mt8186: Fix 'reg-names' for
 pinctrl nodes
Message-ID: <20220817160928.ppkjonuymr7rn4bu@notapiano>
References: <20220817052615.27153-1-allen-kh.cheng@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220817052615.27153-1-allen-kh.cheng@mediatek.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Allen,

On Wed, Aug 17, 2022 at 01:26:15PM +0800, Allen-KH Cheng wrote:
> The mt8186 contains 8 GPIO physical address bases that correspond to
> the 'reg-names' of the pinctrl driver. The 'reg-names' entries in
> bindings are ordered incorrectly, though. The system crashes due of an
> erroneous address when the regulator initializes.
> 
> We fix the 'reg-names' for the pinctrl nodes and the pinctrl-mt8186
> example in bindings.
> 
> Fixes: 338e953f1bd1 ("dt-bindings: pinctrl: mt8186: add pinctrl file and binding document")
> Signed-off-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>
> Signed-off-by: Guodong Liu <guodong.liu@mediatek.com>

The sender's (your) signed-off-by should come last [1]. Also, what is the
participation of Guodong in this patch? If Guodong helped in writing the patch
there should also be a Co-developed-by tag for Guodong, as shown in [1].

[1] https://www.kernel.org/doc/html/latest/process/submitting-patches.html#when-to-use-acked-by-cc-and-co-developed-by

> ---
[..]
> --- a/Documentation/devicetree/bindings/pinctrl/pinctrl-mt8186.yaml
> +++ b/Documentation/devicetree/bindings/pinctrl/pinctrl-mt8186.yaml
[..]
> @@ -232,12 +232,12 @@ examples:
>              <0x10002200 0x0200>,
>              <0x10002400 0x0200>,
>              <0x10002600 0x0200>,
> -            <0x10002A00 0x0200>,
> +            <0x10002a00 0x0200>,

Also, you should avoid making changes that don't have to do with the patch
itself. This patch is about fixing the reg names, so no need to touch the
formatting of addresses. It just adds noise.

Other than that,

Reviewed-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

Thanks,
Nícolas
