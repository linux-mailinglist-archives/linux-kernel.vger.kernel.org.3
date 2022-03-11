Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B332C4D6155
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 13:14:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348006AbiCKMPA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 07:15:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234114AbiCKMO6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 07:14:58 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9F135F55;
        Fri, 11 Mar 2022 04:13:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 739ED61D82;
        Fri, 11 Mar 2022 12:13:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3E4FC340E9;
        Fri, 11 Mar 2022 12:13:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647000834;
        bh=I4dI9lI3tS85NOltH/aiLZCiUVCs1ikDTbg5+Tph9Zo=;
        h=From:To:Cc:Subject:Date:From;
        b=vC3XHaQ5lNSJUCx5zIcb9iACSCuRfb89U3QHhHR39q/TXwWoEDcz7fgT+OZ24WD0R
         v6EWCdoXH8dJ+kLjffgmyEc8wJp8sD3r1MM1dKaOrhPiyxJtpv6gPlWsrWOgLphATq
         JRBvkwjnf+4uKv2d2B38S7vPVZmPWc3cfQjmdEVayeTcF9s6sv0TUn34rolOXb5u7u
         AAiz/H5M//lfWOBU5e72GPkt6WBSjEwEarzLcIbBvBN/rdnHQJ+w7vRDaR2T9v4yXW
         TpbnfvTtPxhqHwki4zsJRmJNdFd/+EiXI4EF2Yl3bEm9KGf+JElhkUluE7XEYhv6NP
         vvP88eeKAQP4A==
From:   Georgi Djakov <djakov@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        djakov@kernel.org
Subject: [GIT PULL] interconnect changes for 5.18
Date:   Fri, 11 Mar 2022 14:13:57 +0200
Message-Id: <20220311121357.19439-1-djakov@kernel.org>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Greg,

This is the pull request with interconnect changes for the 5.18-rc1 merge
window. It contains a few minor framework and driver updates. The details
are in the signed tag.

All patches have been in linux-next for more than a week. No issues have
been reported so far. Please pull into char-misc-next.

Thanks,
Georgi

The following changes since commit e783362eb54cd99b2cac8b3a9aeac942e6f6ac07:

  Linux 5.17-rc1 (2022-01-23 10:12:53 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/djakov/icc.git tags/icc-5.18-rc1

for you to fetch changes up to 52c85167e41341c2cbc2570f4bb6bc6cd8f8bc6e:

  Merge branch 'icc-msm8939' into icc-next (2022-03-01 16:31:35 +0200)

----------------------------------------------------------------
interconnect changes for 5.18

These are the interconnect changes for the 5.18-rc1 merge window
consisting of minor framework and driver updates.

Core changes:
 - Added stubs for the bulk API to expand compile testing coverage.

Driver changes:
 - imx: Implemented get_bw() function to get initial avg/peak bandwidth.
 - msm8939: Fix ioremap collision for snoc-mm.

Signed-off-by: Georgi Djakov <djakov@kernel.org>

----------------------------------------------------------------
Abel Vesa (1):
      interconnect: imx: Add imx_icc_get_bw function to set initial avg and peak

Bryan O'Donoghue (2):
      dt-bindings: interconnect: Convert snoc-mm to a sub-node of snoc
      interconnect: qcom: msm8939: Remove snoc_mm specific regmap

Georgi Djakov (2):
      interconnect: Add stubs for the bulk API
      Merge branch 'icc-msm8939' into icc-next

 Documentation/devicetree/bindings/interconnect/qcom,rpm.yaml | 33 ++++++-
 drivers/interconnect/imx/imx.c                               |  9 ++
 drivers/interconnect/qcom/msm8939.c                          | 10 +-
 include/linux/interconnect.h                                 | 36 ++++++--
 4 files changed, 70 insertions(+), 18 deletions(-)
