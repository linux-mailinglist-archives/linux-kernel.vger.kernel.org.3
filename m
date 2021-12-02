Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FD54465E12
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 07:12:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355681AbhLBGPe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 01:15:34 -0500
Received: from mail.pr-group.ru ([178.18.215.3]:50154 "EHLO mail.pr-group.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344972AbhLBGPc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 01:15:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
        d=metrotek.ru; s=mail;
        h=from:subject:date:message-id:to:cc:mime-version:content-transfer-encoding;
        bh=7M5/+ZjFpJFZ7JNVxf3J1RcU8/cym02LNFv156Yi9Uw=;
        b=dmjdo1DWaUkpG6IovUMXn+aX4QSKlQi4KOhQ15qGjqyKPwpbwGaNc6Q995/Sc++WBk7iNKli38YWy
         j6UNtKY3288GbczZNhtt4ZevlrzIZUUbmRXFFejAfx3vHIom3SyagxMQ9yejaC2UdyurTotz/SbnRt
         Irr+L8N7tjJ0YCcoNpl8K1Uvy7eSGBHK/XbR2xa7sbmrB7BxsBPgnwkD6LgDsr+qovGx/irHY8w7zi
         djpQt+ld8tMu0MNc7OuwYrYzlXprZVVeq7xGX3aLD9OJbRjqW4E/ENXjThRQNEkbm6maCTI8Dzx0xA
         auwKRDQa6cSf6R9thoCNFqn9Lmvmshg==
X-Spam-Status: No, hits=0.0 required=3.4
        tests=AWL: -0.416, BAYES_00: -1.665, CUSTOM_RULE_FROM: ALLOW,
        TOTAL_SCORE: -2.081,autolearn=ham
X-Spam-Level: 
X-Footer: bWV0cm90ZWsucnU=
Received: from localhost.localdomain ([178.70.66.234])
        (authenticated user i.bornyakov@metrotek.ru)
        by mail.pr-group.ru with ESMTPSA
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256 bits));
        Thu, 2 Dec 2021 09:11:55 +0300
From:   Ivan Bornyakov <i.bornyakov@metrotek.ru>
Cc:     Ivan Bornyakov <i.bornyakov@metrotek.ru>, system@metrotek.ru,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v3 0/2] bus: imx-weim: optionally enable continuous burst clock
Date:   Thu,  2 Dec 2021 08:57:22 +0300
Message-Id: <20211202055724.4416-1-i.bornyakov@metrotek.ru>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce option to enable continuous burst clock, if burst clock itself
is enabled.

Changelog:
  v1 -> v2:
    * documentation about this option added to
      Documentation/devicetree/bindings/bus/imx-weim.txt
  v2 -> v3:
    * added missing Signed-off-by line


Ivan Bornyakov (2):
  bus: imx-weim: optionally enable continuous burst clock
  dt-bindings: bus: imx-weim: add words about continuous bclk

 .../devicetree/bindings/bus/imx-weim.txt       |  5 +++++
 drivers/bus/imx-weim.c                         | 18 ++++++++++++++++--
 2 files changed, 21 insertions(+), 2 deletions(-)

-- 
2.32.0


