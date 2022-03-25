Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 095044E7C48
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Mar 2022 01:21:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233225AbiCYVId (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 17:08:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233106AbiCYVIb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 17:08:31 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FCFA1EA5F3
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 14:06:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 033AAB829E7
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 21:06:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9870AC340F0;
        Fri, 25 Mar 2022 21:06:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648242413;
        bh=HBNxehuWM95mJ5tBOdvdjSVbzp99mTC/zrq/CgLQ/0w=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=lyR3Xc7+3i7qATxCDuL8jKg9L/LXVtU6QjGNVD0YB6PyX8GHwjd2Gc4X2iJBPtfW6
         ql1I2OPu2qNiUhzmI9XtHrdE8dwwszXspPQKmUwLIxcX+J308YKkdsixu929qxShFy
         swfkBY95k+h2LFZ14da4p0iy8/R05WRpQwtTkzMQnPoR1UPJtPHhwlr0A3Jg3l91Xj
         0dA6oedtXiTGC7BKbW24G2Jw41ItpqfSGOIA9CcHwVRwmgXFb2vaziQ7b+t4XdFrJ9
         96MEWJWPtXdkCF2eC+TGED84NaEhYeoRKA1XJjNAeSjuEfaP/umDY4WTSFDDkPwUZK
         nZJqmN15Yu4Xw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 85B1FE7BB0B;
        Fri, 25 Mar 2022 21:06:53 +0000 (UTC)
Subject: Re: [GIT PULL] mtd: Changes for 5.18
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220324102537.074f3a73@xps13>
References: <20220324102537.074f3a73@xps13>
X-PR-Tracked-List-Id: Linux MTD discussion mailing list <linux-mtd.lists.infradead.org>
X-PR-Tracked-Message-Id: <20220324102537.074f3a73@xps13>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git tags/mtd/changes-for-5.18
X-PR-Tracked-Commit-Id: 6cadd424abb63120f8346a4509dc43bddc9401d3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e35a4a4e13c35f500a8d38e836b5e335c7515494
Message-Id: <164824241354.8431.2470875877028264178.pr-tracker-bot@kernel.org>
Date:   Fri, 25 Mar 2022 21:06:53 +0000
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-mtd@lists.infradead.org, Richard Weinberger <richard@nod.at>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Michael Walle <michael@walle.cc>,
        Pratyush Yadav <p.yadav@ti.com>, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 24 Mar 2022 10:25:37 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git tags/mtd/changes-for-5.18

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e35a4a4e13c35f500a8d38e836b5e335c7515494

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
