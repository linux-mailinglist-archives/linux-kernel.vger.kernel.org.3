Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01A935B1816
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 11:10:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230214AbiIHJKO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 05:10:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230377AbiIHJKC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 05:10:02 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B38CB2A701
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 02:09:53 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id a70so7219720edf.10
        for <linux-kernel@vger.kernel.org>; Thu, 08 Sep 2022 02:09:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=lIbJZPrjKHbLawmYplyVNe7T2V7IAHLU3wOIAk3SPCY=;
        b=RT+flP0e20Rx7yTxlmK9baTqcO82+tmfKOPfqBKdIRim1kuv2l5wG7AvUxae21EMrY
         aPM3rLDM1YwhXFHONho8nS/0Ht2/vT6JQoosjBPJ7O8E8/1s+aEOhswoX5qNJJ/+1uBW
         wDFjxZPtUi7ntvzOZokxfF1DhhsWJZwj4IpQdHMwteY37NIGSCmVecKvBKqSE3l0Cxnc
         PgVv7aSHWME2t/yil0Kh6zQQ7fDmF5iGtbw7jZtdYWWLAD9xElcto3OZ76NCRCApSXnJ
         oG6Vym5ika/fBRsJHYmEVbs9/gwbAgLSzOf5V5aRHq/a/Kp+91DiWZQ7jZ4ZBCuf9PR5
         AN+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=lIbJZPrjKHbLawmYplyVNe7T2V7IAHLU3wOIAk3SPCY=;
        b=UJnHHD/OqODb+k1SwASoYBGu535ZixT9/niZ3AqHBvwwoU38G9zScuAyVZtGo2rjEX
         aOekoPNJyKLMBUs7jIhghMPjFqFr0U4789mfLI1m9cVtu2bvv6KLUkPn5T2bAPmktzdf
         MnTpQgLHbcpxEbkYfs04L9fto5Pm2YRxAoUIBSEgjRCRTtHWZwhmIq1Klex8zo5aAWFK
         vZj0qyuJvaKwqP46p5tP1rz/NhtcFNjMzdvcPNf4zjZ+xqZxtQTcca+ZjZ8+ar4E+QQK
         UpdbMjDa0XcfXihdGUVdGaKNxDrIq5Q4aOCSTIIIQBNl0ZEK4o8nCOVG6RyogY6ET7n/
         abQw==
X-Gm-Message-State: ACgBeo0/ZKd44IXRo2df8en9nh83RvrBLKxIzCIHYbggf+t50UTsP4Ia
        QPkigslTTCVSkfSFVOCplyWQHfs4D48sKP8FbWUzJoRjqKXB25pB
X-Google-Smtp-Source: AA6agR4rF+e76GoR10h7poG0rnV0jc8VwRLn3xcHPhyxPnOYp5ls2vp7gGVf1IgI4ex50/LcAbEdsgjEEJYKKK4evkE=
X-Received: by 2002:aa7:df87:0:b0:44e:2851:7e8d with SMTP id
 b7-20020aa7df87000000b0044e28517e8dmr6390046edy.106.1662628192118; Thu, 08
 Sep 2022 02:09:52 -0700 (PDT)
MIME-Version: 1.0
References: <tencent_E1BBF05904DFB73C478DCD592740AAE0780A@qq.com>
 <CAJedcCxVW++iH49UFZp9ruUuTcNubWCH6Wsqe11K4COB3E8msg@mail.gmail.com>
 <CAJedcCw1eJqjSK+yR7eQMDheNtH3Mjm+viwt00xAhnmrfpq2pw@mail.gmail.com>
 <CAJedcCweHjD78F7iydiq6Xc2iH=t_3m=H9JKnaCooToUk32FvQ@mail.gmail.com>
 <YxWtfjfpNsoPUrgh@kroah.com> <CAJedcCzMo51aiy=Dv7zn7VmL3gwkw7JgzwAPAB2Z27C9CnhoYA@mail.gmail.com>
 <20220907030754.GU1089@zhen-hp.sh.intel.com>
