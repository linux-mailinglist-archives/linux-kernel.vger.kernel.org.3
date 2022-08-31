Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FE955A88CF
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 00:09:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229682AbiHaWJt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 18:09:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbiHaWJn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 18:09:43 -0400
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79A13CC33A
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 15:09:42 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id B4FEB5EAF;
        Wed, 31 Aug 2022 22:09:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net B4FEB5EAF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1661983781; bh=r5VovZqN3iVFsIULkmnuZLwO9OSFvAmCAbywePG+08U=;
        h=From:To:Cc:Subject:Date:From;
        b=KPnT3w5A3Y8y4x7c30NEH6tPhUyCSB3a2YbC5P3y8TwSH6ZbJ3L+Bpf87vhgtZtPc
         m+Gd459AfiUsX1cBp8CML/oFFeiM33I6T2UsNSe7cWRRpcecaeIunzoCfoiweWOk1S
         JB89ZX3saBzaXxBEsiU7hWOJJuKLco74jQutUwtHdhNK1zZdWo3+tZ859kuibO2GJ3
         rRt9sVraTvO13p+54EuxxGQr0uxPS/dsMMvCohkcd8n1vLRr+GCUpEShIk8qYSiv+k
         N76f1sODpv7kAUnsdLX53ImBF7EDjrUhmjyeAW6wtup8VDbPcf2vL1OBh/gdcxHQ20
         0zcng0KNfGU9w==
From:   Jonathan Corbet <corbet@lwn.net>
To:     linux-kernel@vger.kernel.org, ksummit@lists.linux.dev
Cc:     tab-elections@lists.linuxfoundation.org
Subject: An LF TAB election update
Date:   Wed, 31 Aug 2022 16:09:39 -0600
Message-ID: <877d2ojc9o.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I have a few updates for anybody wanting to participate in the upcoming
Linux Foundation Technical Advisory Board election.

First of all: do not forget to nominate yourself if you are interested in
serving on the TAB.  I'll append the call for nominations to this message
for folks needing a reminder.

Everybody who is eligible to receive a ballot automatically should have
received a note from me last week indicating that fact.  If you are
eligible for an automatic ballot and did not receive that note, please
contact me directly; there were quite a few bounced mailings.

Also remember that you must activate your email address with the CIVS
service prior to the start of voting or you will not receive your ballot:

  https://civs1.civs.us/cgi-bin/opt_in.pl

Unfortunately, some of the companies employing kernel developers have
adopted creative spam-management solutions that prevent the CIVS activation
emails from arriving.  If that affects you, you will need to provide an
alternative, working email address to be able to vote.  Please go ahead and
activate your email address soon and contact us if you need to vote from a
different address.  It will probably *not* be possible to make changes once
the voting has begun.

Feel free to email tab-elections@lists.linuxfoundation.org with any
questions.

Thanks,

jon

The 2022 election for membership on the Linux Foundation Technical Advisory
Board (TAB) will be held electronically during the 2022 Kernel Summit and
Linux Plumbers Conference, from September 12 to 14.  This announcement
covers both the call for candidates and the details of voting in this
election.

The TAB exists to provide advice from the kernel community to the Linux
Foundation; it also serves to facilitate interactions both within the
community and with outside entities.  Over the last year, the TAB has
continued its assistance with the UMN "false commits" episode (including
drafting a set of guidelines for researchers working with the community),
overseen the organization of the Linux Plumbers Conference, put together
guidelines for corporate support of kernel developers and maintainers,
advised on code-of-conduct issues, and more.

CALL FOR NOMINATIONS

The TAB has ten members serving two-year terms; half of the board is
elected each year.  The members whose terms are expiring this year are:

 - Laura Abbott
 - Christian Brauner
 - Kees Cook
 - Chris Mason
 - Dan Williams

The members whose terms expire next year are:

 - Jonathan Corbet
 - Greg Kroah-Hartman
 - Sasha Levin
 - Steve Rostedt
 - Ted Ts'o

Anybody who meets the voting criteria (described below) may self-nominate
to run in this election.  To nominate yourself, please send an email to:

  tech-board-discuss@lists.linux-foundation.org

Please include a short (<= 200 words) statement describing why you are
running and what you would like to accomplish on the TAB; these statements
will be collected and made publicly available.

The nomination deadline is 9:00AM IST (GMT+1) on September 12.

VOTING IN THE TAB ELECTION

The criteria for voting in this year's TAB election are unchanged from
2021.  To be eligible to vote, you must have at least three commits in a
released mainline or stable kernel that:

 - Have a commit date in 2021 or later
 - List your email in a Signed-off-by, Tested-by, Reported-by, Reviewed-by,
   or Acked-by tag.

Everybody with at least 50 commits meeting this description will receive a
ballot automatically.  Eligible voters with less than 50 commits can
receive a ballot by sending a request to
tab-elections@lists.linuxfoundation.org.

We will, once again, be using the Condorcet Internet Voting Service (CIVS)
https://civs1.civs.us/ . This is a voting service focused on security and
privacy. There are sample polls on the website if you would like to see
what a ballot will look like.

Please contact tab-elections@lists.linuxfoundation.org if you have any
questions.

