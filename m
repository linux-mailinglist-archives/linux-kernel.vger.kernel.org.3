Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 290334D027E
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 16:10:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243587AbiCGPKw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 10:10:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236493AbiCGPKu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 10:10:50 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE3FA34BB6;
        Mon,  7 Mar 2022 07:09:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 68F4AB815DD;
        Mon,  7 Mar 2022 15:09:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C642C340E9;
        Mon,  7 Mar 2022 15:09:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646665793;
        bh=nroespDCTfI8GUP+QfMklKnR583dye6R4K9fyDl8frs=;
        h=Subject:From:To:Date:From;
        b=kpguhQ9aXByJLq1N2/25s98p7Zh/ak5SbThhkVzZ+oJh6vWQovVFLl6DGq/Z3RHaV
         CD5tpt5zCblQ2qyYzyfa235c5S0DWPeso/ft5HB7v0iJSY8vG0UXxIzH4UMwZcbyMz
         ND00oqxmypyZ+WrIjFx8mH+iyQ0n1AIWGwLic3y3z6RdBrXcHMFoDEZ+uX2Ay3SrZI
         brFf0/b5cXtakbpBYKxwk/Tz7tINtJpcHkg293nzoPqPMSXJGvQh9hZHZXtncPLj82
         sUM4AsTmSAT+u///aPIKx7zIi3ayGn09iJN9JlyjWj6VOtK99IBtZEk/MGJQjslJB/
         4/5CPKWu62BaQ==
Message-ID: <c4f9c937630a72d5a5034cebe7facdbad9866e8b.camel@kernel.org>
Subject: [ANNOUNCE] 5.4.182-rt70
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
Date:   Mon, 07 Mar 2022 09:09:50 -0600
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello RT Folks!

I'm pleased to announce the 5.4.182-rt70 stable release.

This release is just an update to the new stable 5.4.182
version and no RT specific changes have been made.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v5.4-rt
  Head SHA1: ffd36f43c2e7b9eb1f1c261b2146c44ccd781936

Or to build 5.4.182-rt70 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v5.x/linux-5.4.tar.xz

  https://www.kernel.org/pub/linux/kernel/v5.x/patch-5.4.182.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/5.4/patch-5.4.182-rt70.patch.xz

Enjoy!

   Tom

