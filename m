Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 977E846F329
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 19:33:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243359AbhLISgp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 13:36:45 -0500
Received: from linux.microsoft.com ([13.77.154.182]:34000 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230204AbhLISgo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 13:36:44 -0500
Received: from thelio.attlocal.net (107-203-255-60.lightspeed.sntcca.sbcglobal.net [107.203.255.60])
        by linux.microsoft.com (Postfix) with ESMTPSA id 085B220B7179;
        Thu,  9 Dec 2021 10:33:10 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 085B220B7179
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1639074790;
        bh=UqyQ7i4LR6Zw04lsGzoktJR0My443juD1bbXPnDal5w=;
        h=From:To:Cc:Subject:Date:From;
        b=N4aN2ycYFULe5SM6Oyby11+tw15krbPKDp6QPcXrDTNUklxeFHdl6xWSyQuc44jhc
         MdFhXmfmGfd+v4m6qh5wovHc9X6AufVbcNakdKrIWPN2YV31Cr4HdTN082n1skSa+l
         5n7UVx5SoBx7GFhEW79RzvTYdF4CInuKUJ+e+d3Y=
From:   Katherine Perez <kaperez@linux.microsoft.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Felipe Balbi <balbi@kernel.org>,
        Konrad Dybcio <konradybcio@gmail.com>,
        Vinod Koul <vkoul@kernel.org>
Subject: [PATCH v4 0/1] arm64: dts: qcom: add support for Microsoft Surface Duo 2
Date:   Thu,  9 Dec 2021 10:32:45 -0800
Message-Id: <20211209183246.842880-1-kaperez@linux.microsoft.com>
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

