Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CA87504647
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Apr 2022 06:23:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233416AbiDQEZx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Apr 2022 00:25:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231489AbiDQEZv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Apr 2022 00:25:51 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4581319C10;
        Sat, 16 Apr 2022 21:23:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650169397; x=1681705397;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=IGknIamWu77T6Ipn26rG79IrhNzIvpjNecPm/RNCOfo=;
  b=HNDtszgqFI3585o05BjNwogTpv6+CqNTpfCI4+3+V37Pwz47aOJnP7kV
   76tKYa41YwJdi0dz5c0SxNbgBI0f+GqDD5Ct9fxdRec810vXIhqb1LVOB
   8OKs2Sbygcv3rjSU2NHyrPm1RL+d21p0ZZPi2NfifwiyJmdnaGciGJqOY
   cAzOuFkCrcefpQQcsE7yVGJczq5JvITX+gPVHxDO7ETmjIBNa5+N/VTLg
   b7zAyc36PMSsgIVqCaQiw4TOmKqZf3HxVZcHFSFrtNJFjNRRj8GxSlnSv
   nPptu82BWS2LFOzXg3Bh34UFcBiTGzZyCCBGMnqMaE8VYKM95EUfMP3bn
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10318"; a="262820037"
X-IronPort-AV: E=Sophos;i="5.90,266,1643702400"; 
   d="scan'208";a="262820037"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2022 21:23:16 -0700
X-IronPort-AV: E=Sophos;i="5.90,266,1643702400"; 
   d="scan'208";a="575063588"
Received: from spandruv-desk.jf.intel.com ([10.54.75.8])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2022 21:23:16 -0700
Message-ID: <dc9b317f88f7d43cd30141376156c0f3eec687d8.camel@linux.intel.com>
Subject: Re: [PATCH v2 0/4] tools/thermal: thermal library and tools
From:   srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Date:   Sat, 16 Apr 2022 21:23:16 -0700
In-Reply-To: <916d2e4c-7224-f824-f3cf-5c1dee411ed1@linaro.org>
References: <20220330100444.3846661-1-daniel.lezcano@linaro.org>
         <f526d227-ffbb-4ac0-ceb6-c793ab912559@linaro.org>
         <5380fef6d45f2f7a0b8a5f681934f02943d5e138.camel@linux.intel.com>
         <9ccb342b-2f20-6efd-a668-96d593aa921e@linaro.org>
         <CAJZ5v0hrRuVz8pgD6-m7EhVdHPPn67O4ajx_7vkOOOYdTkv2BQ@mail.gmail.com>
         <0181977f5843fb9df4eae7d397d96c890846a0db.camel@linux.intel.com>
         <f1d2b1c7a9691c64ece07fbc1fc5a2d4e70aa00a.camel@linux.intel.com>
         <916d2e4c-7224-f824-f3cf-5c1dee411ed1@linaro.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

On Sat, 2022-04-16 at 09:55 +0200, Daniel Lezcano wrote:
> 
> Hi Srinivas,
> 
> 
> On 16/04/2022 05:50, srinivas pandruvada wrote:
> > On Wed, 2022-04-13 at 10:21 -0700, srinivas pandruvada wrote:
> > > On Wed, 2022-04-13 at 17:06 +0200, Rafael J. Wysocki wrote:
> > > > On Wed, Apr 6, 2022 at 4:44 PM Daniel Lezcano <
> > > > daniel.lezcano@linaro.org> wrote:
> > > > > 
> > 

[...]

> > root@srinivas-otcpl-icl-u:~/development/linux/tools/thermal/thermal-
> > engine# LD_LIBRARY_PATH=../lib:../../lib/thermal:$LD_LIBRARY_pATH
> > ./thermal-engine -l DEBUG
> > Segmentation fault (core dumped)
> > root@srinivas-otcpl-icl-u:~/development/linux/tools/thermal/thermal-
> > engine# LD_LIBRARY_PATH=../lib:../../lib/thermal:$LD_LIBRARY_pATH
> > ./thermal-engine --loglevel DEBUG
> > Segmentation fault (core dumped)
> > root@srinivas-otcpl-icl-u:~/development/linux/tools/thermal/thermal-
> > engine# LD_LIBRARY_PATH=../lib:../../lib/thermal:$LD_LIBRARY_pATH
> > ./thermal-engine -s
> > Segmentation fault (core dumped)
> 
> Is CONFIG_THERMAL_NETLINK set ?

