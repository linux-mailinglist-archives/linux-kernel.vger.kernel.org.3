Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64779501DED
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 00:02:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343741AbiDNWE3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 18:04:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245136AbiDNWEJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 18:04:09 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7278DA1461
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 15:01:38 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id bg24so6306248pjb.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 15:01:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cs-iitr-ac-in.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+1mAXBLJMi+kcuQeqEFVkpTFAdTtHWNKfLqhzSS5OcA=;
        b=5iZlroAPeAixTJjDn18L8Y9yKhNMqDK3hGvkINQHBuwcb5YLIBNaC3BS+j5BKTyqcR
         cDoB0g0EuVoS+Z2ISoJRCg13dvV0F5I1pFC54oS8KBsrOWFLm0jIb24aU3IuBrppLILW
         yEx5sNBMxh9jqaiLqI+XGwAEi9H6ecRhxUg8BqXDg6tN3D2zwDssaRceUW3qJrZt7QPI
         lGhvRUBw1YG0lS+NdpMSdt9hDiaRpzGSYTVj+8BO6xpoS6cCW6cVDhXNLJCZDu1nG2GU
         siCzR6BUcNY0ZQg9RZUU6LhhQsvKpu/eMPEjaNs68u0Ja6kBa6FbwLiZpim1Mq2/+U+L
         4bdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+1mAXBLJMi+kcuQeqEFVkpTFAdTtHWNKfLqhzSS5OcA=;
        b=06now7n+UAUFneAHadV1ARt1P20Yp6uBglNVtci3AHi57e8OgmlfsZ+03orZSJs2ST
         74a0CJJIyZ1+B0peHwRzA0r9d2ayJR33ulxK/T+jPexercDZWI3O74zm+QQXgJTgfNp9
         +w4q8+IiFeMi7rMkB+WAAmaEHEOFbiBbx5AId8P8/iz5oPf+WUnTWiwXgvbsmGf11TFo
         N7dxzpQ7pXHGxpjtP9twjXk7gCW670YEf9mxZFlr0yI4rhkNZWA0E7PDbDTtYB+5omSN
         NbufHBQ9EP0Y/8WiBQh1ty+ZGDuMPThaUCMPgb+WDIFWYWWaWEhJCvDZ8MOTVGELM2Hd
         ZgLg==
X-Gm-Message-State: AOAM532EQSZfCPwI8zqhcIyFEHMIrs7tsAATI5ddRI5BNe9kgXJ4Bx1p
        pwlXMm25jjd0KokPslQ2pRBlQTE3P9LwI+JSp7WnG8dl9jSW/r6S
X-Google-Smtp-Source: ABdhPJzBg71n2jrzmvI+0rKVKOoXVlTxmkLk67ypF754KAV0kb2sXxy/YPgmPGRgU9H+I3xwx6rsCLK9Wr2dpN3XkYM=
X-Received: by 2002:a17:90b:4c41:b0:1c7:3fa8:9b6a with SMTP id
 np1-20020a17090b4c4100b001c73fa89b6amr716180pjb.120.1649973697898; Thu, 14
 Apr 2022 15:01:37 -0700 (PDT)
MIME-Version: 1.0
References: <20220413052759.4859-1-mahak_g@cs.iitr.ac.in> <20226182-81b2-92b9-d286-d9520a1d568b@lwfinger.net>
In-Reply-To: <20226182-81b2-92b9-d286-d9520a1d568b@lwfinger.net>
From:   MAHAK GUPTA <mahak_g@cs.iitr.ac.in>
Date:   Fri, 15 Apr 2022 03:31:00 +0530
Message-ID: <CANnaPbDceguo6K2FeZ1OT8Woz9-RYJyn+gptsVTXnaLstTz+zQ@mail.gmail.com>
Subject: Re: [PATCH] staging: r8188eu: remove else after return and break statements
To:     Larry Finger <Larry.Finger@lwfinger.net>
Cc:     Phillip Potter <phil@philpotter.co.uk>, gregkh@linuxfoundation.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,
        T_SPF_TEMPERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Larry and Pavel,
On Wed, Apr 13, 2022 at 10:21 PM Larry Finger <Larry.Finger@lwfinger.net> wrote:
>
> On 4/13/22 00:27, Mahak Gupta wrote:
> > Else is not necessary after return and break statements, hence remove
> > it.
> >
> > Reported by checkpatch:
> >
> > WARNING: else is not generally useful after a break or return
> >
> > Signed-off-by: Mahak Gupta <mahak_g@cs.iitr.ac.in>
>
> The commit message is redundant. I would suggest the following:
>
> checkpatch reports the following:
>
> WARNING: else is not generally useful after a break or return
>
> Remove those cases.
This patch is merged by Greg now but I'll keep this in mind for next
patches. Thanks

>
>
> > ---
> >   drivers/staging/r8188eu/core/rtw_ieee80211.c | 41 ++++++++------------
> >   1 file changed, 17 insertions(+), 24 deletions(-)
> >
> > diff --git a/drivers/staging/r8188eu/core/rtw_ieee80211.c b/drivers/staging/r8188eu/core/rtw_ieee80211.c
> > index 5a0e42ed4a47..bb4c9bc864da 100644
> > --- a/drivers/staging/r8188eu/core/rtw_ieee80211.c
> > +++ b/drivers/staging/r8188eu/core/rtw_ieee80211.c
> > @@ -97,16 +97,15 @@ bool      rtw_is_cckratesonly_included(u8 *rate)
> >
> >   int rtw_check_network_type(unsigned char *rate, int ratelen, int channel)
> >   {
> > -     if (channel > 14) {
> > +     if (channel > 14)
> >               return WIRELESS_INVALID;
> > -     } else {  /*  could be pure B, pure G, or B/G */
> > -             if (rtw_is_cckratesonly_included(rate))
> > -                     return WIRELESS_11B;
> > -             else if (rtw_is_cckrates_included(rate))
> > -                     return  WIRELESS_11BG;
> > -             else
> > -                     return WIRELESS_11G;
> > -     }
> > +     /*  could be pure B, pure G, or B/G */
> > +     if (rtw_is_cckratesonly_included(rate))
> > +             return WIRELESS_11B;
> > +     else if (rtw_is_cckrates_included(rate))
> > +             return  WIRELESS_11BG;
> > +     else
> > +             return WIRELESS_11G;
>
> Is this 'else' necessary?
Yeah, we can remove this else too, sorry didn't notice it. Should I
submit another patch removing this?

>
>
> Larry

Mahak
