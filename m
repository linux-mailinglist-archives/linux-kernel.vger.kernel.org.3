Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CDD84F66CB
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 19:19:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238737AbiDFRQG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 13:16:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238718AbiDFRPv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 13:15:51 -0400
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 692EA3C59A1;
        Wed,  6 Apr 2022 07:36:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649255796; x=1680791796;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pYFWpetVoxCbWFjEA4TJFxgbar+HNO3sGIldRIqiTWs=;
  b=Rrj/pu76TaEmk4ccio+kleoPqFn61G3GuhKxbXpoHT1cl+f8L4dcbBE2
   IeHEr4lE1ltBuMJmKEu3kmRE1O2VHRZMXFV50gMjnWfmbkzKzw+RXJH+p
   cdswXJGSaVg2VTnZrWI42Ndmf6ukFUOKYtLdF+j8NDYAaTZJG/XQVHQk0
   HOL6X+sGACvx5pRDRx2CNDKuvwS7JrQGp3aSRpCIo4P0nVrnOTm4T3Yqg
   QWBvDpMiuYm9xeRguqqF6UuMSiQOg9/RGqQ0p4DVmsg1QjkWby8j0cpeJ
   vk7z7u6H0ay3AoOKJHF5Owdx3w6k+7lwJikwPfMCTSwak1vRbeIHRfLXU
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10309"; a="321759721"
X-IronPort-AV: E=Sophos;i="5.90,240,1643702400"; 
   d="scan'208";a="321759721"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2022 07:29:00 -0700
X-IronPort-AV: E=Sophos;i="5.90,240,1643702400"; 
   d="scan'208";a="505758016"
Received: from spandruv-desk.jf.intel.com ([10.54.75.8])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2022 07:29:00 -0700
Message-ID: <5380fef6d45f2f7a0b8a5f681934f02943d5e138.camel@linux.intel.com>
Subject: Re: [PATCH v2 0/4] tools/thermal: thermal library and tools
From:   srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>, rafael@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Date:   Wed, 06 Apr 2022 07:28:59 -0700
In-Reply-To: <f526d227-ffbb-4ac0-ceb6-c793ab912559@linaro.org>
References: <20220330100444.3846661-1-daniel.lezcano@linaro.org>
         <f526d227-ffbb-4ac0-ceb6-c793ab912559@linaro.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

On Wed, 2022-04-06 at 10:00 +0200, Daniel Lezcano wrote:
> 
> Hi,
> 
> if there is no comment for the series, shall I pick it so we can go 
> forward ?
Didn't get time to check yet. It will still be for the next merge
window, correct?

Thanks,
Srinivas

