Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 237D747AB21
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 15:16:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233546AbhLTOQn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 09:16:43 -0500
Received: from mail-m17643.qiye.163.com ([59.111.176.43]:42752 "EHLO
        mail-m17643.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233529AbhLTOQm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 09:16:42 -0500
DKIM-Signature: a=rsa-sha256;
        b=DeDq/yu7u6po/x4S4xCHZgkBaoW+kghwbEd0dng9Fmz8nspCUCcuRV3B3VvxFrkxNGtUibi4/fzXFn2rjlC+D9R4OtD2apEyNnHSU9LrJok4cBVXXGr5CA70Sw842GInduy8td07qnjRCcOWqFnEtIZLscppR5k+Xx2kYU7OMrE=;
        s=default; c=relaxed/relaxed; d=vivo.com; v=1;
        bh=E2HnN7muVKxpmTCLh2jsvhcb5yHu+6PjZo/+8Vrr9f0=;
        h=date:mime-version:subject:message-id:from;
Received: from vivo-600-G6.vivo.xyz (unknown [58.250.176.229])
        by mail-m17643.qiye.163.com (Hmail) with ESMTPA id 3F7A47E04E2;
        Mon, 20 Dec 2021 22:16:39 +0800 (CST)
From:   Yaqin Pan <akingchen@vivo.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Felipe Balbi <balbi@kernel.org>, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     kernel@vivo.com, Yaqin Pan <akingchen@vivo.com>
Subject: [PATCH v2 0/2] usb: dwc3: Add a quirk to set GUCTL.SPRSCTRLTRANSEN bit
Date:   Mon, 20 Dec 2021 22:16:27 +0800
Message-Id: <20211220141629.14282-1-akingchen@vivo.com>
X-Mailer: git-send-email 2.17.1
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgPGg8OCBgUHx5ZQUlOS1dZCBgUCR5ZQVlLVUtZV1
        kWDxoPAgseWUFZKDYvK1lXWShZQUhPN1dZLVlBSVdZDwkaFQgSH1lBWUJLSUlWThlMGk8dGE0dSU
        JJVRMBExYaEhckFA4PWVdZFhoPEhUdFFlBWVVLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6OT46SCo5Ez5IISoqLUpWMAMO
        MCgaFDJVSlVKTU9LS0tCTEJCTENPVTMWGhIXVRoQEhUcGBMeFTsNEg0UVRgUFkVZV1kSC1lBWU5D
        VUlOS1VKTE1VSUlCWVdZCAFZQUpPQkI3Bg++
X-HM-Tid: 0a7dd8339745d999kuws3f7a47e04e2
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a quirk to set dwc3 controller GUCTL.SPRSCTRLTRANSEN bit.

Changes in v2:
- modify Documentation/devicetree/bindings/usb/snps,dwc3.yaml

Yaqin Pan (2):
  usb: dwc3: Add a quirk to set GUCTL.SPRSCTRLTRANSEN bit.
  dt-bindings: usb: document snps,dis_split_quirk property in dwc3

 Documentation/devicetree/bindings/usb/snps,dwc3.yaml | 6 ++++++
 drivers/usb/dwc3/core.c                              | 4 ++++
 drivers/usb/dwc3/core.h                              | 3 +++
 3 files changed, 13 insertions(+)

-- 
2.17.1

