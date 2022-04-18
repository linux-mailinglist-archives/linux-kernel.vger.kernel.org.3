Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CCF7504B5C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 05:36:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236069AbiDRDiu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Apr 2022 23:38:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiDRDis (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Apr 2022 23:38:48 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C81DF26CD;
        Sun, 17 Apr 2022 20:36:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650252969; x=1681788969;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version;
  bh=tvpttQMzq0v8mpnDg1tJBx7TBcWOv8OJzXhptA9aBac=;
  b=m1z0nQ2nFTMmHhtjr73fkiSSAFEfPrKVIttzFxVOgE0VIoeRWVSv4rdG
   kGQvb/YmU/b7TvYhDs1FVeysrsb37e96tK0C7ASolav5mfYEFq04Y84zc
   4+61MqHtTtQaFlZwFH/5Lq6+5oVEO65Iy6LaNp48f3LFHqeJOqphIoB9T
   1pTZOV3PHN7qnB9BTtlfNwIEtq3V+Ep4GcImX4RBtioQFeled65a7M1F/
   LrHrQTscp9A7ZVDdgA67GB/BUgRlfnh0rhke+tUuy1dVlvc4oUfBcekxO
   YNR5HmUkKWHTVXyqFY+BEVQInncU+FzHoZF1QBEPXXQsLGw7Z+nLH+WH/
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10320"; a="349892641"
X-IronPort-AV: E=Sophos;i="5.90,267,1643702400"; 
   d="diff'?scan'208";a="349892641"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2022 20:36:09 -0700
X-IronPort-AV: E=Sophos;i="5.90,267,1643702400"; 
   d="diff'?scan'208";a="554064357"
Received: from spandruv-desk.jf.intel.com ([10.54.75.8])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2022 20:36:09 -0700
Message-ID: <f7e4f4604f122dfab4aa5e589d68eb2c8773e00d.camel@linux.intel.com>
Subject: Re: [PATCH v2 0/4] tools/thermal: thermal library and tools
From:   srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Date:   Sun, 17 Apr 2022 20:36:09 -0700
In-Reply-To: <ba3cbf3d-938b-1530-1178-68b447f20a9c@linaro.org>
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
Content-Type: multipart/mixed; boundary="=-G+LS8sAGrcX6RolYPxPJ"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-G+LS8sAGrcX6RolYPxPJ
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

Hi Daniel,

The attached diff fixes the crash,

Also when you run in daemon mode, you need to use some pid lock file.
Otherwise it launches multiple daemons.

Thanks,
Srinivas



On Sun, 2022-04-17 at 10:20 +0200, Daniel Lezcano wrote:
> 
> Hi Srinivas,
> 
> thanks for the information. I've indeed not tested on x86_64 but on
> ARM64.
> 
> I'll give a try to reproduce and fix the issue.
> 
> Thanks again for taking the time to run it
> 
>    -- Daniel
> 
> On 17/04/2022 06:23, srinivas pandruvada wrote:
> > Hi Daniel,
> > 
> > On Sat, 2022-04-16 at 09:55 +0200, Daniel Lezcano wrote:
> > > 
> > > Hi Srinivas,
> > > 
> > > 
> > > On 16/04/2022 05:50, srinivas pandruvada wrote:
> > > > On Wed, 2022-04-13 at 10:21 -0700, srinivas pandruvada wrote:
> > > > > On Wed, 2022-04-13 at 17:06 +0200, Rafael J. Wysocki wrote:
> > > > > > On Wed, Apr 6, 2022 at 4:44 PM Daniel Lezcano <
> > > > > > daniel.lezcano@linaro.org> wrote:
> > > > > > > 
> > > > 
> > 
> > [...]
> > 
> > > > root@srinivas-otcpl-icl-u:~/development/linux/tools/thermal/the
> > > > rmal-
> > > > engine#
> > > > LD_LIBRARY_PATH=../lib:../../lib/thermal:$LD_LIBRARY_pATH
> > > > ./thermal-engine -l DEBUG
> > > > Segmentation fault (core dumped)
> > > > root@srinivas-otcpl-icl-u:~/development/linux/tools/thermal/the
> > > > rmal-
> > > > engine#
> > > > LD_LIBRARY_PATH=../lib:../../lib/thermal:$LD_LIBRARY_pATH
> > > > ./thermal-engine --loglevel DEBUG
> > > > Segmentation fault (core dumped)
> > > > root@srinivas-otcpl-icl-u:~/development/linux/tools/thermal/the
> > > > rmal-
> > > > engine#
> > > > LD_LIBRARY_PATH=../lib:../../lib/thermal:$LD_LIBRARY_pATH
> > > > ./thermal-engine -s
> > > > Segmentation fault (core dumped)
> > > 
> > > Is CONFIG_THERMAL_NETLINK set ?
> > 
> > Yes, Thermometer program works fine. Just thermal-engine fails.
> > CONFIG_THERMAL=y
> > CONFIG_THERMAL_NETLINK=y
> > CONFIG_THERMAL_STATISTICS=y
> > CONFIG_THERMAL_EMERGENCY_POWEROFF_DELAY_MS=0
> > CONFIG_THERMAL_HWMON=y
> > CONFIG_THERMAL_WRITABLE_TRIPS=y
> > CONFIG_THERMAL_DEFAULT_GOV_STEP_WISE=y
> > # CONFIG_THERMAL_DEFAULT_GOV_FAIR_SHARE is not set
> > # CONFIG_THERMAL_DEFAULT_GOV_USER_SPACE is not set
> > CONFIG_THERMAL_GOV_FAIR_SHARE=y
> > CONFIG_THERMAL_GOV_STEP_WISE=y
> > CONFIG_THERMAL_GOV_BANG_BANG=y
> > CONFIG_THERMAL_GOV_USER_SPACE=y
> > CONFIG_DEVFREQ_THERMAL=y
> > CONFIG_THERMAL_EMULATION=y
> > 
> > This may help
> > 
> > #gdb ./thermal-engine
> > GNU gdb (Ubuntu 8.1.1-0ubuntu1) 8.1.1
> > Copyright (C) 2018 Free Software Foundation, Inc.
> > License GPLv3+: GNU GPL version 3 or later
> > <http://gnu.org/licenses/gpl.html>
> > This is free software: you are free to change and redistribute it.
> > There is NO WARRANTY, to the extent permitted by law.  Type "show
> > copying"
> > and "show warranty" for details.
> > This GDB was configured as "x86_64-linux-gnu".
> > Type "show configuration" for configuration details.
> > For bug reporting instructions, please see:
> > <http://www.gnu.org/software/gdb/bugs/>.
> > Find the GDB manual and other documentation resources online at:
> > <http://www.gnu.org/software/gdb/documentation/>.
> > For help, type "help".
> > Type "apropos word" to search for commands related to "word"...
> > Reading symbols from ./thermal-engine...(no debugging symbols
> > found)...done.
> > (gdb) run
> > Starting program:
> > /home/labuser/development/linux/tools/thermal/thermal-
> > engine/thermal-
> > engine
> > [Thread debugging using libthread_db enabled]
> > Using host libthread_db library "/lib/x86_64-linux-
> > gnu/libthread_db.so.1".
> > 
> > Program received signal SIGSEGV, Segmentation fault.
> > 0x00007ffff7402036 in parse_tz_get_trip (info=0x7fffffffdf60,
> > tz=0x555555607898) at commands.c:143
> > 143             __tt[size].id = -1;
> > (gdb) backtrace
> > #0  0x00007ffff7402036 in parse_tz_get_trip (info=0x7fffffffdf60,
> > tz=0x555555607898) at commands.c:143
> > #1  0x00007ffff7402233 in handle_netlink (unused=0x0,
> > cmd=0x7ffff76052f8 <thermal_cmds+120>, info=0x7fffffffdf60,
> > arg=0x555555607898) at commands.c:206
> > #2  0x00007ffff7003435 in ?? () from /lib/x86_64-linux-gnu/libnl-
> > genl-
> > 3.so.200
> > #3  0x00007ffff6810c1c in nl_recvmsgs_report () from /lib/x86_64-
> > linux-
> > gnu/libnl-3.so.200
> > #4  0x00007ffff6811049 in nl_recvmsgs () from /lib/x86_64-linux-
> > gnu/libnl-3.so.200
> > #5  0x00007ffff7402eaf in nl_send_msg (sock=0x555555606040,
> > cb=0x5555556065d0, msg=0x555555606110, rx_handler=0x7ffff70036f0
> > <genl_handle_msg>, data=0x555555607898) at thermal_nl.c:70
> > #6  0x00007ffff7402327 in thermal_genl_auto (th=0x5555556048a0,
> > id=1,
> > cmd=2, flags=0, arg=0x555555607898) at commands.c:282
> > #7  0x00007ffff74023e0 in thermal_cmd_get_trip (th=0x5555556048a0,
> > tz=0x555555607898) at commands.c:304
> > #8  0x00007ffff74039db in __thermal_zone_discover
> > (tz=0x555555607898,
> > th=0x5555556048a0) at thermal.c:71
> > #9  0x00007ffff7403842 in for_each_thermal_zone (tz=0x555555607860,
> > cb=0x7ffff74039b8 <__thermal_zone_discover>, arg=0x5555556048a0) at
> > thermal.c:33
> > #10 0x00007ffff7403a5b in thermal_zone_discover (th=0x5555556048a0)
> > at
> > thermal.c:87
> > #11 0x00005555554019bd in main ()
> > 
> > Thanks,
> > Srinivas
> > 
> > > 
> > 
> > 
> 
> 


