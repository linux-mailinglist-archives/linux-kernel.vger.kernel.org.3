Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6FAF4D20E8
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 20:06:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349509AbiCHTH0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 14:07:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243715AbiCHTHW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 14:07:22 -0500
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 762B653B53;
        Tue,  8 Mar 2022 11:06:25 -0800 (PST)
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-2d6d0cb5da4so212617967b3.10;
        Tue, 08 Mar 2022 11:06:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oVBQQpJm0vrQakdQuma+GTMMkD0FLVIWH06jI4M26nM=;
        b=AMmWRw1V0TTL0O0wguoADDnm51PsjR/Nc97b17fHa+QgJ1jeaTDAUuhz0LElXqf/PY
         75h/jhByVlRcN4E+fFV1Jn7IkC32s5xuXI9sBN3/YedPJsRJNbRwd0iJjhSTzWqoqxH8
         p4IKvxuoLBdMMX2q19WLAfFH4kDEH4I8DPD9flVBo61aJf1D/ZYWBPFGjnljxAkJKHyq
         o7VIx+NH8gzdvcIZh0FubURiYa7+G8MQX9AWXCVxRhRNvNxlhWkltFVKHKsAePnkHu1a
         F/fbnRViXQKVMLvLutcTtqa7xqKmG7F7S6VYLgWWp5jkz+qMbfyy3ib1Ay9kRnJBpp/x
         L00g==
X-Gm-Message-State: AOAM533MNQfn0Xb0wopJ0tTJfkXfv0EvS4+jZfDAV0DtRLALO5fjgT8J
        0LRFGY7Iy53yLDBC6ayUcOaimwLx8avxVl8xtgE=
X-Google-Smtp-Source: ABdhPJyby8QRu5YnwqkerT6w/CHY+qxnQ9wKdVuFm/yV114I67inOonq4GNEWF6eX4Hf+wPl9nMa1gM9xF3rXuXLFa8=
X-Received: by 2002:a81:f008:0:b0:2d0:cd72:74e5 with SMTP id
 p8-20020a81f008000000b002d0cd7274e5mr14622312ywm.301.1646766384745; Tue, 08
 Mar 2022 11:06:24 -0800 (PST)
MIME-Version: 1.0
References: <20220308140559.46932-1-andriy.shevchenko@linux.intel.com> <YieF9eUnY5l3tT+a@lahna>
In-Reply-To: <YieF9eUnY5l3tT+a@lahna>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 8 Mar 2022 20:06:13 +0100
Message-ID: <CAJZ5v0gBz_g0T_=wNWm9NDHZe-r_7K0TXSn4BLYdBNfrL8yx9g@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] ACPI: docs: gpio-properties: Unify ASL style for
 GPIO examples
To:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Jonathan Corbet <corbet@lwn.net>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 8, 2022 at 5:37 PM Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:
>
> On Tue, Mar 08, 2022 at 04:05:59PM +0200, Andy Shevchenko wrote:
> > GPIO examples of ASL in the board.rst, enumeration.rst and gpio-properties.rst
> > are not unified. Unify them for better reader experience.
> >
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>
> Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>

Applied as 5.18 material, thanks!
