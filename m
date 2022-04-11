Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C63C4FC163
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 17:47:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348220AbiDKPty (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 11:49:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348211AbiDKPtw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 11:49:52 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87A631095
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 08:47:37 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id l9-20020a05600c4f0900b0038ccd1b8642so217439wmq.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 08:47:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hTKDlxgcWuz5hgaxxxjWWtj91cd/fjAAO8kmOVAY+X8=;
        b=mItDidY53oCf6TvO5FbO0bjeTogS3DCpwx/LcQm2jl37tZF/LmKbvLaTssumOcfS+h
         p17S5pmzSZatW81iEajHfT7BfBIornGLCGZv2WNbk6Faqr7WdBwezXndUlxKHkU9Sw//
         XboCcTWZJt2uQtgR8JYdqwmFTxgmjq/vz2NpsrRyWl6nZlVaN50FLlAouGSkieXJarfH
         55dgGC0PMZivhd8UB3oeYUbkP9AV8oGOVHgfB9gklhzclTuiCvB7m8mFHalTA12K6qWv
         3gjCD5T+9J5KMZ7rVYxG9PUAUUHxZfdkrfN3LbthvJ5RSSGK8aSMGpHULPnWTiU4DO0O
         TDLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hTKDlxgcWuz5hgaxxxjWWtj91cd/fjAAO8kmOVAY+X8=;
        b=iBDfeHRgW9savVCJnTptvCHvU3wIjPehP68tKOsuP8Vo429xaME5n2v8AB/+LpN3Gn
         oBXL1GhrfMGGX81NMNDLJTONHj7yrWmVb+1zf/HLJqnV5c0DL78baOFlaMb5SempmvdZ
         Dfv9jwcHtLGr1LCJZb0C+AEaYH0IJN0F9BCfcRx7fAlYLdZWDzTCsTppIa6hjC1vjy7w
         CDOXx4uhViGBH9mqW8JaKjaUVgvzWSfWatbP/i27H9sAy3vdGiJ2aHPDC+GG7IrWVeKL
         oq45Q+x1GUH5IMa3/NXOvgrRCCuef7NNa+NsZvzmQ4H4rTvr4wuk2gDoeox1csPZMyFY
         ru1g==
X-Gm-Message-State: AOAM533FS0TmnN4JLr+CCOguGgR8iSZBN6GPMC/DtsDuiHUbtWt3AvDM
        lQdZVTUcJN2pyp2yF7M36MwxaynrAn+DeP8yazk=
X-Google-Smtp-Source: ABdhPJzZztoomMLk+0fR4ea/zJn1FjiMBN1Wvq1BMZ9XcdYtBOxWVdV8bCRBGfpbTWv2gPALhDW3RxVlZn3PF1CdLdc=
X-Received: by 2002:a1c:f70a:0:b0:37c:533d:d296 with SMTP id
 v10-20020a1cf70a000000b0037c533dd296mr28942520wmh.147.1649692056053; Mon, 11
 Apr 2022 08:47:36 -0700 (PDT)
MIME-Version: 1.0
References: <20220204035644.734878-1-xiehuan09@gmail.com> <20220208230830.6b8c03c0f4f11c1ed18da236@kernel.org>
 <20220208104806.5272f2ea@gandalf.local.home> <CAEr6+EANLuP1=PpGvB4G1j4a-iM-mM4c69Pvo7j8GtafKPhyPw@mail.gmail.com>
 <20220228110822.4b906204@gandalf.local.home> <CAEr6+EAJqM6py_8xtVyH3BZ9U+vODVecSUkLdZkKu3FN2ZkRtw@mail.gmail.com>
In-Reply-To: <CAEr6+EAJqM6py_8xtVyH3BZ9U+vODVecSUkLdZkKu3FN2ZkRtw@mail.gmail.com>
From:   Jeff Xie <xiehuan09@gmail.com>
Date:   Mon, 11 Apr 2022 23:47:23 +0800
Message-ID: <CAEr6+EB61DZdga+74RXQufLvbXPZ-rJzTrhL+JC54N5-gQm8-Q@mail.gmail.com>
Subject: Re: [PATCH v9 0/4] trace: Introduce objtrace trigger to trace the
 kernel object
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>, mingo@redhat.com,
        Tom Zanussi <zanussi@kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 23, 2022 at 1:20 AM Jeff Xie <xiehuan09@gmail.com> wrote:
>
> Hi steve,
>
> On Tue, Mar 1, 2022 at 12:08 AM Steven Rostedt <rostedt@goodmis.org> wrote:
> >
> > On Sun, 27 Feb 2022 00:01:06 +0800
> > Jeff Xie <xiehuan09@gmail.com> wrote:
> >
> > > Congratulations on joining google.  Just check out this series when
> > > you are free.
> > >
> > > Please don't get me wrong, I'm not pushing anyone.
> > > It just doesn't feel good that I haven't responded to emails for a long time ;-)
> >
> > And keep responding ;-) I want to look at this series, and your emails do
> > remind me (it's still in my patchwork queue, so it wont be forgotten, but
> > it is getting crowded in that queue of "todo"s).
> >
> > Yeah, I'm hoping to start being able to do more upstream, but I'm still a
> > bit in the flux of figuring out what I'm suppose to be doing at work ;-)
> >
> > -- Steve
>
> Hope this series is less crowded in your todo queue ;-)
> ---
> JeffXie

Hi Steve,

Just don't want you to forget this patch series ;-)

---
JeffXie
