Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46B40537523
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 09:24:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232461AbiE3GS2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 02:18:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229999AbiE3GSW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 02:18:22 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 386A53DA6A;
        Sun, 29 May 2022 23:18:21 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id r9-20020a1c4409000000b00397345f2c6fso2189635wma.4;
        Sun, 29 May 2022 23:18:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=wCa0ONUW/7eLmIEW6Vz4vrdmuGmLGHrFxs6lE7bBuXU=;
        b=WQNxH5GXICW2z2T718ddf8FqcP/+YTOH9cw6SHXfZkb2DxzfqOf+NCiGqm+R3jDhVB
         v8lifuDLDw4rGxnA/jqbe4KEDbwn++GLYJMsvguZBDOphAxkdcsHYpTfO4PAJrwvG1uP
         Wr+Ar4sy9PRgpaik9/PoGnDla9wxGSbZFuVtFpAak9FUSJdk0cBIrLPSa9PKHyU0eMDU
         qnhS4XD9YCpKoo4sEpvkAHct+v2TZDBiyx26W7rR6xKcx6EXpPnH5BSW8kR0T+2vULY1
         8QylNTU3DmFo6D8HN0O4GogC/CoBc0BGAfWAU0Dg54WcyqwWq8TRzjYXc4Qe3Itr5p+A
         lAEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=wCa0ONUW/7eLmIEW6Vz4vrdmuGmLGHrFxs6lE7bBuXU=;
        b=rvuNj+8Ca0c79wiH20XBAVl0cDLjs6gSbW4QwJRl0xXDPyrv2lg2uByQbLYzuYdtOd
         0m55D5YZV1D7SRAPqF5pOzbWO1Hq9LGm0AUcZesQg/JzflbH5SSZIuSq8WLStr7IyUx1
         T3y5RoFYNqEJSSUoETFjkymlZMccoUUMdIUh07jUdP4xiqrGI+uX7RvD/w8FQGqjsCGG
         yJRPA3ROjvNDbxJ601YcGfkUMbBdhDoKruj3Gm1MGN3F8xVkNwyEIfwQ+G7059WwDRb/
         XlmwhAI1KXlS9HVFnfUtNxA9JzCkxElckkROLHVxX6ARTAhyymdQKHV4ee/AIuSvfFI/
         0S5w==
X-Gm-Message-State: AOAM533MGIk6bax+9V4YGBqWHCyq4rXn4m8zwfZL8yJGNvVYsPkIk2B+
        Zw3M4GgQ+cFNhLhfRacUrp8=
X-Google-Smtp-Source: ABdhPJwZxR8QK122CwRNpoQJgvt+f45BUE1wlGtlEHnyElslssmbLiRRUEXk0uDUWlJl6mjiVUYizA==
X-Received: by 2002:a05:600c:3583:b0:397:3d93:75b8 with SMTP id p3-20020a05600c358300b003973d9375b8mr16994338wmq.76.1653891499648;
        Sun, 29 May 2022 23:18:19 -0700 (PDT)
Received: from elementary ([94.73.36.128])
        by smtp.gmail.com with ESMTPSA id j13-20020a05600c1c0d00b00397243d3dbcsm9899256wms.31.2022.05.29.23.18.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 May 2022 23:18:19 -0700 (PDT)
Date:   Mon, 30 May 2022 08:18:12 +0200
From:   =?iso-8859-1?Q?Jos=E9_Exp=F3sito?= <jose.exposito89@gmail.com>
To:     Hilton Chain <hako@ultrarare.space>
Cc:     bryancain3@gmail.com, jikos@kernel.org,
        benjamin.tissoires@redhat.com, linux-kernel@vger.kernel.org,
        linux-input@vger.kernel.org
Subject: Re: [PATCH] HID: apple: Reset quirks when Fn key is not found
Message-ID: <20220530061812.GA10391@elementary>
References: <20220529180230.17e9a0f9@ultrarare.space>
 <20220529182036.10226-1-jose.exposito89@gmail.com>
 <20220530083752.1973a905@ultrarare.space>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220530083752.1973a905@ultrarare.space>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 30, 2022 at 08:42:32AM +0800, Hilton Chain wrote:
> > My understanding of Bryan's patch (in cc) was that the new config option
> > worked out of the box for Keychron and Apple keyboards and allowed for
> > manual configuration where required.
> >
> > Could you explain a bit which bug is fixed by reverting these 2
> > commits, please? I don't own a Keychron keyboard for testing, so it is
> > not obvious to me why this change is required.
> 
> I own a GANSS keyboard which encounters this issue as well, related device
> information given by `lsusb -v` below:
> 
>     idVendor           0x05ac Apple, Inc.
>     idProduct          0x024f Aluminium Keyboard (ANSI)
>     iManufacturer           1 SONiX
>     iProduct                2 USB DEVICE
> 
> As I searching through, I found similar reports regarding another GANSS
> model[1], and other brands like Varmilo[2] (a lot!) and Keychron. As a
> common pattern, they mostly use 05ac:024f.
> 
> Currently I have two idea:
> 
> 1. Modify Bryan's patch, so that fnmode default to 2 if device name not
> starting with "Apple" (But I can't validate my assumption since I don't
> own any Apple keyboards), I'll attach this patch in the next email.

That could be problematic because Apple keyboards can be renamed after
connecting them to a Mac.

For example, the name of my keyboard is: "José Expósito’s Keyboard".
 
> 2. Find out which quirk pattern solves this issue brute-forcely, I may
> attach this patch later when I finally find a solution.
> 
> What's your opinion?
> 
> Stay boiled,
> Hilton Chain
> 
> ---
> [1]: https://www.amazon.com/gp/customer-reviews/R1EV0B1FG21GGD
> [2]: https://unix.stackexchange.com/questions/604791/keyboard-function-keys-always-trigger-media-shortcuts-regardless-of-whether-fn

I think it'd be safer to assume that the device is an Apple keyboard
and create exceptions for know non-Apple keyboards  because the
majority of the devices handled by this driver are Apple keyboards and
because there is already a config option available (real_fnmode) to fix
the problematic devices in the meanwhile.

In my opinion, creating a function like "apple_is_non_apple_keyboard"
(or similar) containing all the rules to identify devices from
Keychron, GANSS, etc could do the trick. Something similar to:

  if (apple_is_non_apple_keyboard(hdev)) {
          hid_info(hdev, "Non-apple keyboard detected; function keys will default to fnmode=2 behavior\n");
          asc->quirks |= APPLE_IS_NON_APPLE;
  }

Unfortunately, I can't think of a generic way to detect those devices
as they have the same vendor and product as the Apple ones :S

Best wishes,
Jose
