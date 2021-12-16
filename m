Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2C67476AA6
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 07:54:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234230AbhLPGy6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 01:54:58 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:37728 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbhLPGy5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 01:54:57 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4B72361C63;
        Thu, 16 Dec 2021 06:54:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E36F6C36AE5;
        Thu, 16 Dec 2021 06:54:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639637695;
        bh=Wj/t9web4ey2NI4eh1KobmSBrCKnyYqU9UKDsRQ/5OE=;
        h=From:To:Cc:Subject:Date:From;
        b=KjdL8eTKChshORjRmSUhbwh+Goi3enSnVS7D1K32jtbrCHKyEgzujaIxfPwWMHhtL
         pNhC0LYrLM5U+d27eIY9zkLoX1hS0AOKM6BzuARVCY/vnbW4f6ohMs9tGYALhNT7/o
         wBo2htBv5uBEL6mMrkmUea104Cot5uEG3/zllAoWdU3QXdZzcK9qcPRPWa7GU40Wrc
         hw7T8Tl07KiPfUkyL9Z7VcmSk5kj5CJO153/TnrZjv62ggp1GhtNttxbCjBRNwvi1r
         CBU9NfdEK3mBNbaXz/gC97Xwz278SP6RnTXZeA2dNE6c21zfOGhjFn8dnrA+xGbtS0
         TwmLQJ9P9QuqQ==
From:   Vinod Koul <vkoul@kernel.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] arm64: defconfig: Add SM8450 drivers
Date:   Thu, 16 Dec 2021 12:24:41 +0530
Message-Id: <20211216065444.650357-1-vkoul@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We recently added support for Qualcomm SM8450. Enable the clock, pincontrol
and interconnect drivers in the defconfig. All these driver are already
picked up by respective maintainers

Vinod Koul (3):
  arm64: defconfig: Add SM8450 GCC config
  arm64: defconfig: Add SM8450 pinctrl config
  arm64: defconfig: Add SM8450 icc configs

 arch/arm64/configs/defconfig | 3 +++
 1 file changed, 3 insertions(+)

-- 
2.31.1

