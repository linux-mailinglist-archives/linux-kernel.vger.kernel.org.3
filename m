Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAEC847B1FD
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 18:18:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240146AbhLTRS3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 12:18:29 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:50106 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233328AbhLTRS2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 12:18:28 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0286561250
        for <linux-kernel@vger.kernel.org>; Mon, 20 Dec 2021 17:18:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDBE7C36AE2;
        Mon, 20 Dec 2021 17:18:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640020707;
        bh=sSNfHTfJjn2otaO4uiaeX9OFSmqG0bSnNb+zEzAt0ow=;
        h=From:To:Cc:Subject:Date:From;
        b=e4PtLQ8cLZGVrQePE2tQa4jRiKw+0gDrrCzLWvvXX8mVIJ333edmdRQaLze3lTBA6
         HFYd+2iyiNRncNWLlXP/StOvMMyEKjGl+Q61X+utbVMevz9pFPqWxRgkO6dzYL5Eix
         9Md2PZLZKM73GSwdBJz7GY7bmNx228UJnyg6nmB2sd00Pnc/F87S4rSkIfCCeJRUIS
         5fZgaqb4yaJxQTDKxGBKe8EqnJAxslpRjepL9KVkuHHUnObJ5y72VjNtKTUu0D7Vkc
         4cRXd3XWPLz4kkhINTwshi5wym9jYPr+L+m2ckbP+v4FxdVv5W53QDYujQfDK2iXUz
         n1Cc/QkSv1RxQ==
From:   Mark Brown <broonie@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] regulator fixes for v5.16-rc6
Date:   Mon, 20 Dec 2021 17:18:11 +0000
Message-Id: <20211220171826.CDBE7C36AE2@smtp.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 6966df483d7b5b218aeb0e13e7e334a8fc3c1744:

  regulator: Update protection IRQ helper docs (2021-11-18 13:57:09 +0000)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-fix-v5.16-rc6

for you to fetch changes up to 85223d609c99eaa07cc598632b426cb33753526f:

  regulator: dt-bindings: samsung,s5m8767: add missing op_mode to bucks (2021-12-06 13:49:07 +0000)

----------------------------------------------------------------
regulator: Binding fix for v5.16

This fixes problems validating DT bindings using op_mode which wasn't
described as it should have been when converting to DT schema.

----------------------------------------------------------------
Krzysztof Kozlowski (1):
      regulator: dt-bindings: samsung,s5m8767: add missing op_mode to bucks

 .../bindings/regulator/samsung,s5m8767.yaml        | 25 ++++++++++++++++++++++
 1 file changed, 25 insertions(+)
