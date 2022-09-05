Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D33125ACE36
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 10:55:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237958AbiIEIxy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 04:53:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237920AbiIEIxm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 04:53:42 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BA0A3E740
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 01:53:41 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id 123so11843778ybv.7
        for <linux-kernel@vger.kernel.org>; Mon, 05 Sep 2022 01:53:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=/pV2O0LzRWD83l6/jD0rtHLxlqUObMDm7uvvnSIQmGc=;
        b=JKD28+KNbsLLTDcJUSuELgoPlKu5YIRp5QZSmrEOFawOF6K5/5DChQtAhhxGF8ONCn
         +QRJ7TgPO7CQOHuoeTcAfrnr2OigYoscUzd3BOTJwSVJdttD3w+6V4pkabYRKuQbiu6Y
         WW7VVU/LS8FX76Q3i45nCYnAd3FiYxTLpGEwoZ8GPZD4jXg7s/rl7x2tYCkzjRAhtXgF
         z/CbHtbJYrM8B5PERGv4gQZaJ2lJ9PoTPvPaYwYaDXEBXtg1w6CRbo4XY4+8HGBU4G/N
         UZ/uyEZSDfPrjimlDN9R8dw4mswE59Y7MnANy1BpyQxR9mEpTTeAOPakRIAOqpWD9jLN
         12Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=/pV2O0LzRWD83l6/jD0rtHLxlqUObMDm7uvvnSIQmGc=;
        b=f6B/FXFMbcnQJdY0Ho1zQq1duPRutD4bfm77rd5xRnDWoK7qh+Arpmn7CA0lm9896f
         x1uPjv9oAi+BZ/KZInTFnCQuP6DmlN148TNRYxECNEoAfTu0cJqZd6c9qjbHuJrjk0U4
         gX3v2Zha8SxM+TXbdqC8rMqyXm74tJB6BV/wE8d+9VjrPjGvH0/gEBqNPWyu8G8YxnEp
         Ogt7qOngc+nKYenlSNvGHS/Mor/e6HkzTnTKcpeAjQmX/R7pf19izrSc0nZsAuM0fFMp
         hfTuR7txD++uaKCWU78Uj1j4YCado5YcJ3+ofdwshVNzUklHxrpETZc7IbWWxGnY0GTv
         ePzA==
X-Gm-Message-State: ACgBeo36R28m57efOsDLbSATfhVyGydx3U+UbDIV78KvXj9pRFjkABFn
        48MW073k+7UDqnYWKmGeAVjqzna4teYCsoPaZYc=
X-Google-Smtp-Source: AA6agR5ZoT8N/kx3Hp+YXfHmKmfG/qcnkF+Mi6m8yvrs5x8843emp7V1dIC4jkLetItugqNAEs6WUpxoVUdeZuRVj2U=
X-Received: by 2002:a25:d087:0:b0:6a9:1991:d3fb with SMTP id
 h129-20020a25d087000000b006a91991d3fbmr3544564ybg.130.1662368020106; Mon, 05
 Sep 2022 01:53:40 -0700 (PDT)
MIME-Version: 1.0
References: <tencent_E1BBF05904DFB73C478DCD592740AAE0780A@qq.com>
 <CAJedcCxVW++iH49UFZp9ruUuTcNubWCH6Wsqe11K4COB3E8msg@mail.gmail.com>
 <CAJedcCw1eJqjSK+yR7eQMDheNtH3Mjm+viwt00xAhnmrfpq2pw@mail.gmail.com>
 <CAJedcCweHjD78F7iydiq6Xc2iH=t_3m=H9JKnaCooToUk32FvQ@mail.gmail.com> <YxWtfjfpNsoPUrgh@kroah.com>
In-Reply-To: <YxWtfjfpNsoPUrgh@kroah.com>
From:   Alex Young <alex000young@gmail.com>
Date:   Mon, 5 Sep 2022 16:53:28 +0800
Message-ID: <CAFC++j0_11fpgGaAdDsQUyTzCG8KU0cO1ufMYFzACWquJALuZg@mail.gmail.com>
Subject: Re: [PATCH] drm/i915/gvt: fix double-free bug in split_2MB_gtt_entry.
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Zheng Hacker <hackerzheng666@gmail.com>,
        xmzyshypnc <1002992920@qq.com>, airlied@linux.ie,
        daniel@ffwll.ch, zhenyuw@linux.intel.com, zhi.a.wang@intel.com,
        jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
        rodrigo.vivi@intel.com, tvrtko.ursulin@linux.intel.com,
        intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, security@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for your reply.

We think that when intel_gvt_dma_map_guest_page() fails,
ppgtt_invalidate_spt is called to handle this error.

If the ppgtt_invalidate_spt is successful to kfree the spt object,
then in the ppgtt_populate_spt function there  is no need to kfree the
spt again.

And if the ppgtt_invalidate_spt failed, then in the ppgtt_populate_spt
function there is need to kfree the spt for error handling.

This is our fix, if it's not right, we are glad to discuss with you.

Greg KH <gregkh@linuxfoundation.org> =E4=BA=8E2022=E5=B9=B49=E6=9C=885=E6=
=97=A5=E5=91=A8=E4=B8=80 16:04=E5=86=99=E9=81=93=EF=BC=9A
>
> On Mon, Sep 05, 2022 at 03:46:09PM +0800, Zheng Hacker wrote:
> > I rewrote the letter. Hope it works.
> >
> > There is a double-free security bug in split_2MB_gtt_entry.
> >
> > Here is a calling chain :
> > ppgtt_populate_spt->ppgtt_populate_shadow_entry->split_2MB_gtt_entry.
> > If intel_gvt_dma_map_guest_page failed, it will call
> > ppgtt_invalidate_spt, which will finally call ppgtt_free_spt and
> > kfree(spt). But the caller does not notice that, and it will call
> > ppgtt_free_spt again in error path.
> >
> > Fix this by returning the result of ppgtt_invalidate_spt to split_2MB_g=
tt_entry.
> >
> > Signed-off-by: Zheng Wang
> >
> > ---
> >  drivers/gpu/drm/i915/gvt/gtt.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/i915/gvt/gtt.c b/drivers/gpu/drm/i915/gvt/=
gtt.c
> > index ce0eb03709c3..9f14fded8c0c 100644
> > --- a/drivers/gpu/drm/i915/gvt/gtt.c
> > +++ b/drivers/gpu/drm/i915/gvt/gtt.c
> > @@ -1215,7 +1215,7 @@ static int split_2MB_gtt_entry(struct intel_vgpu =
*vgpu,
> >                 ret =3D intel_gvt_dma_map_guest_page(vgpu, start_gfn + =
sub_index,
> >                                                    PAGE_SIZE, &dma_addr=
);
> >                 if (ret) {
> > -                       ppgtt_invalidate_spt(spt);
> > +                       ret =3D ppgtt_invalidate_spt(spt);
> >                         return ret;
>
> But now you just lost the original error, shouldn't this succeed even if
> intel_gvt_dma_map_guest_page() failed?
>
> And how are you causing intel_gvt_dma_map_guest_page() to fail in a real
> system?
>
> thanks,
>
> greg k-h
