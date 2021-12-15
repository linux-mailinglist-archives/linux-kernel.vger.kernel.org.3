Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0DB4475941
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 14:03:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237328AbhLONDk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 08:03:40 -0500
Received: from mail-m17643.qiye.163.com ([59.111.176.43]:17314 "EHLO
        mail-m17643.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbhLONDk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 08:03:40 -0500
DKIM-Signature: a=rsa-sha256;
        b=UURVgkmk81EbQ3curSqoWOOSg4Hw2MU30H9YcKdix4PfJCvaN8OiRt8fbxbWYlEPA8LtOIaoNYeSTE8jyuZ9DnkMJSGqG9UsKHlhTG/A+zcl/BVQpDFKrwKJmDpwK4NTIrQ9tgoBZOS4MwdkK1AKGmm1KeuZNsiCLy5r8VILMmE=;
        s=default; c=relaxed/relaxed; d=vivo.com; v=1;
        bh=5YU14A/bhXwJu+stiA5csZZAQPyageN2gV1IIQgT9hY=;
        h=date:mime-version:subject:message-id:from;
Received: from vivo-600-G6.vivo.xyz (unknown [58.251.74.232])
        by mail-m17643.qiye.163.com (Hmail) with ESMTPA id E3D627E01E1;
        Wed, 15 Dec 2021 21:03:35 +0800 (CST)
From:   Yaqin Pan <akingchen@vivo.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Felipe Balbi <balbi@kernel.org>, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     kernel@vivo.com, Yaqin Pan <akingchen@vivo.com>
Subject: [PATCH 0/2] usb: dwc3: Add a quirk to set GUCTL.SPRSCTRLTRANSEN bit
Date:   Wed, 15 Dec 2021 21:03:22 +0800
Message-Id: <20211215130325.19017-1-akingchen@vivo.com>
X-Mailer: git-send-email 2.17.1
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgPGg8OCBgUHx5ZQUlOS1dZCBgUCR5ZQVlLVUtZV1
        kWDxoPAgseWUFZKDYvK1lXWShZQUhPN1dZLVlBSVdZDwkaFQgSH1lBWRkZGB5WSB1KShgaTEJPQk
        MaVRMBExYaEhckFA4PWVdZFhoPEhUdFFlBWVVLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PCI6Kjo6HT5MOTI2MRwyHEkX
        IToaCx9VSlVKTUhCTkxIT0pNTU1CVTMWGhIXVRoQEhUcGBMeFTsNEg0UVRgUFkVZV1kSC1lBWU5D
        VUlOSlVMT1VJSElZV1kIAVlBSk9KSTcG
X-HM-Tid: 0a7dbe30e984d999kuwse3d627e01e1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a quirk to set dwc3 controller GUCTL.SPRSCTRLTRANSEN bit.

Yaqin Pan (2):
  usb: dwc3: Add a quirk to set GUCTL.SPRSCTRLTRANSEN bit.
  dt-bindings: usb: document snps,dis_split_quirk property in dwc3

 Documentation/devicetree/bindings/usb/snps,dwc3.yaml | 6 ++++++
 drivers/usb/dwc3/core.c                              | 4 ++++
 drivers/usb/dwc3/core.h                              | 3 +++
 3 files changed, 13 insertions(+)

-- 
2.17.1

