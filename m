Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EC73563BA2
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 23:15:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232056AbiGAUuA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 16:50:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231237AbiGAUts (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 16:49:48 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2F516051C;
        Fri,  1 Jul 2022 13:49:46 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id 194so987224ybc.4;
        Fri, 01 Jul 2022 13:49:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=L3xyYkVUb08ki16owDdwA0s6fxyBYTVKhzo/OZc4swY=;
        b=Q2bHi8xGPVEu5bceVUNZYHpmzzugqU9zcEOTOg2MdUoxdlZMrh2dhUi/3V/yVyoP8T
         7JZKoRSgqiX3kGpk6q8nfQN+YnjerSQKLRyC5wB9fCeMncQJ3qV6JNf2cjyYqUtH+8NM
         pdl9uOadAWBK3qlpdDJd7bhS4ek7Jt+2teWEvzgDro4DgmMj/6UqIUVyrft2OnpZsIjb
         valYyD/7fj2Fg3XZsjwz0WFbMBR4OJjKVoa+i9poO3QyMXjzjnCbuPxui6Unq14iapP6
         HLgpXiF/htqOgwAORxZbk3vYkJwLJnrzVADBiTnCagwQpcjAD42LQfLIDiM/Jnv7p14Z
         c5ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=L3xyYkVUb08ki16owDdwA0s6fxyBYTVKhzo/OZc4swY=;
        b=hoP3kRxZBoTr0SSee1gkWBKvlMMDQkwsoLbTU4sFhYYI/VF7RlnLQWs8AMcJd8bRyl
         nIHeZIxVn+asVm/e963cFPup21Gm+vqOHatPbnwmizFewNPdOQMz4rcpLeJZDsMaMBiB
         WQrj76oiDIzmM59BiYbt3yEfCoJcYn9vZo+gIXORLPXNyb6aG2q+LPJ1xU1lYbvzSCxW
         uImUaQJQTTAIwYnRrJuVmtlh/GYhyuGoI1zLA00+um0dSHl5FS35I5vQNj+xg7wbBf6S
         j1TrlK6IBWmaq9kONH/qBivIbEC0okFDNG6jOCY+gyG0pEycoeJ9IGuFxHYE05p8kEZ5
         wPGQ==
X-Gm-Message-State: AJIora9i/dBkJqzCeChptcyKzi0iYbykXMuN2X/00gH6e8fQCznK8nmn
        kMXHl7S0so6L//fMCYVohNwXyNX9gG/2INnmKV8=
X-Google-Smtp-Source: AGRyM1sSuMB2bm2+fgeAw4QBEbPXyLstIl8n4mXHDssuvKcqLX+xrURcZllP7cVih4dACkvtsUY4DWlFxSN1vsLxeLQ=
X-Received: by 2002:a05:6902:1142:b0:66d:999a:81a7 with SMTP id
 p2-20020a056902114200b0066d999a81a7mr13503264ybu.460.1656708586203; Fri, 01
 Jul 2022 13:49:46 -0700 (PDT)
MIME-Version: 1.0
References: <20220701134415.4017794-1-vincent.knecht@mailoo.org>
 <20220701134415.4017794-5-vincent.knecht@mailoo.org> <CAHp75Vf1nMi6OAbksNMCEkq3snrtDQSwRcSnbkB=gPwS=WWz9A@mail.gmail.com>
In-Reply-To: <CAHp75Vf1nMi6OAbksNMCEkq3snrtDQSwRcSnbkB=gPwS=WWz9A@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 1 Jul 2022 22:49:08 +0200
Message-ID: <CAHp75VdpQ5J1nSONpM=C9YL1Qd6sJMLbrmGT_3uQHn8Um_0++w@mail.gmail.com>
Subject: Re: [PATCH v2 4/6] leds: is31fl319x: Use non-wildcard names for vars,
 structs and defines
To:     Vincent Knecht <vincent.knecht@mailoo.org>
Cc:     Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        "H. Nikolaus Schaller" <hns@goldelico.com>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org
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

On Fri, Jul 1, 2022 at 10:47 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Fri, Jul 1, 2022 at 3:45 PM Vincent Knecht <vincent.knecht@mailoo.org> wrote:

...

> > +#define IS31FL3196_CURRENT_MIN         ((u32)5000)
> > +#define IS31FL3196_CURRENT_MAX         ((u32)40000)
> > +#define IS31FL3196_CURRENT_STEP                ((u32)5000)
> > +#define IS31FL3196_CURRENT_DEFAULT     ((u32)20000)

Also why no units as below, for example, has?

> > +#define IS31FL3196_AUDIO_GAIN_DB_MAX   ((u32)21)
> > +#define IS31FL3196_AUDIO_GAIN_DB_STEP  ((u32)3)

-- 
With Best Regards,
Andy Shevchenko
