Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1D5358CB58
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 17:35:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243601AbiHHPfr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 11:35:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243798AbiHHPfl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 11:35:41 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6088F1022
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 08:35:40 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id bz13so6739547qtb.7
        for <linux-kernel@vger.kernel.org>; Mon, 08 Aug 2022 08:35:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=puC/6h23B5IaywejRNVPQBFYwckZIkSJb29KB5XMvgE=;
        b=MWz17Jof7NENmiVBbflj9h1Bjzn5OS8R+9mh0uhzbHDwUJij4rTahTfE5lHGYKHwtA
         esEVisAZJUOtn2ARqGHUkBb7Xo4EHlILuH5rzkvVrvvaJHgGZr7hpfFY6MV/tyTHQYvn
         4NoLZX09CU+XykS4Xg+Ryj6QLqjIo2eNuuGolwD++TZ2TNPPm04uvRH/BzIDmml1avFe
         h6Kkbq02nJhJrnX+hHeVnv3kgeQkA6SvfrJMcqK0hBP2AJhXBL2lJxDNRJwv7h5SyGtn
         GP+tqmXjyHI8HmQPYM9uCdBm/0PfhD5Vmv+7ZAVJpv09kaweXFBghlUD4q3pgi45SapK
         Fp1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=puC/6h23B5IaywejRNVPQBFYwckZIkSJb29KB5XMvgE=;
        b=yQnk4d7qV46N0TCyZ+vCnBjczNZqVyC5+gF9yglg7fLWAUIw80pIpx2cyEj+qVQp0Z
         ejxodSpEG/PumzVxjz+BDL/IgJ9wF7h4p8Q3NbCCvdqX74+Fi/8PuLSGZhJsONA/5Glk
         UzD770ejTaoFoIDGRJHDs3ddv3q4+SDX7fSLcKrC3mimjoQNNZoYYyXw1N8Ntkcip7qU
         980yhIDeBd2y4W0VCzPbq8saGZXxbWWozlC4dh2f09a7uj/2o0SefcJurMHXV4SAkjxg
         6GdVIKRvgvvwWolAFp2I5iQl3ULAy1lMpSG4Smo1TTrb9ij/mm7y+3bvRApO3g9TY8Lr
         VusQ==
X-Gm-Message-State: ACgBeo1H/uQ55FoaylgFObHh70u3VtKC3nJNCR1bD/F/PuACwA9sSPMf
        O3xNXyHjiJ2ds8LgSvdfHCiTxohsFjFxf4bQOlTCbrf4y+6nkQ==
X-Google-Smtp-Source: AA6agR4oAE6eAYwY7UH1l1eDGYPOe16FydT2pIzHVD+1XxWOYijxuFur1kZBFddN+1GK9VI3pYKbjQDPynxAIQKsoV4=
X-Received: by 2002:ac8:5784:0:b0:31f:24e:93f5 with SMTP id
 v4-20020ac85784000000b0031f024e93f5mr16573844qta.429.1659972939175; Mon, 08
 Aug 2022 08:35:39 -0700 (PDT)
MIME-Version: 1.0
References: <20220718122328.8287-1-andriy.shevchenko@linux.intel.com>
 <20220718122328.8287-9-andriy.shevchenko@linux.intel.com> <YvEpy/I2F9pk19Ar@google.com>
 <YvEp76xF265c3/yL@google.com>
In-Reply-To: <YvEp76xF265c3/yL@google.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 8 Aug 2022 17:35:03 +0200
Message-ID: <CAHp75VdnJKfy7cfbGKhHpk3b7OBS=mjghR51qigNa3Fhc_o2=g@mail.gmail.com>
Subject: Re: [RESEND][PATCH v1 9/9] Revert "mfd: intel_soc_pmic_bxtwc: Support
 IRQ chip hierarchy"
To:     Lee Jones <lee@kernel.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andy@kernel.org>
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

On Mon, Aug 8, 2022 at 5:21 PM Lee Jones <lee.jones@linaro.org> wrote:
> On Mon, 08 Aug 2022, Lee Jones wrote:
> > On Mon, 18 Jul 2022, Andy Shevchenko wrote:
> >
> > > This reverts commit 4a34dfdfcc185efea44da958b2e4a6005a70e7d4.
> >
> > Sign-off?
> >
> > Commit message?
>
> My guess is that you didn't mean to send 8 and 9, right?

Right!

It was a wrong series, and I guess the latest one is this:
https://lore.kernel.org/lkml/20220801114211.36267-1-andriy.shevchenko@linux.intel.com/


--
With Best Regards,
Andy Shevchenko
