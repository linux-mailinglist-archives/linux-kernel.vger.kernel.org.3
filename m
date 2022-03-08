Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55CF04D0E78
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 04:48:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244577AbiCHDtD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 22:49:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235171AbiCHDtB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 22:49:01 -0500
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E6362F025
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 19:48:05 -0800 (PST)
Received: by mail-yb1-xb2a.google.com with SMTP id g1so35207638ybe.4
        for <linux-kernel@vger.kernel.org>; Mon, 07 Mar 2022 19:48:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SB1pR6R36cG/5vqUJ9L1OYX7dRask2g/0weyNuOkOYQ=;
        b=Aqt++puDVTDcltryRW77a9cwhFd1XciMKNs9AsjManml5e4eEQPtDOB/5nEXjsn+P9
         GkEs/gI5+4vK3gNMFYbQocu8XMlxE9wCZPPoS8OfoPNDIE6avBWb/hU6LMu1/Cf2whCu
         FFb8lEOczvnEeE5kzWcvCMw/ecWn+5SZxlX2s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SB1pR6R36cG/5vqUJ9L1OYX7dRask2g/0weyNuOkOYQ=;
        b=rshgSl9GrDwLcJ6OTeoyt6c8E96oCuznjV3g/CFk6CCIB3NHib/LdlXJP/Ux4F3pBb
         VFKphqnY/MF8YL7gS338Sf+avmPcDbqiXjjvu5tWUbLiGjfqhBsmDkB5o+hq0Z6szPRd
         lkBCBDuUCRUcZJqD1SmjPOHzUz+ZGa4yOJrrA3fWlCIhAihj4unxt1sWBNHV25rDwlb7
         tA+hMHqvzMMko5EvZyp7/QVMaoNCRtTXWfcTVCpZ+eYu3cgF8a3QIYCYnYkU06+paoQR
         oxhHKAI+1dISMfvdKyIYeBvT1s1FoPZORqn/zJWrcElZpqxiCwlCtFhLtGcy9s1zgSOL
         X1sw==
X-Gm-Message-State: AOAM530hgToXU2nCqBdp+Q4vIpdGbY0jnOH+qB5B1u/1mSGrRZGaMMcm
        NCFEwv0s2mUpm5NEupZco1HUMR7IxTrfHNI7CYEDAw==
X-Google-Smtp-Source: ABdhPJyuGeWIUlb3utDkOR1PhipoTjIrNi/Cf0gmscf2NmU/0KOasS7EzcBrtPdNSmwisXmV8F84klzvCTpKGd/lH2w=
X-Received: by 2002:a25:d449:0:b0:628:945d:713c with SMTP id
 m70-20020a25d449000000b00628945d713cmr11205541ybf.164.1646711284731; Mon, 07
 Mar 2022 19:48:04 -0800 (PST)
MIME-Version: 1.0
References: <20220307154558.2505734-1-robert.foss@linaro.org>
 <20220307154558.2505734-3-robert.foss@linaro.org> <CAG3jFytGV3NNfkEPqx_rZX9O9aZjTjzo2tpeSK8mFimOrYt9zw@mail.gmail.com>
In-Reply-To: <CAG3jFytGV3NNfkEPqx_rZX9O9aZjTjzo2tpeSK8mFimOrYt9zw@mail.gmail.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Tue, 8 Mar 2022 11:47:53 +0800
Message-ID: <CAGXv+5H7RvczEeAyLEmJ-RNAwqV1G71FhsG3Kpi0r+qPkXVaeQ@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] Revert "arm64: dts: mt8183: jacuzzi: Fix bus
 properties in anx's DSI endpoint"
To:     Robert Foss <robert.foss@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
Cc:     airlied@linux.ie, daniel@ffwll.ch, robh+dt@kernel.org,
        matthias.bgg@gmail.com, xji@analogixsemi.com, hsinyi@chromium.org,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 8, 2022 at 12:20 AM Robert Foss <robert.foss@linaro.org> wrote:
>
> Signed-off-by: Robert Foss <robert.foss@linaro.org>

Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>

I think we need to send this directly to the soc maintainers to get it
picked up before the final 5.17 release?

>
> On Mon, 7 Mar 2022 at 16:46, Robert Foss <robert.foss@linaro.org> wrote:
> >
> > This reverts commit 32568ae37596b529628ac09b875f4874e614f63f.
> > ---
> >  arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi.dtsi | 2 --
> >  1 file changed, 2 deletions(-)
> >
> > diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi.dtsi b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi.dtsi
> > index e8f133dc96b95..8f7bf33f607da 100644
> > --- a/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi.dtsi
> > +++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi.dtsi
> > @@ -171,8 +171,6 @@ port@0 {
> >
> >                         anx7625_in: endpoint {
> >                                 remote-endpoint = <&dsi_out>;
> > -                               bus-type = <5>;
> > -                               data-lanes = <0 1 2 3>;
> >                         };
> >                 };
> >
> > --
> > 2.32.0
> >
