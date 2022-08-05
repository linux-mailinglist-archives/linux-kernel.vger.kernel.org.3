Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C0CF58A472
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 03:28:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235655AbiHEB2Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 21:28:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235767AbiHEB2X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 21:28:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 918471BE82
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 18:28:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2CF0F61959
        for <linux-kernel@vger.kernel.org>; Fri,  5 Aug 2022 01:28:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8C0C8C433D7;
        Fri,  5 Aug 2022 01:28:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659662901;
        bh=HIgHUL+NoIFTIcuocIccWIIflqzul0P9/AwFVMACFYk=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=rEYJpgS9HyQbDH997/B6Vy/XIf7OZoIKSqZTT9eFtBoHCoHWPX6e9lnObK8/NaaR0
         xp4chH6uMbjWvfB1qXTMf3Cdbc4sa791xwA0WjW3z8/f/nBS66+LxzhGdLP5QB8v7r
         b6w0CuaPOQNttUzKLW8a/EhvDdwknYntT2i6XrDhxK9QMU7IhrTq6OKZrgLdrMB1ZJ
         JLc3iiuxSxAaYaH40GblV2RpUq1s5dT3lCpzsh+6QEErwteHv27UkvhKf/VeRyJjDL
         PYo3O4uphGRi1kH/gRKpwWJTFY+IgvS1OfMQJPxDKFj+mSRhjf+icubeeT+75nf27+
         D1XH1kawN+2DQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 70395C43142;
        Fri,  5 Aug 2022 01:28:21 +0000 (UTC)
Subject: Re: [GIT PULL] HID for 5.20
From:   pr-tracker-bot@kernel.org
In-Reply-To: <nycvar.YFH.7.76.2208022133430.19850@cbobk.fhfr.pm>
References: <nycvar.YFH.7.76.2208022133430.19850@cbobk.fhfr.pm>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <nycvar.YFH.7.76.2208022133430.19850@cbobk.fhfr.pm>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git tags/for-linus-2022080201
X-PR-Tracked-Commit-Id: a60885b6a97b5dc9340dd9310a57b5682c2daf2d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8d9420ca9bd9bceddcfab3d0263d6a8e073396fe
Message-Id: <165966290145.8823.1394185326501751440.pr-tracker-bot@kernel.org>
Date:   Fri, 05 Aug 2022 01:28:21 +0000
To:     Jiri Kosina <jikos@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 2 Aug 2022 21:38:09 +0200 (CEST):

> git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git tags/for-linus-2022080201

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8d9420ca9bd9bceddcfab3d0263d6a8e073396fe

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
