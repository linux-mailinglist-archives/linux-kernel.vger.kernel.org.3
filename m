Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06ADF549FAA
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 22:44:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235651AbiFMUoS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 16:44:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344519AbiFMUnG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 16:43:06 -0400
Received: from smtpq1.tb.ukmail.iss.as9143.net (smtpq1.tb.ukmail.iss.as9143.net [212.54.57.96])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D26062A251
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 12:46:24 -0700 (PDT)
Received: from [212.54.57.105] (helo=csmtp1.tb.ukmail.iss.as9143.net)
        by smtpq1.tb.ukmail.iss.as9143.net with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.90_1)
        (envelope-from <zarniwhoop@ntlworld.com>)
        id 1o0q11-0007hu-4T
        for linux-kernel@vger.kernel.org; Mon, 13 Jun 2022 21:46:23 +0200
Received: from llamedos.mydomain ([81.97.236.130])
        by cmsmtp with ESMTPA
        id 0q10oMdyp2Ckp0q10oMdd4; Mon, 13 Jun 2022 21:46:23 +0200
X-SourceIP: 81.97.236.130
X-Authenticated-Sender: zarniwhoop@ntlworld.com
X-Spam: 0
X-Authority: v=2.4 cv=S5fKfagP c=1 sm=1 tr=0 ts=62a7940f cx=a_exe
 a=OGiDJHazYrvzwCbh7ZIPzQ==:117 a=OGiDJHazYrvzwCbh7ZIPzQ==:17
 a=IkcTkHD0fZMA:10 a=JPEYwPQDsx4A:10 a=VwQbUJbxAAAA:8 a=lAgNKBcoAAAA:8
 a=e5mUnYsNAAAA:8 a=NEAV23lmAAAA:8 a=XEvPOTf6ql8ZxkX-kUwA:9 a=QEXdDO2ut3YA:10
 a=s7WzIJ968vAA:10 a=oEyQGRKERE8A:10 a=-FEs8UIgK8oA:10
 a=AjGcO6oz07-iQ99wixmX:22 a=drE6d5tx1tjNRBs8zHOc:22 a=Vxmtnl_E_bksehYqCbjh:22
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ntlworld.com;
        s=meg.feb2017; t=1655149583;
        bh=RNfcCIKdVJ/iG8hi0PXRos+6xeUX7TSDceFHiaLae90=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=FqGA2psNIzF3xmCoUS3yKuvPQ2RCW6eRy1kRkbHogTxNX7XzJOObkvfg7T5wWIO6m
         twsPgi196Peg7p0zyMBj1qm/9POOm4XGOPWsjho6QWQYkfsOi2dJc09n9b+OAAGi5o
         G3oY0V3qUIHa58H/9Vd8M7K2/qTEkpwvuIVjV9NxPDPwLlvhUpW/OjQ3Lj36MiunfW
         yXGgfDPeyxNC7SohsRKODgOB9IXiKY7mRvOUsC1dQiAt225zFSpeKZr+z4GxrmSugf
         B4zVVHsplLsFtUsp4QNvOPRJucxrd43Ulok2nErrGzePnEaPoOAhPrbL1QGBfbodwG
         TxBdYCcrGE4pg==
Received: by llamedos.mydomain (Postfix, from userid 1000)
        id 862148DB58; Mon, 13 Jun 2022 20:46:22 +0100 (BST)
Date:   Mon, 13 Jun 2022 20:46:22 +0100
From:   Ken Moffat <zarniwhoop@ntlworld.com>
To:     Thorsten Leemhuis <regressions@leemhuis.info>
Cc:     linux-kernel@vger.kernel.org,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        Linux PM <linux-pm@vger.kernel.org>,
        Pavel Machek <pavel@ucw.cz>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: regression, 5.19.0-rc1 not powering off when hibernated
Message-ID: <YqeUDpo+8RLVKH8r@llamedos.localdomain>
References: <YqE22nS9k2+AldI6@llamedos.localdomain>
 <84d01637-febb-f602-2d03-fe1600e85ae3@leemhuis.info>
 <YqTPlGM9KQ0FqHdc@llamedos.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Clacks-Overhead: GNU Terry Pratchett
