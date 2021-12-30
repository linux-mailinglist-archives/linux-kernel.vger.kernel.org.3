Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5965481CBF
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 15:04:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239798AbhL3OEu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 09:04:50 -0500
Received: from mail-m17657.qiye.163.com ([59.111.176.57]:10712 "EHLO
        mail-m17657.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239756AbhL3OEq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 09:04:46 -0500
X-Greylist: delayed 333 seconds by postgrey-1.27 at vger.kernel.org; Thu, 30 Dec 2021 09:04:43 EST
DKIM-Signature: a=rsa-sha256;
        b=AbM4daWnIb2IIN88LOepWnOIEAtiHpSsrnp51Yc6kEG0cR3RmWcPsGGIC9x+EhJafzqcDfJ6ChXjc9zmdPIvxz/scuNQ4QZCNruMM+ekiKYKlkRNfNJBDmHWuCZ6Y8I0z/GKFjpGaoc2D4EarhdQLmF+dTbjeEH4XLsAPT6fsus=;
        s=default; c=relaxed/relaxed; d=vivo.com; v=1;
        bh=2Yp9DFSg8v3FvFJPhl/zrISfuB6wjKCS48VeStC+kds=;
        h=date:mime-version:subject:message-id:from;
Received: from vivo-600-G6.vivo.xyz (unknown [58.251.74.232])
        by mail-m17657.qiye.163.com (Hmail) with ESMTPA id D1F49280067;
        Thu, 30 Dec 2021 21:59:08 +0800 (CST)
From:   Yaqin Pan <akingchen@vivo.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Felipe Balbi <balbi@kernel.org>, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     kernel@vivo.com, Yaqin Pan <akingchen@vivo.com>
Subject: [PATCH v3 0/2] usb: dwc3: Add a quirk to set GUCTL.SPRSCTRLTRANSEN bit
Date:   Thu, 30 Dec 2021 21:58:29 +0800
Message-Id: <20211230135832.23005-1-akingchen@vivo.com>
X-Mailer: git-send-email 2.17.1
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgPGg8OCBgUHx5ZQUlOS1dZCBgUCR5ZQVlLVUtZV1
        kWDxoPAgseWUFZKDYvK1lXWShZQUhPN1dZLVlBSVdZDwkaFQgSH1lBWRofHkhWH0tMQxkdQ0oYGU
        hKVRMBExYaEhckFA4PWVdZFhoPEhUdFFlBWVVLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Pgg6Phw6TD5PCxEXCR8IHy4w
        AU9PCy1VSlVKTU9LQ0xJTE9CQ01DVTMWGhIXVRoQEhUcGBMeFTsNEg0UVRgUFkVZV1kSC1lBWU5D
        VUlOSlVMT1VJSElZV1kIAVlBSk5CTzcG
X-HM-Tid: 0a7e0ba3282fda03kuwsd1f49280067
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Sorry for the late reply.

Changes in v3:
modify Documentation/devicetree/bindings/usb/snps,dwc3.yaml
because the errors in dt-binding check.

Changes in v2:
modify Documentation/devicetree/bindings/usb/snps,dwc3.yaml

Yaqin Pan (2):
  usb: dwc3: Add a quirk to set GUCTL.SPRSCTRLTRANSEN bit.
  dt-bindings: usb: document snps,sprs-ctrl-trans-quirk property in dwc3

 Documentation/devicetree/bindings/usb/snps,dwc3.yaml | 6 ++++++
 drivers/usb/dwc3/core.c                              | 4 ++++
 drivers/usb/dwc3/core.h                              | 3 +++
 3 files changed, 13 insertions(+)

-- 
2.17.1

