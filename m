Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64607504CA9
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 08:32:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236794AbiDRGe3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 02:34:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231245AbiDRGe1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 02:34:27 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C066C18E21
        for <linux-kernel@vger.kernel.org>; Sun, 17 Apr 2022 23:31:49 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id f38so24140321ybi.3
        for <linux-kernel@vger.kernel.org>; Sun, 17 Apr 2022 23:31:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=a5//32PVRH4DcQnv6kHRa806XtetNIhG8fCqBfNSSJs=;
        b=f0BznFeVGD83lSwWWGcinsPJjC7Wzat6bDrnUNkVXT/aJYh2ONJHwOo9cvRTb7aDNl
         lW1+xBOInbLn/zzi5Ihi5ekWZD9H/QRffjeBMxlBZChb0neixnM/tojfM87/1exPJisy
         E7AnI5sAvtzoYnDc2pqP5gcqON17hWnMtbckE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=a5//32PVRH4DcQnv6kHRa806XtetNIhG8fCqBfNSSJs=;
        b=kezkq360HE2RItfUZDaFTZs77MuGLIXI1XAoA4SpO1d1re9/Ymx1+a7GJLP/V4OjR5
         rY6Jes6Jmgtcp6lGreWsKXtAKEfif3nXbY4uYUuXkVUsxGOnG2GAywBwd7N2UxEQNb36
         QOjdixiESXwqSf8cOrIR1Xx8sr6c+zMx0HepC/8HwHRCJoMUQmIifqKcBDrXP4zQ/gsu
         RzjYCKShzELd0+BkBvT4od6kyP+qPWVaPa+RYH9fs9wHtQdPir2RMduncQRsDKGf/u+c
         wxQr1gG+ygrnMArTHxgUcCq+PYV5sKQZfBJZXrSLwvRLkCXW0ZsimdoJ85bpUn3gzjgc
         EnqQ==
X-Gm-Message-State: AOAM530V8phyAZmB9oIRudKsnHQEoiSDc8dtpjJei3s9N/QXjbDdrk06
        PsoCVCWBDAQZhM+tuG+r2yIYC95Dfu67oDgyFM+xPaFQBgEPdg==
X-Google-Smtp-Source: ABdhPJwXobB5o6QFfFdjRXteJBihb/U5G3fs0zlNBqiQCrA0zUqMQjYkLesIDylCJpkV8h8NHMX12IpuelBIRiuI/No=
X-Received: by 2002:a25:dbd3:0:b0:641:56d3:dbe2 with SMTP id
 g202-20020a25dbd3000000b0064156d3dbe2mr8223010ybf.203.1650263509024; Sun, 17
 Apr 2022 23:31:49 -0700 (PDT)
MIME-Version: 1.0
References: <20220328120956.1848795-1-xji@analogixsemi.com>
 <20220328120956.1848795-3-xji@analogixsemi.com> <YkswTpDiPYfdIFtE@robh.at.kernel.org>
 <20220409044740.GA595530@anxtwsw-Precision-3640-Tower> <CAG3jFyt1Srtn2aTFQ6b8Rxc6F_GCzU2mKxiEiWwgskMwHHjj5Q@mail.gmail.com>
 <20220414022655.GA606685@anxtwsw-Precision-3640-Tower>
In-Reply-To: <20220414022655.GA606685@anxtwsw-Precision-3640-Tower>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Mon, 18 Apr 2022 14:31:38 +0800
Message-ID: <CAGXv+5EXpfVQCSUwgMP2fGf6ZPzvTuZxYbLB+F=cOKH4op0o3Q@mail.gmail.com>
Subject: Re: [PATCH 3/4] dt-bindings: drm/bridge: anx7625: Change bus-type to
 7 (DPI)
