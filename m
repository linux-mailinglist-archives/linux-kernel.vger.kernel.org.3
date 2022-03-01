Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C2434C9222
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 18:45:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236638AbiCARp4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 12:45:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236614AbiCARpw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 12:45:52 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 326632AC6C;
        Tue,  1 Mar 2022 09:45:11 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id r10so21748083wrp.3;
        Tue, 01 Mar 2022 09:45:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LCKZuqBaQrqVvcLu/EUZDoUvEFQ31pI7qQ+wygT5714=;
        b=GgdmWlO6xVaLOUNuLj+YvNsSoAlTqMq+dOrCyEjLKS+ZFbI2FQbSkpU2ikDfOzkS63
         fgIHsSAFVJRTiXxioBvPS3Fj5Spj2nIxhcf2L7R24GTdQHbeGQvQjtZgzBZ/HE+QNYJA
         iHjXoDqknYBPfOULvIzlb2BeMyItKLFDk0d9hVXJe3mtde2171/FtAcKiIgiAURpFuOU
         /epZze29QyzrVoZGY1GgRHXmkgHyQuzsLFB/cP1oufq80EOxPWTAQ7xwZD4ElrD/Ck99
         ptIoFxorgkey4MAKh+JiiQMTS+K3YJlcQf+6XnCZcc8xtgx2W05S2wMssyHlyn/TMk7/
         DN6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LCKZuqBaQrqVvcLu/EUZDoUvEFQ31pI7qQ+wygT5714=;
        b=H/UPYG/ks8na1TXBmlSUxf279velAzY15/vcuX0RsP8lsn3THLwmdpStSbu7rFDJeP
         ZyMuJdyUQDU1y036DxZLLBayBQyKb2BtvVrdMyzNOP7vpg9wLd6uCqSTxgwqO+mmf6D+
         4mtS/euVvuAZq9h1L6EUlPfIi34D/vbe1FmgB/FJ7Q1yAZfLaZcftl/fhvmnBDEVAfSq
         Ib7jbcvikcSQwsXyuDdt5l3TmzoAo7DMpaflxr+i3vkzr64SjmostX58z/mUBgSUosDG
         v9NUdKzfhOL8mqlFnC2tbNZQhtKw9oHA/s/V9M3m2IPeqm9J5gM0ApA221o4YYtB3+je
         LbBw==
X-Gm-Message-State: AOAM533EDXIJ0qJ+Gvv7Z/sYx8rwPTe0nYj8LjLBaAWfhyVQArG41qAf
        Imy+3y9ruEb14+BklZYRFtdjGDgSxj6Ah6ZwQ1g=
X-Google-Smtp-Source: ABdhPJwQNgpFjfl73NGhoHP4atwM/20R77juX1EAsRkGpJfhZO7TsJePIDQE5ElT3fRCwE7agOirdL04RUfznC8bUXE=
X-Received: by 2002:a5d:44c7:0:b0:1ed:e11c:9b73 with SMTP id
 z7-20020a5d44c7000000b001ede11c9b73mr19967467wrr.574.1646156709718; Tue, 01
 Mar 2022 09:45:09 -0800 (PST)
MIME-Version: 1.0
References: <1644349472-31077-1-git-send-email-quic_abhinavk@quicinc.com>
 <YgZD8vPqB7ISpRpZ@kroah.com> <654d620b-9e14-c47f-b48c-762dc0bd32a1@quicinc.com>
 <Ygdb63FrorUsX/Hg@kroah.com> <b9156bde-137c-2fac-19e0-b205ab4d6016@quicinc.com>
 <7db7d01fcf5a3edce61161769c0e6eb1541237bf.camel@sipsolutions.net>
 <2add9ba7-7bc8-bd1d-1963-61e8154b0e3c@quicinc.com> <989efb15-cc5e-8f6d-c313-118f01498e33@quicinc.com>
 <8fa2f879e33e4e42b76e21c6fbdcb023@AcuMS.aculab.com>
In-Reply-To: <8fa2f879e33e4e42b76e21c6fbdcb023@AcuMS.aculab.com>
From:   Rob Clark <robdclark@gmail.com>
Date:   Tue, 1 Mar 2022 09:45:39 -0800
Message-ID: <CAF6AEGtNGJanJ9f2pkjst50yPSWGJPo5nDkcZZgq=BkRWMq4yg@mail.gmail.com>
Subject: Re: [PATCH] devcoredump: increase the device delete timeout to 10 mins
To:     David Laight <David.Laight@aculab.com>
Cc:     Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Greg KH <gregkh@linuxfoundation.org>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "swboyd@chromium.org" <swboyd@chromium.org>,
        "khsieh@codeaurora.org" <khsieh@codeaurora.org>,
        "nganji@codeaurora.org" <nganji@codeaurora.org>,
        "seanpaul@chromium.org" <seanpaul@chromium.org>,
        "dmitry.baryshkov@linaro.org" <dmitry.baryshkov@linaro.org>,
        "aravindh@codeaurora.org" <aravindh@codeaurora.org>,
        "freedreno@lists.freedesktop.org" <freedreno@lists.freedesktop.org>
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

On Mon, Feb 28, 2022 at 10:49 PM David Laight <David.Laight@aculab.com> wrote:
>
> From: Abhinav Kumar
> > Sent: 28 February 2022 21:38
> ...
> > We also did some profiling around how much increasing the block size
> > helps and here is the data:
> >
> > Block size    cost
> >
> > 4KB           229s
> > 8KB            86s
>
> You must have an O(n^2) operation in there - find it.

The problem is how the devcoredump/sysfs interface works, which
results in "re-rendering" the output for each block.. it's fine for
moderate size sysfs files, but scales quite badly once you get into
couple MB size sysfs files.

It could be fixed by having some way to keep state across successive
read callbacks.

BR,
-R

>         David
>
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
> Registration No: 1397386 (Wales)
