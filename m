Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 076964CAB3D
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 18:12:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239550AbiCBRNR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 12:13:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234636AbiCBRNL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 12:13:11 -0500
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 567AB5595;
        Wed,  2 Mar 2022 09:12:26 -0800 (PST)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-2dbd8777564so26068887b3.0;
        Wed, 02 Mar 2022 09:12:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AvcFqOYltGy+0NWy8JBCis1x7cnlm0NXxI65Z4H9cuA=;
        b=YF7dFPct/RccQtzqMIZlbMgKl+DOMpfbkGMkkci+ZFO/QYDkK0opHy2/Gaonc1ZEaF
         gs5PxnqeR5Tle5f3kkNArSNvSbbphHdrZre6jVTGygh53B7+jua7CTQ6vP5idUVvH1go
         gtlXCOWQFPMT8SWzVRVhaHOhnktTI/5xjzS0CYeeLNgDj5nks3ZQPM9bD2hp0tjXbaiq
         BhfzFdrRjPBU5EbVLBlZfWPoRK8XdJQH9A9H38Gi+mAS10YQ9f5qrPlNI29ZUVKN26bo
         N2YMg5nNxffw1Pq3mfD2Bb1mHPob78PJa3jrR/hW78I7YVXSftkhIgSEeCkTO+oGRWmX
         /PHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AvcFqOYltGy+0NWy8JBCis1x7cnlm0NXxI65Z4H9cuA=;
        b=417+qRrUwpzYTBCf0q1sbyAde8njBGkcri/ZRLEkrGbXBd2P37bx0GUMLcnmPgeq2Z
         3Cb0RQ4GtRRcfKAVAPQhSZxcgVysKaAXUoij0ggbxdro2kYr1ntSOpCQiNWzmqJee+C0
         s0I0Uch6Y/TbKKLPvTAsvlP/SwVxBU60cHu61BIDmqArck1D6mFun0ydbrLbGzSnp1hn
         EnXAroufIzsLIPLIy/4c+vOyQXsq2K2x8cCodFuUmY254eT22+2HtSL9AJXmOVbXlnzZ
         FgsFK7IcxYmjgyXas1uMdOtJbfyw/3vDv2zMuxAG9GnsbAlPRCaMhYPNs5f88DwVojPu
         fy2g==
X-Gm-Message-State: AOAM532X++cjF1QqxTBAZ3N5vmI/WRROmDt1pAEAmXCwK4FkPD15ebaL
        2BSyJffrBEoBuGfcQfoeCx6RT4SR9kYJ6CWva3s=
X-Google-Smtp-Source: ABdhPJy69RwfdCCJC68UIsfdXRgP0PJVVpf3TFtA9o0oEVpIj8OY9p2dVyfF5kCHR5KWl1EEwNMj9doM+vj+bE3vShY=
X-Received: by 2002:a0d:fa01:0:b0:2d6:595d:81d4 with SMTP id
 k1-20020a0dfa01000000b002d6595d81d4mr31750715ywf.86.1646241145503; Wed, 02
 Mar 2022 09:12:25 -0800 (PST)
MIME-Version: 1.0
References: <20220302143427.447748-1-vkoul@kernel.org> <CAL_JsqJMZ8PHqJk6drNbNHprmfeV9UvJzJnech7sz_JwcdbckA@mail.gmail.com>
In-Reply-To: <CAL_JsqJMZ8PHqJk6drNbNHprmfeV9UvJzJnech7sz_JwcdbckA@mail.gmail.com>
From:   Peter Geis <pgwipeout@gmail.com>
Date:   Wed, 2 Mar 2022 12:12:13 -0500
Message-ID: <CAMdYzYoCeSKPQjUqigtP7GiAB8iDre9BRwVTqvmq_OA-N06NQw@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: Revert "dt-bindings: soc: grf: add naneng
 combo phy register compatible"
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        "open list:GENERIC PHY FRAMEWORK" <linux-phy@lists.infradead.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Johan Jonker <jbx6244@gmail.com>,
        Jianqun Xu <jay.xu@rock-chips.com>,
        Tobias Schramm <t.schramm@manjaro.org>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 2, 2022 at 12:04 PM Rob Herring <robh+dt@kernel.org> wrote:
>
> On Wed, Mar 2, 2022 at 8:34 AM Vinod Koul <vkoul@kernel.org> wrote:
> >
> > This reverts commit b3df807e1fb0 ("dt-bindings: soc: grf: add naneng
> > combo phy register compatible") as that was wrongly merged, so better to
> > drop the wrong patch
> >
> > Signed-off-by: Vinod Koul <vkoul@kernel.org>
> > ---
> > I am applying this to phy-next to fix the issue
>
> Reverting will just cause a different warning that it is undocumented.
> The fix in the other thread won't apply either if you revert.

Reverting and reapplying the original patch would work.
https://patchwork.kernel.org/project/linux-rockchip/patch/20220208091326.12495-2-yifeng.zhao@rock-chips.com/

>
> Rob
