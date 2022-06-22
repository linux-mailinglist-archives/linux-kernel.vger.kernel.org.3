Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8567F55493F
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 14:17:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353167AbiFVL0m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 07:26:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbiFVL0j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 07:26:39 -0400
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2920E2FFD4;
        Wed, 22 Jun 2022 04:26:39 -0700 (PDT)
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-3178acf2a92so125422537b3.6;
        Wed, 22 Jun 2022 04:26:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lE9iqImghkiie75m0MiePRNUMGYeC1JJZ9fd+mwV2eU=;
        b=oRd0dhizUxQ7zXUoY+9xztduJJJvPkhBCikG31zcKq4CJUc0kKtAlrKySPxd65Xv4t
         Qacgq4rTqnBrRA2tr2nAm3bUOuk324eTLtq2wUSYUqT3mezh4RJdqIxSapIDYfO1rz0w
         qGD2mfL/RbmX9I+YB6hbeIqOlFerfvQ2HJbh5zyMAJFB0KbUZgV632bcQSXxJK7ylnMd
         cB/YMU3lhy3TQCzTw+mX/3gO4ugcVf2zsNNiJVBSoVFdTXTBN13kZrnvZ+pVfAe4mg3l
         Spo3n0JQhFgi9vek23AoQGwu+C2Xn+bu4Ajw0AvTFLrj/yJscu1zd17QjPpiU+d6ivYm
         hQMQ==
X-Gm-Message-State: AJIora8/ldkxX9EbkcLWYOTyMPLvokZR2VdaNO6LfI4d2s1Lb1roMsG7
        evLCFYpuk7ZUwRsFOapfKQnBfHuM18gzarCW82gNOhoJ
X-Google-Smtp-Source: AGRyM1vVLe1jPc5wb5TYX403fUEVdAJoGmjvIdslyb0ARdVTHi/6tJahc7rdCC2tMFf1CMQQOs8BG6gIuH5yfdgaw/M=
X-Received: by 2002:a81:6c06:0:b0:317:94ff:d1a with SMTP id
 h6-20020a816c06000000b0031794ff0d1amr3552102ywc.515.1655897198330; Wed, 22
 Jun 2022 04:26:38 -0700 (PDT)
MIME-Version: 1.0
References: <20220621150436.3303431-1-sudeep.holla@arm.com> <CAHp75VfX7ZbK67WhRjuw-s0VF5QZk+dvYEYrN+Kw1ucXofN=yg@mail.gmail.com>
In-Reply-To: <CAHp75VfX7ZbK67WhRjuw-s0VF5QZk+dvYEYrN+Kw1ucXofN=yg@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 22 Jun 2022 13:26:27 +0200
Message-ID: <CAJZ5v0jY2ugfw_NVR+hbT4Nc1a7p129hz9yVu1=f-Zyrqv8-8Q@mail.gmail.com>
Subject: Re: [PATCH] Documentation: ACPI: Update links and references to DSD
 related docs
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Samer El-Haj-Mahmoud <Samer.El-Haj-Mahmoud@arm.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 22, 2022 at 12:42 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Tue, Jun 21, 2022 at 5:12 PM Sudeep Holla <sudeep.holla@arm.com> wrote:
> >
> > The existing references to DSD are stale and outdated. The new process
> > and guidance is maintained @https://github.com/UEFI/DSD-Guide
> >
> > Update the existing documents to reflect the same.
>
> Hmm... On one hand I like the change, on the other the mentioned
> repository doesn't look like it is officially supported by ASWG (or
> did I misread something?). If I'm not mistaken, then I would rather
> see both mentioned. Otherwise it looks good, thanks!

The new project officially replaces the "legacy" documentation hosted
on the UEFI Forum web site.
