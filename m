Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E2154FCBF8
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 03:48:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231308AbiDLBuZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 21:50:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229793AbiDLBuX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 21:50:23 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6F1F19290
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 18:48:07 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id e189so17615042oia.8
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 18:48:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oPrX2CAjOyKCqDAsQqHEkCRe94OKbEjEy8TsnU+5R8A=;
        b=Tz9lOvynvSS0T8uwXuQC5Hk3HnS83JDtCEYKcsHJWX9rrGEchtu9cFprNiOL+kg5wR
         G6exSArA3BnYhmr/XsjdqzJxLAtjVayYDh3+aXpCbHkLMZ1Qxb72RDO84hAiUPpXsp0J
         gTAozMh4+yxDkRiaZTj41HcrW3ggVl63h1IlNZA+t6eEy6SvjEGEA+oteDP2vC3tLZhD
         KuYzhJON2DDNVKXoY0gcl6KPOPgfVgwA9cXO2OZTff2mPACuGNCoOhj2uq4qY4tXxO3i
         p45oR3ongGVdw1rGzZ4EJpHnNwKnOlO8VemfS6VQHwuXge4a47+AFJMOqtbvBx2zywEp
         TbOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oPrX2CAjOyKCqDAsQqHEkCRe94OKbEjEy8TsnU+5R8A=;
        b=A5ymzJDzncW1xQNOK5AXuMcdnyuD7+qfiQjAU5AoLOIqcM58uLc+Jm4Y4Y0jjat7th
         BprCWZGw/CXc31TMCCNFasaMxh03/3jolu0MKG7oV8XtAlixU2MJMb3dZD//D8K2VrPp
         21pSsMwtT+bEeMqzd1FYsC36E/x+Gz7dcQLWn0Cx8N35x9faQXrSujdUu/05jsIpOBk1
         YfWPcA/RR7omcyeQpGw7JdO6tnPVwXkXxzKrVv7SvmBBiJ56KIvKG1/oocCvfdnRDwpJ
         HuFwggEbEbrjoMQHJLtBpx3gmPkJQGH1ODGu1ZwlHAZNHg0TyXMzrSBLDF+ebDuUwuTT
         bwXQ==
X-Gm-Message-State: AOAM5322TROQQae2VdnlyIrjYi/+IPVukQKueRGrWao3g8xcf7BZzLLV
        KYsYZZozy6Fx4VucRaY8a/JwrefZWqMnsn4YWBk=
X-Google-Smtp-Source: ABdhPJxJFmZg+65Cg7zq3pn7r3IVdQ0+22MCSm52acOMCZR83hiXAgaakpLAHcY8OHrJc1a2OB39lhw48TMyUFV6ihE=
X-Received: by 2002:a05:6808:1528:b0:2f9:65fa:b878 with SMTP id
 u40-20020a056808152800b002f965fab878mr790075oiw.99.1649728086925; Mon, 11 Apr
 2022 18:48:06 -0700 (PDT)
MIME-Version: 1.0
References: <20220409042321.3184493-1-james.hilliard1@gmail.com>
 <CAMeQTsanEow=zq=MuZLjMqpzybdS=5S0=JrkxuCdT7d5MxpEWQ@mail.gmail.com>
 <CADvTj4rBKzGFch8iVzHu1s+6=P0PcLEwoFi74xd_ormEX+2rMA@mail.gmail.com>
 <CAMeQTsaM363n5F=--xhSTayFqOMNvjTQjqz_aEhby6i-KRVBKQ@mail.gmail.com>
 <CADvTj4o_zyVZxaBz0+kRUF30OW3SKFMuo87r6FE9Qkfn1dVsBw@mail.gmail.com> <CAMeQTsbKMxQcDsDRqHsMwqU1BnrcOLwtU7uOrB-1E0z65P79-w@mail.gmail.com>
In-Reply-To: <CAMeQTsbKMxQcDsDRqHsMwqU1BnrcOLwtU7uOrB-1E0z65P79-w@mail.gmail.com>
From:   James Hilliard <james.hilliard1@gmail.com>
Date:   Mon, 11 Apr 2022 19:47:55 -0600
Message-ID: <CADvTj4rR5zt5iFTDrrYfNQ267KV896dHnjJHx6yq=e10+V_Okg@mail.gmail.com>
Subject: Re: [PATCH v3] drm/gma500: depend on framebuffer
To:     Patrik Jakobsson <patrik.r.jakobsson@gmail.com>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        linux-kernel <linux-kernel@vger.kernel.org>
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

On Mon, Apr 11, 2022 at 3:27 AM Patrik Jakobsson
<patrik.r.jakobsson@gmail.com> wrote:
>
> On Sun, Apr 10, 2022 at 10:05 PM James Hilliard
> <james.hilliard1@gmail.com> wrote:
> >
> > On Sun, Apr 10, 2022 at 1:52 PM Patrik Jakobsson
> > <patrik.r.jakobsson@gmail.com> wrote:
> > >
> > > On Sun, Apr 10, 2022 at 9:40 PM James Hilliard
> > > <james.hilliard1@gmail.com> wrote:
> > > >
> > > > On Sun, Apr 10, 2022 at 1:36 PM Patrik Jakobsson
> > > > <patrik.r.jakobsson@gmail.com> wrote:
> > > > >
> > > > > On Sat, Apr 9, 2022 at 6:23 AM James Hilliard <james.hilliard1@gmail.com> wrote:
> > > > > >
> > > > > > Select the efi framebuffer if efi is enabled.
> > > > > >
> > > > > > This appears to be needed for video output to function correctly.
> > > > > >
> > > > > > Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
> > > > >
> > > > > Hi James,
> > > > > EFI_FB is its own driver and not needed by gma500 to drive its
> > > > > hardware. What makes you think it's required?
> > > >
> > > > I wasn't getting any HDMI video output without it enabled for some reason,
> > > > I assume it is doing some sort of initialization needed by gma500
> > > > during startup.
> > >
> > > Then it sounds like you might just be using EFI_FB and not gma500. Can
> > > you provide the kernel log with drm.debug=0x1f set on kernel
> > > command-line.
> >
> > Seems efifb loads first and then hands off to gma500
>
> That is how it normally works but efifb shouldn't change the state of
> the currently set mode so shouldn't affect gma500.
> From the logs I can see that you have LVDS (internal panel), HDMI and
> DP (3 displays in total) connected. This sounds wrong. Your version of
> gma500 (Cedarview) doesn't support more than 2 crtcs/pipes. This might
> be a problem.

Yeah, there's a bug there with the connector status, only DVI-D-1 is actually
connected, I have DP-2 and LVDS-1 turned off in weston.
