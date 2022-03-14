Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31F244D8F7A
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 23:23:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245554AbiCNWYU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 18:24:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245547AbiCNWYS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 18:24:18 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 772802BEB;
        Mon, 14 Mar 2022 15:23:05 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 9FAC85C0227;
        Mon, 14 Mar 2022 18:23:02 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Mon, 14 Mar 2022 18:23:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=KlJ4W3E/DZOai3ong
        DezQFkkKLCDtgk7PVp0U2t4V50=; b=SC2huqwNWLs+eBuNLQbAIEIxtLVpN+1YP
        /XrG0bt9WkKq+OdXmTWQLBxchn8ukNIOBn1YMPUJ2SUBH8kpXcReVS+5GjfImh4s
        oYpLDD6nFRpQvEU9DS5WMzBpx3YLkg+mGsKR2I/nNq3ubXr6ImCriLAXGxH/z4uJ
        R9jJWbbNje+gkrPTd53cBZ/5zzV6OllMIi+JXEcnQ0aEI0klmuurW3jE+0jNRuF7
        C9LXI1+1ncc18GHKm/gn4TZoA0iyoAC9H0T/e+yjqYVmqIRoFqF0UWTLVYjyZ+9n
        8HOQ70zHZWmXbtbtI62Wy6nGJe37iBAsmhWMBgwc+fgrdbpmem6EQ==
X-ME-Sender: <xms:RcAvYqOnntmGsLDHkTJBITBQ8g1rKc8S27w6Z1IyG00OVVl3DIseOg>
    <xme:RcAvYo_uY1-23_86C9ckEdPdmrsqB9K13Go3l63qlrF_NJ-tvbuwAV78OnyMBk4Vc
    ZmTDS3oUtJcnNX1K9w>
X-ME-Received: <xmr:RcAvYhRlFUt9Ey2Rn5yMZm_aEEf7zq6fIJjkOIzp3dm3DxV5_-JcUjPaStVfy8OC06A-49yRFhvqd9aVhyT9M2SPHW_xZUgmL2c>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddruddvkedgudehkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvufgjkfhfgggtsehttdertddttddvnecuhfhrohhmpefhihhnnhcu
    vfhhrghinhcuoehfthhhrghinheslhhinhhugidqmheikehkrdhorhhgqeenucggtffrrg
    htthgvrhhnpefftdejfeejudejvdeuveffvdeuieegiefhudfhffejueeuvedvvdevvdeu
    hedtueenucffohhmrghinhepkhgvrhhnvghlrdhorhhgpdgtohhmphhuthhinhhghhhish
    htohhrhidrohhrghdruhhkpdhotghtohhprghrthdrtghomhenucevlhhushhtvghrufhi
    iigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehfthhhrghinheslhhinhhugidqmh
    eikehkrdhorhhg
X-ME-Proxy: <xmx:RcAvYqttP_zBb3tKznwJLsmHpM_KxwlN7CowEepi02Eva_E8eyfvcA>
    <xmx:RcAvYicYcQPSbvd2lmhBz3eFY-_sJBrtVUlW_Nj5Y7rk5H0cTaVtQg>
    <xmx:RcAvYu3utKmSl1wpY7eM53HOmJKhM7hf9spkEUlG2lwDz7TA5aWbYQ>
    <xmx:RsAvYu2WyOKV1exmia410TrkEb1HBifzJDC-BLwaF54rGU9GxF_w7Q>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 14 Mar 2022 18:22:59 -0400 (EDT)
Date:   Tue, 15 Mar 2022 09:15:08 +1100 (AEDT)
From:   Finn Thain <fthain@linux-m68k.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
cc:     Pekka Paalanen <ppaalanen@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Sam Ravnborg <sam@ravnborg.org>, Helge Deller <deller@gmx.de>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        Linux/m68k <linux-m68k@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 05/10] drm/fourcc: Add DRM_FORMAT_C[124]
In-Reply-To: <CAMuHMdVj8wxAVbcov1wFsgt_knMkcySBH8nMoKjyr=G+mLQmjQ@mail.gmail.com>
Message-ID: <1f915fcc-1d95-99d1-c7b7-dc4e3b49e09f@linux-m68k.org>
References: <cover.1646683502.git.geert@linux-m68k.org> <8d3c0cc370b0214244b01a64c588e5e506531716.1646683502.git.geert@linux-m68k.org> <CAMuHMdVq19wpA_7nKKTm-G2EmK3cMxxP6nbR_u=vkazqCZ=KhQ@mail.gmail.com> <20220314170539.17400f93@eldfell>
 <CAMuHMdVj8wxAVbcov1wFsgt_knMkcySBH8nMoKjyr=G+mLQmjQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert,

On Mon, 14 Mar 2022, Geert Uytterhoeven wrote:

> On Mon, Mar 14, 2022 at 4:05 PM Pekka Paalanen <ppaalanen@gmail.com> wrote:
> > On Mon, 14 Mar 2022 14:30:18 +0100
> > Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > > On Mon, Mar 7, 2022 at 9:53 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > > > Introduce fourcc codes for color-indexed frame buffer formats with 
> > > > two, four, and sixteen colors, and provide a mapping from bit per 
> > > > pixel and depth to fourcc codes.
> > > >
> > > > As the number of bits per pixel is less than eight, these rely on 
> > > > proper block handling for the calculation of bits per pixel and 
> > > > pitch.
> > > >
> > > > Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> > >
> > > > --- a/include/uapi/drm/drm_fourcc.h
> > > > +++ b/include/uapi/drm/drm_fourcc.h
> > > > @@ -99,7 +99,10 @@ extern "C" {
> > > >  #define DRM_FORMAT_INVALID     0
> > > >
> > > >  /* color index */
> > > > -#define DRM_FORMAT_C8          fourcc_code('C', '8', ' ', ' ') /* [7:0] C */
> > > > +#define DRM_FORMAT_C1          fourcc_code('C', '1', ' ', ' ') /* [7:0] C0:C1:C2:C3:C4:C5:C6:C7 1:1:1:1:1:1:1:1 eight pixels/byte */
> > > > +#define DRM_FORMAT_C2          fourcc_code('C', '2', ' ', ' ') /* [7:0] C0:C1:C2:C3 2:2:2:2 four pixels/byte */
> > > > +#define DRM_FORMAT_C4          fourcc_code('C', '4', ' ', ' ') /* [7:0] C0:C1 4:4 two pixels/byte */
> > > > +#define DRM_FORMAT_C8          fourcc_code('C', '8', ' ', ' ') /* [7:0] C 8 one pixel/byte */
> > > >
> > > >  /* 8 bpp Red */
> > > >  #define DRM_FORMAT_R8          fourcc_code('R', '8', ' ', ' ') /* [7:0] R */
> > >
> > > After replying to Ilia's comment[1], I realized the CFB drawing
> > > operations use native byte and bit ordering, unless
> > > FBINFO_FOREIGN_ENDIAN is set.
> > > While Amiga, Atari, and Sun-3 use big-endian bit ordering,
> > > e.g. Acorn VIDC[2] uses little endian, and SH7760[3] is configurable
> > > (sh7760fb configures ordering to match host order).
> > > BTW, ssd130{7fb,x}_update_rect() both assume little-endian, so I
> > > guess they are broken on big-endian.
> > > Fbtest uses big-endian bit ordering, so < 8 bpp is probably broken
> > > on little-endian.
> > >
> > > Hence the above should become:
> > >
> > >     #define DRM_FORMAT_C1          fourcc_code('C', '1', ' ', ' ') /*
> > > [7:0] C7:C6:C5:C4:C3:C2:C1:C0 1:1:1:1:1:1:1:1 eight pixels/byte */
> > >     #define DRM_FORMAT_C2          fourcc_code('C', '2', ' ', ' ') /*
> > > [7:0] C3:C2:C1:C0 2:2:2:2 four pixels/byte */
> > >     #define DRM_FORMAT_C4          fourcc_code('C', '4', ' ', ' ') /*
> > > [7:0] C1:C0 4:4 two pixels/byte */
> > >
> > > The same changes should be made for DRM_FORMAT_[RD][124].
> > >
> > > The fbdev emulation code should gain support for these with and without
> > > DRM_FORMAT_BIG_ENDIAN, the latter perhaps only on big-endian platforms?
> > >
> > > [1] https://lore.kernel.org/r/CAKb7UvgEdm9U=+RyRwL0TGRfA_Qc7NbhCWoZOft2DKdXggtKYw@mail.gmail.com/
> > > [2] See p.30 of the VIDC datasheet
> > >     http://chrisacorns.computinghistory.org.uk/docs/Acorn/Misc/Acorn_VIDC_Datasheet.pdf
> > > [3] See p.1178 of the SH7660 datasheet
> > >     https://datasheet.octopart.com/HD6417760BL200AV-Renesas-datasheet-14105759.pdf
> >
> > why would CPU endianess affect the order of bits in a byte?
> 
> It doesn't, but see below.
> 
> > Do you mean that bit 0 one machine is (1 << 0), and on another machine
> > bit 0 is (1 << 7)?
> 
> No, I mean that in case of multiple pixels per byte, the display
> hardware pumps out pixels to the CRTC starting from either the MSB
> or the LSB of the first display byte.  Which order depends on the
> display hardware, not on the CPU.
> 
> > In C, we have only one way to address bits of a byte and that is with
> > arithmetic. You cannot take the address of a bit any other way, can you?
> >
> > Can we standardise on "bit n of a byte is addressed as (1 << n)"?
> 
> BIT(n) in Linux works the same for little- and big-endian CPUs.
> But display hardware may use a different bit order.
> 

Perhaps some of this confusion could be avoided if you describe the 
problem in terms of the sequence of scan-out of pixels, rather than in 
terms of the serialization of bits. The significance of bits within each 
pixel and the ordering of pixels within each memory word are independent, 
right?
