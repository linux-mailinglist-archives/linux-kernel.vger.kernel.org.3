Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 966295AE6B5
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 13:37:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233020AbiIFLhN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 07:37:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231688AbiIFLhK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 07:37:10 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66B654B489
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 04:37:09 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id z8so14739183edb.6
        for <linux-kernel@vger.kernel.org>; Tue, 06 Sep 2022 04:37:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=M2uKdk7Tp89RSg1nNky+wcqDqkwDzuiMCD1W37dZrH0=;
        b=ZQTLztfGcVGjBsblOMebM+NFagwGsHE86jaN0nn5Ucp+OVvrMMNQeKea7Erer2AZTv
         8WSgYVetr0SUIrYJZ0+e7yU/SKcRDrTPrm58bXWa26qdTJev+OTiAIpybgolEHth6ER3
         7SqWSK6DRK/PqWU0dmWaTzvxR4ExDaYuiAPOEC0fxGVOdBtdfGSj5XnM6mi+0s+0pTZs
         udNATEjqtglI137EMLEmHkW7K7Ix/djafa4Y4qjJhPMUq/Thni4rH0q1ZvkDF40LuGto
         rXj9JnAls09vHek6yKWp4go5hBfkz26YX4cC4Zt42WRC2CpFdzGS4kzpB6DZgdXUeCvB
         PPnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=M2uKdk7Tp89RSg1nNky+wcqDqkwDzuiMCD1W37dZrH0=;
        b=UushL6qzSz1WJCCWb86zi0sjzZO4BaecBGbrpnoUjt3zvB5SJOz9T3qgsdqYjQKnoG
         easc6Qado7HY9xIjspDStdVrrA+zFB8EcJMe8jbMhYzpdZyMMU/ykxidVOd0oC7qtA18
         LWRVjIuG41WXWDE8iURlxdadg0/DrCV37JrhzsLjlcnEMOlwd+VRt1hOB1e6eBVXuQ4p
         gCDnOwlfB1qUK0Z0u6QNOrHxWpQsWt+/EQzweqVuePgmGjkAXnyzDlhHfeQ/2M/Z5RhP
         R3+nh/dh1zssBwD0wqpVya5o16gvjEGANaVDISXYq2QuOU3bs2GrS0z5QB83Yo6/OLBt
         o1Dg==
X-Gm-Message-State: ACgBeo05DgQIhWG/VyC+XI7X2L5kNMc3sU1J+dsB4lHXPlT/dPpBE3BN
        G+IzSBgSxVvg7TgA55WoBiFee9JtGXyND+lgZQk=
X-Google-Smtp-Source: AA6agR7IKf/e9xKyzj81LJcXChDsfXfQhD46/b5OzVDrIs69K0v464O0PVRKlwhKyEF/Q3Jqvn8Le1k13liwXyHRDMw=
X-Received: by 2002:aa7:df87:0:b0:44e:2851:7e8d with SMTP id
 b7-20020aa7df87000000b0044e28517e8dmr10684584edy.106.1662464227838; Tue, 06
 Sep 2022 04:37:07 -0700 (PDT)
MIME-Version: 1.0
References: <tencent_E1BBF05904DFB73C478DCD592740AAE0780A@qq.com>
 <CAJedcCxVW++iH49UFZp9ruUuTcNubWCH6Wsqe11K4COB3E8msg@mail.gmail.com>
 <CAJedcCw1eJqjSK+yR7eQMDheNtH3Mjm+viwt00xAhnmrfpq2pw@mail.gmail.com>
 <CAJedcCweHjD78F7iydiq6Xc2iH=t_3m=H9JKnaCooToUk32FvQ@mail.gmail.com> <YxWtfjfpNsoPUrgh@kroah.com>
In-Reply-To: <YxWtfjfpNsoPUrgh@kroah.com>
From:   Zheng Hacker <hackerzheng666@gmail.com>
Date:   Tue, 6 Sep 2022 19:36:56 +0800
Message-ID: <CAJedcCzMo51aiy=Dv7zn7VmL3gwkw7JgzwAPAB2Z27C9CnhoYA@mail.gmail.com>
Subject: Re: [PATCH] drm/i915/gvt: fix double-free bug in split_2MB_gtt_entry.
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     xmzyshypnc <1002992920@qq.com>, airlied@linux.ie, daniel@ffwll.ch,
        zhenyuw@linux.intel.com, zhi.a.wang@intel.com,
        alex000young@gmail.com, jani.nikula@linux.intel.com,
        joonas.lahtinen@linux.intel.com, rodrigo.vivi@intel.com,
        tvrtko.ursulin@linux.intel.com,
        intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, security@kernel.org
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

Hi Greg,

Alex has explained how we figured out the patch. We did analyze the
code and found it possible to reach the vulnerability code. But we
have no physical device in hand to test the driver. So we'd like to
discuss with developers to see if the issue exists or not.

Best regards,
Zheng Wang.

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
