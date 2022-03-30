Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E46A4EBBDD
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 09:36:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240674AbiC3HiK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 03:38:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243896AbiC3HiE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 03:38:04 -0400
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0023B55BE0;
        Wed, 30 Mar 2022 00:36:18 -0700 (PDT)
Received: by mail-il1-x12e.google.com with SMTP id e9so13996005ilu.9;
        Wed, 30 Mar 2022 00:36:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=K4jqbVE230M9wS+1QXIPRjVS4MYSGVkCyAOthMzzuT8=;
        b=NdX1PJx79ceLi53HWoka1JaM+2R9nUAaulmuuGNGSXDWk/ZLlchEF0lgouHL3SrPUx
         cXgivj92UK2ugRw0qCpIPkaphY97RGnb3cDtRBFdKtEusG2csEkg/ocbKfiwzf8uLsYh
         +bkh+5M3oRdQq/gJtJQUGM66Pgv1ZAlPR4H8xJSNmoB1AHqqqEbWMoECXc7OSo9da4+y
         qlkS5AXnoguqnqNBAG7FzqVjEkM3CRFkpKKW3qRXjSS4B9FzOZLEjZXaEWoqJ2qs7rNL
         24WgjHYrMvxs4vMR7mgqhDldrvzsn5Oej6F+eb0octlfFWvbZOJcqNvEgSN7zLKcvUjr
         ix6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=K4jqbVE230M9wS+1QXIPRjVS4MYSGVkCyAOthMzzuT8=;
        b=Vt0NvpuPJxfD4gQf2IddAi17YifMUEamc0HdWtQV+P3Ywu3k/NYOAYS7xd48xoXv5L
         krWdEDSZAQQqbe5hTZMDcSv3IhottPRrtQRKu9jQawlBmQ61QS5yr8s7oYkZBaODTuwL
         CsP6Bn2opFYuukSFzbyzB2f1kK1BTrA7jm8iTfsYp4c69KLIl5vWlr5sZS2YD6r6qz9Q
         xvhhEIasdTiD97Mnp3Z/+xtBygw6NWA+7HdCyzCl/NUOTS27RSG7yxMyMkuxWFdTRDEy
         VIX1PfDJBMeJU8UKvSryzrFv+AElDfRyEavksjxQ7vgMZ1m+Q4UY1OMOUvOSER6rzIwB
         4IfA==
X-Gm-Message-State: AOAM532BwH+ASTVvdshoyM9skIYGK6ao3p1AT6XwseeneFJy+3fkLgBI
        XXsGNrRz6lfRvMeYdH5iwA/K50IlqEaYO/vW+1O1OiwHgss=
X-Google-Smtp-Source: ABdhPJzILfjbvZouqSmF9BbpFgISbz1vhLK8IKxTWZkYOnBLLHk90MwqMsffPeqph/YKwubQzseyj2lyXH0FBB958EQ=
X-Received: by 2002:a05:6e02:d88:b0:2c8:713f:dcff with SMTP id
 i8-20020a056e020d8800b002c8713fdcffmr10307147ilj.289.1648625778394; Wed, 30
 Mar 2022 00:36:18 -0700 (PDT)
MIME-Version: 1.0
References: <20220327121404.1702631-1-eugene.shalygin@gmail.com>
 <20220327121404.1702631-3-eugene.shalygin@gmail.com> <df43bce6-b1bc-1abc-307b-878ee7acb261@roeck-us.net>
 <CAB95QASgzUSaLjZuxWauiSvNK7Or=1Kz8htJcjWqU+HrRutvJg@mail.gmail.com> <fef5c154-2b1b-0a2b-52c3-c3fe0b4c2abf@roeck-us.net>
In-Reply-To: <fef5c154-2b1b-0a2b-52c3-c3fe0b4c2abf@roeck-us.net>
From:   Eugene Shalygin <eugene.shalygin@gmail.com>
Date:   Wed, 30 Mar 2022 09:36:06 +0200
Message-ID: <CAB95QAR+shnkC=QjmxYzdr69WuzW41aXmrGg-j7kfXM9+zGCuw@mail.gmail.com>
Subject: Re: [PATCH 2/4] hwmon: (asus-ec-sensors) implement locking via the
 ACPI global lock
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     darcagn@protonmail.com, Jean Delvare <jdelvare@suse.com>,
        linux-hwmon@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

On Wed, 30 Mar 2022 at 01:37, Guenter Roeck <linux@roeck-us.net> wrote:
>
> On 3/29/22 15:11, Eugene Shalygin wrote:
> > On Tue, 29 Mar 2022 at 23:23, Guenter Roeck <linux@roeck-us.net> wrote:
> >
> >>> +/* Moniker for the ACPI global lock (':' is not allowed in ASL identifiers) */
> >>> +#define ACPI_GLOBAL_LOCK_PSEUDO_PATH ":GLOBAL_LOCK"
> >>> +
> >>
> >> That needs to be documented.
> >
> > Do you mean a note in the /Documentation/..../...rst or adding details
> > here? There is an additional bit of information on this identifier
> > below, in the ec_board_info struct declaration.
> >
> My understanding was that the user would/could request its use via
> the module parameter, so it needs to be documented in the rst file.
I see now, thank you.

> >>> +     if (!mutex_path || !strlen(mutex_path)) {
> >>
> >> When would mutex_path be NULL ?
> > When it is set to NULL in the board definition struct ec_board_info.
> >
>
> Are there any such board definitions ? I don't recall seeing any.

You are right, there are no such definitions neither in this
submission nor before. I'm messaging with a user who showed a hint
that such boards might exist [1]. We have not confirmed it yet, but I
thought this little test is obvious enough to be put in the code
already.

Best regards,
Eugene

[1] https://github.com/zeule/asus-ec-sensors/issues/19
