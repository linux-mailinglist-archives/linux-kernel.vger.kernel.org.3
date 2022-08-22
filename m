Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD94459CBA8
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 00:42:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232172AbiHVWm3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 18:42:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232281AbiHVWmZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 18:42:25 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E499750726
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 15:42:23 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 7BC412AE;
        Mon, 22 Aug 2022 22:42:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 7BC412AE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1661208143; bh=iwqKafgKtoHa324ilfuky7BSyJRg7gT/fs7VjGkALSo=;
        h=From:To:Cc:Subject:Date:From;
        b=aRdcQyCW/A7Z5VIL5621ZkbZtdqcnj3EO3Pl1hChdS9Y/JbZNm/KS6r+IMdWW0ECc
         oriPpL3MNc8iZXu/N92NPWtPwXnzmyI+QJu5aE9bkhT9Mg6C0e4yUIGo6nNH2phIs0
         7T4OxACmxmsyeCU4GrlVhd7Uki5gC4KnT6hCQXVeYloOySBPVMpGy4lrP8ecozrkqM
         UP0D7PZF6czpdUXbeXGp0TEL4OyRCk2CzLguIUqP4FdvK/cedcQ4T3NGMm6OEnK2bn
         DpEJbwdIBdHCOYpQPRX5Jv2jErolZIW3GENv6GjUDK1i8YAJeqapKzy2yZsUxu5uwc
         uXxgTArttFn3w==
From:   Jonathan Corbet <corbet@lwn.net>
To:     linux-kernel@vger.kernel.org, ksummit@lists.linux.dev
Cc:     tab-elections@lists.linuxfoundation.org
Subject: Technical Advisory Board election info and call for nominees
Date:   Mon, 22 Aug 2022 16:42:22 -0600
Message-ID: <87ilmj6gtt.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

Everybody with at least 50 commits meeting this description will receive
a ballot automatically; they will receive an email confirming this
status shortly.  Eligible voters with less than 50 commits can receive a
ballot by sending a request to tab-elections@lists.linuxfoundation.org.

We will, once again, be using the Condorcet Internet Voting Service (CIVS)
https://civs1.civs.us/ . This is a voting service focused on security and
privacy. There are sample polls on the website if you would like to see
what a ballot will look like.

Please contact tab-elections@lists.linuxfoundation.org if you have any
questions.

