Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A07434FA200
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 05:39:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238520AbiDIDlD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 23:41:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235967AbiDIDlB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 23:41:01 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EE801DA65;
        Fri,  8 Apr 2022 20:38:55 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id j20-20020a17090ae61400b001ca9553d073so11439107pjy.5;
        Fri, 08 Apr 2022 20:38:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=4kW6FydV/PjRulHBLjg8FFc7AELt+xTBn6rJtJ/7Z3c=;
        b=BP+uU78vxtDZN4Xm5ywuhdjycXWz+VIU8GvP0gjEWukx5Z2Ja2xf5u4RoU71+zIj/5
         lDsnQ4A9dIepxyOo0uTLKXzilSZist1sqkUdj41x2oB3wEoAHZi5TVpfeYbKBiUvw4Gd
         Yjm6C0q6sFXXB/xjofZrcLMAJrgNXPHPGbyFlI7sP15rYgDHIWJ5M+eNPoYkMDmy1mro
         KJHoFFTnCXMLv/PyTAPPSnU2GBLhbDESUlkoqy/j2dbl8juOnA5FcM2/qJyaqX59iLVB
         8NTRUPFMVqAhYqKgINyKvAF0/GsFFz2qxpml67xt0IfxmzBVzd5lnSiJwbGM1JW60q4j
         3zsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4kW6FydV/PjRulHBLjg8FFc7AELt+xTBn6rJtJ/7Z3c=;
        b=jJzXs/0x4HHOX0hbg+22th30OwvHrWNel37CDu0/CZdUi7s9wS5Pql/mry7icdCw6S
         OnOHl82VWriCUC/bqR5/Rnb3Ze3A+6LjKJVUmpIEvtN7BSwx+mdlomVrfygLRFTq5t3H
         3wkGog3cEat4NT3LJhibgdc9O4sNYqfqwo9LrSSgsGK5yRBOrpm9HeodXpv58HJRsxwt
         0yOG56OqjeNrJCck9Sl+b0GxHs6AkE7HR5Qg/RbK/a8VIFQmyLcjibMfGmeAlgTJMiaZ
         5DSepTuHpSJ7yPh4VL0ZYIpwOLzvXY/5jru8zKO/F1q3S7JQhIilCNvALFB2wyFZnHHI
         jurw==
X-Gm-Message-State: AOAM530DDhHvd1iFu/ql/OFGCvyLJtoTvTEIIFoWdor7aADmskUSmLN5
        31JhHhGN1LGqm9P5ymjIeX5Xa7lEyhU=
X-Google-Smtp-Source: ABdhPJzVORQVyXGasfyRNMzAk5TI/onlAf9A6vFjgmMXisiB4YmRrdflwkcSGAkdItT0z6Bm6InXBw==
X-Received: by 2002:a17:902:d2d2:b0:156:cda5:e8a1 with SMTP id n18-20020a170902d2d200b00156cda5e8a1mr22449512plc.85.1649475534796;
        Fri, 08 Apr 2022 20:38:54 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:9186:332c:bcb2:4506])
        by smtp.gmail.com with ESMTPSA id fa11-20020a17090af0cb00b001ca6e27a684sm13090637pjb.16.2022.04.08.20.38.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Apr 2022 20:38:54 -0700 (PDT)
Date:   Fri, 8 Apr 2022 20:38:51 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Shelby Heffron <Shelby.Heffron@garmin.com>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] input: Add Marine Navigation Keycodes
Message-ID: <YlD/y3zwnJChSaPF@google.com>
References: <20210622235708.8828-1-matthew.stephenson2@garmin.com>
 <20220126211224.28590-1-Shelby.Heffron@garmin.com>
 <Yg9EmVAHpEpmnLok@google.com>
 <20556881-1d16-4718-f28c-4a32946d2ecb@garmin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20556881-1d16-4718-f28c-4a32946d2ecb@garmin.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shelby,

On Thu, Mar 03, 2022 at 05:28:52PM -0600, Shelby Heffron wrote:
> Hi Dmitry,
> 
> We would like to take a step back and describe our application in more
> detail. We are supporting global physical keys on devices such as boat
> steering wheels that will interact with multiple marine navigation
> displays on the vessel. Could you please provide some further
> suggestions based on our requested keys and the description below.

Thank you very much for the detailed explanation.

