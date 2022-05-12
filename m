Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F024524909
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 11:34:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348155AbiELJeS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 05:34:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232425AbiELJeQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 05:34:16 -0400
Received: from mail-ua1-x930.google.com (mail-ua1-x930.google.com [IPv6:2607:f8b0:4864:20::930])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C89E669B6B;
        Thu, 12 May 2022 02:34:14 -0700 (PDT)
Received: by mail-ua1-x930.google.com with SMTP id ay15so1770003uab.9;
        Thu, 12 May 2022 02:34:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=It32UX8nOIVa55dLWgMXuIgBRh6vRzogSEnYGTpk8F4=;
        b=jaEne6eQVDb6G7kiyFRSRprd1WA/ZBUURTZeUVhV4+bxfBxKf1UB6YVRzg+DD7DvBw
         NzfA2W330TWAjtB5kRrhQ1gWZi8+MwPkTdeV9GlYsE6bzr72bGZ+M4dEHx1aXqBcAtNZ
         U++clv2AwRZSUwL2WP87SiXd4BW2WQFFW/xE/no0RLEZgeDTb5XD/MpB4SY0KTERUFnx
         ZsGyYzvvfIB9jsH4OcCEjGUkrsSnBe4zZzxk/TlWu3pB8gm+lX3KuEYcgIGVb8+xWApI
         QTLZlqCxkmFS0exAel/Xn022MQNIOeH1yvz2WpaQupj4VI3prWTm/bpOsObUw88OyNGU
         Hq6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=It32UX8nOIVa55dLWgMXuIgBRh6vRzogSEnYGTpk8F4=;
        b=nOZKsyJXStpSI5Yv7kNkpgvjXjSPak7h5Jk2bglYVNm0nd2Xs9s26LdQ+idmNH31yQ
         uGOcoJYLnycpqTqr9XDevwyTmY7TYkEUqXpkwAQXHI2AJhJS/uISv0Q6Cwmk2E9/TDwe
         bvdTXTam5NYT5YhoDaVfGYn6IEUFJib7aLXcdNnGn6vnJAdUVjZpPVwt4TUUn1ocCCgm
         g8fGeafcujL1SO9g8fxouZ9tc/fX4edfaSbrc/z5OYp6FGJRYjnvoR3msSU1d33dvTC3
         5c66lK1DYwOxR5koXLGj7FlURBXZ3h7YxAihkwwaeTR4Yj3twXujpeiEb6cgxkAp92FJ
         JwbA==
X-Gm-Message-State: AOAM532vFyG06Hzm+fR0HSEwMUHt0oV8P6HTarOFk2yoSLG9TvQZeP7y
        oq04TmRnEMwxqSY5I+EhSgA5bzc1QqxphCtKKXM=
X-Google-Smtp-Source: ABdhPJxy4IsI78DxYQjxG3pVGElT5APglQbnF74rwi5bZzJOo7mdDSQs5xP+UgckO8uhg7WFUk1J1K4wtgF5Jo20nYs=
X-Received: by 2002:ab0:5b4d:0:b0:35d:2f9c:f01 with SMTP id
 v13-20020ab05b4d000000b0035d2f9c0f01mr15421035uae.86.1652348053811; Thu, 12
 May 2022 02:34:13 -0700 (PDT)
MIME-Version: 1.0
References: <20220405183953.2094007-1-pceballos@google.com> <nycvar.YFH.7.76.2204210947590.30217@cbobk.fhfr.pm>
In-Reply-To: <nycvar.YFH.7.76.2204210947590.30217@cbobk.fhfr.pm>
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date:   Thu, 12 May 2022 11:34:01 +0200
Message-ID: <CAKdAkRQ7yxFFGJg41UxptxapKiP4bmHsfw7dRNE+LPzs1PRk=A@mail.gmail.com>
Subject: Re: [PATCH] HID: Driver for Google Hangouts Meet Speakermic
To:     Jiri Kosina <jikos@kernel.org>
Cc:     Pablo Ceballos <pceballos@google.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        lkml <linux-kernel@vger.kernel.org>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>
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

On Thu, Apr 21, 2022 at 10:28 AM Jiri Kosina <jikos@kernel.org> wrote:
>
> On Tue, 5 Apr 2022, Pablo Ceballos wrote:
>
> > This driver works around a problem with the HID usage sent by this
> > device for the mute button. It prevents key events from being generated
> > for that HID usage since they would be incorrect.
> >
> > Signed-off-by: Pablo Ceballos <pceballos@google.com>
>
> Applied to hid.git#for-5.19/google. Thanks,

I am curious, could not this be achieved without a kernel driver by
simply using udev to map this usage code to KEY_RESERVED?

Thanks.

-- 
Dmitry
