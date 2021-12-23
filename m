Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4247E47E387
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 13:33:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243699AbhLWMdv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 07:33:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348289AbhLWMdi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 07:33:38 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02632C06175E;
        Thu, 23 Dec 2021 04:33:36 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5F1C961E7E;
        Thu, 23 Dec 2021 12:33:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C1D8C36AE9;
        Thu, 23 Dec 2021 12:33:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640262815;
        bh=9dtIDUIeaOL1iIFajBw4lij0XHvFv4zAoRx3F2P0ROo=;
        h=From:To:Cc:Subject:Date:From;
        b=myDr0vL981wkE2hdzlfZwkQ6xFz3iLUabhfD9eYczeFYpP8IhDK/u7FYnEXxAPJea
         jTmUByZgGzypsdUgEUMBf+CdMLJ0d1MWDBGH6S8qHVb/2aEQeiAE6rPtfGlrz/6y4M
         33j6FLv9cQfAUwNaQlHnYtV/U61rejMN4V0eyhI4mcPDVRp30m008ngkoRBNXAkiTz
         Jw6vA73hco5yk2zwvaoktwhg//Zx8WEhozoSH+FUopo54bTqZtzEy4TAgx6JT5fbEh
         eKiIjPrtZMLLo5cxUun453mE7r3kfjMy+KgBYdZPLhqQOlo/xMV/EWYnUbLWvsQseB
         7Z7M8RpV1Hgpw==
From:   Georgi Djakov <djakov@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        djakov@kernel.org
Subject: [GIT PULL] interconnect changes for 5.17
Date:   Thu, 23 Dec 2021 14:33:34 +0200
Message-Id: <20211223123334.22485-1-djakov@kernel.org>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Greg,

This is the pull request with interconnect changes for the 5.17-rc1 merge
window. The highlight are drivers for 4 new platforms. The details are in
the signed tag.

All patches have been in linux-next for more than a week. No issues have
been reported so far. Please pull into char-misc-next.

Thanks,
Georgi

