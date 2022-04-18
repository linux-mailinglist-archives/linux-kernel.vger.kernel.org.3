Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8BD9504B5E
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 05:38:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236077AbiDRDlZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Apr 2022 23:41:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiDRDlW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Apr 2022 23:41:22 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE35E26CD;
        Sun, 17 Apr 2022 20:38:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650253123; x=1681789123;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=sJt7iJqXrfj70TlkpWQlpfVt50M8HRPuJHKoUXIGYP4=;
  b=SeHZqv7lZmQxisTbszxiSPFRjVfjMlQSDM8jwa0fLcWqS7iY+phjwzcV
   bphmPT8ag5LpPWPNOiLdZtQ5p6kx3N6AyFQeH3biu2iiF32sbOeXOCUOa
   FpiA39RWzohiWW1fVizjlg4Ol+wSZIRPr2qq6QI9k322etfNHtQ05a7Fc
   2G7YfySUU9FV7xbGlWt5zaVcMg67sK2zgYInlQDwFVQXc4mxQr65rxPpx
   RKUsvPClEUZNupqJ6TsLKu8w7JwKzSJBYm/nwY4MwQsSSNo4yP1sYuHUt
   ylOQyDNJ9tN9RsI9VgDHwihkb7jqvVnf8lt2/Y+oZOz11ge9iNxqWKjuD
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10320"; a="245331169"
X-IronPort-AV: E=Sophos;i="5.90,267,1643702400"; 
   d="scan'208";a="245331169"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2022 20:38:43 -0700
X-IronPort-AV: E=Sophos;i="5.90,267,1643702400"; 
   d="scan'208";a="554064907"
Received: from spandruv-desk.jf.intel.com ([10.54.75.8])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2022 20:38:43 -0700
Message-ID: <2f31bb43af71b6c8f2f72b272e113bfc9dd54693.camel@linux.intel.com>
Subject: Re: [PATCH v2 0/4] tools/thermal: thermal library and tools
From:   srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Date:   Sun, 17 Apr 2022 20:38:43 -0700
In-Reply-To: <f7e4f4604f122dfab4aa5e589d68eb2c8773e00d.camel@linux.intel.com>
References: <20220330100444.3846661-1-daniel.lezcano@linaro.org>
         <f526d227-ffbb-4ac0-ceb6-c793ab912559@linaro.org>
         <5380fef6d45f2f7a0b8a5f681934f02943d5e138.camel@linux.intel.com>
         <9ccb342b-2f20-6efd-a668-96d593aa921e@linaro.org>
         <CAJZ5v0hrRuVz8pgD6-m7EhVdHPPn67O4ajx_7vkOOOYdTkv2BQ@mail.gmail.com>
         <0181977f5843fb9df4eae7d397d96c890846a0db.camel@linux.intel.com>
         <f1d2b1c7a9691c64ece07fbc1fc5a2d4e70aa00a.camel@linux.intel.com>
         <916d2e4c-7224-f824-f3cf-5c1dee411ed1@linaro.org>
         <dc9b317f88f7d43cd30141376156c0f3eec687d8.camel@linux.intel.com>
         <ba3cbf3d-938b-1530-1178-68b447f20a9c@linaro.org>
         <f7e4f4604f122dfab4aa5e589d68eb2c8773e00d.camel@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2022-04-17 at 20:36 -0700, srinivas pandruvada wrote:
> Hi Daniel,
> 
> The attached diff fixes the crash,
> 
> Also when you run in daemon mode, you need to use some pid lock file.
> Otherwise it launches multiple daemons.
> 
With the diff
./thermal-engine 
thermal zone 'acpitz', id=0
trip id=0, type=3, temp=119000, hyst=0
trip id=1, type=0, temp=71000, hyst=0
trip id=2, type=0, temp=55000, hyst=0
trip id=3, type=0, temp=50000, hyst=0
trip id=4, type=0, temp=45000, hyst=0
trip id=5, type=0, temp=40000, hyst=0
temperature: 25000
governor: 'step_wise'
thermal zone 'INT3400 Thermal', id=1
temperature: 20000
governor: 'user_space'
thermal zone 'B0D4', id=2
trip id=0, type=3, temp=110050, hyst=0
trip id=1, type=2, temp=110050, hyst=0
trip id=2, type=1, temp=110050, hyst=0
trip id=3, type=0, temp=90050, hyst=0
trip id=4, type=0, temp=85050, hyst=0
trip id=5, type=0, temp=80050, hyst=0
trip id=6, type=0, temp=75050, hyst=0
trip id=7, type=0, temp=70050, hyst=0
temperature: 26050
governor: 'user_space'
thermal zone 'x86_pkg_temp', id=3
trip id=0, type=1, temp=-274000, hyst=0
trip id=1, type=1, temp=-274000, hyst=0
temperature: 26000
governor: 'step_wise'
Waiting for thermal events ...

