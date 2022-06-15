Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CB2C54CEE3
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 18:41:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357081AbiFOQkw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 12:40:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356968AbiFOQku (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 12:40:50 -0400
Received: from smtpq1.tb.ukmail.iss.as9143.net (smtpq1.tb.ukmail.iss.as9143.net [212.54.57.96])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFE004BBB4
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 09:40:48 -0700 (PDT)
Received: from [212.54.57.112] (helo=csmtp8.tb.ukmail.iss.as9143.net)
        by smtpq1.tb.ukmail.iss.as9143.net with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.90_1)
        (envelope-from <zarniwhoop@ntlworld.com>)
        id 1o1W4V-00030g-3i
        for linux-kernel@vger.kernel.org; Wed, 15 Jun 2022 18:40:47 +0200
Received: from llamedos.mydomain ([81.97.236.130])
        by cmsmtp with ESMTPA
        id 1W4UoXz0UPoCm1W4UospSt; Wed, 15 Jun 2022 18:40:47 +0200
X-SourceIP: 81.97.236.130
X-Authenticated-Sender: zarniwhoop@ntlworld.com
X-Spam: 0
X-Authority: v=2.4 cv=XaCaca15 c=1 sm=1 tr=0 ts=62aa0b8f cx=a_exe
 a=OGiDJHazYrvzwCbh7ZIPzQ==:117 a=OGiDJHazYrvzwCbh7ZIPzQ==:17
 a=IkcTkHD0fZMA:10 a=JPEYwPQDsx4A:10 a=VwQbUJbxAAAA:8 a=lAgNKBcoAAAA:8
 a=QX4gbG5DAAAA:8 a=QyXUC8HyAAAA:8 a=e5mUnYsNAAAA:8 a=7PGKVeoXzDYJnXtM3nYA:9
 a=QEXdDO2ut3YA:10 a=s7WzIJ968vAA:10 a=oEyQGRKERE8A:10 a=-FEs8UIgK8oA:10
 a=AjGcO6oz07-iQ99wixmX:22 a=drE6d5tx1tjNRBs8zHOc:22 a=AbAUZ8qAyYyZVLSsDulk:22
 a=Vxmtnl_E_bksehYqCbjh:22
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ntlworld.com;
        s=meg.feb2017; t=1655311247;
        bh=SxYWuqoWSJcMiUlxl/6yaopIwStLbUnQXsNuJ7YGflk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=wVeB1S5ZCONmilE8JHszuUox37Z5WX6TrtVBtxRC7AbvL0q0ApGe2LePyzSgm9cuH
         xzSzQowN9GAPQGpHzAiSwMEF9SVZ6QxwiJeU9qIbZXoHouTUmSo+9b9sANeqPp0+46
         MXcaorCOMGK8HnvzgobZOEvAEucbgZmPZRTuYZOMHfvQgsjc0UCctiVO5DwO+SeH0K
         9xyj1Tu7MZtFBJk3yczUQQYQ37ev/UR9JmRwa3EQlE5/0dYQ9YyWUn65blyAdcv7GQ
         CQJaZ1u6xbwQXUm6GDMLBseysajBh1lq6jwaQa+th3HVObBg8eik36L07/6RourNSv
         U4B3XZSNN1Wgw==
Received: by llamedos.mydomain (Postfix, from userid 1000)
        id 4C0738DB5D; Wed, 15 Jun 2022 17:40:46 +0100 (BST)
Date:   Wed, 15 Jun 2022 17:40:46 +0100
From:   Ken Moffat <zarniwhoop@ntlworld.com>
To:     Thorsten Leemhuis <regressions@leemhuis.info>
Cc:     linux-kernel@vger.kernel.org,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        Linux PM <linux-pm@vger.kernel.org>,
        Pavel Machek <pavel@ucw.cz>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>
Subject: Re: regression, 5.19.0-rc1 not powering off when hibernated
Message-ID: <YqoLjk8P+fChJ04m@llamedos.localdomain>
References: <YqE22nS9k2+AldI6@llamedos.localdomain>
 <84d01637-febb-f602-2d03-fe1600e85ae3@leemhuis.info>
 <YqTPlGM9KQ0FqHdc@llamedos.localdomain>
 <YqeUDpo+8RLVKH8r@llamedos.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Clacks-Overhead: GNU Terry Pratchett