The following changes since commit fa55b7dcdc43c1aa1ba12bca9d2dd4318c2a0dbf:

  Linux 5.16-rc1 (2021-11-14 13:56:52 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/djakov/icc.git tags/icc-5.17-rc1

for you to fetch changes up to 01f8938ad036e97802551ea3746fbc5fdc091de6:

  Merge branch 'icc-qcm2290' into icc-next (2021-12-15 07:14:27 +0200)

----------------------------------------------------------------
interconnect changes for 5.17

Here are the interconnect changes for the 5.17-rc1 merge window
consisting of new drivers, minor changes and fixes.

New drivers:
 - New driver for MSM8996 platforms
 - New driver for SC7280 EPSS L3 hardware
 - New driver for QCM2290 platforms
 - New driver for SM8450 platforms

Driver changes:
 - dt-bindings: interconnect: Combine SDM660 bindings into RPM schema
 - icc-rpm: Add support for bus power domain
 - icc-rpm: Use NOC_QOS_MODE_INVALID for qos_mode check
 - icc-rpm: Define ICC device type
 - icc-rpm: Add QNOC type QoS support
 - icc-rpm: Support child NoC device probe
 - icc-rpm: Prevent integer overflow in rate
 - icc-rpmh: Add BCMs to commit list in pre_aggregate

Signed-off-by: Georgi Djakov <djakov@kernel.org>

----------------------------------------------------------------
Georgi Djakov (4):
      Merge branch 'icc-msm8996' into icc-next
      Merge branch 'icc-sc7280' into icc-next
      Merge branch 'icc-sm8450' into icc-next
      Merge branch 'icc-qcm2290' into icc-next

Mike Tipton (1):
      interconnect: qcom: icc-rpmh: Add BCMs to commit list in pre_aggregate

Odelu Kukatla (2):
      dt-bindings: interconnect: Add EPSS L3 DT binding on SC7280
      interconnect: qcom: Add EPSS L3 support on SC7280

Shawn Guo (6):
      interconnect: icc-rpm: Use NOC_QOS_MODE_INVALID for qos_mode check
      interconnect: icc-rpm: Define ICC device type
      interconnect: icc-rpm: Add QNOC type QoS support
      interconnect: icc-rpm: Support child NoC device probe
      dt-bindings: interconnect: Add Qualcomm QCM2290 NoC support
      interconnect: qcom: Add QCM2290 driver support

Stephan Gerhold (1):
      interconnect: qcom: rpm: Prevent integer overflow in rate

Vinod Koul (2):
      dt-bindings: interconnect: Add Qualcomm SM8450 DT bindings
      interconnect: qcom: Add SM8450 interconnect provider driver

Yassine Oudjana (4):
      dt-bindings: interconnect: Combine SDM660 bindings into RPM schema
      interconnect: icc-rpm: Add support for bus power domain
      dt-bindings: interconnect: Add Qualcomm MSM8996 DT bindings
      interconnect: qcom: Add MSM8996 interconnect provider driver

 .../devicetree/bindings/interconnect/qcom,osm-l3.yaml          |    1 +
 .../devicetree/bindings/interconnect/qcom,qcm2290.yaml         |  137 +
 Documentation/devicetree/bindings/interconnect/qcom,rpm.yaml   |  143 +-
 Documentation/devicetree/bindings/interconnect/qcom,rpmh.yaml  |   11 +
 .../devicetree/bindings/interconnect/qcom,sdm660.yaml          |  185 -
 drivers/interconnect/qcom/Kconfig                              |   27 +
 drivers/interconnect/qcom/Makefile                             |    6 +
 drivers/interconnect/qcom/icc-rpm.c                            |   64 +-
 drivers/interconnect/qcom/icc-rpm.h                            |   15 +-
 drivers/interconnect/qcom/icc-rpmh.c                           |   10 +-
 drivers/interconnect/qcom/msm8916.c                            |    4 +-
 drivers/interconnect/qcom/msm8939.c                            |    5 +-
 drivers/interconnect/qcom/msm8996.c                            | 2110 ++++++++
 drivers/interconnect/qcom/msm8996.h                            |  149 +
 drivers/interconnect/qcom/osm-l3.c                             |   20 +-
 drivers/interconnect/qcom/qcm2290.c                            | 1363 +++++
 drivers/interconnect/qcom/sc7280.h                             |    2 +
 drivers/interconnect/qcom/sdm660.c                             |    7 +-
 drivers/interconnect/qcom/sm8150.c                             |    1 -
 drivers/interconnect/qcom/sm8250.c                             |    1 -
 drivers/interconnect/qcom/sm8350.c                             |    1 -
 drivers/interconnect/qcom/sm8450.c                             | 1987 +++++++
 drivers/interconnect/qcom/sm8450.h                             |  169 +
 include/dt-bindings/interconnect/qcom,msm8996.h                |  163 +
 include/dt-bindings/interconnect/qcom,qcm2290.h                |   94 +
 include/dt-bindings/interconnect/qcom,sm8450.h                 |  171 +
 26 files changed, 6632 insertions(+), 214 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/interconnect/qcom,qcm2290.yaml
 delete mode 100644 Documentation/devicetree/bindings/interconnect/qcom,sdm660.yaml
 create mode 100644 drivers/interconnect/qcom/msm8996.c
 create mode 100644 drivers/interconnect/qcom/msm8996.h
 create mode 100644 drivers/interconnect/qcom/qcm2290.c
 create mode 100644 drivers/interconnect/qcom/sm8450.c
 create mode 100644 drivers/interconnect/qcom/sm8450.h
 create mode 100644 include/dt-bindings/interconnect/qcom,msm8996.h
 create mode 100644 include/dt-bindings/interconnect/qcom,qcm2290.h
 create mode 100644 include/dt-bindings/interconnect/qcom,sm8450.h