In-Reply-To: <20220907030754.GU1089@zhen-hp.sh.intel.com>
From:   Zheng Hacker <hackerzheng666@gmail.com>
Date:   Thu, 8 Sep 2022 17:09:40 +0800
Message-ID: <CAJedcCxO_Rq0qMeLiHtY5+FuN1A1pDGsZd3gMtvUpm1xbAK3aA@mail.gmail.com>
Subject: Re: [PATCH] drm/i915/gvt: fix double-free bug in split_2MB_gtt_entry.
To:     Zhenyu Wang <zhenyuw@linux.intel.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>, alex000young@gmail.com,
        security@kernel.org, dri-devel@lists.freedesktop.org,
        tvrtko.ursulin@linux.intel.com, airlied@linux.ie,
        intel-gfx@lists.freedesktop.org, joonas.lahtinen@linux.intel.com,
        linux-kernel@vger.kernel.org, xmzyshypnc <1002992920@qq.com>,
        jani.nikula@linux.intel.com, daniel@ffwll.ch,
        rodrigo.vivi@intel.com, intel-gvt-dev@lists.freedesktop.org,
        zhi.a.wang@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Zhenyu,

This issue has been open for a few days. Could you plz write a patch
for that :) I'm not familiar with the logical code here.

Regards,
Zheng Wang

Zhenyu Wang <zhenyuw@linux.intel.com> =E4=BA=8E2022=E5=B9=B49=E6=9C=887=E6=
=97=A5=E5=91=A8=E4=B8=89 11:33=E5=86=99=E9=81=93=EF=BC=9A
>
> On 2022.09.06 19:36:56 +0800, Zheng Hacker wrote:
> > Hi Greg,
> >
> > Alex has explained how we figured out the patch. We did analyze the
> > code and found it possible to reach the vulnerability code. But we
> > have no physical device in hand to test the driver. So we'd like to
> > discuss with developers to see if the issue exists or not.
> >
> > Best regards,
> > Zheng Wang.
> >
> > Greg KH <gregkh@linuxfoundation.org> ???2022???9???5????????? 16:04????=
?????
> > >
> > > On Mon, Sep 05, 2022 at 03:46:09PM +0800, Zheng Hacker wrote:
> > > > I rewrote the letter. Hope it works.
> > > >
> > > > There is a double-free security bug in split_2MB_gtt_entry.
> > > >
> > > > Here is a calling chain :
> > > > ppgtt_populate_spt->ppgtt_populate_shadow_entry->split_2MB_gtt_entr=
y.
> > > > If intel_gvt_dma_map_guest_page failed, it will call
> > > > ppgtt_invalidate_spt, which will finally call ppgtt_free_spt and
> > > > kfree(spt). But the caller does not notice that, and it will call
> > > > ppgtt_free_spt again in error path.
> > > >
>
> It's a little mess in code so in theory it might be possible but
> intel_gvt_dma_map_guest_page won't fail in practise...
>
> > > > Fix this by returning the result of ppgtt_invalidate_spt to split_2=
MB_gtt_entry.
> > > >
>
> I don't see why changing ret value can fix this issue, as it doesn't chan=
ge
> any behavior e.g caller of ppgtt_populate_spt to handle possible differen=
t error return.
>
> As current code looks assuming that ppgtt_invalidate_spt would free spt i=
n good case,
> I think the real cleanup should split that assumption and handle free in =
error case properly.
>
> > > > Signed-off-by: Zheng Wang
>
> This misses proper email address.
>
> thanks
>
> > > >
> > > > ---
> > > >  drivers/gpu/drm/i915/gvt/gtt.c | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > >
> > > > diff --git a/drivers/gpu/drm/i915/gvt/gtt.c b/drivers/gpu/drm/i915/=
gvt/gtt.c
> > > > index ce0eb03709c3..9f14fded8c0c 100644
> > > > --- a/drivers/gpu/drm/i915/gvt/gtt.c
> > > > +++ b/drivers/gpu/drm/i915/gvt/gtt.c
> > > > @@ -1215,7 +1215,7 @@ static int split_2MB_gtt_entry(struct intel_v=
gpu *vgpu,
> > > >                 ret =3D intel_gvt_dma_map_guest_page(vgpu, start_gf=
n + sub_index,
> > > >                                                    PAGE_SIZE, &dma_=
addr);
> > > >                 if (ret) {
> > > > -                       ppgtt_invalidate_spt(spt);
> > > > +                       ret =3D ppgtt_invalidate_spt(spt);
> > > >                         return ret;
> > >
> > > But now you just lost the original error, shouldn't this succeed even=
 if
> > > intel_gvt_dma_map_guest_page() failed?
> > >
> > > And how are you causing intel_gvt_dma_map_guest_page() to fail in a r=
eal
> > > system?
> > >
> > > thanks,
> > >
> > > greg k-h
