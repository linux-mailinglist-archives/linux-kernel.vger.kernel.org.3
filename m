Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87EA54B66CC
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 10:01:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235516AbiBOJBV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 04:01:21 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235500AbiBOJBU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 04:01:20 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C401115952
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 01:01:10 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id b13so31072778edn.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 01:01:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=logitech.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=WkhcIWEydrLEu21tGc6bt7TQzVHVN+a5GFEqw2Tp8tE=;
        b=MB06c3iFDV9lwfCDZwEc/OQfwkp5xkFU7/Qlyhdci7nmAsNpWPS+3ZqormO0XrFImA
         yQZy+KF/XIExfT3y6wkBusm7M583EpVm6QSZqQNcorGyjYf3v6LrVlGzkGI8lL7i8Xw2
         skDsBaSt1oZ8aZ3X36F9am5wGhWPBge5+kQfANPUJWKhLbcqXKGsSFDHjdrEuaoZN40E
         YnogateGCCnwa0FeUak+m0wQqYylHXGD1v0TQYw+eKobNUMjH6l2uB6HqDBxJfCRtglp
         JGV0YwpdNTOOKuscBT9bULpjM8n711FW52O2UMf4Igzs7MQyK05IKqb5NDdufS+fUF3P
         tkaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=WkhcIWEydrLEu21tGc6bt7TQzVHVN+a5GFEqw2Tp8tE=;
        b=NQvUzw7NT54jk9LFiU2bq3zbc4jWSDGMsRrUO9l9zgyFVcH7rWZiaBWs9I+PNkmnUd
         zy7lNY49HgQYwVckjLU/DQF5c9U2cHvh7cZ/7lLMLXRdofxolziVHmmsxv9UwM1fIoXq
         aWaXEXFxLmSd2S8ihQGhdSvySLVlEFAZoujKMi9EFciP/1O56GKPbBxr1ZiEgUrLZmoJ
         Ni9GMr09I41bTp83JDMp74pr6yhr5gWNftycwcIIu8CL3lrOgP0gsL1YmFZaoU6anlvS
         +RG+YytSMC1OPRUwz5pfW27xzr9zOg65vWpPxAsuJR6Y6gsbPulUTIskR8+0nWmZEC4Q
         SMrQ==
X-Gm-Message-State: AOAM530gLH3PSSpEdmSWBw6eL/YJ5Yvy7BnF/G5tTbuKcfOKx9D/y4T7
        WNVO5v9bt8+NpoI06c6K710XbkbTjwa8Tvwu4g4cSw==
X-Google-Smtp-Source: ABdhPJwrQw+liqRG/xSGcZ6rv5VuTsffc2RhKNj8UlJLneL8SgpdFmHWnL0Oh0crjcT21on0bpaWjqXxdVukdtHIV8Y=
X-Received: by 2002:a05:6402:51d2:: with SMTP id r18mr2891798edd.88.1644915669053;
 Tue, 15 Feb 2022 01:01:09 -0800 (PST)
MIME-Version: 1.0
References: <20220126144400.130797-1-lzampier@redhat.com> <CAO-hwJ+KyV+Ks38DDF8EuT9kEc9jd9SvNn=nGyTwjkD3GOQ+RA@mail.gmail.com>
 <15ef80cc2ecdcc993043aa0c1d5ea88f41f9b67b.camel@riseup.net>
In-Reply-To: <15ef80cc2ecdcc993043aa0c1d5ea88f41f9b67b.camel@riseup.net>
From:   Nestor Lopez Casado <nlopezcasad@logitech.com>
Date:   Tue, 15 Feb 2022 10:00:42 +0100
Message-ID: <CAE7qMro-ies_7DXhvqWE=aNhGcZKTFGxj9xmU38w12jHTOWbmA@mail.gmail.com>
Subject: Re: [PATCH] HID: logitech-dj: add new lightspeed receiver id
To:     =?UTF-8?Q?Filipe_La=C3=ADns?= <lains@riseup.net>
Cc:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Lucas Zampieri <lzampier@redhat.com>,
        Jiri Kosina <jikos@kernel.org>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 26, 2022 at 3:55 PM Filipe La=C3=ADns <lains@riseup.net> wrote:
>
> On Wed, 2022-01-26 at 15:47 +0100, Benjamin Tissoires wrote:
> > On Wed, Jan 26, 2022 at 3:44 PM Lucas Zampieri <lzampier@redhat.com> wr=
ote:
> > >
> > > As of logitech lightspeed receiver fw version 04.02.B0009,
> > > HIDPP_PARAM_DEVICE_INFO is being reported as 0x11.
> > >
> > > With patch "HID: logitech-dj: add support for the new lightspeed rece=
iver
> > > iteration", the mouse starts to error out with:
> > >   logitech-djreceiver: unusable device of type UNKNOWN (0x011) connec=
ted on
> > >   slot 1
> > > and becomes unusable.
> > >
> > > This has been noticed on a Logitech G Pro X Superlight fw MPM 25.01.B=
0018.
> >
> > The patch looks good to me.
> >
> > Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> >
> > Ideally, Nestor, can you confirm this is expected and that we won't
> > have any bad surprises there?
Yes, I confirm this matches our specifications, this is an iteration
of Lightspeed 1.2
No objections on my side.

> >
> > I think we probably want this to be Cc-ed to stable once it gets
> > merged (we can add the tag as we merge it).
> >
> > Cheers,
> > Benjamin
>
> This is likely a different connection type, so it should probably get its=
 own
> case statement, but let's let Nestor confirm :)
>
> Cheers,
> Filipe La=C3=ADns
best,
-nestor
