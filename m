Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A87B8511AD5
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 16:57:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238606AbiD0OuD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 10:50:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238520AbiD0Ot6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 10:49:58 -0400
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 721503A183;
        Wed, 27 Apr 2022 07:46:46 -0700 (PDT)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 23R8T6L7014829;
        Wed, 27 Apr 2022 07:46:42 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=pfpt0220; bh=UqUPPkmJkCbsaJC2V6XmXvkjVx+YtnCykDekvrhWXw8=;
 b=TLloaoNJ02yCigeY4fXTYH8NTnpSPyhJVLxdlBZ3S5uuVOXPQPIdQ0xDI5ylA++3P7Dd
 5KXuKBk/WCHFVyFtUJ/cXBdyvCic8t+/ZPFWugMCf/N2JgRkDVj7iq0HxtTWXliIPu0G
 G0VQHQi4VTNTSPlYqPCsi0ygJLHcB2FGvdmxkF8nUkw9xKwmu8h0483KbvdiWpW5ZxEA
 hUpoULyxzsd1X7tFOF84h8ZUcewEe6cUca9hfW5qI+shPEwMLg6a3q7EJW8scxMtSFkh
 c9XH2oFdVVugqjlsrjBvlDNlX0ShQ8FeIIAelbnxEbqSyNAkOGeHkP7rQb5QwVP1i5Pl wQ== 
Received: from dc5-exch02.marvell.com ([199.233.59.182])
        by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3fprt4k6t0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 27 Apr 2022 07:46:42 -0700
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Wed, 27 Apr
 2022 07:46:40 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.18 via Frontend
 Transport; Wed, 27 Apr 2022 07:46:40 -0700
Received: from localhost.localdomain (unknown [10.110.150.250])
        by maili.marvell.com (Postfix) with ESMTP id 7BE7A3F7063;
        Wed, 27 Apr 2022 07:46:40 -0700 (PDT)
From:   Piyush Malgujar <pmalgujar@marvell.com>
To:     <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC:     <linus.walleij@linaro.org>, <brgl@bgdev.pl>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <rric@kernel.org>,
        <cchavva@marvell.com>, <wsadowski@marvell.com>,
        Piyush Malgujar <pmalgujar@marvell.com>
Subject: [PATCH 0/5] gpio: thunderx: Marvell GPIO changes.
Date:   Wed, 27 Apr 2022 07:46:15 -0700
Message-ID: <20220427144620.9105-1-pmalgujar@marvell.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: zYjCPlVm0BEFxdrFQbHla2oPr1EjTQWi
X-Proofpoint-GUID: zYjCPlVm0BEFxdrFQbHla2oPr1EjTQWi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-27_04,2022-04-27_01,2022-02-23_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch includes the following changes:

- Using irqsave/irqrestore spinlock variants to avoid any potential
  deadlock in case of GPIO as IRQ
- Introducing a new device tree option 'pin-cfg' which can be used to setup
  mode of one or several GPIO pins. It can be used to choose pin's
  function, filtes, polarity and direction.
- Extending PIN_SEL_MASK to cover for otx2 platform
- In case of level irq, the current handle is not unmasking the GPIO
  interrupt, so using handle_level_irq, which will allow next interrupt
  to be handled.

All the changes have been internally verified on Marvell otx2 platforms.

Piyush Malgujar (5):
  gpio: thunderx: avoid potential deadlock
  dt-bindings: gpio: gpio-thunderx: Describe pin-cfg option
  gpio: thunderx: Configure GPIO pins at probe
  gpio: thunderx: extend PIN_SEL_MASK to cover otx2 platform
  gpio: thunderx: change handler for level interrupt

 .../bindings/gpio/gpio-thunderx.txt           |  4 ++
 drivers/gpio/gpio-thunderx.c                  | 53 +++++++++++++++----
 2 files changed, 47 insertions(+), 10 deletions(-)

-- 
2.17.1