Content-Transfer-Encoding: 8bit
In-Reply-To: <YqeUDpo+8RLVKH8r@llamedos.localdomain>
User-Agent: Mutt/2.2.3 (2022-04-12)
X-CMAE-Envelope: MS4xfHeVLMzGsAe8cOz7ASAJ0c+HSnQiXsGdRPpKymio645sgvBftBDjOEsJ0B8eirB4JG1iDU9hgxzxPcj8olMEc6xx6qJZgfGX/e6SR6V6mmSewRBxnn1b
 KM4YiVA2hOlALq6K8iA2Mytl4vGYwTnz+MDNPhfVNadg6gO4OBasHypRgzTpRNeOOOclBYhH+gxV8p5n+4LHnsfNDP7knhgoGcRc1ls0m8IN8HcftvMCdIUI
 0J/5dO91xwwL6fyfOWdn4ee9dM/URr57J0goC78oWNKYC8e5fqNbDDsJkmwN6A8SoGBUZOwLSM075GWNL+SMaHwSbX6MFby/j8+6x8A1FNdpmncFvmw1JiNk
 MfKTNAUxbzB+eYKjo4UClM78d/iddpJjddMTgiaQoUT5okZm3gGh8Cw31ynvKxkKFdtN24ZH
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 13, 2022 at 08:46:22PM +0100, Ken Moffat wrote:

Adding Dmitry because of git blame (details at end)

> On Sat, Jun 11, 2022 at 06:23:32PM +0100, Ken Moffat wrote:
> > On Sat, Jun 11, 2022 at 03:53:44PM +0200, Thorsten Leemhuis wrote:
> > > Hi, this is your Linux kernel regression tracker.
> > > 
> > > CCing the regression mailing list, as it should be in the loop for all
> > > regressions, as explained here:
> > > https://www.kernel.org/doc/html/latest/admin-guide/reporting-issues.html
> > > Also CCing the hibernation maintainers and Linux-pm.
> > > 
> > > On 09.06.22 01:55, Ken Moffat wrote:
> > > > Up to 5.18.0 hibernation has worked ok on my ryzen 5 3400G : screen
> > > > blanks, disk activity for the write to swap, screen briefly has a
> > > > trashed display, machine powers off.  When powering up from
> > > > hibernation, after the saved files are loaded X starts with a
> > > > briefly trashed display before my desktop reappears.
> > > > 
> > > > But with 5.19.0-rc1 the screen is blank throughtout the hibernation,
> > > > and briefly when restoring (no complaint about that), but when
> > > > hibernating it no longer powers off and I have to hold the on/off
> > > > switch to power off.
> > > > 
> > > > Is this a known problem ?
> > > 
> > > Thanks for the report. Maybe the hibernation maintainers might know, but
> > > often issues like this are caused by other things like drivers. If they
> > > don#t have a idea, you likely need to do a bisection to get down to the
> > > change that introduced this regressions.
> > > 
> > > Anyway: To be sure below issue doesn't fall through the cracks
> > > unnoticed, I'm adding it to regzbot, my Linux kernel regression tracking
> > > bot:
> > > 
> > > #regzbot ^introduced v5.18..v5.19-rc1
> > > #regzbot title hibernate: Not powering off when hibernated
> > > #regzbot ignore-activity
> > > 
> > > This isn't a regression? This issue or a fix for it are already
> > > discussed somewhere else? It was fixed already? You want to clarify when
> > > the regression started to happen? Or point out I got the title or
> > > something else totally wrong? Then just reply -- ideally with also
> > > telling regzbot about it, as explained here:
> > > https://linux-regtracking.leemhuis.info/tracked-regression/
> > > 
> > > Reminder for developers: When fixing the issue, add 'Link:' tags
> > > pointing to the report (the mail this one replied to), as the kernel's
> > > documentation call for; above page explains why this is important for
> > > tracked regressions.
> > > 
> > > Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
> > > 
> > > P.S.: As the Linux kernel's regression tracker I deal with a lot of
> > > reports and sometimes miss something important when writing mails like
> > > this. If that's the case here, don't hesitate to tell me in a public
> > > reply, it's in everyone's interest to set the public record straight.
> > 
> > Thanks.  I've started to bisect, but I've got a lot else on and it
> > might be a few days before I get a result.  All I know so far is
> > that whatever got rid of the garbled screens was fine, and the
> > problem seems to have arisen in the last 800+ commits for 5.19-rc1.
> > 
> I think I must have gone wrong somewhere in that bisection, it took
> me through a load of habanalabs commits which were all good, and
> blamed the merge which for this which *was* definitely bad, but seems
> to have nothing related to the box not powering off on hibernation::
> 
Indeed, on the second attempt I've got a much more likely commit to
blame:

98f30d0ecf79da8cf17a171fa4cf6eda7ba4dd71 is the first bad commit
commit 98f30d0ecf79da8cf17a171fa4cf6eda7ba4dd71
Author: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Date:   Tue May 10 02:32:30 2022 +0300

    ACPI: power: Switch to sys-off handler API
    
    Switch to sys-off API that replaces legacy pm_power_off callbacks,
    allowing us to remove global pm_* variables and support chaining of
    all restart and power-off modes consistently.
    
    Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
    Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Unsurprisingly, with this reverted 5.19-rc2 fails to build.

ĸen

Bisect log follows:

