Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 979824FD9DD
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 12:46:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349671AbiDLJk3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 05:40:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1389003AbiDLJXT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 05:23:19 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 098AA5131E
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 01:30:07 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id t4so16592987pgc.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 01:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XWETclwf6JoUIZg5dlEwqaDblFeTlFItFp0Uo6O8hgA=;
        b=DbmUl8o/ELO24qYZcr1EjyCqfOmLogZnBKgh6+F+dnfnI6Ehteres7i2KeD2aNPpyy
         qXoJeE+weKzNTV+nfi/axUfIpPQnEIf5Vv6nCu6gnFA+9xKKN2mYrE2Vu90DkFRiwYNn
         t2xrQhuzZVrOssviGmVZ6OBXy4+qi/r2s1PF39cb+zJZuW/Zi70RyXox6I1CCm9k6wbY
         AHX2/yFxwVGdlv6csXfQJFb4vbtNzk9DdFVTqOrvEPvi9lIhlwqP7Da4TcBbK6sXTIri
         iNsZLka25gxyDS/LYMebCsARRfosbo1cXn9QNP3GSi7ptCz6P/Wf4C9Z4zsOB3ZUiqXJ
         bVmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XWETclwf6JoUIZg5dlEwqaDblFeTlFItFp0Uo6O8hgA=;
        b=dydTLw3vXCSMBzcvh8FG4jgAIBSZjRUUUAHkaH5Uf9KPkXi7hpai6ffMa+chG5c7B5
         wbdZNpgVEp3cf1b16OpYpIfd0mFLVw68dtSzdnkTfIwp2OLD/VWahfmSOMCd8sWYhSwv
         Y2U7gR15VNGPYWyoHo6Kpl6t9I4+ZZptaXrPteZr8boWIbmV0cyomLlyOAgv2qM4p33H
         GLDdJcuLmraSoTRwfl1PCXV9R+dShPl/GF5+iNXX5+T2TB7PG/+pKw36JSPSEqy5yF1P
         PmgySCxY7SKWqjlTNWQ+4G3OwyHxr6KCkWHdYknVC48JbWwiDMITlIccsEJVJRw9fL1g
         Yjug==
X-Gm-Message-State: AOAM532c+aWnSjtYpJtjj57KayGcTcqhw4/H5HKUxHN8WD91FzZMlI/W
        6cZ4cP+T+qvIkfJPKE4W7T/ft765SgT6HOlue+I=
X-Google-Smtp-Source: ABdhPJzlX7vyFTNnPifHlAXzBIE9Hdhxk5KyGpsJjbvDXHYtJW17Ksieg2HCtZnhyQCGQjh74BBTgBur/+0ydWZO02I=
X-Received: by 2002:a63:e20:0:b0:385:fe08:52f9 with SMTP id
 d32-20020a630e20000000b00385fe0852f9mr29891822pgl.99.1649752206929; Tue, 12
 Apr 2022 01:30:06 -0700 (PDT)
MIME-Version: 1.0
References: <20220409042321.3184493-1-james.hilliard1@gmail.com>
 <CAMeQTsanEow=zq=MuZLjMqpzybdS=5S0=JrkxuCdT7d5MxpEWQ@mail.gmail.com>
 <CADvTj4rBKzGFch8iVzHu1s+6=P0PcLEwoFi74xd_ormEX+2rMA@mail.gmail.com>
 <CAMeQTsaM363n5F=--xhSTayFqOMNvjTQjqz_aEhby6i-KRVBKQ@mail.gmail.com>
 <CADvTj4o_zyVZxaBz0+kRUF30OW3SKFMuo87r6FE9Qkfn1dVsBw@mail.gmail.com>
 <CAMeQTsbKMxQcDsDRqHsMwqU1BnrcOLwtU7uOrB-1E0z65P79-w@mail.gmail.com> <CADvTj4rR5zt5iFTDrrYfNQ267KV896dHnjJHx6yq=e10+V_Okg@mail.gmail.com>
In-Reply-To: <CADvTj4rR5zt5iFTDrrYfNQ267KV896dHnjJHx6yq=e10+V_Okg@mail.gmail.com>
From:   Patrik Jakobsson <patrik.r.jakobsson@gmail.com>
Date:   Tue, 12 Apr 2022 10:29:55 +0200
Message-ID: <CAMeQTsZyp40ybkNxnYDCR=pvXRzWvtBLkT+i4VPyjNiwwWg0-A@mail.gmail.com>
Subject: Re: [PATCH v3] drm/gma500: depend on framebuffer
To:     James Hilliard <james.hilliard1@gmail.com>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        linux-kernel <linux-kernel@vger.kernel.org>
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

On Tue, Apr 12, 2022 at 3:48 AM James Hilliard
<james.hilliard1@gmail.com> wrote:
>
> On Mon, Apr 11, 2022 at 3:27 AM Patrik Jakobsson
> <patrik.r.jakobsson@gmail.com> wrote:
> >
> > On Sun, Apr 10, 2022 at 10:05 PM James Hilliard
> > <james.hilliard1@gmail.com> wrote:
> > >
> > > On Sun, Apr 10, 2022 at 1:52 PM Patrik Jakobsson
> > > <patrik.r.jakobsson@gmail.com> wrote:
> > > >
> > > > On Sun, Apr 10, 2022 at 9:40 PM James Hilliard
> > > > <james.hilliard1@gmail.com> wrote:
> > > > >
> > > > > On Sun, Apr 10, 2022 at 1:36 PM Patrik Jakobsson
> > > > > <patrik.r.jakobsson@gmail.com> wrote:
> > > > > >
> > > > > > On Sat, Apr 9, 2022 at 6:23 AM James Hilliard <james.hilliard1@gmail.com> wrote:
> > > > > > >
> > > > > > > Select the efi framebuffer if efi is enabled.
> > > > > > >
> > > > > > > This appears to be needed for video output to function correctly.
> > > > > > >
> > > > > > > Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
> > > > > >
> > > > > > Hi James,
> > > > > > EFI_FB is its own driver and not needed by gma500 to drive its
> > > > > > hardware. What makes you think it's required?
> > > > >
> > > > > I wasn't getting any HDMI video output without it enabled for some reason,
> > > > > I assume it is doing some sort of initialization needed by gma500
> > > > > during startup.
> > > >
> > > > Then it sounds like you might just be using EFI_FB and not gma500. Can
> > > > you provide the kernel log with drm.debug=0x1f set on kernel
> > > > command-line.
> > >
> > > Seems efifb loads first and then hands off to gma500
> >
> > That is how it normally works but efifb shouldn't change the state of
> > the currently set mode so shouldn't affect gma500.
> > From the logs I can see that you have LVDS (internal panel), HDMI and
> > DP (3 displays in total) connected. This sounds wrong. Your version of
> > gma500 (Cedarview) doesn't support more than 2 crtcs/pipes. This might
> > be a problem.
>
> Yeah, there's a bug there with the connector status, only DVI-D-1 is actually
> connected, I have DP-2 and LVDS-1 turned off in weston.

Ok, but are the connectors physically connected to anything?
Regardless of what you do in Weston, the connectors shouldn't be
getting modes if they aren't used. LVDS might be from VBIOS but I'm
not sure where the DP modes come from. It would help if you also
provide kernel logs with drm.debug=0x1f when the outputs doesn't work
so I have something to compare with.
