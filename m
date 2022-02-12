Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD60D4B3741
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Feb 2022 19:25:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230320AbiBLSX7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Feb 2022 13:23:59 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229701AbiBLSXo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Feb 2022 13:23:44 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 230E160040;
        Sat, 12 Feb 2022 10:23:26 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D2345B80886;
        Sat, 12 Feb 2022 18:23:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8A716C340E7;
        Sat, 12 Feb 2022 18:23:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644690195;
        bh=9NXec+aBlohm03rl7cKlxgZKxK0y9ou0XQVb0HaNzfw=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=R77FQ6msfzvNEQgLb/pz3XJtwkLEhfEi7fqPJXIt74dTR5MgLS/3JTpMu6boBpHqy
         fuLE0hJn+cmeE/yL6eselIzyJQppS8VUXi4E7w8D3HwGxyiJJaR00GMCkEfIBhKPaI
         QLb2JW1ecg+2fkANuQpqtorR8g3CUiSuAK8PxH4hFzswGG8iJfYn91U4Uay+Kf85gv
         R1kn1TqkaJTyZ1CPoSfRfq/ZQq5Ak0uI6Navb1bZT1Y5tQ/VG51QaTsIfHK1Ec7Wg4
         ViCjlod+rPbgX01NHvD22qq1X5wuStNiPBgH8qem8wJDxxkt+Qw5QuElwhQGNH4uT0
         pKbLOkWD8iHtQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 787DFE5D07D;
        Sat, 12 Feb 2022 18:23:15 +0000 (UTC)
Subject: Re: [GIT PULL] USB fixes for 5.17-rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YgeMP/kEFRI1Aq6T@kroah.com>
References: <YgeMP/kEFRI1Aq6T@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YgeMP/kEFRI1Aq6T@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-5.17-rc4
X-PR-Tracked-Commit-Id: 736e8d89044c1c330967fb938fa766cd9e0d8af0
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 85187378990eb25012b4a506114ad41a478b00a5
Message-Id: <164469019548.16091.15744992369658238237.pr-tracker-bot@kernel.org>
Date:   Sat, 12 Feb 2022 18:23:15 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 12 Feb 2022 11:30:23 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-5.17-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/85187378990eb25012b4a506114ad41a478b00a5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
