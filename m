Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 196A6574BF6
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 13:26:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238786AbiGNL0p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 07:26:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238808AbiGNL0a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 07:26:30 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C01411A3D;
        Thu, 14 Jul 2022 04:26:25 -0700 (PDT)
Received: from pyrite.rasen.tech (softbank036240121080.bbtec.net [36.240.121.80])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 53808383;
        Thu, 14 Jul 2022 13:26:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1657797983;
        bh=AQ3cDfs5mqD5D2ZbUTNaZ5y1z0ye9T8PPhXg0VIIDWw=;
        h=From:To:Cc:Subject:Date:From;
        b=nupsxWef+p9mFvJUVCdSBTVCVUME6cmFvHmr8GyJvai4My0K4IXHbYmmFMTAn13DW
         zXKoUrAuB5QRBEvysWTB31b/YLAXqXY7ackzYJFPevgvq/rQ/mkBj67/FydnMgqTcJ
         RxLh0p2+OGLjvWkqH+kA8QEsEIBtwJ+1y7wW0ZKw=
From:   Paul Elder <paul.elder@ideasonboard.com>
To:     linux-media@vger.kernel.org
Cc:     Paul Elder <paul.elder@ideasonboard.com>,
        Dafna Hirschfeld <dafna@fastmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        laurent.pinchart@ideasonboard.com,
        linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] media: rkisp1: Add support for UYVY output
Date:   Thu, 14 Jul 2022 20:26:01 +0900
Message-Id: <20220714112603.1117335-1-paul.elder@ideasonboard.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds support for UYVY as an output format in the rkisp1
driver, for devices that support it. Notably, the i.MX8MP supports it,
while the rk3399 does not.

This series is based on branch pinchartl/v5.19/isp/1 [1] at this repo [2].

[1] https://gitlab.com/ideasonboard/nxp/linux/-/commits/pinchartl/v5.19/isp/1
[2] https://gitlab.com/ideasonboard/nxp/linux

Paul Elder (2):
  media: rkisp1: Add YC swap capability
  media: rkisp1: Add UYVY as an output format

 .../platform/rockchip/rkisp1/rkisp1-capture.c | 67 +++++++++++++++++--
 .../platform/rockchip/rkisp1/rkisp1-common.h  |  1 +
 .../platform/rockchip/rkisp1/rkisp1-dev.c     |  3 +-
 3 files changed, 63 insertions(+), 8 deletions(-)

-- 
2.30.2

