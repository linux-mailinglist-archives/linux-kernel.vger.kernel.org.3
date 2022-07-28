Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71982583F87
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 15:05:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238854AbiG1NFZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 09:05:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237806AbiG1NFV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 09:05:21 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E92E41D11;
        Thu, 28 Jul 2022 06:05:20 -0700 (PDT)
Received: from pyrite.rasen.tech (h175-177-042-159.catv02.itscom.jp [175.177.42.159])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id B245556D;
        Thu, 28 Jul 2022 15:05:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1659013518;
        bh=JEmOw0Vyk+XDbX3u+/p8dfRLUILJaGP7HXoicnF/1D0=;
        h=From:To:Cc:Subject:Date:From;
        b=DXcIO3rXXjb+r77sLtxhZqRYaIiJLPkJywLCFq4zEEqY73p+RYLB+VduC48swjD94
         rB+NU3cR0WDeP9uExu1Pfzkc5vwsMuVb7b0/cn9Ez3eTm/c9huFOF3Sn+Yr65jHYuE
         7zwF7PIi6hZepO8bVQNWHE651GRwdJY+1UqqFNoM=
From:   Paul Elder <paul.elder@ideasonboard.com>
To:     linux-media@vger.kernel.org
Cc:     Paul Elder <paul.elder@ideasonboard.com>,
        Dafna Hirschfeld <dafna@fastmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        laurent.pinchart@ideasonboard.com,
        linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] media: rkisp1: Add support for UYVY output
Date:   Thu, 28 Jul 2022 22:05:03 +0900
Message-Id: <20220728130505.2077842-1-paul.elder@ideasonboard.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
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
 .../platform/rockchip/rkisp1/rkisp1-common.h  |  2 +
 .../platform/rockchip/rkisp1/rkisp1-dev.c     |  3 +-
 3 files changed, 64 insertions(+), 8 deletions(-)

-- 
2.30.2

