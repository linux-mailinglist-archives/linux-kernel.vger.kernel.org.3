Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F1485347BF
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 03:01:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345163AbiEZBBq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 21:01:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233274AbiEZBBn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 21:01:43 -0400
Received: from mail-yb1-xb42.google.com (mail-yb1-xb42.google.com [IPv6:2607:f8b0:4864:20::b42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3795F28E3F
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 18:01:42 -0700 (PDT)
Received: by mail-yb1-xb42.google.com with SMTP id t26so567215ybt.3
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 18:01:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=gOEnRJpOdTvkdK6X7t127DgQA0EFmqZ7LKvPVYjecso=;
        b=gtjW6qzphf1fKBxxHmI60e9QD33KM2PUmyoz5a1GxJzW2HN74HLsAiTacc53j4ape8
         lDK4XvWTFh20V8W9HUhxK7RTv+mEfD+cTWXwqTKNDYCRwi70EA02vp7F5LD4t435lkV4
         PWnlO9M7EIGn2Dzk6yf3ymeYHRha+ZsdprhWIZXAz987pY8Iq2mmm240ZbJqUdsQXPHc
         GKDN44JPOwbfoegK8pbop8fV5+4utvHOl/X1OdQj8GEyDh9qnqd7CO4qxJbCP8vHgHas
         QrVrrOicWQROnh2om4b5xyFPlf09QSpX4zaoqw6cOti3uhbE9H2VhE4/x6yQ3W64XbNu
         pWFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=gOEnRJpOdTvkdK6X7t127DgQA0EFmqZ7LKvPVYjecso=;
        b=CJ07pr3Xawu349Sgf6kJBASloNu+t+G1W6y57HNPUjElPwvCzY4VNcaPz5av0C9rTX
         BaJtzXqpkokhvmI2xRf0474zxPH9NFlLidgXXzxZle7Ql3lPANwdqv1BnBBYYIdUb7Lc
         XA/pBMYS9/AeSHZD9wbMav+yL0Hh5FTgxagAkAAfozAfu5XBG3o7J4vov1hLayCeOIfe
         5OhHcbq8iT+5iEfD5GfRSBuZwPMYq8s8Xj/QuAztufyB6IRbbo434o1be5hTrgcM9lJ2
         kj+wxvOtVCQjgNTGzwszbwHjzO0QRfE4JR/5gjYolqhUTC7hipGwPa2wxPRTqSuEVHVk
         3XYg==
X-Gm-Message-State: AOAM530b5GS3L4dpltSpm9V1WYOEp+fFakNgrA0Q4mabwEyT9/FDXS/L
        B0YZuon/15qI6vtSLo0S1D/RyQmiLX2nhipRsA==
X-Google-Smtp-Source: ABdhPJx/SCcn+yXFORfJPNf5PZ90/mpSrR3j0NmVsHRDVdzHSfiti4NL+keLJub+ifu8T3LWPna5VFWZIeZ99zpujek=
X-Received: by 2002:a25:614e:0:b0:64d:6b44:514b with SMTP id
 v75-20020a25614e000000b0064d6b44514bmr32701719ybb.397.1653526901454; Wed, 25
 May 2022 18:01:41 -0700 (PDT)
MIME-Version: 1.0
References: <20220523075123.1068763-1-sunliming@kylinos.cn> <20220525115142.279298c1@gandalf.local.home>
In-Reply-To: <20220525115142.279298c1@gandalf.local.home>
From:   sunliming <kelulanainsley@gmail.com>
Date:   Thu, 26 May 2022 09:01:30 +0800
Message-ID: <CAJncD7Q8gV6T2i5EnZzRDdH968da0WZSKk3hZWC=sHu=8onGug@mail.gmail.com>
Subject: Re: [PATCH] tracing: fix comments of event_trigger_separate_filter()
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     mingo@redhat.com, linux-kernel@vger.kernel.org,
        sunliming@kylinos.cn, Tom Zanussi <zanussi@kernel.org>
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

Steven Rostedt <rostedt@goodmis.org> =E4=BA=8E2022=E5=B9=B45=E6=9C=8825=E6=
=97=A5=E5=91=A8=E4=B8=89 23:51=E5=86=99=E9=81=93=EF=BC=9A
>
> On Mon, 23 May 2022 15:51:23 +0800
> slm <kelulanainsley@gmail.com> wrote:
>
> > The parameter name in comments of event_trigger_separate_filter()
> > is inconsistent with actual parameter name, fix it.
> >
> > Signed-off-by: slm <sunliming@kylinos.cn>
>
> Signed off by must have your full name. I doubt "slm" is your full name.
>
> > ---
> >  kernel/trace/trace_events_trigger.c | 23 ++++++++++++-----------
> >  1 file changed, 12 insertions(+), 11 deletions(-)
> >
> > diff --git a/kernel/trace/trace_events_trigger.c b/kernel/trace/trace_e=
vents_trigger.c
> > index 21592bed2e89..c364dc729339 100644
> > --- a/kernel/trace/trace_events_trigger.c
> > +++ b/kernel/trace/trace_events_trigger.c
> > @@ -738,27 +738,28 @@ bool event_trigger_empty_param(const char *param)
> >
> >  /**
> >   * event_trigger_separate_filter - separate an event trigger from a fi=
lter
> > - * @param: The param string containing trigger and possibly filter
> > - * @trigger: outparam, will be filled with a pointer to the trigger
> > + * @param_and_filter: The param_and_filter string containing trigger
> > + * and possibly filter
>
> The parameter description should be contained to a single line. No need t=
o
> say "The param_and_filter".
>
>
> > + * @param: outparam, will be filled with a pointer to the trigger
> >   * @filter: outparam, will be filled with a pointer to the filter
> >   * @param_required: Specifies whether or not the param string is requi=
red
> >   *
> >   * Given a param string of the form '[trigger] [if filter]', this
> >   * function separates the filter from the trigger and returns the
> > - * trigger in *trigger and the filter in *filter.  Either the *trigger
> > + * trigger in *param and the filter in *filter.  Either the *param
>
> If you are updating this, then it should be:
>
>     trigger in @param and the filter in @filter.
>
> As they are referencing parameters which need the "@" notation.
>
> >   * or the *filter may be set to NULL by this function - if not set to
>
> And that includes the above as well.
>
> >   * NULL, they will contain strings corresponding to the trigger and
> >   * filter.
> >   *
> >   * There are two cases that need to be handled with respect to the
> > - * passed-in param: either the param is required, or it is not
> > - * required.  If @param_required is set, and there's no param, it will
> > - * return -EINVAL.  If @param_required is not set and there's a param
> > - * that starts with a number, that corresponds to the case of a
> > - * trigger with :n (n =3D number of times the trigger should fire) and
> > - * the parsing continues normally; otherwise the function just returns
> > - * and assumes param just contains a filter and there's nothing else
> > - * to do.
> > + * passed-in param_and_filter: either the param is required, or
>
> As "param" did not have a "@" in front of it, that means it did not
> represent the parameter.
>
> > + * it is not required.  If @param_required is set, and there's no
> > + * param, it will return -EINVAL.  If @param_required is not set
> > + * and there's a param_and_filter that starts with a number, that
> > + * corresponds to the case of a trigger with :n (n =3D number of times
> > + * the trigger should fire) and the parsing continues normally;
> > + * otherwise the function just returns and assumes param_and_filter
> > + * just contains a filter and there's nothing else to do.
>
> And there's still more space to use, as the biggest line is only 70
> characters and we allow 80.
>
> -- Steve
>
> >   *
> >   * Return: 0 on success, errno otherwise
> >   */
>
I got it. Thanks for your review.
