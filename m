Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1CE346DF1E
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 00:51:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238210AbhLHXzY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 18:55:24 -0500
Received: from linux.microsoft.com ([13.77.154.182]:59190 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235293AbhLHXzX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 18:55:23 -0500
Received: from thelio.attlocal.net (107-203-255-60.lightspeed.sntcca.sbcglobal.net [107.203.255.60])
        by linux.microsoft.com (Postfix) with ESMTPSA id 70ED720B7179;
        Wed,  8 Dec 2021 15:51:50 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 70ED720B7179
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1639007510;
        bh=UqyQ7i4LR6Zw04lsGzoktJR0My443juD1bbXPnDal5w=;
        h=From:To:Cc:Subject:Date:From;
        b=TgJtS5oX6RnYAKw85PtIxUcJMewbv2/ZCST2bzSDfxGMTGJqpFvRqtOrD/ohJ7GDE
         LVimhSvQNIAiqjJET38cW69T9UjOkygdnxtIHS+dCIRz6elqa2u3rG2e5WCzQ4HNGe
         A4N/8LRxZAKtjSAIRhLeqgWpRZIdH5nc9SY05Gzk=
From:   Katherine Perez <kaperez@linux.microsoft.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Felipe Balbi <balbi@kernel.org>
Subject: [PATCH v3 0/1] arm64: dts: sm8350: add support for Microsoft Surface Duo 2
Date:   Wed,  8 Dec 2021 15:51:36 -0800
Message-Id: <20211208235137.2751003-1-kaperez@linux.microsoft.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add initial support for the Microsoft Surface Duo 2 based on the
sm8350-mtp DT.

Katherine Perez (1):
  arm64: dts: add minimal DTS for Microsoft Surface Duo2

 arch/arm64/boot/dts/qcom/Makefile             |   1 +
 .../qcom/sm8350-microsoft-surface-duo2.dts    | 369 ++++++++++++++++++
 2 files changed, 370 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/sm8350-microsoft-surface-duo2.dts

--
2.31.1