--=-G+LS8sAGrcX6RolYPxPJ
Content-Disposition: attachment; filename="segv.diff"
Content-Type: text/x-patch; name="segv.diff"; charset="UTF-8"
Content-Transfer-Encoding: base64

Z2l0IGRpZmYKZGlmZiAtLWdpdCBhL3Rvb2xzL2xpYi90aGVybWFsL2NvbW1hbmRzLmMgYi90b29s
cy9saWIvdGhlcm1hbC9jb21tYW5kcy5jCmluZGV4IDUzOTA4Mzc4MDEwNy4uYjhkOTMzZjE5OTA5
IDEwMDY0NAotLS0gYS90b29scy9saWIvdGhlcm1hbC9jb21tYW5kcy5jCisrKyBiL3Rvb2xzL2xp
Yi90aGVybWFsL2NvbW1hbmRzLmMKQEAgLTExNyw2ICsxMTcsOCBAQCBzdGF0aWMgaW50IHBhcnNl
X3R6X2dldF90cmlwKHN0cnVjdCBnZW5sX2luZm8gKmluZm8sIHN0cnVjdCB0aGVybWFsX3pvbmUg
KnR6KQogICAgICAgIHNpemVfdCBzaXplID0gMDsKICAgICAgICBpbnQgcmVtOwogCisgICAgICAg
dHotPnRyaXBfY291bnQgPSAwOworCiAgICAgICAgbmxhX2Zvcl9lYWNoX25lc3RlZChhdHRyLCBp
bmZvLT5hdHRyc1tUSEVSTUFMX0dFTkxfQVRUUl9UWl9UUklQXSwgcmVtKSB7CiAKICAgICAgICAg
ICAgICAgIGlmIChubGFfdHlwZShhdHRyKSA9PSBUSEVSTUFMX0dFTkxfQVRUUl9UWl9UUklQX0lE
KSB7CkBAIC0xNDAsMTAgKzE0MiwxNSBAQCBzdGF0aWMgaW50IHBhcnNlX3R6X2dldF90cmlwKHN0
cnVjdCBnZW5sX2luZm8gKmluZm8sIHN0cnVjdCB0aGVybWFsX3pvbmUgKnR6KQogICAgICAgICAg
ICAgICAgICAgICAgICBfX3R0W3NpemUgLSAxXS5oeXN0ID0gbmxhX2dldF91MzIoYXR0cik7CiAg
ICAgICAgfQogCisgICAgICAgaWYgKCFzaXplKQorICAgICAgICAgICAgICAgcmV0dXJuIFRIRVJN
QUxfRVJST1I7CisKICAgICAgICBfX3R0W3NpemVdLmlkID0gLTE7CiAKICAgICAgICB0ei0+dHJp
cCA9IF9fdHQ7CiAKKyAgICAgICB0ei0+dHJpcF9jb3VudCA9IHNpemU7CisKICAgICAgICByZXR1
cm4gVEhFUk1BTF9TVUNDRVNTOwogfQogCmRpZmYgLS1naXQgYS90b29scy9saWIvdGhlcm1hbC9p
bmNsdWRlL3RoZXJtYWwuaCBiL3Rvb2xzL2xpYi90aGVybWFsL2luY2x1ZGUvdGhlcm1hbC5oCmlu
ZGV4IDFhYmM1NjA2MDJjZi4uNWNiOWJhOGM2YzBlIDEwMDY0NAotLS0gYS90b29scy9saWIvdGhl
cm1hbC9pbmNsdWRlL3RoZXJtYWwuaAorKysgYi90b29scy9saWIvdGhlcm1hbC9pbmNsdWRlL3Ro
ZXJtYWwuaApAQCAtNTEsNiArNTEsNyBAQCBzdHJ1Y3QgdGhlcm1hbF96b25lIHsKICAgICAgICBj
aGFyIG5hbWVbVEhFUk1BTF9OQU1FX0xFTkdUSF07CiAgICAgICAgY2hhciBnb3Zlcm5vcltUSEVS
TUFMX05BTUVfTEVOR1RIXTsKICAgICAgICBzdHJ1Y3QgdGhlcm1hbF90cmlwICp0cmlwOworICAg
ICAgIGludCB0cmlwX2NvdW50OwogfTsKIAogc3RydWN0IHRoZXJtYWxfY2RldiB7CmRpZmYgLS1n
aXQgYS90b29scy9saWIvdGhlcm1hbC90aGVybWFsLmMgYi90b29scy9saWIvdGhlcm1hbC90aGVy
bWFsLmMKaW5kZXggYTgwYjk2N2NlMzM0Li5kZDRlYmZiYmYxZDAgMTAwNjQ0Ci0tLSBhL3Rvb2xz
L2xpYi90aGVybWFsL3RoZXJtYWwuYworKysgYi90b29scy9saWIvdGhlcm1hbC90aGVybWFsLmMK
QEAgLTE5LDcgKzE5LDEwIEBAIGludCBmb3JfZWFjaF90aGVybWFsX3RyaXAoc3RydWN0IHRoZXJt
YWxfdHJpcCAqdHQsIGNiX3R0X3QgY2IsIHZvaWQgKmFyZykKIHsKICAgICAgICBpbnQgaSwgcmV0
ID0gMDsKIAotICAgICAgIGZvciAoaSA9IDA7IHR0W2ldLmlkICE9IC0xOyBpKyspCisgICAgICAg
aWYgKCF0dCkKKyAgICAgICAgICAgICAgIHJldHVybiAtMTsKKworICAgICAgIGZvciAoaSA9IDA7
ICZ0dFtpXSAmJiB0dFtpXS5pZCAhPSAtMTsgaSsrKQogICAgICAgICAgICAgICAgcmV0IHw9IGNi
KCZ0dFtpXSwgYXJnKTsKIAogICAgICAgIHJldHVybiByZXQ7CkBAIC0yOSw2ICszMiw5IEBAIGlu
dCBmb3JfZWFjaF90aGVybWFsX3pvbmUoc3RydWN0IHRoZXJtYWxfem9uZSAqdHosIGNiX3R6X3Qg
Y2IsIHZvaWQgKmFyZykKIHsKICAgICAgICBpbnQgaSwgcmV0ID0gMDsKIAorICAgICAgIGlmICgh
dHopCisgICAgICAgICAgICAgICByZXR1cm4gMDsKKwogICAgICAgIGZvciAoaSA9IDA7IHR6W2ld
LmlkICE9IC0xOyBpKyspCiAgICAgICAgICAgICAgICByZXQgfD0gY2IoJnR6W2ldLCBhcmcpOwog
CmRpZmYgLS1naXQgYS90b29scy90aGVybWFsL3RoZXJtYWwtZW5naW5lL3RoZXJtYWwtZW5naW5l
LmMgYi90b29scy90aGVybWFsL3RoZXJtYWwtZW5naW5lL3RoZXJtYWwtZW5naW5lLmMKaW5kZXgg
NTI1NTIwMDQ5YWEyLi40ZTQ0NmFlYzIyYjUgMTAwNjQ0Ci0tLSBhL3Rvb2xzL3RoZXJtYWwvdGhl
cm1hbC1lbmdpbmUvdGhlcm1hbC1lbmdpbmUuYworKysgYi90b29scy90aGVybWFsL3RoZXJtYWwt
ZW5naW5lL3RoZXJtYWwtZW5naW5lLmMKQEAgLTY4LDcgKzY4LDggQEAgc3RhdGljIGludCBzaG93
X3R6KHN0cnVjdCB0aGVybWFsX3pvbmUgKnR6LCBfX21heWJlX3VudXNlZCB2b2lkICphcmcpCiB7
CiAgICAgICAgSU5GTygidGhlcm1hbCB6b25lICclcycsIGlkPSVkXG4iLCB0ei0+bmFtZSwgdHot
PmlkKTsKIAotICAgICAgIGZvcl9lYWNoX3RoZXJtYWxfdHJpcCh0ei0+dHJpcCwgc2hvd190cmlw
LCBOVUxMKTsKKyAgICAgICBpZiAodHotPnRyaXBfY291bnQpCisgICAgICAgICAgICAgICBmb3Jf
ZWFjaF90aGVybWFsX3RyaXAodHotPnRyaXAsIHNob3dfdHJpcCwgTlVMTCk7CiAKICAgICAgICBz
aG93X3RlbXAodHosIGFyZyk7Cgo=


--=-G+LS8sAGrcX6RolYPxPJ--

