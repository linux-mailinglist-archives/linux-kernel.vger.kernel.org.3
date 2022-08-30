Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B91A5A6BEA
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 20:18:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229888AbiH3SSS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 14:18:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231319AbiH3SSO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 14:18:14 -0400
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D727456B8C;
        Tue, 30 Aug 2022 11:18:13 -0700 (PDT)
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-3321c2a8d4cso286780027b3.5;
        Tue, 30 Aug 2022 11:18:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=NOBgk7oYaKfLeIeT+JIPmzQRF+4qx8efXeMsbw966Eo=;
        b=x+VE2/t3pBjlGoXv6lIhMqmRmp3R/VeoN8JLFqA79yXDJ/asxU2iuHEsXGK1XzK1vU
         X/KWE9DtjsebHOKzzlNBAyZUjo0uI8F2F1ZVLgxYXBRJgHgOK4dwwzhNmRjbotlvR1hL
         wy3B2F2ZM1vOOowWDWz7XA9tOVXEZ+pJ6m9PoqFzVi9c1TQMeJnZFCuQrHCIMzMF9X7K
         Pn5/rMzdQh+BbZ1WtUtsVTgz6UBiEP1OOC1jebB2t+ySQ3PZ0Zoql+QvoHlse0RMCO9r
         DTzshtalu7v0QTaniF1cLvaLOHZOgho2ubYV3kXh8WdSqvbcbSALSbQplFmJDOIcmA0u
         kotg==
X-Gm-Message-State: ACgBeo21JxJzRFCuxyBQfF+jQvO0Xqq6oBzvmVPmKd2PeZ5zV9rxO6Q5
        HJOOXQ8GsxUEp0ZqL+Qiava7rQxwngvnAleYsA45i7Y+5f4=
X-Google-Smtp-Source: AA6agR4tPgQyxf+FhLG89R/pHVU18J2AHPRg4AGYjaAWywp+vLNwRqD3ZBhsiA+w+UUMaICOpLDgQJ30n8aUG7y2an4=
X-Received: by 2002:a0d:df92:0:b0:340:b90d:fb75 with SMTP id
 i140-20020a0ddf92000000b00340b90dfb75mr13901527ywe.149.1661883493144; Tue, 30
 Aug 2022 11:18:13 -0700 (PDT)
MIME-Version: 1.0
References: <0fc7062d-696a-0794-8730-48ef08bcb8bd@linaro.org>
 <CAJZ5v0h0r2dW7xW+GW3=KDEZZEkyYOXVCOmD3fad=a2enNhddA@mail.gmail.com> <CAJZ5v0hNCezncvW-g1UVPoF-ZmeVWd192FCaZVWrV-+Ucsycpg@mail.gmail.com>
In-Reply-To: <CAJZ5v0hNCezncvW-g1UVPoF-ZmeVWd192FCaZVWrV-+Ucsycpg@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 30 Aug 2022 20:18:02 +0200
Message-ID: <CAJZ5v0ipq3swfX28o4YTCgsX6oyAJfqe385tdYzZXF=2ysfuvQ@mail.gmail.com>
Subject: Re: [GIT PULL] early thermal changes for v6.1-rc1
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Linux PM mailing list <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
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

On Tue, Aug 30, 2022 at 6:50 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Wed, Aug 24, 2022 at 8:16 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
> >
> > On Wed, Aug 24, 2022 at 1:38 PM Daniel Lezcano
> > <daniel.lezcano@linaro.org> wrote:
> > >
> > >
> > > Hi Rafael,
> > >
> > > this cycle will contain certainly a higher number of changes than the
> > > previous ones. That will come from the rework of the thermal trip
> > > handling / consolidation which is still WIP but where the drivers
> > > changes are partly acked-by the different maintainers. The result will
> > > be great IMO in terms of cleanup, encapsulation and maintainability.
> > >
> > > The thermal OF cleanup and rework have been consolidated meanwhile.
> > >
> > > In order to not have a huge pull request at the end of the v6.1
> > > development cycle, I propose to send early but smaller pull requests
> > > (release often, release early), so hopefully that will make the changes
> > > smooth and may be hit the potential bugs for those who are sticking to
> > > linux-pm instead of linux-next.
> > >
> > > This pull request is the first one and has been in the linux-next branch
> > > since a couple of weeks.
> > >
> > > It includes the thermal OF rework, with the corresponding fixes and the
> > > monitoring locking scheme path changes.
> >
> > Pulled, thanks!
>
> So after merging this, the Dell XPS13 9360 in my office doesn't reboot any more.
>
> Undoing the merge makes it reboot again.
>
> Bisection indicates
>
> commit 670a5e356cb6dfc61b87b599eba483af6a3a99ad
> Author: Daniel Lezcano <daniel.lezcano@linaro.org>
> Date:   Fri Aug 5 17:38:33 2022 +0200
>
>    thermal/core: Move the thermal zone lock out of the governors
>
> as the first bad commit, but I'm not sure what can be wrong with it yet.

See: https://patchwork.kernel.org/project/linux-pm/patch/12067136.O9o76ZdvQC@kreacher/

I'm adding this one to linux-next right away.