> 
> Our marine displays usually show a single fullscreen application which
> may show multiple types of data at the same time. For example, the
> application may be showing a map, RADAR, and some media controls at the
> same time. There can also be a control bar at the bottom of the screen
> giving options to do things like return to the home page or open a menu.
> Multiple network-connected marine displays can interact with each other
> to share a single keyed input device across them. In this setup, there
> will only be one active focus for the set of those connected devices.
> For multi-display setups, the focus can transition between displays
> either through the use of dedicated keys to immediately move the focus
> to the previous or next display or the focus can transition between
> displays automatically (e.g. when the user requests to move the focus to
> the next element but we're already at the current display's last element
> we will move the focus to the first element of the next display).
> 
> For the elements displayed on a single marine display, our UI supports
> grouping them together into containers which function somewhat similarly
> to a group of radio buttons in a more-traditional application. We would
> place the previously mentioned map, RADAR, media controls, and bottom
> bar each into their own container. Containers also get used for things
> like menu pages where we have a list of items to scroll through and a
> separate list of buttons that can be used to take actions on the
> currently selected item. The focus can move between items within a
> container by using keys like up, down, left, right, next highlight, and
> previous highlight. To make navigating between these containers more
> convenient, we have a focus key that moves to the next container. This
> focus key behaves similarly to the tab key with a traditional
> application that has multiple sets of radio buttons, but we also have
> support for embedding traditional keyboard input into one of these
> containers where we would need KEY_TAB to behave normally. Our focus key
> does not change the visibility of anything on screen, which made it feel
> a little different than the description of KEY_CYCLEWINDOWS from the
> video remote controller documentation
> (https://www.kernel.org/doc/html/v4.9/media/uapi/rc/rc-tables.html), so
> our initial proposal avoided repurposing that event code.
> 
> >> +/* Toggle the focus in or out */
> >> +#define KEY_FOCUS_TOGGLE        0x27b
> >
> > Could it be served by KEY_SELECT?
> >
> 
> We have a select key on our marine display which is used for actions
> like to select/press the currently-focused button or behave similarly to
> a left mouse click when moving a cursor around on a map. We'd planned on
> using KEY_SELECT for that since its proximity to KEY_OK made us think it
> was intended to confirm selection of an item rather than to select the
> next item.
> 
> In our application, the focus key will move between containers on the
> same display, but we felt it was different than KEY_CYCLEWINDOWS or KEY_TAB.

I see. In HID spec we have consumer code 0x1A3 AL Next Task/Application
that seems to be fitting the bill. And we map it to KEY_NEXT (to which
you voicing the concerns below). But HID also defines

0xb5 Scan Next Track - Moves to the next chapter or track boundary
0xb6 Scan Previous Track - Moves to the previous chapter or track
boundary

that we map to KEY_NEXTSONG and KEY_PREVIOUSSONG and I recommend your
media application(s) to use those for media controls.

> 
> >> +/* Move between highlightable items */
> >> +#define KEY_NEXT_HIGHLIGHT        0x27c
> >> +#define KEY_PREVIOUS_HIGHLIGHT        0x27d
> >
> > I wonder if KEY_NEXT and KEY_PREVIOUS would be suitable for your
> > application.
> >
> 
> KEY_NEXT/KEY_PREVIOUS seemed to be designated as media-related to
> control chapters in the remote controller documentation, so our initial
> proposal avoided repurposing those event codes. We anticipate needing
> keys for next chapter/previous chapter to control our media inputs in
> the future, so using KEY_NEXT/KEY_PREVIOUS for highlight movement now
> could lead to conflicts for us down the road.
> 
> In our application, the next/previous highlight will transition the
> focus to elements within the same UI container.

OK, I see. Could we call them KEY_NEXT_ELEMENT/KEY_PREV_ELEMENT maybe?
And I would like to see comments describing intended use.

> 
> >> +/* Navigate Displays */
> >> +#define KEY_NEXT_DISPLAY        0x27f
> >> +#define KEY_PREVIOUS_DISPLAY        0x280
> >
> > I am not familiar with marine navigation devices, could you please
> > explain a bit more about displays you are navigating. Are there separate
> > physical screens or are there several application screens/views you are
> > switching between?
> >
> 
> Correct. These are separate physical screens. These keys would
> transition the current highlight between separate physical screens that
> are located next to each other.

OK, so we have the following keycodes:

KEY_SWITCHVIDEOMODE
KEY_VIDEO_NEXT
KEY_VIDEO_PREV

They are intended to request to switch between physical displays (see
drivers/acpi/acpi_video.c) and were introduced specifically for that in 
a7ecd1ea913346a72f41a002c365882dc05c9bd5.

The comments on KEY_VIDEO_NEXT and KEY_VIDEO_PREV are unfortunate, I'll
need to fix that, and their use in hid-input.c,
rc-terratec-cinergy-c-pci, and rc-tivo are not correct. I think,
however, that there are not a lot of systems where we have combination
of multiple signal sources, and multiple output displays, so probably
this clash does not matter in practice.

> 
> 
> >> +#define KEY_BRIGHTNESS_MENU        0x28c
> >
> > Do you have multiple menus in the application?
> >
> 
> Our marine displays do have multiple menus. This physical key will bring
> up a menu to immediately adjust the display brightness. Our displays go
> extremely bright and extremely dim to support outdoor use during the day
> or at night. This physical key can be used to quickly adjust brightness.

OK, then we shall have it.

Thanks.

-- 
Dmitry
