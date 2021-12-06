Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B358E469684
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 14:13:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244133AbhLFNQp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 08:16:45 -0500
Received: from comms.puri.sm ([159.203.221.185]:47986 "EHLO comms.puri.sm"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244117AbhLFNQn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 08:16:43 -0500
Received: from localhost (localhost [127.0.0.1])
        by comms.puri.sm (Postfix) with ESMTP id 60523DF382;
        Mon,  6 Dec 2021 05:13:15 -0800 (PST)
Received: from comms.puri.sm ([127.0.0.1])
        by localhost (comms.puri.sm [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id gOByUN2D2aqJ; Mon,  6 Dec 2021 05:13:14 -0800 (PST)
From:   Martin Kepplinger <martin.kepplinger@puri.sm>
To:     slongerbeam@gmail.com, p.zabel@pengutronix.de, mchehab@kernel.org,
        laurent.pinchart@ideasonboard.com
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Martin Kepplinger <martin.kepplinger@puri.sm>
Subject: [PATCH v1 0/2] media: imx: imx8mq-mipi-csi2 fixes
Date:   Mon,  6 Dec 2021 14:12:40 +0100
Message-Id: <20211206131242.2697464-1-martin.kepplinger@puri.sm>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hi Laurent and all interested,

these are fixes for the imx8mq mipi controller driver I collected recently.

thank you very much for any review,

                            martin


Martin Kepplinger (2):
  media: imx: imx8mq-mipi-csi2: fix system resume issue
  media: imx: imx8mq-mipi-csi2: remove wrong irq config write operation

 drivers/staging/media/imx/imx8mq-mipi-csi2.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

-- 
2.30.2

