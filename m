Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 431F852FFEE
	for <lists+linux-kernel@lfdr.de>; Sun, 22 May 2022 02:22:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347893AbiEVAWh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 May 2022 20:22:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347501AbiEVAWd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 May 2022 20:22:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA08F3FBC1;
        Sat, 21 May 2022 17:22:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 62DBA60EF8;
        Sun, 22 May 2022 00:22:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C5B4EC385B8;
        Sun, 22 May 2022 00:22:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653178951;
        bh=Cvc0TCsFYfrtsDOto8w+o7+IC1twPbLpFDRQpCQ0iuI=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=PR5FsHIUfOhCx01eG+RwbDAyS79lbtxvT4VlmR6JdrQI1G0KwBnf48mtMipnfYXdv
         +mzErIuChSdA00G5iePqTcgbZvUu5FECyiFwM+vBpI/n+i6te17upy5WlEcJWKdxGg
         UDlSd/ffIgTufldG2T2HdA2jheZJNrfYHTzdA/zD1kSlslWS6iMIiBXx67QYEyw+8S
         brgzJGTIYa8T6BrgMG4fZZjo81y21qtTd7uUbiurQ+Cpx0p7Kw38wySheFtI+/Xi3a
         Ct6srvCJ+z/dXqK71h/tMPNZNMk5/nsi2zyYMlVoVXK2Ur4u31+c2eIazrN6Wb0jcY
         DG/n6Z9XxXVAA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B3B30E7BA5A;
        Sun, 22 May 2022 00:22:31 +0000 (UTC)
Subject: Re: [GIT PULL] SCSI fixes for 5.18-rc6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <333254c5b864c9c8bf50b895d99309b27065a487.camel@HansenPartnership.com>
References: <333254c5b864c9c8bf50b895d99309b27065a487.camel@HansenPartnership.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <333254c5b864c9c8bf50b895d99309b27065a487.camel@HansenPartnership.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes
X-PR-Tracked-Commit-Id: d5d92b64408443e113b9742f8f1c35278910dd4d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 36ed2da76b181200ecdee4a8bf84f698138f290a
Message-Id: <165317895173.14812.15638882572260549793.pr-tracker-bot@kernel.org>
Date:   Sun, 22 May 2022 00:22:31 +0000
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 21 May 2022 13:09:43 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/36ed2da76b181200ecdee4a8bf84f698138f290a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
