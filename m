Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DCC54810ED
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Dec 2021 09:27:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239308AbhL2I1j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Dec 2021 03:27:39 -0500
Received: from esa.microchip.iphmx.com ([68.232.154.123]:41711 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239286AbhL2I1i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Dec 2021 03:27:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1640766459; x=1672302459;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dk65/TNZb+6FwOTLi3tG/ia/WxkE3ieWpYa+bJxvILk=;
  b=Wc508OCht1XGg98Dn9IN1UkjvhxjIKaCRwLIJwMlnukqfyPkNlft2FbZ
   W8403G3g5omJSqrkV6+PyZB890mbZDnpv+KLinUY+cbOgC4gTzUehVwTu
   orvVTYMzqCf5oVw1TJQ8GmBdKggEAmOR8tAGJ2Hi4GNi+AH8rJVTqQgPw
   Gghs0o/CiEclKfaDYjkWzgdk0+N+WNxHzsapnaLdcr2LlnIBcuogJeTEy
   AVQSNJivAkZAnbbleSsuFXFbLpI+P31codXQnHSX/3khbF3jN022bV7M+
   wb+jeyHw1GGYsKy0qbYqAqSIDgv2oM/vhwypATjiqEwkU56VShbcWWVxL
   g==;
IronPort-SDR: LXWq6CAI2IOvWTkQXpJMKWP1KJeD/SNEnbVRwuG/QSRD4CsIBeagQlpjP5hMQDoqqHa4devtVe
 uPTu2y3Q5SPFLrjsa+6s7oQI6C63Xbragmlz6iJzC1K/OT+N82eOjZNsIdDbHC5Z5ThhbMdOOj
 PetKMb8YWV/jWFw5br0B3GTJ8byLxHE62n9mNLOP6VcLv3vfSLaeLPuO26pRGN2Rqk/5GGUl32
 ACxiaV2zhoT421FIGDugNoO/vdlFc/vKXEF3PBn2q2xy4UQK/Hj54Y5/brqJVH4iuo8C9VUhe8
 WNULk2bLgaoccMjc7wnww0Fg
X-IronPort-AV: E=Sophos;i="5.88,244,1635231600"; 
   d="scan'208";a="143787647"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 29 Dec 2021 01:27:38 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Wed, 29 Dec 2021 01:27:37 -0700
Received: from ROB-ULT-M18064N.mchp-main.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Wed, 29 Dec 2021 01:27:33 -0700
From:   Tudor Ambarus <tudor.ambarus@microchip.com>
To:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        <zhuohao@chromium.org>, <richard@nod.at>,
        <miquel.raynal@bootlin.com>, <p.yadav@ti.com>, <vigneshr@ti.com>,
        <michael@walle.cc>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: (subset) [PATCH 0/2] mtd: core: Remove partid and partname debugfs files
Date:   Wed, 29 Dec 2021 10:27:31 +0200
Message-ID: <164076623215.10805.7001463971424800594.b4-ty@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211217122636.474976-1-tudor.ambarus@microchip.com>
References: <20211217122636.474976-1-tudor.ambarus@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Dec 2021 14:26:34 +0200, Tudor Ambarus wrote:
> SPI NOR has equivalent sysfs device attributes, thus let's remove the
> duplicated debugfs entries. There's no one else using partid and partname
> debugfs files, thus remove them from the mtd core as well.
> 
> If you find the idea acceptable, I would like to queue these through
> spi-nor/next, I'll have some other patches that will depend on these.
> 
> [...]

Applied to spi-nor/next, thanks!

[1/2] mtd: spi-nor: Remove debugfs entries that duplicate sysfs entries
      https://git.kernel.org/mtd/c/5f340402bbfc

Best regards,
-- 
Tudor Ambarus <tudor.ambarus@microchip.com>
