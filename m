Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0E2C533363
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 00:17:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242112AbiEXWRg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 18:17:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241092AbiEXWRa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 18:17:30 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1DE41DA49;
        Tue, 24 May 2022 15:17:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4B122B81A50;
        Tue, 24 May 2022 22:17:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 572BAC34100;
        Tue, 24 May 2022 22:17:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653430647;
        bh=6GNFurm58C42MzfXxHuRYU+AEBKCekUhpcZwmsIzaXo=;
        h=Date:From:To:Cc:Subject:From;
        b=XK+SyBlH3t7wkaxMq0EdrM3rR/t7Nvkgdkyj4/66FgfTZSnZu4F1DiPfAU4QtK5we
         ENpwLhgt5RgWC7jHHU+hG18uc4htGMaJE295w2PjTdHFC8fi2aYBiUHB0MHh2yq4u5
         Qn1w/ogK7OvArmKAO1wF+HfBUv14MPdOOMjMTlypc1CcMaTigbLomfi9jxGVEx5RP9
         vMRLN1lTPesXQwnqwlhDCZ5Rjn7x0t5ZDerOuhuuEhxJWS4rfr0in1rJerv839glm1
         uDMQzyf+iFtzB5hyPFH6NtHv8qT3qtk+wjMAB8LnELNzKiHs6ZztpGlVfS5aeuAbQt
         quSx0o14V9Kyw==
Date:   Tue, 24 May 2022 17:27:01 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Kees Cook <keescook@chromium.org>, linux-hardening@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: [GIT PULL] Misc hardening changes for 5.19-rc1
Message-ID: <20220524222701.GA7784@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit ce522ba9ef7e2d9fb22a39eb3371c0c64e2a433e:

  Linux 5.18-rc2 (2022-04-10 14:21:36 -1000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git tags/size_t-saturating-helpers-5.19-rc1

for you to fetch changes up to 746f1b0ac5bf6ecfb71674af210ae476aa714f46:

  virt: acrn: Prefer array_size and struct_size over open coded arithmetic (2022-04-26 10:20:10 -0500)

----------------------------------------------------------------
Misc hardening changes for 5.19-rc1

Hi Linus,

Please, pull the following hardening changes that I've been collecting
in my tree during the last development cycle. All of them have been
baking in linux-next.

Replace open-coded instances with size_t saturating arithmetic helpers:

- virt: acrn: Prefer array_size and struct_size over open coded arithmetic (Len Baker)
- afs: Prefer struct_size over open coded arithmetic (Len Baker)

Thanks
--
Gustavo

----------------------------------------------------------------
Len Baker (2):
      afs: Prefer struct_size over open coded arithmetic
      virt: acrn: Prefer array_size and struct_size over open coded arithmetic

 drivers/virt/acrn/acrn_drv.h | 10 ++++++----
 drivers/virt/acrn/mm.c       |  9 ++++-----
 fs/afs/security.c            |  3 +--
 3 files changed, 11 insertions(+), 11 deletions(-)
