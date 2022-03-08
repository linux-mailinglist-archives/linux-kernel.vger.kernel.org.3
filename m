Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51B0A4D183F
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 13:50:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244900AbiCHMvZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 07:51:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230080AbiCHMvX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 07:51:23 -0500
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69B622899C;
        Tue,  8 Mar 2022 04:50:27 -0800 (PST)
Received: by mail-yb1-xb2f.google.com with SMTP id x200so37497263ybe.6;
        Tue, 08 Mar 2022 04:50:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0t+oRuFUeoTJYozgTMtCFZq9+My0K/1omeutSIQNN6c=;
        b=VdjJnnr+C0SxYl1Zfv6eCgIvxYd2ufGHcIvRcQ/VIGsIYVt9PhlbvbUzfggbRSqFzj
         RxPPhr/2Eb9RCPAk1xO7BXtorCMVdZT5LuH2tXfmkAF6xSbB8cEMwtNZ9wGLXjNud/dB
         jBsOBGtLDj5scOtoeErNpyUcFex47626+5L11vUXquCf3XsBAjGuEWh590sePBBeLctH
         is1y9mYA53c4lJpnuG01+P/3uXLvMEFls0rae/X/iScC2mU96fR28PzQzNz37GICrhJj
         vl0Skchxw4ZoQpEHxNXPNWKQLjNPvCdK/c6YVCUCMhZmdO0ulw1v2ahwXKB1L6N2+PsY
         ydag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0t+oRuFUeoTJYozgTMtCFZq9+My0K/1omeutSIQNN6c=;
        b=8OBmJ6vXOR1yBHskhXFcsn07/ZdoiA/Aiczb9d8EeWyIjEzPBoVil0PdJoJCcjcItq
         CaKuGpc7iasGbIjnLE1Ip/2abrO36zzXS/WBA2f6B9XiqbpW7bwXtK92WoWb6VfSnlgW
         1X0DCaizz12E0rOok7IQ3Tl3UdQU7XdUikHgWjlCF0xClUSuS1DXU5fsZvfhxIlwiNyI
         rzxdWz6O1jxRlWD0Q89fDWa4OGnNWUpRu705D/xQXYr7LykOoIkLz1vW4HKzgQYSdMuD
         Xye8dgiqk9VpJ4MP0dejRnf/eHwNq3memTN0XnigjVenQviMh+/Hj7icuhZb1BOjywgI
         AOIQ==
X-Gm-Message-State: AOAM531O5g1rmEmqLZLlbI3qmQVC9g6DAy0ucr8QhrudZbFW761o3zk6
        75GaK6K+xxhX3QmBf8jFJ7J7uymx2/z07fQOn64vBqPEYXg=
X-Google-Smtp-Source: ABdhPJx/FmDFbVg6U7+f8zWD9dQz7u0t1Y3O/0rcVHlTq7FZM3OaV5Cp3DElVYlhAwovztLHGmt1Nj+tJeGepzc1Fcs=
X-Received: by 2002:a25:8149:0:b0:623:bc3c:be06 with SMTP id
 j9-20020a258149000000b00623bc3cbe06mr12366407ybm.223.1646743826531; Tue, 08
 Mar 2022 04:50:26 -0800 (PST)
MIME-Version: 1.0
References: <20220225155622.585621-1-ahamedhusni73@gmail.com> <818eb53d-0ca5-d0dc-4a06-37615a5c4c3b@xs4all.nl>
In-Reply-To: <818eb53d-0ca5-d0dc-4a06-37615a5c4c3b@xs4all.nl>
From:   Ahamed Husni <ahamedhusni73@gmail.com>
Date:   Tue, 8 Mar 2022 18:20:14 +0530
Message-ID: <CAFjpAKpyDeEKvA9TEK0KbKVHFN8KSMDZKF=L2Azq_7cuAhHH4A@mail.gmail.com>
Subject: Re: [PATCH] media: av7110: av7110_av: Fix Switch and Case Same Indent
 Style Error
To:     Hans Verkuil <hverkuil@xs4all.nl>
Cc:     mchehab@kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
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

Hello Hans,