Yes, Thermometer program works fine. Just thermal-engine fails.
CONFIG_THERMAL=y
CONFIG_THERMAL_NETLINK=y
CONFIG_THERMAL_STATISTICS=y
CONFIG_THERMAL_EMERGENCY_POWEROFF_DELAY_MS=0
CONFIG_THERMAL_HWMON=y
CONFIG_THERMAL_WRITABLE_TRIPS=y
CONFIG_THERMAL_DEFAULT_GOV_STEP_WISE=y
# CONFIG_THERMAL_DEFAULT_GOV_FAIR_SHARE is not set
# CONFIG_THERMAL_DEFAULT_GOV_USER_SPACE is not set
CONFIG_THERMAL_GOV_FAIR_SHARE=y
CONFIG_THERMAL_GOV_STEP_WISE=y
CONFIG_THERMAL_GOV_BANG_BANG=y
CONFIG_THERMAL_GOV_USER_SPACE=y
CONFIG_DEVFREQ_THERMAL=y
CONFIG_THERMAL_EMULATION=y

This may help

#gdb ./thermal-engine 
GNU gdb (Ubuntu 8.1.1-0ubuntu1) 8.1.1
Copyright (C) 2018 Free Software Foundation, Inc.
License GPLv3+: GNU GPL version 3 or later
<http://gnu.org/licenses/gpl.html>
This is free software: you are free to change and redistribute it.
There is NO WARRANTY, to the extent permitted by law.  Type "show
copying"
and "show warranty" for details.
This GDB was configured as "x86_64-linux-gnu".
Type "show configuration" for configuration details.
For bug reporting instructions, please see:
<http://www.gnu.org/software/gdb/bugs/>.
Find the GDB manual and other documentation resources online at:
<http://www.gnu.org/software/gdb/documentation/>.
For help, type "help".
Type "apropos word" to search for commands related to "word"...
Reading symbols from ./thermal-engine...(no debugging symbols
found)...done.
(gdb) run
Starting program:
/home/labuser/development/linux/tools/thermal/thermal-engine/thermal-
engine 
[Thread debugging using libthread_db enabled]
Using host libthread_db library "/lib/x86_64-linux-
gnu/libthread_db.so.1".

Program received signal SIGSEGV, Segmentation fault.
0x00007ffff7402036 in parse_tz_get_trip (info=0x7fffffffdf60,
tz=0x555555607898) at commands.c:143
143		__tt[size].id = -1;
(gdb) backtrace 
#0  0x00007ffff7402036 in parse_tz_get_trip (info=0x7fffffffdf60,
tz=0x555555607898) at commands.c:143
#1  0x00007ffff7402233 in handle_netlink (unused=0x0,
cmd=0x7ffff76052f8 <thermal_cmds+120>, info=0x7fffffffdf60,
arg=0x555555607898) at commands.c:206
#2  0x00007ffff7003435 in ?? () from /lib/x86_64-linux-gnu/libnl-genl-
3.so.200
#3  0x00007ffff6810c1c in nl_recvmsgs_report () from /lib/x86_64-linux-
gnu/libnl-3.so.200
#4  0x00007ffff6811049 in nl_recvmsgs () from /lib/x86_64-linux-
gnu/libnl-3.so.200
#5  0x00007ffff7402eaf in nl_send_msg (sock=0x555555606040,
cb=0x5555556065d0, msg=0x555555606110, rx_handler=0x7ffff70036f0
<genl_handle_msg>, data=0x555555607898) at thermal_nl.c:70
#6  0x00007ffff7402327 in thermal_genl_auto (th=0x5555556048a0, id=1,
cmd=2, flags=0, arg=0x555555607898) at commands.c:282
#7  0x00007ffff74023e0 in thermal_cmd_get_trip (th=0x5555556048a0,
tz=0x555555607898) at commands.c:304
#8  0x00007ffff74039db in __thermal_zone_discover (tz=0x555555607898,
th=0x5555556048a0) at thermal.c:71
#9  0x00007ffff7403842 in for_each_thermal_zone (tz=0x555555607860,
cb=0x7ffff74039b8 <__thermal_zone_discover>, arg=0x5555556048a0) at
thermal.c:33
#10 0x00007ffff7403a5b in thermal_zone_discover (th=0x5555556048a0) at
thermal.c:87
#11 0x00005555554019bd in main ()

Thanks,
Srinivas

> 


