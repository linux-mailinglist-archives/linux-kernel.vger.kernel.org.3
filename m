Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 526FD4FF8EF
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 16:29:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234367AbiDMOb3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 10:31:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234323AbiDMOb1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 10:31:27 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF9A456407
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 07:29:02 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id p10so2108694plf.9
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 07:29:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=W3hJGrmaAvxQ1Iq6K+QFDHPYd+AnBBrGQGYmAYimyFM=;
        b=Jws5h8+7lkW5dWJUO628L+BorIWyk9T5tBc726AJSWzLf5pJBLWUVKbwW6UOJukFGr
         waJ+8M/0jtPvdqefqOlUwzauP1OG5BnrNsmDCbbSlwK4hF/t16sPmj8ofalRaLbs+Zdw
         HlNmGZeBEtRx/Z18Lb5crO21/nhVD91XmaOpeYtJwKYVKsTGb8SBP4BdARSE1+TmbA45
         hwN1XewpTS2vSKhjD6MFZSWFShNGPmoS+bOZ/Kok9IOeqAHXJSpTKWx4L3TLcT05oTkF
         Y2kJxSTAJfQ1T1NnpOKijzutYmUy03NGxJNA3pPK/eSMUCrfe/Fbx1cZLfPl608iIEaN
         cMfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=W3hJGrmaAvxQ1Iq6K+QFDHPYd+AnBBrGQGYmAYimyFM=;
        b=hJVWE4H12kiwEWzjjrlmc7GihHi8QUGzm6xCIfZGRR7cKdrQ1RClyePZqvPkR5kCHU
         qlZEfkq4V1/s5wy5oNf8YpO61a/D2W9oLwDMdfG+ptw6qmfHayKENaLCNyd0kd+wUYjf
         IJVC4IHvjRWcd61oiaK93Qt0VlcYwYiBZEIC7Tf7B2NTkyULk4EMPU7j5HxB0pPC7ma7
         IEpFW99Lp67AJBNXqOeBPllUt7PDWZjuypOrv+o1w6xmtEZ+e5FmdkHtwJLBTkn614qn
         hyK9A36d2uUJKu0Mc3xAYDsnXduwr1rd9CoUH6glsaB8563y1e4qLusFRIG6e9ffN0Rd
         y0bg==
X-Gm-Message-State: AOAM532HzUBRX2EChjLg14XszhFK2oxdwFAT4XcUgndhk4b1GLiAcKjm
        SRzouC/h4Lr4ia3zRu5X7E2DSq0XzFg4MgIjR+h+MA==
X-Google-Smtp-Source: ABdhPJz3n3+dk2Krw4doJzCu1wCrOBh4/t9lU1aVQm4BPNjr3lisjMW5XOOnjfCrRT56oMgfkVfEXl3aKlZ/ZAOIbR4=
X-Received: by 2002:a17:902:c94c:b0:154:45c6:fbea with SMTP id
 i12-20020a170902c94c00b0015445c6fbeamr43212960pla.117.1649860142164; Wed, 13
 Apr 2022 07:29:02 -0700 (PDT)
MIME-Version: 1.0
References: <20220328120956.1848795-1-xji@analogixsemi.com>
 <20220328120956.1848795-3-xji@analogixsemi.com> <YkswTpDiPYfdIFtE@robh.at.kernel.org>
 <20220409044740.GA595530@anxtwsw-Precision-3640-Tower>
In-Reply-To: <20220409044740.GA595530@anxtwsw-Precision-3640-Tower>
From:   Robert Foss <robert.foss@linaro.org>
Date:   Wed, 13 Apr 2022 16:28:51 +0200
Message-ID: <CAG3jFyt1Srtn2aTFQ6b8Rxc6F_GCzU2mKxiEiWwgskMwHHjj5Q@mail.gmail.com>
Subject: Re: [PATCH 3/4] dt-bindings: drm/bridge: anx7625: Change bus-type to
 7 (DPI)
To:     Xin Ji <xji@analogixsemi.com>
Cc:     Rob Herring <robh@kernel.org>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, bliang@analogixsemi.com,
        qwen@analogixsemi.com, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Sat, 9 Apr 2022 at 06:47, Xin Ji <xji@analogixsemi.com> wrote:
>
> On Mon, Apr 04, 2022 at 12:52:14PM -0500, Rob Herring wrote:
> > On Mon, Mar 28, 2022 at 08:09:54PM +0800, Xin Ji wrote:
> > > Change bus-type define for DPI.
> > >
> > > Fixes: a43661e7e819 ("dt-bindings:drm/bridge:anx7625:add vendor define")
> > >
> > > Signed-off-by: Xin Ji <xji@analogixsemi.com>
> > > ---
> > >  .../devicetree/bindings/display/bridge/analogix,anx7625.yaml  | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/Documentation/devicetree/bindings/display/bridge/analogix,anx7625.yaml b/Documentation/devicetree/bindings/display/bridge/analogix,anx7625.yaml
> > > index 0d38d6fe3983..4590186c4a0b 100644
> > > --- a/Documentation/devicetree/bindings/display/bridge/analogix,anx7625.yaml
> > > +++ b/Documentation/devicetree/bindings/display/bridge/analogix,anx7625.yaml
> > > @@ -106,7 +106,7 @@ properties:
> > >                remote-endpoint: true
> > >
> > >                bus-type:
> > > -                enum: [1, 5]
> > > +                enum: [7]
> >
> > Changing is an ABI break, but didn't we revert adding this?
> Hi Rob, sorry, what do you mean about ABI break? Do I need remove this
> patch in this serial? Or do I need revert patch
> https://patchwork.freedesktop.org/patch/462331/, I don't know how to do
> it.
>

I contributed to the confusion about this, let's see if we can clear it up.

An issue was found related to which enum values were used to represent
what late in the last release cycle. As a result a revert[1] patch for
everything touching bus-type in anx7625 was merged.

This patch, does not apply to drm-misc-next due to the revert, and if
Xin Ji rebases his work on the drm-misc-next there should be no
ABI-change as this patch when fixed up will introduce bus-type to the
nax7625 ABI.

Xin: Does this make sense to you?

[1] https://cgit.freedesktop.org/drm/drm-misc/commit/?id=979452fbc43028675b5a5da156f91928b739dea8
