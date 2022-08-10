Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2C0858F0B1
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 18:47:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232413AbiHJQqr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 12:46:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233113AbiHJQqg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 12:46:36 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8CEE1EC69;
        Wed, 10 Aug 2022 09:46:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 90742B81DDE;
        Wed, 10 Aug 2022 16:46:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81F6EC433C1;
        Wed, 10 Aug 2022 16:46:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660149993;
        bh=gcicsdUEiKWmC0tlAUooZjrEaF5hKScV9pHxuFJ+SAY=;
        h=Subject:From:To:Date:From;
        b=f09VTYUsxxXWX4CHHI/yWUk8lbx6rwQe7rt9iaVsaC+qVaghXHRdfA7LemBF9Yv9q
         wwRzfyu+U4a6hHMyl1J6dygAmYWszlASsi2DrI6FdfACI3S5CHbCsx0KZp6cYk63hE
         dRVWyZfh5wd1/3AS/UM5FNZBg8ByJ5Jey88tBsnKLVFLYl7eJtpznUgjqSSHowJypd
         a1dMUJz95MX3wvWfVg4Yf/JWidBGkiRAzolDPnT8H3erGywnHHUrihylrhua33RaBI
         f8JBLZiRRyE1ppIXldsdWfpTqFepQB8kyZbnJ6FvGaR7T6RA2ilMcCTU/IQNKssPQi
         fg9DMEq2Cjvlg==
Message-ID: <a97ea871f47fc1179159d74858247c620268681a.camel@kernel.org>
Subject: [ANNOUNCE] 5.4.209-rt77
From:   Tom Zanussi <zanussi@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Wagner <wagi@monom.org>,
        Clark Williams <williams@redhat.com>,
        "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>,
        Tom Zanussi <zanussi@kernel.org>
Date:   Wed, 10 Aug 2022 11:46:31 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.1-0ubuntu1 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello RT Folks!

I'm pleased to announce the 5.4.209-rt77 stable release.

This release is just an update to the new stable 5.4.209
version and no RT specific changes have been made.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v5.4-rt
  Head SHA1: a770236dce7c64534de9f843a9fc2c6b3a24efec

Or to build 5.4.209-rt77 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v5.x/linux-5.4.tar.xz

  https://www.kernel.org/pub/linux/kernel/v5.x/patch-5.4.209.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/5.4/patch-5.4.209-rt7=
7.patch.xz

Enjoy!

   Tom


