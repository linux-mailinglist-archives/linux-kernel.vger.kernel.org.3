Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7C2248F210
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 22:40:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229899AbiANVkY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 16:40:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229710AbiANVkX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 16:40:23 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3678C061574;
        Fri, 14 Jan 2022 13:40:22 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id n185so3894544pfd.2;
        Fri, 14 Jan 2022 13:40:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=5CZaMdnFwKIS25P7FXe8qrzsl683KSPNybAxRv3JsgU=;
        b=O+Eql4u2oJZR8SricH7RsWhofVyx2xdGlqZxGZ7W8Yliweqh7C5xVRka6Ao4gpKyd8
         DrH8DzVx2dMuF/YuDXuNrJLCCo93XfFR5phs+6PCt8ZglZpkJjZBAJ5sQd+3dmZ5ynCE
         oNzv+SSWD+K/zKruIDdl6Qk/Vl2piH0qL0r1sp5aNZMxDcRdOMjUWWYtcmOLGr5Bo+JL
         x9+s5M/TQDRy36ACQqLGPz5SPLMiyJMCf3Q+kmQ1qASexN9UYlD6dYbC+0YGAauf+G5X
         B9qEoY0S8pLVxqpDqusFoxYiCSHR3L0zFi+Lw8cb56ubaiT8ln0exrxcOfmmEO+rkCbL
         gpGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5CZaMdnFwKIS25P7FXe8qrzsl683KSPNybAxRv3JsgU=;
        b=ILWury3EU2nsvVOtOQsM2w/qLgDCdP8YJsRn3e0171NSqNI0oyx684qZthHtlzr6+Y
         41hAu9mx5cPDX7RcUGGEgADZX+rgEkDbXq0abXLkpqC9dtjWyWK9QlAUXixiofpASB2z
         DqcjlsXnnUDXBzz9I2jv/BdeqUsH1ET7hmqsfDvYLUGWoPUFwrtQasny7/kppCftxEam
         y0YwfD0mWFmDks511tLgypxOaI5VvkHQ2GcpR73O/3eql8Vp82NaobhTGx4XQDFZLRch
         3IvAs5/Y99hr6Fepc1Maekf/kyCgR6wreLz/q1hodtUBSqNUqJNkhaLnOnx2nZXbXpP4
         3M+w==
X-Gm-Message-State: AOAM533YdUtahCzKF/J9c5YxKb34KkQMbUgXAE/hjQ5CGuYKbkWf0Gl1
        oi6icXPpy4ZnNS5Nk9iSJHk=
X-Google-Smtp-Source: ABdhPJz9TbSYOfMk7/mvo8ljhyJqUrURjEgMH76SRWE9vHDuVbmP6zmtDurIQqRsecBLMxlxrsHelQ==
X-Received: by 2002:a62:f210:0:b0:4c2:84b2:b8ff with SMTP id m16-20020a62f210000000b004c284b2b8ffmr4512117pfh.62.1642196422290;
        Fri, 14 Jan 2022 13:40:22 -0800 (PST)
Received: from google.com ([2620:15c:202:201:20f0:3cd3:13fc:6b46])
        by smtp.gmail.com with ESMTPSA id l2sm6416821pfc.42.2022.01.14.13.40.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jan 2022 13:40:21 -0800 (PST)
Date:   Fri, 14 Jan 2022 13:40:18 -0800
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
Message-ID: <YeHtwsmKzqhU4Fiq@google.com>
References: <20220107091357.28960-1-xiazhengqiao@huaqin.corp-partner.google.com>
 <nycvar.YFH.7.76.2201140935460.28059@cbobk.fhfr.pm>
 <CAE-0n53M723sZ7H-f0SF=AoTrwznmTRhKPapgHe5H7Mw6bPb7Q@mail.gmail.com>
 <YeHWNtl0Or1dgadz@google.com>
 <CAE-0n51TAtifbbruKhCJ_u5xH1j0zKjWOehGQFFdCez=RubxVA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAE-0n51TAtifbbruKhCJ_u5xH1j0zKjWOehGQFFdCez=RubxVA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 14, 2022 at 02:55:49PM -0600, Stephen Boyd wrote:
> Quoting Dmitry Torokhov (2022-01-14 11:59:50)
> > On Fri, Jan 14, 2022 at 01:25:12PM -0600, Stephen Boyd wrote:
> > >
> > > My understanding is that 'vivaldi' is mostly a keyboard layout and
> > > 'hammer' is a detachable keyboard. We want to prevent the hid-vivaldi
> > > driver from probing this particular device because the hid-vivaldi
> > > driver doesn't know about detachable keyboards. Hammer devices also
> > > support 360 degree wraparound so we know that the keyboard has been put
> > > behind the screen or that it's being used to stand up the device on a
> > > table.
> > >
> > > Given all that, I'm still confused. If we make the hid-google-hammer
> > > driver probe this device and the keyboard layout is vivaldi then we'd
> > > want the part of the vivaldi driver that exposes the
> > > function_row_physmap through sysfs. Otherwise userspace won't know how
> > > to handle the function row properly. I think we need the device to stack
> > > two drivers here. Does that happen with HID?
> >
> > As far as I know HID does not easily allow "stacking" drivers like that.
> 
> Ok.
> 
> >
> > Probably the easiest way would be to export vivaldi_feature_mapping()
> > and the show method for the physical row map and call them from the
> > hammer driver.
> >
> 
> I worry about builtin vs. modular drivers so probably ought to make some

Just make hid-hammer depend on hid-vivaldi, hid-vivaldi is tiny
otherwise.

> hid-vivaldi-common.c file that has the physmap code and then have both
> drivers call that mini-library. The 'vivaldi_data' structure would need
> to be figured out too. The hammer driver stores 'hammer_kbd_leds' in the
> hid_get_drvdata() whereas the vivaldi driver stores 'vivalid_data' so we
> can't simply call the show method for the sysfs attribute without some
> minor surgery.

Yeah, we'll need to convert them into helpers into which callers can
pass buffers.

Thanks.

-- 
Dmitry