On Mon, Mar 7, 2022 at 12:58 PM Hans Verkuil <hverkuil@xs4all.nl> wrote:
>
> Hi Husni,
>
> Thank you for the patch.
>
> The Subject line needs some work: either name the source ('av7110_av.c:') or
> driver ('av7110:'), but not both. Also just stick to lower case, so:
> "media: av7110_av.c: fix switch indentation"
>
> That gives all the relevant information, and is a lot shorter.
Noted with thanks. I'll update the subject line in the V2 of the patch.

>
> On 2/25/22 16:56, Husni Faiz wrote:
> > This patch fixes "switch and case should be at the same indent"
> > checkpatch error.
> >
> > Signed-off-by: Husni Faiz <ahamedhusni73@gmail.com>
> > ---
> >  drivers/staging/media/av7110/av7110_av.c | 30 ++++++++++++------------
> >  1 file changed, 15 insertions(+), 15 deletions(-)
> >
> > diff --git a/drivers/staging/media/av7110/av7110_av.c b/drivers/staging/media/av7110/av7110_av.c
> > index 91f4866c7e59..1d42862e9669 100644
> > --- a/drivers/staging/media/av7110/av7110_av.c
> > +++ b/drivers/staging/media/av7110/av7110_av.c
> > @@ -770,22 +770,22 @@ static void p_to_t(u8 const *buf, long int length, u16 pid, u8 *counter,
> >       if (length > 3 &&
> >            buf[0] == 0x00 && buf[1] == 0x00 && buf[2] == 0x01)
> >               switch (buf[3]) {
> > -                     case PROG_STREAM_MAP:
> > -                     case PRIVATE_STREAM2:
> > -                     case PROG_STREAM_DIR:
> > -                     case ECM_STREAM     :
> > -                     case EMM_STREAM     :
> > -                     case PADDING_STREAM :
> > -                     case DSM_CC_STREAM  :
> > -                     case ISO13522_STREAM:
> > -                     case PRIVATE_STREAM1:
> > -                     case AUDIO_STREAM_S ... AUDIO_STREAM_E:
> > -                     case VIDEO_STREAM_S ... VIDEO_STREAM_E:
> > -                             pes_start = 1;
> > -                             break;
> > +             case PROG_STREAM_MAP:
> > +             case PRIVATE_STREAM2:
> > +             case PROG_STREAM_DIR:
> > +             case ECM_STREAM     :
> > +             case EMM_STREAM     :
> > +             case PADDING_STREAM :
> > +             case DSM_CC_STREAM  :
> > +             case ISO13522_STREAM:
> > +             case PRIVATE_STREAM1:
> > +             case AUDIO_STREAM_S ... AUDIO_STREAM_E:
> > +             case VIDEO_STREAM_S ... VIDEO_STREAM_E:
> > +                     pes_start = 1;
> > +                     break;
> >
> > -                     default:
> > -                             break;
> > +             default:
> > +                     break;
> >               }
> >
> >       while (c < length) {
>
> Running checkpatch.pl over this patch give me:
>
> ERROR: space prohibited before that ':' (ctx:WxE)
> #40: FILE: drivers/staging/media/av7110/av7110_av.c:776:
> +               case ECM_STREAM     :
>                                     ^
>
> ERROR: space prohibited before that ':' (ctx:WxE)
> #41: FILE: drivers/staging/media/av7110/av7110_av.c:777:
> +               case EMM_STREAM     :
>                                     ^
>
> ERROR: space prohibited before that ':' (ctx:WxE)
> #42: FILE: drivers/staging/media/av7110/av7110_av.c:778:
> +               case PADDING_STREAM :
>                                     ^
>
> ERROR: space prohibited before that ':' (ctx:WxE)
> #43: FILE: drivers/staging/media/av7110/av7110_av.c:779:
> +               case DSM_CC_STREAM  :
>                                     ^
> Can you fix that as well in a v2 of this patch?
It seems that these spaces are deliberately added by the author to
keep the case statements' colons aligned.
Some other lines in the file where the same approach has been taken
are [line 598,599,600,601] and [line 662, 663, 664, 665].
Should we leave these spaces as it is?

Thanks,
Husni.
