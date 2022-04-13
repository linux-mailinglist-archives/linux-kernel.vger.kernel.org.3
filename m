Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C11A4FF9B5
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 17:06:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236355AbiDMPIj convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 13 Apr 2022 11:08:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230492AbiDMPIg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 11:08:36 -0400
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C548C2CC87;
        Wed, 13 Apr 2022 08:06:14 -0700 (PDT)
Received: by mail-yb1-f170.google.com with SMTP id f17so4249804ybj.10;
        Wed, 13 Apr 2022 08:06:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Ku6dT6SskYpelGy1vZQbgw+p6225batSgaxusaO2oBc=;
        b=5lkZkcqR+m7PYy3fb8z+PYNboYBAaBAFzCu6KIbJnDYXSMaKXyt8HgN+7PSei6yfkD
         fSdiVdhFjZ5DS7QAqhru8ulSsWAQLpccXnbDQIKGheXrQ1aVTjy8WjzdFgKe2o6nayfi
         zVWs3oY8ZrMrqWvm23OA7F5bdrgncXDT2scKk3ki8mhdWoYoVFK0AXtyJTbdyX/Jkbfk
         eODshRnfdswIcuGnzbXwnByj0k7VoAJIGrrkxR8YZdCK52yc+1lNO8TnNGEsZStgX017
         uUbG4mEKP8ZTryn2q5emspomae8zm9TMZtzY2wDhwPWcgAcjCWMlNfiuUoc8VAPxyH4U
         LxTw==
X-Gm-Message-State: AOAM533EvKr9SK5YFqdrgsvYJaNsf+JRx7LVXOIl0HhnoWLpiWvktLq7
        hmGLPpZJ0OrI3DW30PFNMrNJQGy9amHCGtkdIRs=
X-Google-Smtp-Source: ABdhPJxFvzrkFSaTInRkPcgv1LG+0tTalMr8nTyiAxsU5MPwC8iQfLRoJlZm9oru6Amuos406zn/IP/DN697dymcQi4=
X-Received: by 2002:a05:6902:187:b0:63d:9c95:edca with SMTP id
 t7-20020a056902018700b0063d9c95edcamr28678466ybh.81.1649862373708; Wed, 13
 Apr 2022 08:06:13 -0700 (PDT)
MIME-Version: 1.0
References: <20220330100444.3846661-1-daniel.lezcano@linaro.org>
 <f526d227-ffbb-4ac0-ceb6-c793ab912559@linaro.org> <5380fef6d45f2f7a0b8a5f681934f02943d5e138.camel@linux.intel.com>
 <9ccb342b-2f20-6efd-a668-96d593aa921e@linaro.org>
In-Reply-To: <9ccb342b-2f20-6efd-a668-96d593aa921e@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 13 Apr 2022 17:06:02 +0200
Message-ID: <CAJZ5v0hrRuVz8pgD6-m7EhVdHPPn67O4ajx_7vkOOOYdTkv2BQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] tools/thermal: thermal library and tools
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 6, 2022 at 4:44 PM Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>
> On 06/04/2022 16:28, srinivas pandruvada wrote:
> > Hi Daniel,
> >
> > On Wed, 2022-04-06 at 10:00 +0200, Daniel Lezcano wrote:
> >>
> >> Hi,
> >>
> >> if there is no comment for the series, shall I pick it so we can go
> >> forward ?
> > Didn't get time to check yet. It will still be for the next merge
> > window, correct?
>
> Right, but I would like to continue adding more features, scripts and
> tests. Iteratively.

Srinivas, if you can give this a go, please, it will help.

Otherwise, I think that all of your comments so far have been
addressed, or have I missed anything?

