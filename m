Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B600C57016A
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 13:58:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230050AbiGKL6a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 07:58:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230140AbiGKL61 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 07:58:27 -0400
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E41C232BB3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 04:58:21 -0700 (PDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-31c8a1e9e33so46184437b3.5
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 04:58:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Kb9KHIuo4IosRBw4fXiFNpYBgAtjRiuQdEYMHy61dYk=;
        b=uuzucqYoJK9QyuGI60SrzoVpti+2eBlJqaCC6sB9ZZJd08dlBVmeCukV4HfC6zZVhe
         1/X/qe6RzkOA/Q+PuOEA0auY09gTuarB3qd9dqHvZTDV3zFz2f++mKS7gh0uMHZz/QaB
         rrdn12qHtkuMmBtsPJc3r1Ohad2owVw1j4OQI2HRw1CbbNkim870g3cUO6VQ9Lvgm8Zp
         QTDX/2jmvmoB/kKzXTbrY19GS92XKmd/rAkm/4WYpC3ZXPJ+fS5EnaXEMj1SdT6sBWP8
         9j3WF8jB6rdPDEHdldwClYu2VKbdZQ6i0P2XBLQgjXq3lg+CzUXaBSMaFuhDmOqlGYB1
         yZPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Kb9KHIuo4IosRBw4fXiFNpYBgAtjRiuQdEYMHy61dYk=;
        b=Q857MgnqgD+i5Z2SA+ggLzMgT7I5aQimEsL/S4X564UoklnBp34z/MibWexkLA8Fm+
         dERzCDWUnBOq+MxOeg6lBu0tmEsPV9N/VOgFfdt3Oh0c2NTZQxrN6R4qP6Qhoj6s39iq
         z5wdzCLfJuYhK28lzPHMYGReU4fscLrHLtHclObuSGpD41GAXpTKyUyYiNmy/3INZCwO
         i4eas9Nb5Wg2VxAN9TbWBC0mIvFjwKhPkcQgkSI2KDQBLABfZedZ5v+TWeotCck61e5e
         sYV+nVU40PqcOwK59EXew9wwXTwcPhapFpBZ1GMKxiUJiJLvCo3N4dj/QMmnJoy/tgxq
         LGXA==
X-Gm-Message-State: AJIora+9LcblWIAxM4yXrZCYux75qW944Ym/jI/qzCmpRpNWFOm5IMSp
        q/Kos7SiNYCV+ifyiQ/7lfHemO3j1lDf2VTEHyqw/w==
X-Google-Smtp-Source: AGRyM1s/a3hRCOR5r59cRwkAhmMUw0kBr01CcqkFmETfUZZ7ZH7MngwVHzji1O6LK5sxiEbLLw+AGGSOXnjRa4RncAA=
X-Received: by 2002:a81:34c:0:b0:31c:8b37:6595 with SMTP id
 73-20020a81034c000000b0031c8b376595mr19493629ywd.126.1657540701119; Mon, 11
 Jul 2022 04:58:21 -0700 (PDT)
MIME-Version: 1.0
References: <20220630122334.216903-1-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220630122334.216903-1-angelogioacchino.delregno@collabora.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 11 Jul 2022 13:58:10 +0200
Message-ID: <CACRpkdbkpBwABmj31yY0GN++gvbaaox6=i7GkrRYu6ESROZzGg@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: pinctrl: mt8195: Fix name for mediatek,rsel-resistance-in-si-unit
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        matthias.bgg@gmail.com, sean.wang@mediatek.com,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        nfraprado@collabora.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 30, 2022 at 2:23 PM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:

> When this property was introduced, it contained underscores, but
> the actual code wants dashes.
>
> Change it from mediatek,rsel_resistance_in_si_unit to
> mediatek,rsel-resistance-in-si-unit.
>
> Fixes: 91e7edceda96 ("dt-bindings: pinctrl: mt8195: change pull up/down description")
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Patch applied!
Yours,
Linus Walleij
