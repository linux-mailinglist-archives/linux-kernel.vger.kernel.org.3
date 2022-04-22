Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FECD50B1AF
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 09:33:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444889AbiDVHfY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 03:35:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1444876AbiDVHfV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 03:35:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95775515BE;
        Fri, 22 Apr 2022 00:32:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1AE5461F5A;
        Fri, 22 Apr 2022 07:32:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63C86C385A0;
        Fri, 22 Apr 2022 07:32:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650612747;
        bh=UB28YGlhAkWEAuV9AeyG9g+eUkzmMf90dg+QB+rqWlA=;
        h=From:To:Cc:Subject:Date:From;
        b=jqttIBEWlQitOymB/4TM6jgFBEJ1Getb1PJx6UNuGLHWijmeWJs0pYENdEVOINA7X
         hbjQr61D9B3qKkpsnO9+KufPzlPvAYyoeDGt2zjlMDnNRR/0ZWQnScvef9PglVKka7
         aioFwBSe3MQLKNypbPiK4Z6wbn3bcFzNXU4Zn5lj8pGEOM5ZhpIyio2C9gGCuzauyd
         S10H5IXc0K7yWJjwWEOKlzzJTZwncl+IFLUIqnZP63GS6eanxWtUZ2l0sqUFrkBWQ5
         fl2gNnLhoOfHk4PdQbgCcTxtKY26O+FVKzcoqPq3gKYGmySEWoOFJccGqb/1GUQUz1
         kMViTExNDBIkw==
From:   Georgi Djakov <djakov@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        djakov@kernel.org
Subject: [GIT PULL] interconnect fixes for 5.18-rc
Date:   Fri, 22 Apr 2022 10:32:21 +0300
Message-Id: <20220422073221.30745-1-djakov@kernel.org>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Greg,

This pull request contains interconnect driver fixes for an issue that
has been reported. Please pull into char-misc-linus when possible. The
patches have been in linux-next for a week.

Thanks,
Georgi

The following changes since commit 3123109284176b1532874591f7c81f3837bbdc17:

  Linux 5.18-rc1 (2022-04-03 14:08:21 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/djakov/icc.git tags/icc-5.18-rc4

for you to fetch changes up to 2fb251c265608636fc961b7d38e1a03937e57371:

  interconnect: qcom: sdx55: Drop IP0 interconnects (2022-04-14 09:47:16 +0300)

----------------------------------------------------------------
interconnect fixes for v5.18

This contains a fix for a reported issue on sc7180 platforms, where
one of the resources has been incorrectly modelled as both clock and
interconnect, which is causing a crash when both frameworks try to
manage it. Fix the same issue also on another platform that appears
to be affected by the same.

- interconnect: qcom: sc7180: Drop IP0 interconnects
- interconnect: qcom: sdx55: Drop IP0 interconnects

Signed-off-by: Georgi Djakov <djakov@kernel.org>

----------------------------------------------------------------
Stephen Boyd (2):
      interconnect: qcom: sc7180: Drop IP0 interconnects
      interconnect: qcom: sdx55: Drop IP0 interconnects

 drivers/interconnect/qcom/sc7180.c | 21 --------
 drivers/interconnect/qcom/sdx55.c  | 21 --------
 2 files changed, 42 deletions(-)
