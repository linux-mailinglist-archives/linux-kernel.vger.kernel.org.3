Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B91525476CD
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Jun 2022 19:23:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238192AbiFKRXo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Jun 2022 13:23:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234947AbiFKRXh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jun 2022 13:23:37 -0400
Received: from smtpq1.tb.ukmail.iss.as9143.net (smtpq1.tb.ukmail.iss.as9143.net [212.54.57.96])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EBC03CA54
        for <linux-kernel@vger.kernel.org>; Sat, 11 Jun 2022 10:23:34 -0700 (PDT)
Received: from [212.54.57.105] (helo=csmtp1.tb.ukmail.iss.as9143.net)
        by smtpq1.tb.ukmail.iss.as9143.net with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.90_1)
        (envelope-from <zarniwhoop@ntlworld.com>)
        id 1o04pg-0002OP-L9
        for linux-kernel@vger.kernel.org; Sat, 11 Jun 2022 19:23:32 +0200
Received: from llamedos.mydomain ([81.97.236.130])
        by cmsmtp with ESMTPA
        id 04pgo6VSR2Ckp04pgo0pFb; Sat, 11 Jun 2022 19:23:32 +0200
X-SourceIP: 81.97.236.130
X-Authenticated-Sender: zarniwhoop@ntlworld.com
X-Spam: 0
X-Authority: v=2.4 cv=S5fKfagP c=1 sm=1 tr=0 ts=62a4cf94 cx=a_exe
 a=OGiDJHazYrvzwCbh7ZIPzQ==:117 a=OGiDJHazYrvzwCbh7ZIPzQ==:17
 a=IkcTkHD0fZMA:10 a=JPEYwPQDsx4A:10 a=VwQbUJbxAAAA:8 a=lAgNKBcoAAAA:8
 a=T7ssiTtlOCIPov6mUGUA:9 a=QEXdDO2ut3YA:10 a=s7WzIJ968vAA:10
 a=oEyQGRKERE8A:10 a=-FEs8UIgK8oA:10 a=AjGcO6oz07-iQ99wixmX:22
 a=drE6d5tx1tjNRBs8zHOc:22
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ntlworld.com;
        s=meg.feb2017; t=1654968212;
        bh=ilnr9i/X41U0qRdhZb/1/6UnEC7zor2PPUXzLKyEOCE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=EyNfB/B5QhEyq5b6QFIF5saE6w6fW4JH4HMpBWGd8LkXsDZxQxABEbXsQnPxLG+ey
         cJuNNl/rhbKMLtNPcVFnkKp3Dtwq0xM9Rzxd2JjrphXOdf4aDEVRiPqWNcGcb7VP0O
         /iPX4/ZFGK0PJSvliLUpY6EroWawbjoRPZ2uFFLv44CPV705i30Fx+0PLFxnbw8VKK
         Oln+W+ihKJQvMn5p6k59Lbs0+94AKEcTT8NEIRrp8W5ipIxviAGgk59WqGV7T66h2z
         QCg7+jXpQTUTE8srzk2qj/89ZF8iQcF0ncbTlQmyqQvie6qXk5cgOkjLnx6bUqeree
         GZG2X2V//lNWg==
Received: by llamedos.mydomain (Postfix, from userid 1000)
        id 153AB8DB3D; Sat, 11 Jun 2022 18:23:32 +0100 (BST)
Date:   Sat, 11 Jun 2022 18:23:32 +0100
From:   Ken Moffat <zarniwhoop@ntlworld.com>
To:     Thorsten Leemhuis <regressions@leemhuis.info>
Cc:     linux-kernel@vger.kernel.org,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        Linux PM <linux-pm@vger.kernel.org>,
        Pavel Machek <pavel@ucw.cz>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: regression, 5.19.0-rc1 not powering off when hibernated
Message-ID: <YqTPlGM9KQ0FqHdc@llamedos.localdomain>
References: <YqE22nS9k2+AldI6@llamedos.localdomain>
 <84d01637-febb-f602-2d03-fe1600e85ae3@leemhuis.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Clacks-Overhead: GNU Terry Pratchett
