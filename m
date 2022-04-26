Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D9D850FBAE
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 13:06:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349483AbiDZLJM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 07:09:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349440AbiDZLI6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 07:08:58 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC8111D32B;
        Tue, 26 Apr 2022 04:05:49 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id l7so35345268ejn.2;
        Tue, 26 Apr 2022 04:05:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=79YMmecniTibmsg7vJUZ+X02gOTamrh9pEXoc3ztOsI=;
        b=hY0PvQxd52o7a5RL31zKEanI+5zD/Fj9OoIs4H6V5NWMRkRiT1TpyIYgPDC5ye0iex
         3KCoVhqSsB18fDNYKGTUFgHpV7hXi5JA3Mv7P+azG2oJRnC+8+dhs2CW6JIv6PX0SuqF
         v6RKAAEjL+SrJxw2it8Vi6xS/ZfZjOw0jKtQTCnxW+kAiLfw1J5iLd4hFWhE6gjSLG3T
         y6xgxZcl9oS8AS+fsdX8AIjapy5pvT/6K1BWGKl8H1QM9nYY+SJWasrAgO3a/5YxF+jB
         hdz7Ns/vueqCI1LPdNAknCRvQptVODT2tJgM0a2Pb+ku3wag6GKsKfM7l6eAm1YZafTL
         rmow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=79YMmecniTibmsg7vJUZ+X02gOTamrh9pEXoc3ztOsI=;
        b=EfucEZDEDj/43+xSUe0Fg1qiXxGHYz/s9Lx3vP9bly0mAbwxtWshrLaCfQYAHC4b0M
         4X7k0PHu8ejeC59Cjru5LPGmrY6f1v4M8HWCWNu4sa1+/6Ru2JgIkXde1Hw8EbUBssed
         ANtG0v+bB4dHvO0gAGMbCxNDH4VouEWB8O35zmgjmo1YZRLDwg2SQGpGddz4adnG/eH3
         hAM4drgcUdlE50RqFdVLfmvQgiZp4+syLTglYO6X0HaxCDOSyLWVgsINMO0q5IVMo/3a
         8PaT4Hyv/2hEPnn7qeAAM6lT53AhtMocHFzjMJKgLsnTPRZjaOZTMBfH4Svvi2vzUQhp
         tGwg==
X-Gm-Message-State: AOAM533sHI75sSzc5hqogQ+cMOrwUocQ3QBfH3kmid0gU7uny5Bi5tbX
        P2VUs6BDAIpTuEMmj/6Hcg9ZLIQW4CCevhKGULpv8bKPKkpJdleU
X-Google-Smtp-Source: ABdhPJz3Oc8Ec1tbl53rBwwgD516RimSL1NBRvi8E0BMh5xN1s4Dc6m2buU3rqxfklIbnxa7LxSwiNS6I+s/809+134=
X-Received: by 2002:a17:907:7d8c:b0:6f2:476d:fde4 with SMTP id
 oz12-20020a1709077d8c00b006f2476dfde4mr19708272ejc.497.1650971148564; Tue, 26
 Apr 2022 04:05:48 -0700 (PDT)
MIME-Version: 1.0
References: <20220420211105.14654-1-jagathjog1996@gmail.com> <CAHp75VdyPekY7t8Y4-nyVXNt7wFZKB+yL2i6MNe1WLez178a6Q@mail.gmail.com>
In-Reply-To: <CAHp75VdyPekY7t8Y4-nyVXNt7wFZKB+yL2i6MNe1WLez178a6Q@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 26 Apr 2022 13:05:11 +0200
Message-ID: <CAHp75VfCxD13X4RdL0ZtiB_MXODck9votoek2s3sUc457AXOrA@mail.gmail.com>
Subject: Re: [PATCH v4 0/9] iio: accel: bma400: Add buffer, step and activity/inactivity
To:     Jagath Jog J <jagathjog1996@gmail.com>
Cc:     Dan Robertson <dan@dlrobertson.com>,
        Jonathan Cameron <jic23@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 26, 2022 at 1:04 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Wed, Apr 20, 2022 at 11:11 PM Jagath Jog J <jagathjog1996@gmail.com> wrote:
> >
> > This patch series adds trigger buffer support with data ready interrupt,
> > separate channel for step counter, an event for step change interrupt,
> > activity recognition and activity/inactivity event support.
>
> You forgot to add tags from the previous round of review, please be
> respectful to reviewers.

That said, send a new version with properly added tags for what it was given.

-- 
With Best Regards,
Andy Shevchenko
