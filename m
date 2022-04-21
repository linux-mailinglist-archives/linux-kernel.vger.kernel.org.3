Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E255350A3C3
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 17:13:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385331AbiDUPP6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 11:15:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbiDUPP5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 11:15:57 -0400
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14A553ED2E;
        Thu, 21 Apr 2022 08:13:07 -0700 (PDT)
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-2ec05db3dfbso55402057b3.7;
        Thu, 21 Apr 2022 08:13:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vf+iGZ57jnQDVvhI59R62sL2DbiAyfAIvUJBun6tDe8=;
        b=7+4h+ERESFBYXOQtPS3dGHBMiH8D6iWhrBUV7q7ZeNINWDyTf7UOKVYDycSlsTNAwf
         8PEdzLjdeg6BNE8PHqPi937MdMgS7dFbSf7VU1lp+2/rOlYtanC4uIU0VxwP1bdji0g1
         O3lovjODzY69GSexqbP5vVCIJRnxZ0irGHrnlTup23EaeLa+FALhaqrB60P5rcoV38R7
         96ifAXIRWRXExUrq+MwnNWQSdKxJ4t6SFKxgjUDcTXt3hwkF6DIBR6MatiD9MFUySzBR
         nvkErVE4LGKikfi/9hGlFHVYddiA3hLKcZLrJa+DyzvFQn4ipN2RthLTfu45/eiRRk8l
         tJTQ==
X-Gm-Message-State: AOAM533IgXSDCq/Bs3/DqWxD64pQJ96VlXtipl0th7x453IXuivHke0i
        tOPwLaky9aCpFZo3BY1X5bFGC4Zx1LVLJ70KUM0RXD5K
X-Google-Smtp-Source: ABdhPJxlk7VnMmw29Chuv0omBuFlXfuRTl6ImAWXMCv5HENJWbjh7C7eQHJsDrVQWkJhnLdni6Bg5XCD+p5Y8cyeivQ=
X-Received: by 2002:a81:4b8e:0:b0:2ef:5240:69fc with SMTP id
 y136-20020a814b8e000000b002ef524069fcmr115437ywa.19.1650553986334; Thu, 21
 Apr 2022 08:13:06 -0700 (PDT)
MIME-Version: 1.0
References: <20220420160933.347088-1-daniel.lezcano@linaro.org>
 <8610206dac7bf538eaf8fa81569741a91e4b8dc7.camel@linux.intel.com> <e10b3f13-75b6-c19b-9a27-d75e2e80054a@linaro.org>
In-Reply-To: <e10b3f13-75b6-c19b-9a27-d75e2e80054a@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 21 Apr 2022 17:12:55 +0200
Message-ID: <CAJZ5v0j8iTNv2KXYx6M7Y-4iDLTfzStig9kSg8vr2WidYEkDYg@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] tools/thermal: thermal library and tools
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     srinivas pandruvada <srinivas.pandruvada@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 21, 2022 at 5:05 PM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> On 21/04/2022 05:59, srinivas pandruvada wrote:
> > On Wed, 2022-04-20 at 18:09 +0200, Daniel Lezcano wrote:
>
> [ ... ]
>
> > But I still see these errors in applying patches:
> >
> > Applying: tools/lib/thermal: Add a thermal library
> > Applying: tools/thermal: Add util library
> > Applying: tools/thermal: Add a temperature capture tool
> > .git/rebase-apply/patch:809: space before tab in indent.
> >               polling = 100; }
> > .git/rebase-apply/patch:90: new blank line at EOF.
> > +
> > .git/rebase-apply/patch:221: new blank line at EOF.
> > +
> > warning: 3 lines add whitespace errors.
> > Applying: tools/thermal: Add thermal daemon skeleton
> > .git/rebase-apply/patch:86: new blank line at EOF.
> > +
> > warning: 1 line adds whitespace errors.
>
> Ok, I'll apply it with --whitespace=fix
>
> I did a try and it fixes the trailing whitespace
>
> Is ok for you Rafael ?

Sounds good.
