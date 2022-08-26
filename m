Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77B0D5A295F
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 16:26:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230258AbiHZO0E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 10:26:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343958AbiHZOZ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 10:25:56 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1DA233356;
        Fri, 26 Aug 2022 07:25:51 -0700 (PDT)
Received: from canpemm500009.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MDhpd5XTNzYcmQ;
        Fri, 26 Aug 2022 22:21:29 +0800 (CST)
Received: from CHINA (10.175.102.38) by canpemm500009.china.huawei.com
 (7.192.105.203) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 26 Aug
 2022 22:25:49 +0800
From:   Wei Yongjun <weiyongjun1@huawei.com>
To:     Mark Brown <broonie@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>
CC:     Wei Yongjun <weiyongjun1@huawei.com>,
        <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>
Subject: [PATCH -next 0/4] spi: Introduce BPF based SPI mockup controller
Date:   Fri, 26 Aug 2022 14:43:37 +0000
Message-ID: <20220826144341.532265-1-weiyongjun1@huawei.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.102.38]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 canpemm500009.china.huawei.com (7.192.105.203)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series Introduce a BPF based SPI mockup controller, which can be
used for testing SPI drivers without real device.

The testsuite for SPI drivers will be post in other series, with also
support for I2C and PCI bus device drivers.

patch 1-2 introduce BPF based SPI mockup controller
patch 3 interface for dynamically add devices from dts, may use
        of-configfs insead
patch 4 add the document

Wei Yongjun (4):
  spi: mockup: Add SPI controller testing driver
  spi: mockup: Add writeable tracepoint for spi transfer
  spi: mockup: Add runtime device tree overlay interface
  spi: mockup: Add documentation

 Documentation/spi/index.rst       |   1 +
 Documentation/spi/spi-mockup.rst  | 201 +++++++++++++++++++
 drivers/spi/Kconfig               |  15 ++
 drivers/spi/Makefile              |   1 +
 drivers/spi/spi-mockup.c          | 315 ++++++++++++++++++++++++++++++
 include/linux/spi/spi-mockup.h    |  13 ++
 include/trace/events/spi_mockup.h |  32 +++
 7 files changed, 578 insertions(+)
 create mode 100644 Documentation/spi/spi-mockup.rst
 create mode 100644 drivers/spi/spi-mockup.c
 create mode 100644 include/linux/spi/spi-mockup.h
 create mode 100644 include/trace/events/spi_mockup.h

-- 
2.34.1


