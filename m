Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 571EA59CAF0
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 23:37:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232702AbiHVVhb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 17:37:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234909AbiHVVh1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 17:37:27 -0400
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D48F85302D;
        Mon, 22 Aug 2022 14:37:26 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id n14so5930775qvq.10;
        Mon, 22 Aug 2022 14:37:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=pPU18e07mVMRZonMkH6YRrQgCI3bj2mEK8P06gbETkw=;
        b=Cz5KJORjR3VyGIXyN1n3LIqyfGyFV+50H9FX+Ov3+G3GmNfxYtvfVbFgmSn+ECUneC
         L/PZ4eA2ihWoxtmQc4aojSOMduhkk9seFbYNfgwr/5fSdU6mzK1O6u0XVrXFLHyd1Owv
         pa3CxU89O79IXm7xRes8lk/k+4F0mpsaMPS1Dve7RDIQWzgPCnEW0XbpO145d+ibkwhI
         3V/SXJsoRBC2GJ9dzQ1M1oCIraroWFd+qPI5nXbCZ9UzW5ikFusDIqIlyJ+x2WCoXu9Z
         gcGATGyxPQs/wi3ltJRvLf/keJbxOhFE5BJ/F9JboOdhy3ynOoSdmGvfagrr1xGUEBi8
         RYRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=pPU18e07mVMRZonMkH6YRrQgCI3bj2mEK8P06gbETkw=;
        b=WfH5CfqV/WDQ6Pk59kf5BJcEvllwMgwz5Qx7j80CqyEWbdmQgpKau1Bsts+Zhu7Bs7
         e8nnB54LXAa1ACyGzMulj3xdbKwF5xDpircfDSWy9xEI8NTw0mnr1jHcPszS31MgJ7dC
         VJ0zqj/za5r+OTMBIPdvToV3miS02+eTc92GbMlVqYGM8dwbW47diBwrToIKAl8DJBM4
         GbgnjIxfhoknlLaiZtavJfTxYsvZELaoGvMXMQmzCN0PC8cUSP33TM9BZooITb650ffx
         ZLmVbIn7LUBLh9BY+Y0gE+ybHDM3dnEfS8RwcAWNX4uheGsPWcP9jZwxQlBzv2J7OlNG
         nrLg==
X-Gm-Message-State: ACgBeo0aFilG6ioErkxtSTL821K8Q6fFYb29+osnGIv1+3wX2C0Xc2uc
        KA6JBYGzED+zkqR+aIel5YpLQZBG8uNoxDtM9YicS2p7Zlw7EA==
X-Google-Smtp-Source: AA6agR5KmgDRZBWxrjmbb3BFVC0X81Kz7effbCC2G0e3wcuySxrN3h5GF7nSh+0vPuvh5HUHiGviJLj+e4BSy8zrJEk=
X-Received: by 2002:a05:6214:202d:b0:496:cb8d:538f with SMTP id
 13-20020a056214202d00b00496cb8d538fmr11602873qvf.97.1661204245899; Mon, 22
 Aug 2022 14:37:25 -0700 (PDT)
MIME-Version: 1.0
References: <20220811153908.31283-1-henning.schild@siemens.com>
 <20220811153908.31283-3-henning.schild@siemens.com> <CAHp75VdWdzsT9wc9BNNKTJ3-eBn3uWdCFXqE2TT+CiJnoTOQYw@mail.gmail.com>
 <20220822152133.5e8f257e@md1za8fc.ad001.siemens.net>
In-Reply-To: <20220822152133.5e8f257e@md1za8fc.ad001.siemens.net>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 23 Aug 2022 00:36:49 +0300
Message-ID: <CAHp75VfzOxW6KOW8ObSnqoFiaggkCWgWccrV9wV3x7BJFJR3fg@mail.gmail.com>
Subject: Re: [PATCH v3 2/4] gpio-f7188x: use unique labels for banks/chips
To:     Henning Schild <henning.schild@siemens.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Pavel Machek <pavel@ucw.cz>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Lee Jones <lee@kernel.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-leds@vger.kernel.org" <linux-leds@vger.kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        Sheng-Yuan Huang <syhuang3@nuvoton.com>,
        Tasanakorn Phaipool <tasanakorn@gmail.com>,
        "simon.guinot@sequanux.org" <simon.guinot@sequanux.org>
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

On Mon, Aug 22, 2022 at 4:21 PM Henning Schild
<henning.schild@siemens.com> wrote:
> Am Fri, 12 Aug 2022 10:39:08 +0200
> schrieb Andy Shevchenko <andy.shevchenko@gmail.com>:
> > On Thursday, August 11, 2022, Henning Schild
> > <henning.schild@siemens.com> wrote:
> >
> > > So that drivers building on top can find those pins with GPIO_LOOKUP
> > > helpers.
> >
> > Missed given tag. Do we need to bother reviewing your patches?
>
> Sorry but i have no idea what you are talking about, please help me
> out. Whatever i did miss seems to be pretty relevant it seems.

If I remember correctly somebody gave you an Acked-by (or
Reviewed-by?) tag in previous versions of the series. I don't see it
included.

-- 
With Best Regards,
Andy Shevchenko