Content-Transfer-Encoding: 8bit
In-Reply-To: <84d01637-febb-f602-2d03-fe1600e85ae3@leemhuis.info>
User-Agent: Mutt/2.2.3 (2022-04-12)
X-CMAE-Envelope: MS4xfJIrqa9cjv4v6xLCQjzwoPfTye1tzuMogVd/YyBnjYQQ8CTj3igIZZKNVJRTtTw28z3xTTEucG4iEYwT8BQaFA0DA0atVDgGmBR+GlINjNpJN2Yr0Bee
 PG2pyqvqUTkAc8OqgPJIO1PcxTOd5SWM8ey5J690L1nFkn/DXHdR3fAHOS0XfucpJsuMdkC+C6CTvElqjpaI+CPpkHb+eEKWsIE4c5ahd7U0tAo2OiFYSVED
 3t1U8lq2SReNUW3IE/GZ3MparKCFYwY45pE8EgCA3zejm0WQ/nIr6VLAelFbReIidY7L4B4pi9YjnA2UPB1C6w3bvSCtxHbfD6e+lZQm7mNDjJkXPISf1jf6
 agkIr46ERI2KIs4r0ss9QK+bCh2gKQ==
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 11, 2022 at 03:53:44PM +0200, Thorsten Leemhuis wrote:
> Hi, this is your Linux kernel regression tracker.
> 
> CCing the regression mailing list, as it should be in the loop for all
> regressions, as explained here:
> https://www.kernel.org/doc/html/latest/admin-guide/reporting-issues.html
> Also CCing the hibernation maintainers and Linux-pm.
> 
> On 09.06.22 01:55, Ken Moffat wrote:
> > Up to 5.18.0 hibernation has worked ok on my ryzen 5 3400G : screen
> > blanks, disk activity for the write to swap, screen briefly has a
> > trashed display, machine powers off.  When powering up from
> > hibernation, after the saved files are loaded X starts with a
> > briefly trashed display before my desktop reappears.
> > 
> > But with 5.19.0-rc1 the screen is blank throughtout the hibernation,
> > and briefly when restoring (no complaint about that), but when
> > hibernating it no longer powers off and I have to hold the on/off
> > switch to power off.
> > 
> > Is this a known problem ?
> 
> Thanks for the report. Maybe the hibernation maintainers might know, but
> often issues like this are caused by other things like drivers. If they
> don#t have a idea, you likely need to do a bisection to get down to the
> change that introduced this regressions.
> 
> Anyway: To be sure below issue doesn't fall through the cracks
> unnoticed, I'm adding it to regzbot, my Linux kernel regression tracking
> bot:
> 
> #regzbot ^introduced v5.18..v5.19-rc1
> #regzbot title hibernate: Not powering off when hibernated
> #regzbot ignore-activity
> 
> This isn't a regression? This issue or a fix for it are already
> discussed somewhere else? It was fixed already? You want to clarify when
> the regression started to happen? Or point out I got the title or
> something else totally wrong? Then just reply -- ideally with also
> telling regzbot about it, as explained here:
> https://linux-regtracking.leemhuis.info/tracked-regression/
> 
> Reminder for developers: When fixing the issue, add 'Link:' tags
> pointing to the report (the mail this one replied to), as the kernel's
> documentation call for; above page explains why this is important for
> tracked regressions.
> 
> Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
> 
> P.S.: As the Linux kernel's regression tracker I deal with a lot of
> reports and sometimes miss something important when writing mails like
> this. If that's the case here, don't hesitate to tell me in a public
> reply, it's in everyone's interest to set the public record straight.

Thanks.  I've started to bisect, but I've got a lot else on and it
might be a few days before I get a result.  All I know so far is
that whatever got rid of the garbled screens was fine, and the
problem seems to have arisen in the last 800+ commits for 5.19-rc1.

ĸen
-- 
      Remembering The People's Republic of Treacle Mine Road.
        Truth!  Justice!  Freedom!  Reasonably priced Love!
                 And a Hard-boiled Egg!
