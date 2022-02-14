Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE8CD4B5645
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 17:31:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356408AbiBNQbk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 11:31:40 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356432AbiBNQbf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 11:31:35 -0500
X-Greylist: delayed 2143 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 14 Feb 2022 08:31:26 PST
Received: from relay5.mymailcheap.com (relay5.mymailcheap.com [159.100.248.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22E7D2AE8
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 08:31:26 -0800 (PST)
Received: from relay3.mymailcheap.com (relay3.mymailcheap.com [217.182.119.155])
        by relay5.mymailcheap.com (Postfix) with ESMTPS id C5DDB267CE
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 16:31:24 +0000 (UTC)
Received: from filter1.mymailcheap.com (filter1.mymailcheap.com [149.56.130.247])
        by relay3.mymailcheap.com (Postfix) with ESMTPS id 9C68E3ECDF;
        Mon, 14 Feb 2022 17:31:22 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by filter1.mymailcheap.com (Postfix) with ESMTP id EB1BC2A037;
        Mon, 14 Feb 2022 16:31:21 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at filter1.mymailcheap.com
Received: from filter1.mymailcheap.com ([127.0.0.1])
        by localhost (filter1.mymailcheap.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 0qKU721WRsB0; Mon, 14 Feb 2022 16:31:20 +0000 (UTC)
Received: from mail20.mymailcheap.com (mail20.mymailcheap.com [51.83.111.147])
        (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by filter1.mymailcheap.com (Postfix) with ESMTPS;
        Mon, 14 Feb 2022 16:31:20 +0000 (UTC)
Received: from ice-e5v2.lan (unknown [59.41.163.244])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail20.mymailcheap.com (Postfix) with ESMTPSA id 240EE406EA;
        Mon, 14 Feb 2022 16:31:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=aosc.io; s=default;
        t=1644856280; bh=SXjwCWk3oSG3im+8gZm1YswbqCYyFuy3JQhG9lXT+a0=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=A+DUMKET/gco1tQQjy17WxpPKQN53qYG3s69VcWu0hwQBBFGwM27FMw353NmwgbAL
         gWu3PrCyI2ia2v0b0tQgk91AJK6Tn2mfAEVZrIQuWybBZvF7YYSlTjQTpbPdmuiasY
         pdpobKVhNKWhru5UfJV/RqlGOH4e7I0Cp8fqWiUA=
Message-ID: <c50c9c7f569914ef56c2c7bc975f7e46db394c65.camel@aosc.io>
Subject: Re: [PATCH] drm/nouveau/bios: Use HWSQ entry 1 for PowerBook6,1
From:   Icenowy Zheng <icenowy@aosc.io>
To:     Ilia Mirkin <imirkin@alum.mit.edu>
Cc:     Ben Skeggs <bskeggs@redhat.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        nouveau <nouveau@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
Date:   Tue, 15 Feb 2022 00:31:08 +0800
In-Reply-To: <CAKb7UvjRoS-z1f6a=p0TknPruZJBKmUEiAFOR9Ka5LgJ765Ybg@mail.gmail.com>
References: <20220214155518.2980270-1-icenowy@aosc.io>
         <CAKb7UvjRoS-z1f6a=p0TknPruZJBKmUEiAFOR9Ka5LgJ765Ybg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

在 2022-02-14星期一的 11:07 -0500，Ilia Mirkin写道：
> I'm not saying this is wrong, but could you file a bug at
> gitlab.freedesktop.org/drm/nouveau/-/issues and include the VBIOS
> (/sys/kernel/debug/dri/0/vbios.rom)? That would make it easier to
> review the full situation.

Created at https://gitlab.freedesktop.org/drm/nouveau/-/issues/158 .

> 
> On Mon, Feb 14, 2022 at 11:03 AM Icenowy Zheng <icenowy@aosc.io> wrote:
> > 
> > On PowerBook6,1 (PowerBook G4 867 12") HWSQ entry 0 (which is
> > currently
> > always used by nouveau) fails, but the BIOS declares 2 HWSQ entries
> > and
> > entry 1 works.
> > 
> > Add a quirk to use HWSQ entry 1.
> > 
> > Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> > ---
> >  drivers/gpu/drm/nouveau/nouveau_bios.c | 7 +++++++
> >  1 file changed, 7 insertions(+)
> > 
> > diff --git a/drivers/gpu/drm/nouveau/nouveau_bios.c
> > b/drivers/gpu/drm/nouveau/nouveau_bios.c
> > index e8c445eb11004..2691d0e0cf9f1 100644
> > --- a/drivers/gpu/drm/nouveau/nouveau_bios.c
> > +++ b/drivers/gpu/drm/nouveau/nouveau_bios.c
> > @@ -1977,6 +1977,13 @@ static int load_nv17_hw_sequencer_ucode(struct
> > drm_device *dev,
> >         if (!hwsq_offset)
> >                 return 0;
> > 
> > +#ifdef __powerpc__
> > +       /* HWSQ entry 0 fails on PowerBook G4 867 12" (Al) */
> > +       if (of_machine_is_compatible("PowerBook6,1"))
> > +               return load_nv17_hwsq_ucode_entry(dev, bios,
> > +                                                 hwsq_offset + sz,
> > 1);
> > +#endif
> > +
> >         /* always use entry 0? */
> >         return load_nv17_hwsq_ucode_entry(dev, bios, hwsq_offset +
> > sz, 0);
> >  }
> > --
> > 2.30.2
> > 


