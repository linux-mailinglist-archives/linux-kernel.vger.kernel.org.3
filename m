Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1A6C467E74
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 20:50:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353508AbhLCTxh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 14:53:37 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:34176 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353441AbhLCTxg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 14:53:36 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 22A89CE2817;
        Fri,  3 Dec 2021 19:50:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 516B2C53FAD;
        Fri,  3 Dec 2021 19:50:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638561009;
        bh=3zpaER5clmvC/+uoSi6iXpa2sHBo5rlHOifUHCh/0/M=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=a2sF5zXF0aMmyUcZ0aMICpj6eqUr3hXHYJpqRN+bnsQVAmB60slRpAnQs0tuvsYnn
         bdC6JSL6MqHHKcnNnHJhB/k8aNncdQOEQZC+715yvL5KnPCShwjLSlQQfda6G/zFcY
         Lyv3J7gZHBGJcyy+S30B05CKxEBjEuNfN5zmolcXT3cIFHMfW9Xf8SOt0SIDban9OA
         g5HZjE6NahAnc2MAeieHJHcIlW1XzRAO3tbRwmsr1/Fy9uoheQVTWenvN1VkG9Bjre
         zNSlEC/ycnlsPA4W1YthbgvV/o6IMskTyEyk1R9FvtYZs+OzygO6GnURTnJqRSxjB3
         +tUWd0A/0odAA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 32D0760A50;
        Fri,  3 Dec 2021 19:50:09 +0000 (UTC)
Subject: Re: [GIT PULL] s390 updates for 5.16-rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Yapz2thD1GK8yQ6J@osiris>
References: <Yapz2thD1GK8yQ6J@osiris>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Yapz2thD1GK8yQ6J@osiris>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-5.16-4
X-PR-Tracked-Commit-Id: 3c088b1e82cfb7c889823d39846d32079f190f3f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 757f3e6ddd6811221f3a0586bd8de90cd046e5fd
Message-Id: <163856100919.9946.302615582661120490.pr-tracker-bot@kernel.org>
Date:   Fri, 03 Dec 2021 19:50:09 +0000
To:     Heiko Carstens <hca@linux.ibm.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 3 Dec 2021 20:45:30 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-5.16-4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/757f3e6ddd6811221f3a0586bd8de90cd046e5fd

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