Content-Transfer-Encoding: 8bit
In-Reply-To: <YqTPlGM9KQ0FqHdc@llamedos.localdomain>
User-Agent: Mutt/2.2.3 (2022-04-12)
X-CMAE-Envelope: MS4xfDxJHgYY1ZVrfwtqpYG4N9qA3bY9O3LSFgEquyIXDU2AU8/FacIQofadO389OjNuDhn90OJsU7m2WdZqDiTt1DgFxnd+JUUwDhUOS97R9XBRJX5AZLuR
 5V4bxk4IFUgaNVyg3wnBkGtnln687Q4ykAhiQ66Cx2m/TZKMlS4S9zrolIomeBkz4rdNI28RDBIXRWoFOmGFyzVtJLTR5rpKo1FOfgZlGY42J83fV8EMcJH9
 6zNHY+g5WNOOhR48kIGYCZAbbxwgHWSHD/+DqdHqBo4hZN0FKSsK726QEwxMCOG2QIq/mU+GUXO70Sch0QkWa+U4rEFuyrAAJ7yxTuZzOmfXgZIq6wPl4hdI
 fEyFKRMKusMuciMhO07SIOeXIMarDA==
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 11, 2022 at 06:23:32PM +0100, Ken Moffat wrote:
> On Sat, Jun 11, 2022 at 03:53:44PM +0200, Thorsten Leemhuis wrote:
> > Hi, this is your Linux kernel regression tracker.
> > 
> > CCing the regression mailing list, as it should be in the loop for all
> > regressions, as explained here:
> > https://www.kernel.org/doc/html/latest/admin-guide/reporting-issues.html
> > Also CCing the hibernation maintainers and Linux-pm.
> > 
> > On 09.06.22 01:55, Ken Moffat wrote:
> > > Up to 5.18.0 hibernation has worked ok on my ryzen 5 3400G : screen
> > > blanks, disk activity for the write to swap, screen briefly has a
> > > trashed display, machine powers off.  When powering up from
> > > hibernation, after the saved files are loaded X starts with a
> > > briefly trashed display before my desktop reappears.
> > > 
> > > But with 5.19.0-rc1 the screen is blank throughtout the hibernation,
> > > and briefly when restoring (no complaint about that), but when
> > > hibernating it no longer powers off and I have to hold the on/off
> > > switch to power off.
> > > 
> > > Is this a known problem ?
> > 
> > Thanks for the report. Maybe the hibernation maintainers might know, but
> > often issues like this are caused by other things like drivers. If they
> > don#t have a idea, you likely need to do a bisection to get down to the
> > change that introduced this regressions.
> > 
> > Anyway: To be sure below issue doesn't fall through the cracks
> > unnoticed, I'm adding it to regzbot, my Linux kernel regression tracking
> > bot:
> > 
> > #regzbot ^introduced v5.18..v5.19-rc1
> > #regzbot title hibernate: Not powering off when hibernated
> > #regzbot ignore-activity
> > 
> > This isn't a regression? This issue or a fix for it are already
> > discussed somewhere else? It was fixed already? You want to clarify when
> > the regression started to happen? Or point out I got the title or
> > something else totally wrong? Then just reply -- ideally with also
> > telling regzbot about it, as explained here:
> > https://linux-regtracking.leemhuis.info/tracked-regression/
> > 
> > Reminder for developers: When fixing the issue, add 'Link:' tags
> > pointing to the report (the mail this one replied to), as the kernel's
> > documentation call for; above page explains why this is important for
> > tracked regressions.
> > 
> > Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
> > 
> > P.S.: As the Linux kernel's regression tracker I deal with a lot of
> > reports and sometimes miss something important when writing mails like
> > this. If that's the case here, don't hesitate to tell me in a public
> > reply, it's in everyone's interest to set the public record straight.
> 
> Thanks.  I've started to bisect, but I've got a lot else on and it
> might be a few days before I get a result.  All I know so far is
> that whatever got rid of the garbled screens was fine, and the
> problem seems to have arisen in the last 800+ commits for 5.19-rc1.
> 
I think I must have gone wrong somewhere in that bisection, it took
me through a load of habanalabs commits which were all good, and
blamed the merge which for this which *was* definitely bad, but seems
to have nothing related to the box not powering off on hibernation::

