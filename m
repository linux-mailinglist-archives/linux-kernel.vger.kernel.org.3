Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 620405A1848
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 20:04:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242956AbiHYSEe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 14:04:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241973AbiHYSEb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 14:04:31 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AABDBCC2E;
        Thu, 25 Aug 2022 11:04:30 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id de16so13636092qvb.12;
        Thu, 25 Aug 2022 11:04:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=gS/oZMKO0RIb585CuMsw8Mx8lGPIsjeA5Tv+9LBK5gw=;
        b=UHTQNhsvI7kjb6sgnttgvVkgi+NHi/rkUjwTxYMlmb52Dyd02DNtEDB4raYn22iD8O
         MihK5uK99OBoL8f2HIhvBMcP+wNyRHUoZVDLUQb9lJ92h+o9n4vFoalrz2g+PXV7HoFF
         53LfIEKKnX+UdxKV5AcGr9XIcDVBubnKDcFBcmQhhJ8/wH9IW0C6JfHpreY0ded8wLQ5
         OYKGurTU6d5K3oTysRUgCK4vYrdc2jgxv2rbff44j8CcW6Enqc3Pgv0US2duIvzrR9Fp
         LKMvgm1MDQubq113huJwvcIutHnt8KYoXZzUROlZIvxT8tkCiP1+aXdkmZaRv59NCE6z
         eAkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=gS/oZMKO0RIb585CuMsw8Mx8lGPIsjeA5Tv+9LBK5gw=;
        b=vLKrOKBmQkOHlytABnNaQ6JiqPrtGFxhuJI2j89qAzpMiJYLXlPuUvZzYyOPzP0/t2
         Czzw1VlbTagFm8H4Vea0Z66+bGo1vy27kL9toB5jQNLgrnf3RCWucyx+eyhZ8QsfrU8H
         0WXkUsvqcGd+4uPqiv+lgzV0LHQtWNomoQsUv36JG2agGtYVY89jVrCbUw6mxaJAKhNE
         yu+Bi/1pRZ74qhWfE2Zqkc77kyXG2KHb43mpFb49mrirY6mXBvrFFzhk8DtxrZvnkVDc
         MuTjFh8WhmMPVRhS6/MNMvlpokEJ6p1+7k7tsM4777Zou4f71x4eHsxtSzCVNq8vMsRR
         5vQw==
X-Gm-Message-State: ACgBeo0fmWxkLZ5p1RhHd8ysBf6aMsNepTHvDo130OT+A+j2SL7+uyOY
        ccPONn/fQEowXuuhO6EJ6LkYxuzZj7kgmXXPFws=
X-Google-Smtp-Source: AA6agR5dyKTJcv75mZiMUn02lP2WnMi8OhVV2WIW2o0eoDeyf/NMdheXCCAT5VkIIH/l9OUZruTXH3g5IjzBePl52Ik=
X-Received: by 2002:ad4:4eaf:0:b0:496:ac46:2d9c with SMTP id
 ed15-20020ad44eaf000000b00496ac462d9cmr4721504qvb.82.1661450669496; Thu, 25
 Aug 2022 11:04:29 -0700 (PDT)
MIME-Version: 1.0
References: <20220825104422.14156-1-henning.schild@siemens.com>
 <20220825104422.14156-6-henning.schild@siemens.com> <20220825193340.058fd4c5@md1za8fc.ad001.siemens.net>
In-Reply-To: <20220825193340.058fd4c5@md1za8fc.ad001.siemens.net>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 25 Aug 2022 21:03:53 +0300
Message-ID: <CAHp75Vd7jrPUb0bOdySDLmJQCdo6qieBaDVkTjf=u7R+Jyiv+g@mail.gmail.com>
Subject: Re: [PATCH v6 5/7] leds: simatic-ipc-leds-gpio: add new model 227G
To:     Henning Schild <henning.schild@siemens.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Pavel Machek <pavel@ucw.cz>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Lee Jones <lee@kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Sheng-Yuan Huang <syhuang3@nuvoton.com>,
        Tasanakorn Phaipool <tasanakorn@gmail.com>,
        simon.guinot@sequanux.org
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

On Thu, Aug 25, 2022 at 8:51 PM Henning Schild
<henning.schild@siemens.com> wrote:
> Am Thu, 25 Aug 2022 12:44:20 +0200
> schrieb Henning Schild <henning.schild@siemens.com>:

...

> Concerning these two tables from above i have a question i need to find
> an answer for for maintaining the out-of-tree modules of these drivers.
>
> When getting the drivers into the kernel i had to rename the leds but
> in out-of-tree i would like to keep the old names and just equip their
> setters/getters with a deprecation warning. Just to give existing
> users time to slowly adopt the upstream name change if i can.
>
> In the open-coded way i just defined each LED twice and added a strcmp
> + pr_warn. With the "leds-gpio" version i still fail to find a solution
> which does not get me into -EBUSY. So i already fail at the second
> definition of the legacy name, not even had a chance to think about how
> to smuggle in my deprecation warning.
>
> I know out-of-tree is not a concern to people here, but someone might
> have an answer anyhow.

Yes, we (upstream) don't care about out-of-tree stuff. But I think
what you are asking for is kinda an alias. Maybe you simply can create
a module that will wait for the led appearing (by notify that adds a
device or alike) and create an alias by sysfs symlink (IIRC there are
kernel APIs for that)? It will be another out-of-tree module that you
may drop whenever is time.

-- 
With Best Regards,
Andy Shevchenko
