Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E51E486D55
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 23:44:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245246AbiAFWoL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 17:44:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245188AbiAFWoJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 17:44:09 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44AA3C061201
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jan 2022 14:44:09 -0800 (PST)
Received: from pendragon.lan (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 4129F11FE;
        Thu,  6 Jan 2022 23:44:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1641509046;
        bh=tnhVWFiHwTR3KNZERwGyfcgsBbhXVfpieZFa8Sbx7OA=;
        h=From:To:Cc:Subject:Date:From;
        b=YU846UDNbcT+ErFTXqHyVYSNIxIYmFmE5pvQ+sSDcZpH795A5Jrp45v82PuU9tVLw
         +OTwKuRniHf43qnDf0OFPG6MUhLMRS+hlAWHHR2/aRBQRGHHQYCJGjKD8SptbiZFVo
         /HEkb9CA54WssP/w2Gr1i4KeJuOCMsMNu2Ho8hYA=
From:   Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
To:     linux-kernel@vger.kernel.org
Cc:     Watson Chow <watson.chow@avnet.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: [PATCH v2 0/2] regulator: Add driver for Maxim MAX20086-MAX20089
Date:   Fri,  7 Jan 2022 00:43:48 +0200
Message-Id: <20220106224350.16957-1-laurent.pinchart+renesas@ideasonboard.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

Hello,

This small series adds a new driver (along with DT bindings) for the
Maxim MAX20086-MAX20089 camera power protectors.

Compared to v1, this version takes all review comments into account
(assuming I've understood them correctly :-)).

The code originates from initial work done by Avnet, which I have
reworked extensively. Watson, I've kept your authorship on patch 2/2.
Would you like to be listed as a maintainer for the driver and the DT
bindings ?

Laurent Pinchart (1):
  dt-bindings: regulators: Add bindings for Maxim MAX20086-MAX20089

Watson Chow (1):
  regulator: Add MAX20086-MAX20089 driver

 .../bindings/regulator/maxim,max20086.yaml    | 106 ++++++
 MAINTAINERS                                   |   7 +
 drivers/regulator/Kconfig                     |  10 +-
 drivers/regulator/Makefile                    |   1 +
 drivers/regulator/max20086-regulator.c        | 332 ++++++++++++++++++
 5 files changed, 455 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/regulator/maxim,max20086.yaml
 create mode 100644 drivers/regulator/max20086-regulator.c

-- 
Regards,

Laurent Pinchart

