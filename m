Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BB16539884
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 23:16:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347908AbiEaVQ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 17:16:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346313AbiEaVQY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 17:16:24 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B58C9CF1D;
        Tue, 31 May 2022 14:16:22 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: nfraprado)
        with ESMTPSA id E80101F43EB2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1654031781;
        bh=8X/Ojz+FGTuRQ5jA25wjSSQqOhrJ7O4PjLJxLYdEHMc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=C5pk1xLlV2Cr1FAMqGFilb/Mdlt3WOE36NolfY4TAmFMku/oWkJf7HgczZZRWt1tO
         ZlE97EuEn+7QBXGj+DbRrOmZVeg2oD8UG7kUmpiHYq1wMCShpc5aMPGum17UILhIZJ
         24qi0I2KwfZbHsq9+ui2+Y1ABYz7bxV+ynajL+XXwIKTJoJYPWzDc8NlfvmsLfF3H5
         NdYU4oFMOnAtvS2q0F1lObyhM/AzRd+5Wf5Khmq9735dYtfrDkSHirsk4McWvmQt+r
         aVy40nL/72wqdLolmjgKtECxrSzz1raE6ClsihfFPVqr+KOQBCDQCa5pSVz3Ms94wD
         szS+ElZvXeRZg==
Date:   Tue, 31 May 2022 17:16:16 -0400
From:   =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado 
        <nfraprado@collabora.com>
To:     Chen-Yu Tsai <wenst@chromium.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>, kernel@collabora.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sean Wang <sean.wang@mediatek.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v1 1/2] dt-bindings: pinctrl: mt8192: Add
 drive-strength-microamp
Message-ID: <20220531211616.vq73g6r4vrxxahqe@notapiano>
References: <20220525155714.1837360-1-nfraprado@collabora.com>
 <20220525155714.1837360-2-nfraprado@collabora.com>
 <CAGXv+5FRAvJpn-Nz08NLzqj+X+-yXLx6w-Bz7qa9g8Ct5xTNYg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGXv+5FRAvJpn-Nz08NLzqj+X+-yXLx6w-Bz7qa9g8Ct5xTNYg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 30, 2022 at 04:48:51PM +0800, Chen-Yu Tsai wrote:
> On Wed, May 25, 2022 at 11:58 PM Nícolas F. R. A. Prado
> <nfraprado@collabora.com> wrote:
> >
> > Commit e5fabbe43f3f ("pinctrl: mediatek: paris: Support generic
> > PIN_CONFIG_DRIVE_STRENGTH_UA") added support for using
> > drive-strength-microamp instead of mediatek,drive-strength-adv.
> >
> > Since there aren't any users of mediatek,drive-strength-adv on mt8192
> > yet, remove this property and add drive-strength-microamp in its place,
> > which has a clearer meaning.
> 
> Cool! Thanks for taking care of this~ I was looking at this and tried
> to make drive-strength and drive-strength-microamp mutually exclusive,
> but since they are optional, it didn't really work, and I put it on the
> back burner.

I didn't think of enforcing the properties to be mutually exclusive in the
dt-binding, but that is indeed a good idea. After a bit of head-scratching seems
like it is possible although unintuitive (by using 'required' inside the if
block). I'll send a v2 with this restriction added, and the same thing for patch
2, since bias-pull-up/down also shouldn't be used together with bias-disable.

Thanks,
Nícolas

> 
> 
> ChenYu
