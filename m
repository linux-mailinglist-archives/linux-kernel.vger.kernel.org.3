Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D71FA47378D
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 23:34:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243728AbhLMWdz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 17:33:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243616AbhLMWdl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 17:33:41 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98EB4C061574;
        Mon, 13 Dec 2021 14:33:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3CB5761286;
        Mon, 13 Dec 2021 22:33:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 976F0C34605;
        Mon, 13 Dec 2021 22:33:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639434819;
        bh=QWibT/o9T5XkwjnFZEWKm/t6gnHe/K8YQgsfhTcy6Xc=;
        h=From:To:Cc:Subject:Date:From;
        b=H2hnG88JbSe8wtfhgs/VHUBxGFtibM0YbvefsAFiBFBm4K2xSmbyPBS4Jf3uEYOsy
         80qqJfA5ShtjYQ4nSRU1J1BZW4uykqHPShKMa5alIMG3ZWBCvG9QSg4V6hud5iK3n4
         BzOX4ISBrmcZfoXm5HaANgSye61EO1q4o3AEhZIOgwZxHsYXdlD3DbWevQ4vXpLruf
         XRyeGlk2GSC/UfrJ3JBw+u1tP6WNe29RsF/weW+OhlfzXSzr9fX4YnZde12XUR4FeW
         P6eiw+lJvb9SCN7lOuGHv8hcdpurEOH9vmTN99afo2pQMNNBp4nfVBbgMh3Yg4Yuj7
         5LX6275C/qSMw==
From:   broonie@kernel.org
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Sasha Levin <sashal@kernel.org>,
        Wedson Almeida Filho <wedsonaf@google.com>
Subject: linux-next: manual merge of the rust tree with the origin tree
Date:   Mon, 13 Dec 2021 22:33:34 +0000
Message-Id: <20211213223334.692590-1-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Today's linux-next merge of the rust tree got a conflict in:

  tools/include/linux/lockdep.h

between commit:

  3a49cc22d31ec ("tools/lib/lockdep: drop leftover liblockdep headers")

from the origin tree and commit:

  ab4cc3d9c564d ("kallsyms: increase maximum kernel symbol length to 512")

from the rust tree.

I fixed it up by removing lockdep.h again and can carry the fix as
necessary. This is now fixed as far as linux-next is concerned, but any
non trivial conflicts should be mentioned to your upstream maintainer
when your tree is submitted for merging.  You may also want to consider
cooperating with the maintainer of the conflicting tree to minimise any
particularly complex conflicts.