[6f9b5ed8caddfbc94af8307c557ed57a8ec5c65c] Merge tag 'char-misc-5.19-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc

Not Cc'ing Greg at this point, I really don't believe that result.

Starting over.

ĸen
 ----

Details from this run, with resulting kernel versions -

git bisect start
git bisect good v5.18
git bisect bad  v5.19-rc1

Bisecting: 7030 revisions left to test after this (roughly 13 steps)
[2518f226c60d8e04d18ba4295500a5b0b8ac7659] Merge tag 'drm-next-2022-05-25' of git://anongit.freedesktop.org/drm/drm

 5.18.0-06942-g2518f226c60d

git bisct good

Bisecting: 3527 revisions left to test after this (roughly 12 steps)
[aef1ff15927421a55312b4b9b2881a89a344bd80] Merge tag 'jfs-5.19' of https://github.com/kleikamp/linux-shaggy

 5.18.0-10445-gaef1ff159274

git bisect good

Bisecting: 834 revisions left to test after this (roughly 10 steps)
[54c2cc79194c961a213c1d375fe3aa4165664cc4] Merge tag 'usb-5.19-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb

 5.18.0-13138-g54c2cc79194c

git bisect good

Bisecting: 428 revisions left to test after this (roughly 9 steps)
[7036440eab3e2d47a775d4616909f8235488d714] ARM: omap1: enable multiplatform

 5.18.0-13544-g7036440eab3e

git bisect bad

Bisecting: 203 revisions left to test after this (roughly 8 steps)
[46ee6bcac9838b7f74ff91f9cf38511c901ea9c5] Merge tag 'mhi-for-v5.19' of git://git.kernel.org/pub/scm/linux/kernel/git/mani/mhi into char-work-next

 5.18.0-rc5-00202-g46ee6bcac983

git bisect good

Bisecting: 99 revisions left to test after this (roughly 7 steps)
[dc6a7effb48e7267c9f1314e3aa8cfe539bd6096] Merge tag 'lkdtm-next' of https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux into char-misc-next

 5.18.0-rc5-00306-gdc6a7effb48e

git bisect good

Bisecting: 49 revisions left to test after this (roughly 6 steps)
[b19768d81a6bd1591872952075ff9d960bd4e8d8] habanalabs/gaudi: increase submission resources

 5.18.0-rc5-00356-gb19768d81a6b

git bisect good

Bisecting: 24 revisions left to test after this (roughly 5 steps)
[ab4ea5872842766b0155b2517db61a4ae99d98e0] habanalabs: use for_each_sgtable_dma_sg for dma sgt

 5.18.0-rc5-00381-gab4ea5872842

git bisect good

Bisecting: 12 revisions left to test after this (roughly 4 steps)
[c37803388c95833c4728b089e6c94996dc457d95] habanalabs: handle race in driver fini

 5.18.0-rc5-00393-gc37803388c95

git bisect good

Bisecting: 6 revisions left to test after this (roughly 3 steps)
[83617f5a87f4ad8403bf1177708fedc98b0a1059] habanalabs: order memory manager messages

 5.18.0-rc5-00399-g83617f5a87f4

git bisect good

Bisecting: 3 revisions left to test after this (roughly 2 steps)
[f873a27fd50d161111d0e52087af0f5b2111c5c4] habanalabs: fix missing handle shift during mmap

 5.18.0-rc5-00402-gf873a27fd50d

git bisect good

Bisecting: 1 revision left to test after this (roughly 1 step)
[6f9b5ed8caddfbc94af8307c557ed57a8ec5c65c] Merge tag 'char-misc-5.19-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc

  5.18.0-13542-g6f9b5ed8cadd
  bad

git bisect bad

Bisecting: 0 revisions left to test after this (roughly 0 steps)
[90de6805267f8c79cd2b1a36805071e257c39b5c] habanalabs: use separate structure info for each error collect data

 5.18.0-rc5-00403-g90de6805267f

git bisect good

 ----
-- 
      Remembering The People's Republic of Treacle Mine Road.
        Truth!  Justice!  Freedom!  Reasonably priced Love!
                 And a Hard-boiled Egg!
