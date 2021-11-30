Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B379D4634FA
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 13:58:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233771AbhK3NB3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 08:01:29 -0500
Received: from alexa-out.qualcomm.com ([129.46.98.28]:37429 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230264AbhK3NBT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 08:01:19 -0500
Received: from ironmsg07-lv.qualcomm.com ([10.47.202.151])
  by alexa-out.qualcomm.com with ESMTP; 30 Nov 2021 04:58:00 -0800
X-QCInternal: smtphost
Received: from ironmsg01-blr.qualcomm.com ([10.86.208.130])
  by ironmsg07-lv.qualcomm.com with ESMTP/TLS/AES256-SHA; 30 Nov 2021 04:57:59 -0800
X-QCInternal: smtphost
Received: from ekangupt-linux.qualcomm.com ([10.204.67.11])
  by ironmsg01-blr.qualcomm.com with ESMTP; 30 Nov 2021 18:27:55 +0530
Received: by ekangupt-linux.qualcomm.com (Postfix, from userid 2319895)
        id 48F4B43AB; Tue, 30 Nov 2021 18:27:54 +0530 (IST)
From:   Jeya R <jeyr@codeaurora.org>
To:     linux-arm-msm@vger.kernel.org, srinivas.kandagatla@linaro.org
Cc:     Jeya R <jeyr@codeaurora.org>, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, fastrpc.upstream@qti.qualcomm.com,
        bkumar@qti.qualcomm.com, ekangupt@qti.qualcomm.com,
        jeyr@qti.qualcomm.com
Subject: [PATCH 0/3] Add vmid property and mapping attribute
Date:   Tue, 30 Nov 2021 18:27:47 +0530
Message-Id: <1638277072-6459-1-git-send-email-jeyr@codeaurora.org>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add virtual machine ID DT property which would be used to set up memory
protections for remote processor. Also add implementation to handle
mapping of invoke arguments with attribute.

Jeya R (3):
  dt-bindings: misc: add fastrpc domain vmid property
  misc: fastrpc: Read virtual machine IDs during probe
  misc: fastrpc: Handle mapping of invoke argument with attribute

 .../devicetree/bindings/misc/qcom,fastrpc.txt      |  78 ---------------
 .../devicetree/bindings/misc/qcom,fastrpc.yaml     | 109 +++++++++++++++++++++
 drivers/misc/fastrpc.c                             |  48 +++++++--
 include/uapi/misc/fastrpc.h                        |   5 +-
 4 files changed, 151 insertions(+), 89 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/misc/qcom,fastrpc.txt
 create mode 100644 Documentation/devicetree/bindings/misc/qcom,fastrpc.yaml

-- 
2.7.4

