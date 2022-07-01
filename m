Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17F3556322F
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 13:08:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236459AbiGALIQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 07:08:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236195AbiGALIO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 07:08:14 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37F1FF70;
        Fri,  1 Jul 2022 04:08:12 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-318889e6a2cso20340857b3.1;
        Fri, 01 Jul 2022 04:08:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PiGXCaaTFKY0lcNY/L8S2NKwKy6By8fnTg66icWqtZM=;
        b=HTmq7Hu7JOyXkIFqKXBJUgpHSKmLC2cf0+GShgb2Vuu1xI3pPNBtxeegGyuH5aDI5O
         yxnpq5EKcUFddz1z80/tgqkNJj/h+iJEIkMs5/9TyYZlQIS1Z7c9bAKgfkuGPh5X3Gao
         LkvfaZ5sEm/5dGqg3WMNGzCyYQlMn1LTE92icWrpct9U9ZNlRombiNOvjFWyQ2Z7wy1x
         rkZbDGMuFU6PqFbdpAb3TfOUDOd8jYRwG3vn9tsR9pQqf/B4afT1igqUjnnNXskYgx3o
         K9Ss4zh/emEkxh7zb6qiYe1fZyF5YGGOYT5t8/3T0Urw00hQgvGEDHzGFZpK+ti99BCn
         WxUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PiGXCaaTFKY0lcNY/L8S2NKwKy6By8fnTg66icWqtZM=;
        b=d6sZNEo/5SdLA8MoyAZUDJXWW/UQJG4lRV+qxwwnEdwl7b94rzszJ2rg5udJkSv+gr
         cTIRmzdruvXhUkNkTGOY+Mwk2Bh/G3mGjs+6aUxJzWzyWaEsw1uO0vthOREW6rRx1JYL
         KvkqwAv74cnGxUmK1Io0m9d5NrPGUk36PVmPefjnFdyNQGrdG27KC3Np6xN6A8KpvK+a
         LG6ChAdJ7LPSTgSKMTDpspKcyGf9tlNFPJa1Vbe2KhfKkX1dIjx2//aPXPKAakaMu79h
         9juYqDk0EF3yaAFUk++MzHzQmPXq1n8kSP7daypi8Jz8D+7PmuesynSRReYcKJntmXpu
         q7Bg==
X-Gm-Message-State: AJIora+GLbKYIAAy5jSXaux0G/YOFPGnOEft9z7n86//ezaTyV0N/fCo
        1JS46ZUZqqtw6biG2H521qYn4cxhUtORhyd/8lY=
X-Google-Smtp-Source: AGRyM1t2wkIpDmOVB4/KNW+qV9Guhw3oeiko46jf7Ag8ump3lP6Xi4WzNv2NughskMTiBbHSsf9IYgkv5wkouNJVuTU=
X-Received: by 2002:a81:468b:0:b0:318:4cac:6576 with SMTP id
 t133-20020a81468b000000b003184cac6576mr15584941ywa.277.1656673691457; Fri, 01
 Jul 2022 04:08:11 -0700 (PDT)
MIME-Version: 1.0
References: <12026357.O9o76ZdvQC@kreacher> <2657553.mvXUDI8C0e@kreacher>
 <5606189.DvuYhMxLoT@kreacher> <e9666883-3285-36a6-6278-ace219b88f3c@huawei.com>
 <CAHp75Ve-Cm43HhqqxxfmKTbC_Gkx=0aAcj0jJmA=-Nr-NT1FqQ@mail.gmail.com>
In-Reply-To: <CAHp75Ve-Cm43HhqqxxfmKTbC_Gkx=0aAcj0jJmA=-Nr-NT1FqQ@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 1 Jul 2022 13:07:34 +0200
Message-ID: <CAHp75VdT1YZUQbdHupA2RmucUBSzypcPwKBgSa4=sVQAhC+Vsw@mail.gmail.com>
Subject: Re: [PATCH v3] hisi_lpc: Use acpi_dev_for_each_child()
To:     John Garry <john.garry@huawei.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Yang Yingliang <yangyingliang@huawei.com>
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

On Fri, Jul 1, 2022 at 1:06 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Fri, Jul 1, 2022 at 1:04 PM John Garry <john.garry@huawei.com> wrote:
> > On 30/06/2022 19:13, Rafael J. Wysocki wrote:
>
> ...
>
> > However Yang Yingliang spotted a pre-existing bug in the ACPI probe and
> > sent a fix today (coincidence?):
> >
> > https://lore.kernel.org/lkml/20220701094352.2104998-1-yangyingliang@huawei.com/T/#u
> >
> > And they conflict. This code has been this way for years, so I just
> > suggest Yang Yingliang resends the fix on top off Rafael's change.
>
> Wondering if Yang can actually switch that to use
> platform_device_register_full().

And for the record, I think the Fixes even for very rare bug hits
should go first.

-- 
With Best Regards,
Andy Shevchenko