> 
> 
> 
> On 30/03/2022 12:04, Daniel Lezcano wrote:
> > These changes are providing the following tools and library:
> > 
> >   - A thermal library doing the netlink abstraction from the kernel
> > in
> >     order to make the userspace thermal implementation easier.
> > Having
> >     the library integrated with the kernel tree is also a guarantee
> > to
> >     keep the message format and their encoding/decoding aligned
> >                                                                    
> >                                                                    
> >                                                                    
> >                                                                    
> >    
> >   - A thermal tools library providing a set of functions to deal
> > with
> >     usual features like the log, the mainloop and the time. This
> >     library is used by the provided tools below
> > 
> >   - An data acquisition program to capture the temperature of the
> >     different thermal zone during an amount of time or during the
> >     execution of an application. The output is formated to be
> > easily
> >     parsed by gnuplot, a spreadsheet program or a statistical
> > command
> >     line utility. The timestamp is based on the system uptime, thus
> >     giving an indication of when a thermal event happened, that can
> >     help to spot or reproduce thermal issue in the long run
> > 
> >   - A thermal monitoring program based on the thermal library. It
> > gives
> >     a skeleton to build any logic on top of it and shows how to use
> > the
> >     thermal library. It does nothing except discovering the thermal
> >     zones, their trip points and listening for events like cooling
> >     devices state changes or trip point crossed
> > 
> >   Changelog:
> > 
> >   v1: Initial post after a RFC
> > 
> >   v2:
> > 
> >    - Fixed all trailing whitespaces and some other checkpatch
> >      warnings. Some warnings remain but they can be considered as
> > false
> >      positive
> > 
> >    - Added in the thermometer tool:
> >      - Usage/help option as well as a man page
> >      - The ability to execute a program
> >      - The capture duration
> >      - Create the output directory if it does not exist
> > 
> >    - Add in the thermal-engine tool:
> >      - A usage/help option
> >      - A message telling the userspace it is waiting for events
> >      - A daemonize option
> > 
> >    - Minor bug fixes here and there, as well as typos
> > 
> > Daniel Lezcano (4):
> >    tools/lib/thermal: Add a thermal library
> >    tools/thermal: Add util library
> >    tools/thermal: A temperature capture tool
> >    tools/thermal: Add thermal daemon skeleton
> > 
> >   MAINTAINERS                                   |   1 +
> >   tools/Makefile                                |  36 +-
> >   tools/lib/thermal/.gitignore                  |   2 +
> >   tools/lib/thermal/Build                       |   5 +
> >   tools/lib/thermal/Makefile                    | 165 ++++++
> >   tools/lib/thermal/commands.c                  | 349 +++++++++++
> >   tools/lib/thermal/events.c                    | 164 +++++
> >   tools/lib/thermal/include/thermal.h           | 142 +++++
> >   tools/lib/thermal/libthermal.map              |  25 +
> >   tools/lib/thermal/libthermal.pc.template      |  12 +
> >   tools/lib/thermal/sampling.c                  |  75 +++
> >   tools/lib/thermal/thermal.c                   | 126 ++++
> >   tools/lib/thermal/thermal_nl.c                | 215 +++++++
> >   tools/lib/thermal/thermal_nl.h                |  46 ++
> >   tools/thermal/lib/Build                       |   3 +
> >   tools/thermal/lib/Makefile                    | 158 +++++
> >   .../thermal/lib/libthermal_tools.pc.template  |  12 +
> >   tools/thermal/lib/log.c                       |  77 +++
> >   tools/thermal/lib/log.h                       |  31 +
> >   tools/thermal/lib/mainloop.c                  | 120 ++++
> >   tools/thermal/lib/mainloop.h                  |  15 +
> >   tools/thermal/lib/thermal-tools.h             |  10 +
> >   tools/thermal/lib/uptimeofday.c               |  40 ++
> >   tools/thermal/lib/uptimeofday.h               |  12 +
> >   tools/thermal/thermal-engine/Build            |   2 +
> >   tools/thermal/thermal-engine/Makefile         |  28 +
> >   tools/thermal/thermal-engine/thermal-engine.c | 326 ++++++++++
> >   tools/thermal/thermometer/Build               |   2 +
> >   tools/thermal/thermometer/Makefile            |  26 +
> >   tools/thermal/thermometer/thermometer.8       |  93 +++
> >   tools/thermal/thermometer/thermometer.c       | 558
> > ++++++++++++++++++
> >   tools/thermal/thermometer/thermometer.conf    |   5 +
> >   32 files changed, 2878 insertions(+), 3 deletions(-)
> >   create mode 100644 tools/lib/thermal/.gitignore
> >   create mode 100644 tools/lib/thermal/Build
> >   create mode 100644 tools/lib/thermal/Makefile
> >   create mode 100644 tools/lib/thermal/commands.c
> >   create mode 100644 tools/lib/thermal/events.c
> >   create mode 100644 tools/lib/thermal/include/thermal.h
> >   create mode 100644 tools/lib/thermal/libthermal.map
> >   create mode 100644 tools/lib/thermal/libthermal.pc.template
> >   create mode 100644 tools/lib/thermal/sampling.c
> >   create mode 100644 tools/lib/thermal/thermal.c
> >   create mode 100644 tools/lib/thermal/thermal_nl.c
> >   create mode 100644 tools/lib/thermal/thermal_nl.h
> >   create mode 100644 tools/thermal/lib/Build
> >   create mode 100644 tools/thermal/lib/Makefile
> >   create mode 100644 tools/thermal/lib/libthermal_tools.pc.template
> >   create mode 100644 tools/thermal/lib/log.c
> >   create mode 100644 tools/thermal/lib/log.h
> >   create mode 100644 tools/thermal/lib/mainloop.c
> >   create mode 100644 tools/thermal/lib/mainloop.h
> >   create mode 100644 tools/thermal/lib/thermal-tools.h
> >   create mode 100644 tools/thermal/lib/uptimeofday.c
> >   create mode 100644 tools/thermal/lib/uptimeofday.h
> >   create mode 100644 tools/thermal/thermal-engine/Build
> >   create mode 100644 tools/thermal/thermal-engine/Makefile
> >   create mode 100644 tools/thermal/thermal-engine/thermal-engine.c
> >   create mode 100644 tools/thermal/thermometer/Build
> >   create mode 100644 tools/thermal/thermometer/Makefile
> >   create mode 100644 tools/thermal/thermometer/thermometer.8
> >   create mode 100644 tools/thermal/thermometer/thermometer.c
> >   create mode 100644 tools/thermal/thermometer/thermometer.conf
> > 
> 
> 


