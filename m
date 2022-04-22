Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33AFC50AF6D
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 07:10:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444120AbiDVFNN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 01:13:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386384AbiDVFNK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 01:13:10 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D1E04B84D;
        Thu, 21 Apr 2022 22:10:18 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id d9so4801191qty.12;
        Thu, 21 Apr 2022 22:10:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TWff7qTwFks9/SICsPV5Guj+3/oz5mDxjPoy3+sANMY=;
        b=GLdZan31fedPnJQvY0HuMvKT28Tq0GME2Oz/mxowpgDRkDRzYy4H1X29/DsXHX74r5
         cwe/z04i3QcMMTdp6j30C/hzuyLOggvOSCe2dMvNnFZyDLbzCE0bnT3wgKleaNpTXZjY
         LzONeJHWIM8VEpNO/lhUBwOeqnNt3TKpYMoPrC10Uxdcw1qySo1vn3OwjtmLy/O8avR3
         QYrxf8axaPENQ0ApJiVhE94wDYy6ABHRbMuN/PCkg1qQ6XQspnMNKX88JY7sxQZUG/e2
         vkC1vlfXS6qL+ii0z2hYrMQfTezl/0zikNix+b4X1YspXyUTKcP2dBoltgf7jvFtWk9A
         QzGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TWff7qTwFks9/SICsPV5Guj+3/oz5mDxjPoy3+sANMY=;
        b=diWPYQkRrbMTKa8xdYC3gIEQpd1Tw7HW7EiMGVpkZPal743wA7821JNKfUepJXgzxF
         9bmwQ7MJiRetdzL5qNwNLwHvuj7Lw9A+T6SV75tdZbbpMNUhLbcMBPhoBgJtF52v3iAG
         3XrlrjOmZjgxeR1qw5sXcKX9DMksxzZ7hs5rszMeA/KS+ceAdiryDSyNadRHvPeyOJzL
         5c5a7VzXFHcapC7LTbNsSAbQo3P9qTvqKry5LvP9ZYslSqKuykG/c4/m4iH0k01LcTE5
         3hE6jiB/CU5wgTpDKd0HTdAw85NxHKv/dyJz/19mvEi/eSlGBb4/v1NVSZnpdOXQX3G6
         3Vnw==
X-Gm-Message-State: AOAM5319RBGgladVwxp77uRUhECIA0lke3a7xFLNNSl0avXaoPxg2cFs
        Iid1Z1XGhScM3Eq3y72Hv8yw4eBx001nD3qa7D8=
X-Google-Smtp-Source: ABdhPJxmk+Ep8q2MfVJdlbnq0yjAC6trvGuV/AhxShVlF3NjJDIoK0tW6ZO3Cdh+EXSHioM7h+A2LbnRDSddUXdl3Lo=
X-Received: by 2002:ac8:5a16:0:b0:2e1:ea00:b4e1 with SMTP id
 n22-20020ac85a16000000b002e1ea00b4e1mr1968564qta.329.1650604217364; Thu, 21
 Apr 2022 22:10:17 -0700 (PDT)
MIME-Version: 1.0
References: <20220422041427.32585-1-soumya.negi97@gmail.com> <0a338104-d7cf-a2e1-7d03-97667aa30537@infradead.org>
In-Reply-To: <0a338104-d7cf-a2e1-7d03-97667aa30537@infradead.org>
From:   Soumya Negi <soumya.negi97@gmail.com>
Date:   Thu, 21 Apr 2022 22:10:06 -0700
Message-ID: <CAHH-VXfoRX_cgPMPrubrZmrD1DRXaUOfquuFb5G8eSq8Y_eRWw@mail.gmail.com>
Subject: Re: [PATCH] Documentation: thermal: Include ReST markup standard
 definition file
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-pm@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for letting me know.

On Thu, Apr 21, 2022 at 9:28 PM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> Hi--
>
> On 4/21/22 21:14, Soumya Negi wrote:
> > Fixes the documentation compile error given below:
> >
> > ERROR: Undefined substitution referenced: "copy".
> >
> > Signed-off-by: Soumya Negi <soumya.negi97@gmail.com>
> > ---
> >  Documentation/driver-api/thermal/intel_dptf.rst | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/Documentation/driver-api/thermal/intel_dptf.rst b/Documentation/driver-api/thermal/intel_dptf.rst
> > index 96668dca753a..e3c41d96d63a 100644
> > --- a/Documentation/driver-api/thermal/intel_dptf.rst
> > +++ b/Documentation/driver-api/thermal/intel_dptf.rst
> > @@ -1,4 +1,5 @@
> >  .. SPDX-License-Identifier: GPL-2.0
> > +.. include:: <isonum.txt>
> >
> >  ===============================================================
> >  Intel(R) Dynamic Platform and Thermal Framework Sysfs Interface
>
> linux-next and jc_docs git tree already have a patch for this:
>
> commit 2c2de6f2e2bc
> Author: Akira Yokosawa <akiyks@gmail.com>
> Date:   Sat Apr 2 08:19:05 2022 +0900
>
>     docs: driver-api/thermal/intel_dptf: Use copyright symbol
>
>
> thanks.
> --
> ~Randy
