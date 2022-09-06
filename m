Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 507785ADED4
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 07:19:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232571AbiIFFTP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 01:19:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232514AbiIFFTM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 01:19:12 -0400
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E7636BCD7
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 22:19:11 -0700 (PDT)
Received: by mail-il1-x135.google.com with SMTP id b17so5486274ilh.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Sep 2022 22:19:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=ely/aEFxFzOsBw72pTQ4C/orrI0uHapotCxDtVzcVYQ=;
        b=jTLIue7tHKiJEkIXE4UvdD0oiM5JDsR6TuVAzKn9K426IYhT2US3RYz/q78X3ZWD6c
         sAhbuxwdk9LtcvA6YbW7AXb+ovyOI68IvMeN5JEeACghUSA+NVCNiHOmQwZsazSFfgGM
         Q0IBWq4vNb7kU3n+Ovg2Oe0zLk54+WFQenC2ZV539EAqJOeDvkp1OkUUm2bRcYL3dHrZ
         jj8zRznnkmaPSvd1/Q//+Smnbl6/cJt0xQsAZ1iwZgZxklQLVEmy8aV6tagiaQShm0R2
         j6wcsFrzK2bm69SBEi5tH2EiZ3vm9MPLIKjLpwB3c/4Tafwc3x7R4pVkBLPMiC81hb4m
         R0Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=ely/aEFxFzOsBw72pTQ4C/orrI0uHapotCxDtVzcVYQ=;
        b=Q4z5t1txNA+MrdIV390I2Ogxjx+NHceDQgrspaVtv549DSR7pm+jfBAknS91m2KWGT
         cLnLPsa4UPwFEksxe39n8AVBNGTHXTGgiyI8vqlzK9Ep2n1wRkdcDQ53pJd9D6upzba1
         Rr8KXYbm/NHFnrVv5uBxJaRDS/speH+mzEmddDhrvptUwGNMYLwAj3a7hlVtlkhsn4X3
         Vr8TmQQaUhv3BHPfnVqw2WsulIO5FTcM+vaQxcbgPHWjWQDMMmI5wt4K//lbdSj2gXnR
         1KmXTRUCi9x2HtTmw8c/in+el9LIsBaHIjIhb+ylRpZ+hwm/SGUK7N+qhmBqQ3U5o4Bg
         38zw==
X-Gm-Message-State: ACgBeo2e21pbbOWE58MGJ0aC+KWO9DXmg8B15mzugmiylorkk+CLq5XY
        iRcyHzqdSBlKjySDe0MeLcYZ6WcOnhfGLwkIoso=
X-Google-Smtp-Source: AA6agR5rwgsCL4VMr/DQKH9Y82uS44Oz0RSu8ipUCP41EntnG4CbXRh6pftkDnSorGe7i+G64IFBFZbpeWy6KlRZCzg=
X-Received: by 2002:a05:6e02:1ca9:b0:2e5:fa2a:6345 with SMTP id
 x9-20020a056e021ca900b002e5fa2a6345mr26370929ill.5.1662441550668; Mon, 05 Sep
 2022 22:19:10 -0700 (PDT)
MIME-Version: 1.0
References: <20220826023504.6183-1-steve.lee.analog@gmail.com>
 <Yw+OCnOgYUOWdIEx@sirena.org.uk> <CA+Fz0PZStYOZhNpRQCCVKxaDmPPq_PwvWrxfWbq=sBNKrZzzNg@mail.gmail.com>
 <YxCPYbPsEyZmuHOI@sirena.org.uk>
In-Reply-To: <YxCPYbPsEyZmuHOI@sirena.org.uk>
From:   Lee Steve <steve.lee.analog@gmail.com>
Date:   Tue, 6 Sep 2022 14:17:53 +0900
Message-ID: <CA+Fz0PZv-sxLiXFgFQ4STN+ghg0-eQqW-jXh8X1hzD0ykTn8tQ@mail.gmail.com>
Subject: Re: [PATCH] ASoC: max98390: Remove unnecessary amp on/off conrtol
To:     Mark Brown <broonie@kernel.org>
Cc:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        krzk@kernel.org, ryans.lee@analog.com
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

On Thu, Sep 1, 2022 at 7:54 PM Mark Brown <broonie@kernel.org> wrote:
>
> On Thu, Sep 01, 2022 at 02:57:19PM +0900, Lee Steve wrote:
> > On Thu, Sep 1, 2022 at 1:36 AM Mark Brown <broonie@kernel.org> wrote:
>
> > > I can't see anything which ensures that this is the case?  Should there
> > > be a check which returns an error if the output is not enabled, or
> > > should the function check the current state and preserve it at the end?
> > > I can see that this would fix problems with it being disabled when
> > > callibrating.
>
> >  As your comment, this can fix amp being disabled when calibrating.
> > And this also fix the case that music play right after calibration.
> > Actually, calibration process should start mute playback before
> > trigger this function.
> > AMP disable/enable control in calibration function can break sync with
> > userspace enable/disable control.
>
> Right, so that sounds like there should be something which checks the
> current state and doesn't start callibration unless the device is in a
> sensible state.

 I will send v2 patch adding check before start calibration.
Thanks.
