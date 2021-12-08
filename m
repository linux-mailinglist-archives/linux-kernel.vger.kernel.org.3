Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F12446D088
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 11:05:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230398AbhLHKJ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 05:09:28 -0500
Received: from twspam01.aspeedtech.com ([211.20.114.71]:60081 "EHLO
        twspam01.aspeedtech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbhLHKJ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 05:09:27 -0500
Received: from mail.aspeedtech.com ([192.168.0.24])
        by twspam01.aspeedtech.com with ESMTP id 1B89eqpL032351;
        Wed, 8 Dec 2021 17:40:52 +0800 (GMT-8)
        (envelope-from neal_liu@aspeedtech.com)
Received: from localhost.localdomain (192.168.10.10) by TWMBX02.aspeed.com
 (192.168.0.24) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 8 Dec
 2021 18:05:51 +0800
From:   Neal Liu <neal_liu@aspeedtech.com>
To:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Cai Huoqing <caihuoqing@baidu.com>,
        Tao Ren <rentao.bupt@gmail.com>,
        Julia Lawall <julia.lawall@inria.fr>,
        "kernel test robot" <lkp@intel.com>,
        Sasha Levin <sashal@kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-aspeed@lists.ozlabs.org>, <benh@kernel.crashing.org>
CC:     Neal Liu <neal_liu@aspeedtech.com>, <BMC-SW@aspeedtech.com>
Subject: [PATCH v3 0/4] Refactor Aspeed USB vhub driver
Date:   Wed, 8 Dec 2021 18:05:41 +0800
Message-ID: <20211208100545.1441397-1-neal_liu@aspeedtech.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [192.168.10.10]
X-ClientProxiedBy: TWMBX02.aspeed.com (192.168.0.24) To TWMBX02.aspeed.com
 (192.168.0.24)
X-DNSRBL: 
X-MAIL: twspam01.aspeedtech.com 1B89eqpL032351
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These patch series include 2 parts. One is adding more features
to pass USB30CV compliance test, the other is fixing hw issues.
More detail descriptions are included below patchsets.

Change since v2:
- Add more description in changelog.
- Fix remote wakeup issue patch and make it more configurable.

Change since v1:
- Remove unnecessary configs for SET_CONFIGURATION.
- Separate supporting test mode to new patch.

*** BLURB HERE ***

Neal Liu (4):
  usb: aspeed-vhub: add qualifier descriptor
  usb: aspeed-vhub: fix remote wakeup failure in iKVM use case
  usb: aspeed-vhub: fix ep0 OUT ack received wrong length issue
  usb: aspeed-vhub: support test mode feature

 drivers/usb/gadget/udc/aspeed-vhub/dev.c  | 19 +++++++--
 drivers/usb/gadget/udc/aspeed-vhub/ep0.c  |  7 ++++
 drivers/usb/gadget/udc/aspeed-vhub/epn.c  |  5 +++
 drivers/usb/gadget/udc/aspeed-vhub/hub.c  | 47 ++++++++++++++++++++---
 drivers/usb/gadget/udc/aspeed-vhub/vhub.h |  1 +
 5 files changed, 69 insertions(+), 10 deletions(-)

-- 
2.25.1