To:     Xin Ji <xji@analogixsemi.com>
Cc:     Robert Foss <robert.foss@linaro.org>,
        dri-devel@lists.freedesktop.org, Jonas Karlman <jonas@kwiboo.se>,
        David Airlie <airlied@linux.ie>, qwen@analogixsemi.com,
        Neil Armstrong <narmstrong@baylibre.com>,
        linux-kernel@vger.kernel.org,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        devicetree@vger.kernel.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        bliang@analogixsemi.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Apr 14, 2022 at 10:27 AM Xin Ji <xji@analogixsemi.com> wrote:
>
> On Wed, Apr 13, 2022 at 04:28:51PM +0200, Robert Foss wrote:
> > On Sat, 9 Apr 2022 at 06:47, Xin Ji <xji@analogixsemi.com> wrote:
> > >
> > > On Mon, Apr 04, 2022 at 12:52:14PM -0500, Rob Herring wrote:
> > > > On Mon, Mar 28, 2022 at 08:09:54PM +0800, Xin Ji wrote:
> > > > > Change bus-type define for DPI.
> > > > >
> > > > > Fixes: a43661e7e819 ("dt-bindings:drm/bridge:anx7625:add vendor d=
efine")
> > > > >
> > > > > Signed-off-by: Xin Ji <xji@analogixsemi.com>
> > > > > ---
> > > > >  .../devicetree/bindings/display/bridge/analogix,anx7625.yaml  | =
4 ++--
> > > > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > > >
> > > > > diff --git a/Documentation/devicetree/bindings/display/bridge/ana=
logix,anx7625.yaml b/Documentation/devicetree/bindings/display/bridge/analo=
gix,anx7625.yaml
> > > > > index 0d38d6fe3983..4590186c4a0b 100644
> > > > > --- a/Documentation/devicetree/bindings/display/bridge/analogix,a=
nx7625.yaml
> > > > > +++ b/Documentation/devicetree/bindings/display/bridge/analogix,a=
nx7625.yaml
> > > > > @@ -106,7 +106,7 @@ properties:
> > > > >                remote-endpoint: true
> > > > >
> > > > >                bus-type:
> > > > > -                enum: [1, 5]
> > > > > +                enum: [7]
> > > >
> > > > Changing is an ABI break, but didn't we revert adding this?
> > > Hi Rob, sorry, what do you mean about ABI break? Do I need remove thi=
s
> > > patch in this serial? Or do I need revert patch
> > > https://nam10.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fp=
atchwork.freedesktop.org%2Fpatch%2F462331%2F&amp;data=3D04%7C01%7Cxji%40ana=
logixsemi.com%7C10f5b0213f434592936008da1d59f566%7Cb099b0b4f26c4cf59a0fd5be=
9acab205%7C0%7C0%7C637854569490105386%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wL=
jAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=3DvK=
0Vmb9S425kHZc1WurfnNhnoXDMbUGkkdY1PVnfS9g%3D&amp;reserved=3D0, I don't know=
 how to do
> > > it.
> > >
> >
> > I contributed to the confusion about this, let's see if we can clear it=
 up.
> >
> > An issue was found related to which enum values were used to represent
> > what late in the last release cycle. As a result a revert[1] patch for
> > everything touching bus-type in anx7625 was merged.
> >
> > This patch, does not apply to drm-misc-next due to the revert, and if
> > Xin Ji rebases his work on the drm-misc-next there should be no
> > ABI-change as this patch when fixed up will introduce bus-type to the
> > nax7625 ABI.
> >
> > Xin: Does this make sense to you?
> Hi Robert Foss, yes, my work is based on drm-misc-next, all I can do,
> just make a fix up patch(this patch) to change the bus-type define.

The revert was applied to the soc tree and merged into Linus's tree
in v5.17-rc8. It was not present in drm-misc-next until April 5 with
commit 9cbbd694a58b ("Merge drm/drm-next into drm-misc-next").

So please fetch the latest drm-misc-next, rebase your patches on top, and
resend.


Thanks
ChenYu
