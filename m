Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80AB050E55F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 18:17:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243251AbiDYQS5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 12:18:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231631AbiDYQSy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 12:18:54 -0400
X-Greylist: delayed 1353 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 25 Apr 2022 09:15:48 PDT
Received: from gateway34.websitewelcome.com (gateway34.websitewelcome.com [192.185.148.109])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FF39DECF
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 09:15:47 -0700 (PDT)
Received: from cm10.websitewelcome.com (cm10.websitewelcome.com [100.42.49.4])
        by gateway34.websitewelcome.com (Postfix) with ESMTP id 8338B18366
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 10:53:13 -0500 (CDT)
Received: from gator3214.hostgator.com ([198.57.247.178])
        by cmsmtp with SMTP
        id j11VnII7kRnrrj11VnqxsM; Mon, 25 Apr 2022 10:53:13 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=dolney.com;
        s=default; h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:
        In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=0zdZwXqOP3IfVMI2ktkSdbMROF0Y96jr1KRV+mGdWpE=; b=SHo/c5MK6fD5B83zg72ZbixKwX
        avTtHHh7jySojW1dRm+qBDeECErLE4aVcZ8WaoXkY2/VdjMNqybb3pVd34roVF42D63EDPd3TQpMT
        +XbcaiOTLEE4Skb2SDsDe1s7gQa71DJrH1QcxrYyuEoBRoXXXv9PHsEObLegq9LuKiK8i2pzRKMjV
        +MQQEcX+7XtXtJ4sXql6fj//KgFIc82Lai07SAHwsQPWUVVHxh4kDPYqfcUY/Vec5ASTVI7bLpo1r
        uy7dXmwp+fB8DJVhmwnuX1z5Kt2aKNxvDT6Ktb3X2AcyDoja31n68p+k28gxsayCUGpBc82rKwR/l
        0YTmDOTA==;
Received: from [96.9.249.37] (port=44854 helo=[10.1.70.16])
        by gator3214.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <kernel@dolney.com>)
        id 1nj11U-003RMb-FO; Mon, 25 Apr 2022 10:53:12 -0500
Message-ID: <2a333dba2d9b0629cdbcfa08604fe21f66623762.camel@dolney.com>
Subject: Re: [Bug 215867] New: tboot suspend broken
From:   Unknown <kernel@dolney.com>
To:     Borislav Petkov <bp@alien8.de>, bugzilla-daemon@kernel.org,
        kernel@dolney.com, Vincent Donnefort <vincent.donnefort@arm.com>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Date:   Mon, 25 Apr 2022 11:51:49 -0400
In-Reply-To: <YmEjGl2RzYARUHK2@zn.tnic>
References: <bug-215867-6385@https.bugzilla.kernel.org/>
         <YmEjGl2RzYARUHK2@zn.tnic>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator3214.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - dolney.com
X-BWhitelist: no
X-Source-IP: 96.9.249.37
X-Source-L: No
X-Exim-ID: 1nj11U-003RMb-FO
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([10.1.70.16]) [96.9.249.37]:44854
X-Source-Auth: nospam+dolney.com
X-Email-Count: 2
X-Source-Cap: ZGRqZHJkZGQ7ZGRqZHJkZGQ7Z2F0b3IzMjE0Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yes, still a problem with 5.17.4

On Thu, 2022-04-21 at 11:25 +0200, Borislav Petkov wrote:
> Switching to mail because I can't CC the patch author on bugzilla.
> 
> Vincent, see below. It points to your commit:
> 
> 453e41085183 ("cpu/hotplug: Add cpuhp_invoke_callback_range()")
> 
> @Derek, just to make sure: you're seeing this with the latest 5.17
> kernel too, correct?
> 
> Thx.
> 
> On Thu, Apr 21, 2022 at 02:07:42AM +0000,
> bugzilla-daemon@kernel.org wrote:
> > https://bugzilla.kernel.org/show_bug.cgi?id=215867
> > 
> >             Bug ID: 215867
> >            Summary: tboot suspend broken
> >            Product: Platform Specific/Hardware
> >            Version: 2.5
> >     Kernel Version: 5.12.0
> >           Hardware: All
> >                 OS: Linux
> >               Tree: Mainline
> >             Status: NEW
> >           Severity: normal
> >           Priority: P1
> >          Component: x86-64
> >           Assignee: platform_x86_64@kernel-bugs.osdl.org
> >           Reporter: kernel@dolney.com
> >         Regression: Yes
> > 
> > I am using tboot (v1.10.5) to make use of intel-txt and all was
> > working fine
> > with the Linux kernel 5.10 series. However later in 5.12 release
> > candidates, I
> > have  proper booting however suspend is broken. I am using a Lenovo
> > T460p.
> > Usually when suspending on this machine the power button LED will
> > blink 8 times
> > and then it goes into a sleep state. With newer kernels I get power
> > LED and
> > caps lock LED blinking, cpu fan runs fast, and can't get out of
> > that state
> > without hard powerdown.
> > 
> > I did a git bisect on and found that commit
> > 453e41085183980087f8a80dada523caf1131c3c is the one that breaks
> > tboot+suspend
> > to ram. It is part of a series of some cpu hotplug commits.
> > 
> > Just to be clear: if I build a kernel from the commit just before
> > this one, I
> > can suspend and resume, but if I build with this commit I can not
> > suspend,
> > laptop gets stuck on blinking power LED. Let me also mention that,
> > given the
> > above commit, if I do not use tboot, I can suspend and resume ok.
> > It is only
> > within the tboot boot context that I have suspend&resume problems.
> > 
> > -- 
> > You may reply to this email to add a comment.
> > 
> > You are receiving this mail because:
> > You are watching the assignee of the bug.
> 