>
> >>
> >> On 30/03/2022 12:04, Daniel Lezcano wrote:
> >>> These changes are providing the following tools and library:
> >>>
> >>>    - A thermal library doing the netlink abstraction from the kernel
> >>> in
> >>>      order to make the userspace thermal implementation easier.
> >>> Having
> >>>      the library integrated with the kernel tree is also a guarantee
> >>> to
> >>>      keep the message format and their encoding/decoding aligned
> >>>
> >>>
> >>>
> >>>
> >>>
> >>>    - A thermal tools library providing a set of functions to deal
> >>> with
> >>>      usual features like the log, the mainloop and the time. This
> >>>      library is used by the provided tools below
> >>>
> >>>    - An data acquisition program to capture the temperature of the
> >>>      different thermal zone during an amount of time or during the
> >>>      execution of an application. The output is formated to be
> >>> easily
> >>>      parsed by gnuplot, a spreadsheet program or a statistical
> >>> command
> >>>      line utility. The timestamp is based on the system uptime, thus
> >>>      giving an indication of when a thermal event happened, that can
> >>>      help to spot or reproduce thermal issue in the long run
> >>>
> >>>    - A thermal monitoring program based on the thermal library. It
> >>> gives
> >>>      a skeleton to build any logic on top of it and shows how to use
> >>> the
> >>>      thermal library. It does nothing except discovering the thermal
> >>>      zones, their trip points and listening for events like cooling
> >>>      devices state changes or trip point crossed
> >>>
> >>>    Changelog:
> >>>
> >>>    v1: Initial post after a RFC
> >>>
> >>>    v2:
> >>>
> >>>     - Fixed all trailing whitespaces and some other checkpatch
> >>>       warnings. Some warnings remain but they can be considered as
> >>> false
> >>>       positive
> >>>
> >>>     - Added in the thermometer tool:
> >>>       - Usage/help option as well as a man page
> >>>       - The ability to execute a program
> >>>       - The capture duration
> >>>       - Create the output directory if it does not exist
> >>>
> >>>     - Add in the thermal-engine tool:
> >>>       - A usage/help option
> >>>       - A message telling the userspace it is waiting for events
> >>>       - A daemonize option
> >>>
> >>>     - Minor bug fixes here and there, as well as typos
> >>>
> >>> Daniel Lezcano (4):
> >>>     tools/lib/thermal: Add a thermal library
> >>>     tools/thermal: Add util library
> >>>     tools/thermal: A temperature capture tool
> >>>     tools/thermal: Add thermal daemon skeleton
> >>>
> >>>    MAINTAINERS                                   |   1 +
> >>>    tools/Makefile                                |  36 +-
> >>>    tools/lib/thermal/.gitignore                  |   2 +
> >>>    tools/lib/thermal/Build                       |   5 +
> >>>    tools/lib/thermal/Makefile                    | 165 ++++++
> >>>    tools/lib/thermal/commands.c                  | 349 +++++++++++
> >>>    tools/lib/thermal/events.c                    | 164 +++++
> >>>    tools/lib/thermal/include/thermal.h           | 142 +++++
> >>>    tools/lib/thermal/libthermal.map              |  25 +
> >>>    tools/lib/thermal/libthermal.pc.template      |  12 +
> >>>    tools/lib/thermal/sampling.c                  |  75 +++
> >>>    tools/lib/thermal/thermal.c                   | 126 ++++
> >>>    tools/lib/thermal/thermal_nl.c                | 215 +++++++
> >>>    tools/lib/thermal/thermal_nl.h                |  46 ++
> >>>    tools/thermal/lib/Build                       |   3 +
> >>>    tools/thermal/lib/Makefile                    | 158 +++++
> >>>    .../thermal/lib/libthermal_tools.pc.template  |  12 +
> >>>    tools/thermal/lib/log.c                       |  77 +++
> >>>    tools/thermal/lib/log.h                       |  31 +
> >>>    tools/thermal/lib/mainloop.c                  | 120 ++++
> >>>    tools/thermal/lib/mainloop.h                  |  15 +
> >>>    tools/thermal/lib/thermal-tools.h             |  10 +
> >>>    tools/thermal/lib/uptimeofday.c               |  40 ++
> >>>    tools/thermal/lib/uptimeofday.h               |  12 +
> >>>    tools/thermal/thermal-engine/Build            |   2 +
> >>>    tools/thermal/thermal-engine/Makefile         |  28 +
> >>>    tools/thermal/thermal-engine/thermal-engine.c | 326 ++++++++++
> >>>    tools/thermal/thermometer/Build               |   2 +
> >>>    tools/thermal/thermometer/Makefile            |  26 +
> >>>    tools/thermal/thermometer/thermometer.8       |  93 +++
> >>>    tools/thermal/thermometer/thermometer.c       | 558
> >>> ++++++++++++++++++
> >>>    tools/thermal/thermometer/thermometer.conf    |   5 +
> >>>    32 files changed, 2878 insertions(+), 3 deletions(-)
> >>>    create mode 100644 tools/lib/thermal/.gitignore
> >>>    create mode 100644 tools/lib/thermal/Build
> >>>    create mode 100644 tools/lib/thermal/Makefile
> >>>    create mode 100644 tools/lib/thermal/commands.c
> >>>    create mode 100644 tools/lib/thermal/events.c
> >>>    create mode 100644 tools/lib/thermal/include/thermal.h
> >>>    create mode 100644 tools/lib/thermal/libthermal.map
> >>>    create mode 100644 tools/lib/thermal/libthermal.pc.template
> >>>    create mode 100644 tools/lib/thermal/sampling.c
> >>>    create mode 100644 tools/lib/thermal/thermal.c
> >>>    create mode 100644 tools/lib/thermal/thermal_nl.c
> >>>    create mode 100644 tools/lib/thermal/thermal_nl.h
> >>>    create mode 100644 tools/thermal/lib/Build
> >>>    create mode 100644 tools/thermal/lib/Makefile
> >>>    create mode 100644 tools/thermal/lib/libthermal_tools.pc.template
> >>>    create mode 100644 tools/thermal/lib/log.c
> >>>    create mode 100644 tools/thermal/lib/log.h
> >>>    create mode 100644 tools/thermal/lib/mainloop.c
> >>>    create mode 100644 tools/thermal/lib/mainloop.h
> >>>    create mode 100644 tools/thermal/lib/thermal-tools.h
> >>>    create mode 100644 tools/thermal/lib/uptimeofday.c
> >>>    create mode 100644 tools/thermal/lib/uptimeofday.h
> >>>    create mode 100644 tools/thermal/thermal-engine/Build
> >>>    create mode 100644 tools/thermal/thermal-engine/Makefile
> >>>    create mode 100644 tools/thermal/thermal-engine/thermal-engine.c
> >>>    create mode 100644 tools/thermal/thermometer/Build
> >>>    create mode 100644 tools/thermal/thermometer/Makefile
> >>>    create mode 100644 tools/thermal/thermometer/thermometer.8
> >>>    create mode 100644 tools/thermal/thermometer/thermometer.c
> >>>    create mode 100644 tools/thermal/thermometer/thermometer.conf
> >>>
> >>
> >>
> >
> >
>
>
> --
> <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs
>
> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
> <http://twitter.com/#!/linaroorg> Twitter |
> <http://www.linaro.org/linaro-blog/> Blog
