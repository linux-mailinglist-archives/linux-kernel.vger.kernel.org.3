Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35D9154026F
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 17:30:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344094AbiFGPay (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 11:30:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232029AbiFGPaw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 11:30:52 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 086D1EC327;
        Tue,  7 Jun 2022 08:30:51 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id e184so31739578ybf.8;
        Tue, 07 Jun 2022 08:30:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=M9tGln7o0xO5lNOxGAIh8SVyMBeklhDDJa+pP9KY3R0=;
        b=iChPXs3XNhbFqTNOO6IuvrPdEJRzJQYR/z1R4k3k6e261fhwkQZNxWzmJL0/x3tbSk
         805ylL5Hfzq1RdfiBAYpFZxkmIxO495Nk9CqrCxtIP1Bk7HcCWrmxWxVgKl0J21nw+5X
         wEuwUrZJc/DAW5cUejVTI+RlXvrPemOdH7J6bMfRVdNAHPaALdJsInGcXHDf69B9eOwY
         F6VDyJiFH99vAkpSIX8JhgLbMoVzQELWekUnRsmorhVFYnDTNkqzy+Hvpr8dLCz0i3u9
         hUP0bftq7iJD6aOCXGbvyYzNEj60AjG5+RanJ1sM02jd8Lg0xfZsS9Y+T4OfG+Qj4FTl
         nULQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=M9tGln7o0xO5lNOxGAIh8SVyMBeklhDDJa+pP9KY3R0=;
        b=bw6RdQwXR2obQ6w9B3nDlGbGKLmUWBwkonwbVbhoBseicXy1aXOapWbWLasaKNfB8w
         BCsfxM9U+5JiWsThlXMEtjB9pJ2Gt9zErYPGf7S2wwwryxJeltYngA1LcU/rVNcnfoKr
         ZzAYUyTUgOaI9fH5KPP1QuSi1CvAmRaFePfdm1HynDdrv07v/Ssava3Xb8CK62VINiYY
         6BqOl3p9d2W/JhqzAqK0MDnSzr42pmVb+qy7onxc0sBPiiKfo+HEgO6j1Wbvz+0bXAu5
         6DtaOYY5SqK0Vae788kGKG1JBUy1gh78uKCn8j66Bz4U+2fcuezMVMcnQXNjZ6kVa+dV
         TYfQ==
X-Gm-Message-State: AOAM533uuKVrQgXHI8+Fvid2QUgFNXPRxJYGYwQPo7nDZn/WWr5ZZDfd
        fd2Vw5dgSMj5SBhW1TaUxPa8SEngne4uzguCGXacm0SD
X-Google-Smtp-Source: ABdhPJxWjoZl+fjcF8blNQYsNvpNYUaQTqISItzWwnVlRP+7yiBVzSIGd/UBB3fVhvCegSdSWFSsX+ufnMj6V6TQc0I=
X-Received: by 2002:a25:8803:0:b0:64e:4a6a:afb9 with SMTP id
 c3-20020a258803000000b0064e4a6aafb9mr30066351ybl.482.1654615849929; Tue, 07
 Jun 2022 08:30:49 -0700 (PDT)
MIME-Version: 1.0
References: <CAJZ5v0hjp2-yLN_UyQvMwhoPreTkA3xU0g3boYtxgLi6TWqabA@mail.gmail.com>
In-Reply-To: <CAJZ5v0hjp2-yLN_UyQvMwhoPreTkA3xU0g3boYtxgLi6TWqabA@mail.gmail.com>
From:   =?UTF-8?Q?Rafa=C5=82_Wysocki?= <rjwysocki@gmail.com>
Date:   Tue, 7 Jun 2022 17:30:38 +0200
Message-ID: <CAJZ5v0iLoGsauHTh+H7EemsjGApXpant0RQFEDZRQMiGoHzpCg@mail.gmail.com>
Subject: Re: [CFP] Power Management and Thermal Control MC at LPC 2022
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Zhang, Rui" <rui.zhang@intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Len Brown <len.brown@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Saravana Kannan <saravanak@google.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>
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

Hi All,

On Wed, May 25, 2022 at 7:48 PM Rafa=C5=82 Wysocki <rjwysocki@gmail.com> wr=
ote:
>
> Hi All,
>
> The Power Management and Thermal Control micro-conference:
>
> https://lpc.events/event/16/contributions/1158/
>
> has been accepted for the LPC 2022, so if you have a topic for
> discussion in that session, please submit it through the LPC web page:
>
> https://lpc.events/event/16/abstracts/
>
> (please choose Power Management and Thermal Control MC as the track).
> Please also submit topics already listed in the MC description.
>
> Please note that the LPC is mostly about discussing work in progress
> and development proposals, so make sure that your topic falls into
> this category.  In particular, please avoid submitting topics
> regarding work that has already been done.
>
> The LPC will be held in Dublin this year, but it should be possible to
> participate in the sessions remotely, so it should be fine to submit a
> topic even if you cannot go to Dublin in person.
>
> Looking forward to seeing you all at the LPC!

The deadline for topic submissions is approaching (it appears to be June 15=
).

Cheers!
