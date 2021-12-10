Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C1C947085F
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 19:18:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242190AbhLJSWJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 13:22:09 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:38018 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231148AbhLJSWI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 13:22:08 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 02762CE2C78;
        Fri, 10 Dec 2021 18:18:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31736C00446;
        Fri, 10 Dec 2021 18:18:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639160310;
        bh=6iqMAKPKVrlYmZ4Cc/w6rUiv+blT1OtvuwDt+iq/ook=;
        h=From:To:Cc:Subject:Date:From;
        b=O0kYzEzncWbex1XiLlGDwiPcO7WR9ElihIXMAu3DtGmuAeJXEAOhaPIMMWmkRSpD2
         KZ2PCUIBjyIS4CN3E1dOBLEl8BKeh8jrLP5VhUVuynan9r9gxvYuHkUFkaCnaZKot0
         enC44awH94PKcthfBeRIsj64Ck29u5gUVAqjg3PIj635ZsaXbLAvA0M2S5yyf2ztmS
         sgCyxcRyvRTpir+pl8NTrZqp3bzZNENtL4ZI9wFiwHN8kARYj7xh7wMwTr+7sOupTw
         pl6XWBj0PJSPS6uGJC6zckradH5Cj+w7C4fMYp3Dy7d6+3EhbHIUbuDz4oAJgOrq8V
         hI5JcLkWrxOlQ==
From:   broonie@kernel.org
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Sasha Levin <sashal@kernel.org>,
        Wedson Almeida Filho <wedsonaf@google.com>
Subject: linux-next: manual merge of the rust tree with Linus' tree
Date:   Fri, 10 Dec 2021 18:18:24 +0000
Message-Id: <20211210181824.3710591-1-broonie@kernel.org>
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

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.
