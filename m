Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A18A4D9FCC
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 17:19:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349983AbiCOQUU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 12:20:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349980AbiCOQUS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 12:20:18 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD98024095
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 09:19:04 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id h10so21351903oia.4
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 09:19:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=IcWUs6pXL9TSfsOL915UYAmnTIoLdxHaRaQlaAHskdo=;
        b=fC7D4ln/VQfMzj10H2cDBMwXHWhwmi/bYBuuiME3ozr3PtrxThNWwSieW9Js8ihLCp
         ypoQwifiWuUf/ZxU3od5Odj36c/EzCWh45p3wPqqd88bhCGCI6NDW7sDp8vWxBQpZQaA
         FOhruyBve0+Q8agnJAvdH9HbSOMlR/bQ4B8gY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=IcWUs6pXL9TSfsOL915UYAmnTIoLdxHaRaQlaAHskdo=;
        b=ed1cXyxcmDLA/p8Hq0qFfDui1K+LpJFfd7C6LIjEVdIc0YfeL5vTFGDcTkxv2mV5Ij
         HAyooHmonRjwhZP4flAJEaxlV1pGcZYotlNCO7n6GwiXz9ZID0WmCg9OxlLkZbdUp3S0
         D0ErrATZmo2sp+b5h3g5iNJF6FuB7EEktKpjb0uMPeF4yLCMT7HNjg7IU/VoJ3i+Wj4j
         DnI9xA6jtolN577zSU0VXZJtodFeKvpgfi3mAFdZ42e6UtIe92FwlnnEvNo/yfrcav0C
         yvyadDDL9AyMzbutAvxBU2Od8fySb6T6EwlPXslm3P7C0oUiLuQ9wUt9lLN28zdSYMwi
         +Q3w==
X-Gm-Message-State: AOAM532gfIFLcLuV0HLUtk/aiq0AjgqxflGwTPbfsGKWA6qoyOeiKUhh
        qPmSSk1600lmnbG4/1+YeCAthrpLtyeBeOXfC4hHUU0UERs=
X-Google-Smtp-Source: ABdhPJzDk4xareUQkBQSNZRxRSYxzoeY5zSgGoPp9z3/x9XlUjsIxuVm1HaN2n2bXuM1Gl/1/KDfzaA7lh5uiELirgc=
X-Received: by 2002:aca:a9c8:0:b0:2da:45b6:b796 with SMTP id
 s191-20020acaa9c8000000b002da45b6b796mr1986232oie.193.1647361144031; Tue, 15
 Mar 2022 09:19:04 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 15 Mar 2022 11:19:03 -0500
MIME-Version: 1.0
In-Reply-To: <YjC1OLsB8/JXLEzF@google.com>
References: <20220314232214.4183078-1-swboyd@chromium.org> <20220314232214.4183078-2-swboyd@chromium.org>
 <e7f9466e-03c9-7754-0dc6-a04823d1047a@canonical.com> <YjB0JOKysPpg2KGF@google.com>
 <9ec3c26a-3b85-4bea-5a5b-de9ac570cfca@canonical.com> <YjB46Sq3IwvgR8MB@google.com>
 <CAE-0n51uDh2Cf_wGpAVH1t=T0A1eTT=+KU3WMtxtyPL3kLDAdA@mail.gmail.com> <YjC1OLsB8/JXLEzF@google.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Tue, 15 Mar 2022 11:19:03 -0500
Message-ID: <CAE-0n511YyyfXoCOKpzm3ca0-sE9_wpby31XDu-eGQts=-kV2Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: mfd: Add ChromeOS fingerprint binding
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Benson Leung <bleung@chromium.org>,
        linux-kernel@vger.kernel.org, chrome-platform@lists.linux.dev,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Guenter Roeck <groeck@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Craig Hesling <hesling@chromium.org>,
        Tom Hughes <tomhughes@chromium.org>,
        Alexandru M Stan <amstan@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Lee Jones (2022-03-15 08:48:08)
> On Tue, 15 Mar 2022, Stephen Boyd wrote:
>
> > Quoting Lee Jones (2022-03-15 04:30:49)
> > > It's tough to say from what I was sent above.
> > >
> > > But yes, sounds like it.
> > >
> > > We do not want any device 'functionality' in MFD ideally.
> > >
> >
> > I put it next to the existing cros-ec binding. The existing binding is
> > there because of historical reasons as far as I know. Otherwise it
> > didn't seem MFD related so I didn't Cc mfd maintainer/list. New file
> > additions don't usually conflict with anything and this is in the
> > bindings directory so the driver side maintainer would be picking up the
> > binding.
>
> That's not how it works unfortunately.
>
> This file is located in the MFD bindings directory, so I would be
> picking it up (if it ends up staying here).

The way it works is arbitrary and up to maintainer's choice. I'll move
it out of the mfd directory :)