> Thanks,
> Srinivas
> 
> 
> 
> On Sun, 2022-04-17 at 10:20 +0200, Daniel Lezcano wrote:
> > 
> > Hi Srinivas,
> > 
> > thanks for the information. I've indeed not tested on x86_64 but on
> > ARM64.
> > 
> > I'll give a try to reproduce and fix the issue.
> > 
> > Thanks again for taking the time to run it
> > 
> >    -- Daniel
> > 
> > On 17/04/2022 06:23, srinivas pandruvada wrote:
> > > Hi Daniel,
> > > 
> > > On Sat, 2022-04-16 at 09:55 +0200, Daniel Lezcano wrote:
> > > > 
> > > > Hi Srinivas,
> > > > 
> > > > 
> > > > On 16/04/2022 05:50, srinivas pandruvada wrote:
> > > > > On Wed, 2022-04-13 at 10:21 -0700, srinivas pandruvada wrote:
> > > > > > On Wed, 2022-04-13 at 17:06 +0200, Rafael J. Wysocki wrote:
> > > > > > > On Wed, Apr 6, 2022 at 4:44 PM Daniel Lezcano <
> > > > > > > daniel.lezcano@linaro.org> wrote:
> > > > > > > > 
> > > > > 
> > > 
> > > [...]
> > > 
> > > > > root@srinivas-otcpl-icl-u:~/development/linux/tools/thermal/the
> > > > > rmal-
> > > > > engine#
> > > > > LD_LIBRARY_PATH=../lib:../../lib/thermal:$LD_LIBRARY_pATH
> > > > > ./thermal-engine -l DEBUG
> > > > > Segmentation fault (core dumped)
> > > > > root@srinivas-otcpl-icl-u:~/development/linux/tools/thermal/the
> > > > > rmal-
> > > > > engine#
> > > > > LD_LIBRARY_PATH=../lib:../../lib/thermal:$LD_LIBRARY_pATH
> > > > > ./thermal-engine --loglevel DEBUG
> > > > > Segmentation fault (core dumped)
> > > > > root@srinivas-otcpl-icl-u:~/development/linux/tools/thermal/the
> > > > > rmal-
> > > > > engine#
> > > > > LD_LIBRARY_PATH=../lib:../../lib/thermal:$LD_LIBRARY_pATH
> > > > > ./thermal-engine -s
> > > > > Segmentation fault (core dumped)
> > > > 
> > > > Is CONFIG_THERMAL_NETLINK set ?
> > > 
> > > Yes, Thermometer program works fine. Just thermal-engine fails.
> > > CONFIG_THERMAL=y
> > > CONFIG_THERMAL_NETLINK=y
> > > CONFIG_THERMAL_STATISTICS=y
> > > CONFIG_THERMAL_EMERGENCY_POWEROFF_DELAY_MS=0
> > > CONFIG_THERMAL_HWMON=y
> > > CONFIG_THERMAL_WRITABLE_TRIPS=y
> > > CONFIG_THERMAL_DEFAULT_GOV_STEP_WISE=y
> > > # CONFIG_THERMAL_DEFAULT_GOV_FAIR_SHARE is not set
> > > # CONFIG_THERMAL_DEFAULT_GOV_USER_SPACE is not set
> > > CONFIG_THERMAL_GOV_FAIR_SHARE=y
> > > CONFIG_THERMAL_GOV_STEP_WISE=y
> > > CONFIG_THERMAL_GOV_BANG_BANG=y
> > > CONFIG_THERMAL_GOV_USER_SPACE=y
> > > CONFIG_DEVFREQ_THERMAL=y
> > > CONFIG_THERMAL_EMULATION=y
> > > 
> > > This may help
> > > 
> > > #gdb ./thermal-engine
> > > GNU gdb (Ubuntu 8.1.1-0ubuntu1) 8.1.1
> > > Copyright (C) 2018 Free Software Foundation, Inc.
> > > License GPLv3+: GNU GPL version 3 or later
> > > <http://gnu.org/licenses/gpl.html>
> > > This is free software: you are free to change and redistribute it.
> > > There is NO WARRANTY, to the extent permitted by law.  Type "show
> > > copying"
> > > and "show warranty" for details.
> > > This GDB was configured as "x86_64-linux-gnu".
> > > Type "show configuration" for configuration details.
> > > For bug reporting instructions, please see:
> > > <http://www.gnu.org/software/gdb/bugs/>.
> > > Find the GDB manual and other documentation resources online at:
> > > <http://www.gnu.org/software/gdb/documentation/>.
> > > For help, type "help".
> > > Type "apropos word" to search for commands related to "word"...
> > > Reading symbols from ./thermal-engine...(no debugging symbols
> > > found)...done.
> > > (gdb) run
> > > Starting program:
> > > /home/labuser/development/linux/tools/thermal/thermal-
> > > engine/thermal-
> > > engine
> > > [Thread debugging using libthread_db enabled]
> > > Using host libthread_db library "/lib/x86_64-linux-
> > > gnu/libthread_db.so.1".
> > > 
> > > Program received signal SIGSEGV, Segmentation fault.
> > > 0x00007ffff7402036 in parse_tz_get_trip (info=0x7fffffffdf60,
> > > tz=0x555555607898) at commands.c:143
> > > 143             __tt[size].id = -1;
> > > (gdb) backtrace
> > > #0  0x00007ffff7402036 in parse_tz_get_trip (info=0x7fffffffdf60,
> > > tz=0x555555607898) at commands.c:143
> > > #1  0x00007ffff7402233 in handle_netlink (unused=0x0,
> > > cmd=0x7ffff76052f8 <thermal_cmds+120>, info=0x7fffffffdf60,
> > > arg=0x555555607898) at commands.c:206
> > > #2  0x00007ffff7003435 in ?? () from /lib/x86_64-linux-gnu/libnl-
> > > genl-
> > > 3.so.200
> > > #3  0x00007ffff6810c1c in nl_recvmsgs_report () from /lib/x86_64-
> > > linux-
> > > gnu/libnl-3.so.200
> > > #4  0x00007ffff6811049 in nl_recvmsgs () from /lib/x86_64-linux-
> > > gnu/libnl-3.so.200
> > > #5  0x00007ffff7402eaf in nl_send_msg (sock=0x555555606040,
> > > cb=0x5555556065d0, msg=0x555555606110, rx_handler=0x7ffff70036f0
> > > <genl_handle_msg>, data=0x555555607898) at thermal_nl.c:70
> > > #6  0x00007ffff7402327 in thermal_genl_auto (th=0x5555556048a0,
> > > id=1,
> > > cmd=2, flags=0, arg=0x555555607898) at commands.c:282
> > > #7  0x00007ffff74023e0 in thermal_cmd_get_trip (th=0x5555556048a0,
> > > tz=0x555555607898) at commands.c:304
> > > #8  0x00007ffff74039db in __thermal_zone_discover
> > > (tz=0x555555607898,
> > > th=0x5555556048a0) at thermal.c:71
> > > #9  0x00007ffff7403842 in for_each_thermal_zone (tz=0x555555607860,
> > > cb=0x7ffff74039b8 <__thermal_zone_discover>, arg=0x5555556048a0) at
> > > thermal.c:33
> > > #10 0x00007ffff7403a5b in thermal_zone_discover (th=0x5555556048a0)
> > > at
> > > thermal.c:87
> > > #11 0x00005555554019bd in main ()
> > > 
> > > Thanks,
> > > Srinivas
> > > 
> > > > 
> > > 
> > > 
> > 
> > 
> 


