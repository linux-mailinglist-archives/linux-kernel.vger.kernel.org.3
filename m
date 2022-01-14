Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E1F448F0B9
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 20:59:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244193AbiANT7z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 14:59:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbiANT7z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 14:59:55 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 067C6C061574;
        Fri, 14 Jan 2022 11:59:55 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id f13so3705169plg.0;
        Fri, 14 Jan 2022 11:59:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=D0wKk3vGKLq9UCyFJhVh9PflC/XZziG3O4cSoYLFQ14=;
        b=CMGGmJ6D3NMsRS4cRVv7aywNPWWrW3P/NYH+BuqdX73hVb24Xw4ruWbjUtGgua+dDa
         g7HSHshblLY2yOYIwtAWsouqlwb4tu38D2UL1hM2fC/N3T8kLA8i1VXQ8CO430ag2B5M
         mfm2TwS+IPJ/KnkbQAq7cA/+3PB0PMr+XAjINM7eL1u7YKRlOBTYVQ9xWpVXG/jaBLn2
         +x7GvAulvRNdRhrmSieJjNEwxKTzeN5ZP6PF1LvJhBRrdsGdUmm0pSL+Ap8HyVLBWVvL
         ySuqjvBYN9OK0enYKzEOksdLASixmODRrAsAjhjILS/rrtVZRBJBG8Z8aq2l4vSOUQwx
         3ssg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=D0wKk3vGKLq9UCyFJhVh9PflC/XZziG3O4cSoYLFQ14=;
        b=izF2V6qIdAmZEIIX+v0z/k3o8pHf5izlB+S90xxs6gsmkvxh8tF5Iscn3QS3mCfuqc
         HCYNpKQGD73ipDRlaUv2ENR0YdIcayDv5FsbVybOtna+w4Ky4EHU527Icu9yXSR8EeWh
         Uk/k4SEvyyFpdytMkgPv2YgbzP4LRP+sDApe+2i0XjSyqoOkYupFbCJXG5CSOXlZh61H
         X2fNLmreZntkrUvg207M9lHwy3tf1d0lBU8QaBQiwMArtdzfTgTeY78k7Nz28Gx6ay47
         JZrFKRv4frgFSWruIKvoACdlSUu2oJ2/RGHxF9xTf07siyaoQjl3NnJFMzJfa4eLCx3m
         WP4w==
X-Gm-Message-State: AOAM533m9YbHorvGkn/fMKVXXpe6QRzFPTIQfwyBvz5JSKOjf27osBRr
        jyI0fjHtoqH96DCrtZcLZt8=
X-Google-Smtp-Source: ABdhPJydHKeHi0WAuDG7E8O8JcRh2QkqgprHJfyoPXoR9K601QF4x+ZcgLz720gFAD+4TaRmv1aK0w==
X-Received: by 2002:a17:90a:4214:: with SMTP id o20mr12625102pjg.80.1642190394344;
        Fri, 14 Jan 2022 11:59:54 -0800 (PST)
Received: from google.com ([2620:15c:202:201:20f0:3cd3:13fc:6b46])
        by smtp.gmail.com with ESMTPSA id n15sm11813121pjj.12.2022.01.14.11.59.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jan 2022 11:59:53 -0800 (PST)
Date:   Fri, 14 Jan 2022 11:59:50 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Jiri Kosina <jikos@kernel.org>,
        Zhengqiao Xia <xiazhengqiao@huaqin.corp-partner.google.com>,
        benjamin.tissoires@redhat.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, dianders@chromium.org,
        Wei-Ning Huang <wnhuang@google.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Sean O'Brien <seobrien@chromium.org>, phoenixshen@chromium.org
Subject: Re: [PATCH v2] HID: google: modify HID device groups of eel
Message-ID: <YeHWNtl0Or1dgadz@google.com>
References: <20220107091357.28960-1-xiazhengqiao@huaqin.corp-partner.google.com>
 <nycvar.YFH.7.76.2201140935460.28059@cbobk.fhfr.pm>
 <CAE-0n53M723sZ7H-f0SF=AoTrwznmTRhKPapgHe5H7Mw6bPb7Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAE-0n53M723sZ7H-f0SF=AoTrwznmTRhKPapgHe5H7Mw6bPb7Q@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 14, 2022 at 01:25:12PM -0600, Stephen Boyd wrote:
> Quoting Jiri Kosina (2022-01-14 00:38:23)
> > On Fri, 7 Jan 2022, Zhengqiao Xia wrote:
> >
> > > If HID_GROUP of eel is set to HID_GROUP_GENERIC, Whiskers Tablet
> > > Mode Switch of eel hammer will not be detected by system. when it
> > > is set to HID_GROUP_VIVALDI, system will detect Whiskers Tablet
> > > Mode Switch successfully.
> > >
> > > Signed-off-by: Zhengqiao Xia <xiazhengqiao@huaqin.corp-partner.google.com>
> > > ---
> > >  drivers/hid/hid-google-hammer.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/hid/hid-google-hammer.c b/drivers/hid/hid-google-hammer.c
> > > index 0403beb3104b..e5acd15f4a55 100644
> > > --- a/drivers/hid/hid-google-hammer.c
> > > +++ b/drivers/hid/hid-google-hammer.c
> > > @@ -585,7 +585,7 @@ static void hammer_remove(struct hid_device *hdev)
> > >  static const struct hid_device_id hammer_devices[] = {
> > >       { HID_DEVICE(BUS_USB, HID_GROUP_GENERIC,
> > >                    USB_VENDOR_ID_GOOGLE, USB_DEVICE_ID_GOOGLE_DON) },
> > > -     { HID_DEVICE(BUS_USB, HID_GROUP_GENERIC,
> > > +     { HID_DEVICE(BUS_USB, HID_GROUP_VIVALDI,
> > >                    USB_VENDOR_ID_GOOGLE, USB_DEVICE_ID_GOOGLE_EEL) },
> > >       { HID_DEVICE(BUS_USB, HID_GROUP_GENERIC,
> >
> > Color me confused, but anything with HID_GROUP_VIVALDI should be matched
> > by hid-vivaldi driver, so what is this about?

We need this particular chunk because hid_scan_collection() forces all
devices that declare usage 0x01 from the Google Vendor page to be marked
as HID_GROUP_VIVALDI, so without it the hammer driver will not match
eel.

However this change (I believe) will break vivaldi functionality
(reporting of the top row map) so we can't apply this as is.

> >
> 
> My understanding is that 'vivaldi' is mostly a keyboard layout and
> 'hammer' is a detachable keyboard. We want to prevent the hid-vivaldi
> driver from probing this particular device because the hid-vivaldi
> driver doesn't know about detachable keyboards. Hammer devices also
> support 360 degree wraparound so we know that the keyboard has been put
> behind the screen or that it's being used to stand up the device on a
> table.
> 
> Given all that, I'm still confused. If we make the hid-google-hammer
> driver probe this device and the keyboard layout is vivaldi then we'd
> want the part of the vivaldi driver that exposes the
> function_row_physmap through sysfs. Otherwise userspace won't know how
> to handle the function row properly. I think we need the device to stack
> two drivers here. Does that happen with HID?

As far as I know HID does not easily allow "stacking" drivers like that.

Probably the easiest way would be to export vivaldi_feature_mapping()
and the show method for the physical row map and call them from the
hammer driver.

Thanks.

-- 
Dmitry
