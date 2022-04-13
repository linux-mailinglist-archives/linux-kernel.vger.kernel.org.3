Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B0684FFC4A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 19:21:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237272AbiDMRYL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 13:24:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbiDMRYK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 13:24:10 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1A6C62C8C;
        Wed, 13 Apr 2022 10:21:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649870507; x=1681406507;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hj5kneNXt9GQIiug/+hb6huww6UsvPYM41YmQxPGypE=;
  b=SS3xYGR4zGzbnNSG4fzC/NB6AzIL7fkdyOdSlBZ8AaJAwnLgm7w4UjfZ
   aUTalm+Ri9hf/qH4Ic069wvWVGSo4NbwJholCCs3+4XPwqzwwHBvqe9SX
   6cWiA3x52gauiPwRS1tYYuTbPbGmtCtZwo8ZDAmH2mPTYJQG1bjiic51n
   gC/zZH1cD0OfA7JaITBlGx+SriPqqE6PuUG2o1Rsb44sdjOjP9wekBc5s
   NdcQBsjq3fs+9Tzh9YjhSWRv8bVtj8iwABLGuMr66g5gNKdJc6R1HYmHI
   nB8kshuRda9M9DAFUsjwBeJitRhZe22xIkdhSYqbTp1jEmY1o1CEi7Gfd
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10316"; a="349161021"
X-IronPort-AV: E=Sophos;i="5.90,257,1643702400"; 
   d="scan'208";a="349161021"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2022 10:21:47 -0700
X-IronPort-AV: E=Sophos;i="5.90,257,1643702400"; 
   d="scan'208";a="508059205"
Received: from spandruv-desk.jf.intel.com ([10.54.75.8])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2022 10:21:47 -0700
Message-ID: <0181977f5843fb9df4eae7d397d96c890846a0db.camel@linux.intel.com>
Subject: Re: [PATCH v2 0/4] tools/thermal: thermal library and tools
From:   srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Date:   Wed, 13 Apr 2022 10:21:47 -0700
In-Reply-To: <CAJZ5v0hrRuVz8pgD6-m7EhVdHPPn67O4ajx_7vkOOOYdTkv2BQ@mail.gmail.com>
References: <20220330100444.3846661-1-daniel.lezcano@linaro.org>
         <f526d227-ffbb-4ac0-ceb6-c793ab912559@linaro.org>
         <5380fef6d45f2f7a0b8a5f681934f02943d5e138.camel@linux.intel.com>
         <9ccb342b-2f20-6efd-a668-96d593aa921e@linaro.org>
         <CAJZ5v0hrRuVz8pgD6-m7EhVdHPPn67O4ajx_7vkOOOYdTkv2BQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2022-04-13 at 17:06 +0200, Rafael J. Wysocki wrote:
> On Wed, Apr 6, 2022 at 4:44 PM Daniel Lezcano <
> daniel.lezcano@linaro.org> wrote:
> > 
> > On 06/04/2022 16:28, srinivas pandruvada wrote:
> > > Hi Daniel,
> > > 
> > > On Wed, 2022-04-06 at 10:00 +0200, Daniel Lezcano wrote:
> > > > 
> > > > Hi,
> > > > 
> > > > if there is no comment for the series, shall I pick it so we
> > > > can go
> > > > forward ?
> > > Didn't get time to check yet. It will still be for the next merge
> > > window, correct?
> > 
> > Right, but I would like to continue adding more features, scripts
> > and
> > tests. Iteratively.
> 
> Srinivas, if you can give this a go, please, it will help.
> 
> Otherwise, I think that all of your comments so far have been
> addressed, or have I missed anything?
> 
I will provide by the end of this week.

Thanks,
Srinivas


