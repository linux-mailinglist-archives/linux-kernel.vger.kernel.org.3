Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6947A48B761
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 20:32:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236347AbiAKTcd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 14:32:33 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:46968 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236203AbiAKTcc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 14:32:32 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5CEF061790;
        Tue, 11 Jan 2022 19:32:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCB5CC36AE3;
        Tue, 11 Jan 2022 19:32:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641929551;
        bh=hNjDIPGNlujdRSSf1NQl1cSefZrieuOyQlyWDWXEdgM=;
        h=Date:From:To:Cc:Subject:From;
        b=uqQF/MTxMsB8G39DUL/jWy1HBonrCwkf43V3fACYidyPbQ0CQEnzCt3FbvZuMF5fX
         7HSLfmxBuqPvnNhoSBJmOi7JIgSP+hd8mYTO2hn+II2JMuHvgnuuM23w447Ge2IDFn
         hyl4jwdgevv1jCj2FUmFnXjuz/8b9EY5weU6fHsKFHbse7SCPnb6cCLxveqYjOtBfY
         Kx7INo1U0HURapy2STfgTip8pb5cZk4KnzL1RcEcQi+7tYudw/PCxXxoaC3+rJ4dxP
         /ewj0l+L8oyjP8C2UquPZ0eF0BScz0gs/A53jjIjyZF/etNPLZph4x31AMH905CYWk
         M3Asjwe1wmQ2g==
Date:   Tue, 11 Jan 2022 13:38:55 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Kees Cook <keescook@chromium.org>, linux-hardening@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: [GIT PULL] Enable -Wcast-function-type for 5.17-rc1
Message-ID: <20220111193855.GA13612@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit fa55b7dcdc43c1aa1ba12bca9d2dd4318c2a0dbf:

  Linux 5.16-rc1 (2021-11-14 13:56:52 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git tags/Wcast-function-type-5.17-rc1

for you to fetch changes up to 552a23a0e5d0a84cecd4687043d8030673981d30:

  Makefile: Enable -Wcast-function-type (2021-11-15 13:45:12 -0600)

----------------------------------------------------------------
Enable -Wcast-function-type

Hi Linus,

Please, pull the following patch that globally enables
-Wcast-function-type.

We need to make sure new function cast mismatches are not
introduced in the kernel in order to avoid tripping CFI
checking.

Thanks!
--
Gustavo

----------------------------------------------------------------
Gustavo A. R. Silva (1):
      Makefile: Enable -Wcast-function-type

 Makefile | 5 +++++
 1 file changed, 5 insertions(+)
