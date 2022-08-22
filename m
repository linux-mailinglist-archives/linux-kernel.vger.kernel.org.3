Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1FC759C02B
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 15:08:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235017AbiHVNIJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 09:08:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234670AbiHVNIF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 09:08:05 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AEDC2FFF8
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 06:08:03 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id e19so9707525pju.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 06:08:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=KENEwPWg+QM6i8lJVSpcOJR02BGDL6vvXXWnVkrSkKM=;
        b=m2iL2AOmlxu5RzDNkMGd8DaJOgjWBtIfddWC/0ETz+lOO9bjP/lJeTOhukYZEBxj7+
         B0F2Pey8oqC0UacfNG8U18X2Qe2LuL9qG597GgjcOd6d1oKhR7nGTX0df99FBdV27bu2
         LxbXEoBR0uYJGBacdOZ2Z8DAo/W8fZupquGIgHREBFArbKHwsQqdj6DzvvDkkOHDTHc0
         Ln0tkZb1odIUZspG9CxgVmGicz7PHXrrztQQaErGGAzJ3T5/b9/JdIiM5o+qUA5MqqVL
         md3jcqlEKLtIT0sxbe8BEBiEZkdHPEPF6VWylXHlDgKmqkFH1yLC7QzIu3Rq/Yh0tC6d
         SBDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=KENEwPWg+QM6i8lJVSpcOJR02BGDL6vvXXWnVkrSkKM=;
        b=ugT7QHgqPis5AwLSWLFcOD416OvlL3IfCGuBo41SIv7lmMprgejac6L8u5dNDvOoR0
         EN9AF02lw+gbCBBg00X6Eqad922w+gRVkQw2HoT7ZZ8TMtr+MGw5zliX7fsuad/1zYWL
         2oUot8X9CTZ2nxkkJM+DaOWjcbT1ZfZAxHT2yO/96BZs2XARZb6abDhEcfFB4wkvO6jQ
         +FfPzAyIE0XcmQfwvtSsC9yMUZTt8NRI8FtwKc9qkI3KB3y5Nv6Z4/LHJA+FxAJjhRP6
         D7PDwAXGI5R4CwKzhk7a4zWhaHLwYAvO+ZcWBME8Jn5jz6fpN0eVXDwqAtdfZ0uMn+k2
         DjCw==
X-Gm-Message-State: ACgBeo2QAI4/j0PhADG8jVnP28qUs3nC2jjUpOjhVDoewTkEn4um1wsM
        VWIjfjg/nGwrhNg+l7RlaNlGgAcp/lKWEPHK5iv1SA==
X-Google-Smtp-Source: AA6agR5rIBZX4Flq9sLj5pCfvh891sCOFxNlHR7bL6f+qO5ihzZOMaKAbynQr1VhcCWezyaKyYaJb+T+J0pUVl0D50I=
X-Received: by 2002:a17:902:c411:b0:170:91ff:884b with SMTP id
 k17-20020a170902c41100b0017091ff884bmr20213120plk.58.1661173682451; Mon, 22
 Aug 2022 06:08:02 -0700 (PDT)
MIME-Version: 1.0
References: <20220819153829.135562864@linuxfoundation.org> <20220819153853.762825860@linuxfoundation.org>
 <20220822111546.GA7795@duo.ucw.cz> <CAHUa44HBBgMtT=xAJYmNPkwZntLt=cNCmE8eb29DWm2+1PxF-g@mail.gmail.com>
In-Reply-To: <CAHUa44HBBgMtT=xAJYmNPkwZntLt=cNCmE8eb29DWm2+1PxF-g@mail.gmail.com>
From:   Jens Wiklander <jens.wiklander@linaro.org>
Date:   Mon, 22 Aug 2022 15:07:51 +0200
Message-ID: <CAHUa44HmKs4MVpe9DxHLOTwjLbhgTu0mcxhtbpR6oCLyC3vWdA@mail.gmail.com>
Subject: Re: [PATCH 5.10 540/545] tee: add overflow check in register_shm_helper()
To:     Pavel Machek <pavel@denx.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Nimish Mishra <neelam.nimish@gmail.com>,
        Anirban Chakraborty <ch.anirban00727@gmail.com>,
        Debdeep Mukhopadhyay <debdeep.mukhopadhyay@gmail.com>,
        Jerome Forissier <jerome.forissier@linaro.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
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

On Mon, Aug 22, 2022 at 3:03 PM Jens Wiklander
<jens.wiklander@linaro.org> wrote:
>
> Hi,
>
> On Mon, Aug 22, 2022 at 1:15 PM Pavel Machek <pavel@denx.de> wrote:
> >
> > Hi!
> >
> > > From: Jens Wiklander <jens.wiklander@linaro.org>
> > >
> > > commit 573ae4f13f630d6660008f1974c0a8a29c30e18a upstream.
> > >
> > > With special lengths supplied by user space, register_shm_helper() has
> > > an integer overflow when calculating the number of pages covered by a
> > > supplied user space memory region.
> > >
> > > This causes internal_get_user_pages_fast() a helper function of
> > > pin_user_pages_fast() to do a NULL pointer dereference:
> >
> > Maybe this needs fixing, but this fix adds a memory leak or two. Note
> > the goto err, that needs to be done.
>
> Thanks for bringing this up. I believe the best option is to take the
> backport I just did for 5.4, it should apply cleanly on the 5.10
> stable kernel too.
>
> Greg,  can you cherry-pick the 5.4 backport patch, or would you rather
> have an explicit backport for this stable kernel?

I'm sorry, I'm confused by all the backports. I haven't posted the 5.4
yet, I've only just tested it. I'll tag that backport patch for 5.10
stable too.

Thanks,
Jens

>
> Cheers,
> Jens
>
> >
> > Best regards,
> >                                                                 Pavel
> >
> > Signed-off-by: Pavel Machek <pavel@denx.de>
> >
> > > +++ b/drivers/tee/tee_shm.c
> > > @@ -222,6 +222,9 @@ struct tee_shm *tee_shm_register(struct
> > >               goto err;
> > >       }
> > >
> > > +     if (!access_ok((void __user *)addr, length))
> > > +             return ERR_PTR(-EFAULT);
> > > +
> > >       mutex_lock(&teedev->mutex);
> > >       shm->id = idr_alloc(&teedev->idr, shm, 1, 0, GFP_KERNEL);
> > >       mutex_unlock(&teedev->mutex);
> > >
> >
> >
> > diff --git a/drivers/tee/tee_shm.c b/drivers/tee/tee_shm.c
> > index 6e662fb131d5..283fa50676a2 100644
> > --- a/drivers/tee/tee_shm.c
> > +++ b/drivers/tee/tee_shm.c
> > @@ -222,8 +222,10 @@ struct tee_shm *tee_shm_register(struct tee_context *ctx, unsigned long addr,
> >                 goto err;
> >         }
> >
> > -       if (!access_ok((void __user *)addr, length))
> > -               return ERR_PTR(-EFAULT);
> > +       if (!access_ok((void __user *)addr, length)) {
> > +               ret = ERR_PTR(-EFAULT);
> > +               goto err;
> > +       }
> >
> >         mutex_lock(&teedev->mutex);
> >         shm->id = idr_alloc(&teedev->idr, shm, 1, 0, GFP_KERNEL);
> >
> > --
> > DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
> > HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
