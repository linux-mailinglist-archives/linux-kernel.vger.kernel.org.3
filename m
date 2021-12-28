Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C45DE480AFB
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Dec 2021 16:45:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235159AbhL1Ppt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Dec 2021 10:45:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230489AbhL1Pps (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Dec 2021 10:45:48 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC228C061574
        for <linux-kernel@vger.kernel.org>; Tue, 28 Dec 2021 07:45:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9F8D9B8121D
        for <linux-kernel@vger.kernel.org>; Tue, 28 Dec 2021 15:45:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 235D7C36AE8;
        Tue, 28 Dec 2021 15:45:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640706345;
        bh=61VjJm5PfCJyV3kQn8StWdf+zqdRjqOr4bdI80mKVXI=;
        h=Date:From:To:Cc:Subject:From;
        b=IWwwmmisD3USEZPaJACXojKWUO5BbeZTA4kjZM1esZbjguZekooMTH1Ck86BuGPlc
         zhdYRd5XMFY2Vh41zi06Dpm1RVPtHf5rBUaW048A2XDqK0tUf7eLp2oVS43rKOy/k4
         NlAWKEGdybOHRtn6dBLgHiiJzU0iY0FYVWC1juGPf3C/nrPNVZBDUre5fAZ4wZAkvp
         t4QSmbEEWPbAHBfU++U6pY/PJbGmzyJOfDUAe96lC7BfkoEu0FlNOVKb45SJZd23US
         yJliN4cDYDNb3XrwqnlqhvOCR9vuIAgbgpVbUiuQPCEArMTW17BC9XOLaw1jqT1STp
         FAeVrMkJFOb5w==
Date:   Tue, 28 Dec 2021 16:45:16 +0100
From:   Miguel Ojeda <ojeda@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Luiz Sampaio <sampaio.ime@gmail.com>,
        Miguel Ojeda <ojeda@kernel.org>, linux-kernel@vger.kernel.org
Subject: [GIT PULL] auxdisplay for v5.16
Message-ID: <20211228154449.GA14032@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: elm/2
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull a couple small changes for v5.16 or v5.17.

Cheers,
Miguel

The following changes since commit 136057256686de39cc3a07c2e39ef6bc43003ff6:

  Linux 5.16-rc2 (2021-11-21 13:47:39 -0800)

are available in the Git repository at:

  https://github.com/ojeda/linux.git tags/auxdisplay-for-linus-v5.16

for you to fetch changes up to 4daa9ff89ef27be43c15995412d6aee393a78200:

  auxdisplay: charlcd: checking for pointer reference before dereferencing (2021-11-24 11:46:52 +0100)

----------------------------------------------------------------
A couple improvements for auxdisplay:

  - charlcd: checking for pointer reference before dereferencing.

  - charlcd: fixing coding style issue.

----------------------------------------------------------------
Luiz Sampaio (2):
      auxdisplay: charlcd: fixing coding style issue
      auxdisplay: charlcd: checking for pointer reference before dereferencing

 drivers/auxdisplay/charlcd.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)