> > 
> > > > 
> > > > On 30/03/2022 12:04, Daniel Lezcano wrote:
> > > > > These changes are providing the following tools and library:
> > > > > 
> > > > >    - A thermal library doing the netlink abstraction from the
> > > > > kernel
> > > > > in
> > > > >      order to make the userspace thermal implementation
> > > > > easier.
> > > > > Having
> > > > >      the library integrated with the kernel tree is also a
> > > > > guarantee
> > > > > to
> > > > >      keep the message format and their encoding/decoding
> > > > > aligned
> > > > > 
> > > > > 
> > > > > 
> > > > > 
> > > > > 
> > > > >    - A thermal tools library providing a set of functions to
> > > > > deal
> > > > > with
> > > > >      usual features like the log, the mainloop and the time.
> > > > > This
> > > > >      library is used by the provided tools below
> > > > > 
> > > > >    - An data acquisition program to capture the temperature
> > > > > of the
> > > > >      different thermal zone during an amount of time or
> > > > > during the
> > > > >      execution of an application. The output is formated to
> > > > > be
> > > > > easily
> > > > >      parsed by gnuplot, a spreadsheet program or a
> > > > > statistical
> > > > > command
> > > > >      line utility. The timestamp is based on the system
> > > > > uptime, thus
> > > > >      giving an indication of when a thermal event happened,
> > > > > that can
> > > > >      help to spot or reproduce thermal issue in the long run
> > > > > 
> > > > >    - A thermal monitoring program based on the thermal
> > > > > library. It
> > > > > gives
> > > > >      a skeleton to build any logic on top of it and shows how
> > > > > to use
> > > > > the
> > > > >      thermal library. It does nothing except discovering the
> > > > > thermal
> > > > >      zones, their trip points and listening for events like
> > > > > cooling
> > > > >      devices state changes or trip point crossed
> > > > > 
> > > > >    Changelog:
> > > > > 
> > > > >    v1: Initial post after a RFC
> > > > > 
> > > > >    v2:
> > > > > 
> > > > >     - Fixed all trailing whitespaces and some other
> > > > > checkpatch
> > > > >       warnings. Some warnings remain but they can be
> > > > > considered as
> > > > > false
> > > > >       positive
> > > > > 
> > > > >     - Added in the thermometer tool:
> > > > >       - Usage/help option as well as a man page
> > > > >       - The ability to execute a program
> > > > >       - The capture duration
> > > > >       - Create the output directory if it does not exist
> > > > > 
> > > > >     - Add in the thermal-engine tool:
> > > > >       - A usage/help option
> > > > >       - A message telling the userspace it is waiting for
> > > > > events
> > > > >       - A daemonize option
> > > > > 
> > > > >     - Minor bug fixes here and there, as well as typos
> > > > > 
> > > > > Daniel Lezcano (4):
> > > > >     tools/lib/thermal: Add a thermal library
> > > > >     tools/thermal: Add util library
> > > > >     tools/thermal: A temperature capture tool
> > > > >     tools/thermal: Add thermal daemon skeleton
> > > > > 
> > > > >    MAINTAINERS                                   |   1 +
> > > > >    tools/Makefile                                |  36 +-
> > > > >    tools/lib/thermal/.gitignore                  |   2 +
> > > > >    tools/lib/thermal/Build                       |   5 +
> > > > >    tools/lib/thermal/Makefile                    | 165 ++++++
> > > > >    tools/lib/thermal/commands.c                  | 349
> > > > > +++++++++++
> > > > >    tools/lib/thermal/events.c                    | 164 +++++
> > > > >    tools/lib/thermal/include/thermal.h           | 142 +++++
> > > > >    tools/lib/thermal/libthermal.map              |  25 +
> > > > >    tools/lib/thermal/libthermal.pc.template      |  12 +
> > > > >    tools/lib/thermal/sampling.c                  |  75 +++
> > > > >    tools/lib/thermal/thermal.c                   | 126 ++++
> > > > >    tools/lib/thermal/thermal_nl.c                | 215
> > > > > +++++++
> > > > >    tools/lib/thermal/thermal_nl.h                |  46 ++
> > > > >    tools/thermal/lib/Build                       |   3 +
> > > > >    tools/thermal/lib/Makefile                    | 158 +++++
> > > > >    .../thermal/lib/libthermal_tools.pc.template  |  12 +
> > > > >    tools/thermal/lib/log.c                       |  77 +++
> > > > >    tools/thermal/lib/log.h                       |  31 +
> > > > >    tools/thermal/lib/mainloop.c                  | 120 ++++
> > > > >    tools/thermal/lib/mainloop.h                  |  15 +
> > > > >    tools/thermal/lib/thermal-tools.h             |  10 +
> > > > >    tools/thermal/lib/uptimeofday.c               |  40 ++
> > > > >    tools/thermal/lib/uptimeofday.h               |  12 +
> > > > >    tools/thermal/thermal-engine/Build            |   2 +
> > > > >    tools/thermal/thermal-engine/Makefile         |  28 +
> > > > >    tools/thermal/thermal-engine/thermal-engine.c | 326
> > > > > ++++++++++
> > > > >    tools/thermal/thermometer/Build               |   2 +
> > > > >    tools/thermal/thermometer/Makefile            |  26 +
> > > > >    tools/thermal/thermometer/thermometer.8       |  93 +++
> > > > >    tools/thermal/thermometer/thermometer.c       | 558
> > > > > ++++++++++++++++++
> > > > >    tools/thermal/thermometer/thermometer.conf    |   5 +
> > > > >    32 files changed, 2878 insertions(+), 3 deletions(-)
> > > > >    create mode 100644 tools/lib/thermal/.gitignore
> > > > >    create mode 100644 tools/lib/thermal/Build
> > > > >    create mode 100644 tools/lib/thermal/Makefile
> > > > >    create mode 100644 tools/lib/thermal/commands.c
> > > > >    create mode 100644 tools/lib/thermal/events.c
> > > > >    create mode 100644 tools/lib/thermal/include/thermal.h
> > > > >    create mode 100644 tools/lib/thermal/libthermal.map
> > > > >    create mode 100644
> > > > > tools/lib/thermal/libthermal.pc.template
> > > > >    create mode 100644 tools/lib/thermal/sampling.c
> > > > >    create mode 100644 tools/lib/thermal/thermal.c
> > > > >    create mode 100644 tools/lib/thermal/thermal_nl.c
> > > > >    create mode 100644 tools/lib/thermal/thermal_nl.h
> > > > >    create mode 100644 tools/thermal/lib/Build
> > > > >    create mode 100644 tools/thermal/lib/Makefile
> > > > >    create mode 100644
> > > > > tools/thermal/lib/libthermal_tools.pc.template
> > > > >    create mode 100644 tools/thermal/lib/log.c
> > > > >    create mode 100644 tools/thermal/lib/log.h
> > > > >    create mode 100644 tools/thermal/lib/mainloop.c
> > > > >    create mode 100644 tools/thermal/lib/mainloop.h
> > > > >    create mode 100644 tools/thermal/lib/thermal-tools.h
> > > > >    create mode 100644 tools/thermal/lib/uptimeofday.c
> > > > >    create mode 100644 tools/thermal/lib/uptimeofday.h
> > > > >    create mode 100644 tools/thermal/thermal-engine/Build
> > > > >    create mode 100644 tools/thermal/thermal-engine/Makefile
> > > > >    create mode 100644 tools/thermal/thermal-engine/thermal-
> > > > > engine.c
> > > > >    create mode 100644 tools/thermal/thermometer/Build
> > > > >    create mode 100644 tools/thermal/thermometer/Makefile
> > > > >    create mode 100644 tools/thermal/thermometer/thermometer.8
> > > > >    create mode 100644 tools/thermal/thermometer/thermometer.c
> > > > >    create mode 100644
> > > > > tools/thermal/thermometer/thermometer.conf
> > > > > 
> > > > 
> > > > 
> > > 
> > > 
> > 
> > 
> > --
> > <http://www.linaro.org/> Linaro.org │ Open source software for ARM
> > SoCs
> > 
> > Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
> > <http://twitter.com/#!/linaroorg> Twitter |
> > <http://www.linaro.org/linaro-blog/> Blog


