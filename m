Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6D30482CC5
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jan 2022 22:11:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229939AbiABVLe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jan 2022 16:11:34 -0500
Received: from perceval.ideasonboard.com ([213.167.242.64]:47652 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229883AbiABVLd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jan 2022 16:11:33 -0500
Received: from pendragon.lan (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id DAB39CC;
        Sun,  2 Jan 2022 22:11:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1641157892;
        bh=lse+7FTJOz/5FE8rNz7AXR2ETfwRFAkZBTr1JuWKb24=;
        h=From:To:Cc:Subject:Date:From;
        b=Y9C6XNpR/+cMVSojB07vG/eH9PEQl9bAUrQ/o212l9fqijiGGWcwwfGY4zjQkjA0M
         0LIpSflwfQm33+15xKqtcZndhrEaAacaZFoGoyKhM0pOfRUDEWEOMjyWzZdfb+wXQ4
         fjc+uMcCqVMLKAKexPAJcCpPNSfyWJoa0QnMthjI=
From:   Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
To:     linux-kernel@vger.kernel.org
Cc:     Watson Chow <watson.chow@avnet.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH 0/2] regulator: Add driver for Maxim MAX20086-MAX20089
Date:   Sun,  2 Jan 2022 23:11:22 +0200
Message-Id: <20220102211124.18435-1-laurent.pinchart+renesas@ideasonboard.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This small series adds a new driver (along with DT bindings) for the
Maxim MAX20086-MAX20089 camera power protectors.

The code originates from initial work done by Avnet, which I have
reworked extensively. Watson, I've kept your authorship on patch 2/2.
Would you like to be listed as a maintainer for the driver and the DT
bindings ?

Laurent Pinchart (1):
  dt-bindings: regulators: Add bindings for Maxim MAX20086-MAX20089

Watson Chow (1):
  regulator: Add MAX20086-MAX20089 driver

 .../bindings/regulator/maxim,max20086.yaml    | 116 ++++++
 MAINTAINERS                                   |   7 +
 drivers/regulator/Kconfig                     |  10 +-
 drivers/regulator/Makefile                    |   1 +
 drivers/regulator/max20086-regulator.c        | 333 ++++++++++++++++++
 5 files changed, 466 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/regulator/maxim,max20086.yaml
 create mode 100644 drivers/regulator/max20086-regulator.c

-- 
Regards,

Laurent Pinchart

