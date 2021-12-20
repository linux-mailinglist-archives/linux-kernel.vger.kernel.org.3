Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D367C47A87B
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 12:19:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231642AbhLTLTX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 06:19:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231633AbhLTLTX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 06:19:23 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E269DC06173E;
        Mon, 20 Dec 2021 03:19:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 84ACB60FDD;
        Mon, 20 Dec 2021 11:19:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E28A0C36AE8;
        Mon, 20 Dec 2021 11:19:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639999161;
        bh=3DSyoLMiqIKiqjwMN/htAWvTm7cVAVrGS2EpGgIP6Pg=;
        h=From:To:Cc:Subject:Date:From;
        b=uB46tSGt7Vwl5j/7pi65+1YbO2pWqSJ1tEdCLqdTaMQy2CJgYRJqCOQ2kcfKyX2pU
         4ZhwSg+sOAUgWUw9cAigxIDVxaXwJg2Nu2k6ABTw9rID5ylgSIYs3A1S5RsJR7flrh
         zVbg2DqrsT1pYItaQnKVlmbxXxbOAHbh/crDd3GonVm/V1yY7GfukbfLwKEI1aOKml
         8Ukcjdtgxf7QVn68VOC5aLkEHHoXHmA+B9AGhji8bmEbxXcFFHfr+bp8H1uSz9Ifvw
         Ta3fvCU/xS/JyCozueoPkVUa3yS9NQKaj696i4++/Y0IT1fNBxF6dFT3sF5TdvKEuq
         cmrk3z25pavDw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1mzGhG-000638-Sy; Mon, 20 Dec 2021 12:19:14 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     Marc Ferland <ferlandm@amotus.ca>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] gnss: add USB support
Date:   Mon, 20 Dec 2021 12:18:59 +0100
Message-Id: <20211220111901.23206-1-johan@kernel.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds a generic driver for GNSS receivers with a USB
interface and a first device id for the Sierra Wireless XM1210 receiver.

Johan


Johan Hovold (2):
  gnss: add USB support
  gnss: usb: add support for Sierra Wireless XM1210

 drivers/gnss/Kconfig  |  11 +++
 drivers/gnss/Makefile |   3 +
 drivers/gnss/usb.c    | 210 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 224 insertions(+)
 create mode 100644 drivers/gnss/usb.c

-- 
2.32.0