git bisect start
# good: [4b0986a3613c92f4ec1bdc7f60ec66fea135991f] Linux 5.18
git bisect good 4b0986a3613c92f4ec1bdc7f60ec66fea135991f
# bad: [f2906aa863381afb0015a9eb7fefad885d4e5a56] Linux 5.19-rc1
git bisect bad f2906aa863381afb0015a9eb7fefad885d4e5a56
# skip: [2518f226c60d8e04d18ba4295500a5b0b8ac7659] Merge tag 'drm-next-2022-05-25' of git://anongit.freedesktop.org/drm/drm
git bisect skip 2518f226c60d8e04d18ba4295500a5b0b8ac7659
# good: [8a87419481f2d51a7bd03617d363faf5f2b0e1b3] arm64: dts: mediatek: mt8195-demo: Remove input-name property
git bisect good 8a87419481f2d51a7bd03617d363faf5f2b0e1b3
# good: [0813aeee0d02d80912c86b2b3a1ebdb4ee4476ba] Merge branch 'tcp-pass-back-data-left-in-socket-after-receive' of git://git.kernel.org/pub/scm/linux/kernel/git/kuba/linux
git bisect good 0813aeee0d02d80912c86b2b3a1ebdb4ee4476ba
# good: [d7227785e384d4422b3ca189aa5bf19f462337cc] Merge tag 'sound-5.19-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound
git bisect good d7227785e384d4422b3ca189aa5bf19f462337cc
# good: [907bb57aa7b471872aab2f2e83e9713a145673f9] Merge tag 'pinctrl-v5.19-1' of git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl
git bisect good 907bb57aa7b471872aab2f2e83e9713a145673f9
# bad: [5ac8bdb9ad47334a9590e29daf7e4149b0a34729] Merge tag 'io_uring-5.19-2022-06-02' of git://git.kernel.dk/linux-block
git bisect bad 5ac8bdb9ad47334a9590e29daf7e4149b0a34729
# bad: [35b51afd23c98e2f055ac563aca36173a12588b9] Merge tag 'riscv-for-linus-5.19-mw0' of git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux
git bisect bad 35b51afd23c98e2f055ac563aca36173a12588b9
# good: [c3a9a3c5f5590e85da15d6201e415ff636fe5670] Merge tag 'trace-tools-v5.19' of git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace
git bisect good c3a9a3c5f5590e85da15d6201e415ff636fe5670
# bad: [1ff7bc3ba71d398d349c49103a3da34bb4ea02d1] Merge tag 'pm-5.19-rc1-2' of git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm
git bisect bad 1ff7bc3ba71d398d349c49103a3da34bb4ea02d1
# good: [73d15ba6ba390caed47aa8885811d1cd7b4477f3] Merge tag 'mips_5.19' of git://git.kernel.org/pub/scm/linux/kernel/git/mips/linux
git bisect good 73d15ba6ba390caed47aa8885811d1cd7b4477f3
# bad: [9f9c1f6844bdacb4a011cc69e19b929997038f4f] Merge branch 'pm-sysoff'
git bisect bad 9f9c1f6844bdacb4a011cc69e19b929997038f4f
# good: [22ffff6d21ebfcd6e722af5f6954ab97c726c3c8] Merge branch 'pm-opp'
git bisect good 22ffff6d21ebfcd6e722af5f6954ab97c726c3c8
# good: [9b0d0af145195cfd79210b805448a4bcc69f0e04] sh: Use do_kernel_power_off()
git bisect good 9b0d0af145195cfd79210b805448a4bcc69f0e04
# bad: [eae813b755c46c74d65f52fa6b0b1a5476e13551] soc/tegra: pmc: Use sys-off handler API to power off Nexus 7 properly
git bisect bad eae813b755c46c74d65f52fa6b0b1a5476e13551
# good: [bf8d73b934df8aa485dc4650d6d5dfe5a640af4b] memory: emif: Use kernel_can_power_off()
git bisect good bf8d73b934df8aa485dc4650d6d5dfe5a640af4b
# bad: [02a1124defc2571b81c054ae4c5481f1ac7ccf20] regulator: pfuze100: Use devm_register_sys_off_handler()
git bisect bad 02a1124defc2571b81c054ae4c5481f1ac7ccf20
# bad: [98f30d0ecf79da8cf17a171fa4cf6eda7ba4dd71] ACPI: power: Switch to sys-off handler API
git bisect bad 98f30d0ecf79da8cf17a171fa4cf6eda7ba4dd71
# first bad commit: [98f30d0ecf79da8cf17a171fa4cf6eda7ba4dd71] ACPI: power: Switch to sys-off handler API

-- 
      Remembering The People's Republic of Treacle Mine Road.
        Truth!  Justice!  Freedom!  Reasonably priced Love!
                 And a Hard-boiled Egg!
