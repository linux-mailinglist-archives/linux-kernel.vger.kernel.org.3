Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29F924FE807
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 20:30:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358717AbiDLSdF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 14:33:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358692AbiDLScb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 14:32:31 -0400
Received: from out28-195.mail.aliyun.com (out28-195.mail.aliyun.com [115.124.28.195])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E74B4DF7B;
        Tue, 12 Apr 2022 11:30:10 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.4200453|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.00985243-0.00141626-0.988731;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047211;MF=zhouyanjie@wanyeetech.com;NM=1;PH=DS;RN=16;RT=16;SR=0;TI=SMTPD_---.NPNg.gm_1649788202;
Received: from zhouyanjie-virtual-machine.localdomain(mailfrom:zhouyanjie@wanyeetech.com fp:SMTPD_---.NPNg.gm_1649788202)
          by smtp.aliyun-inc.com(33.37.68.114);
          Wed, 13 Apr 2022 02:30:08 +0800
From:   =?UTF-8?q?=E5=91=A8=E7=90=B0=E6=9D=B0=20=28Zhou=20Yanjie=29?= 
        <zhouyanjie@wanyeetech.com>
To:     gregkh@linuxfoundation.org, hminas@synopsys.com,
        robh+dt@kernel.org, krzk+dt@kernel.org
Cc:     linux-usb@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        dragancecavac@yahoo.com, hns@goldelico.com,
        dongsheng.qiu@ingenic.com, aric.pzqi@ingenic.com,
        rick.tyliu@ingenic.com, sernia.zhou@foxmail.com,
        zhenwenjin@gmail.com, reimu@sudomaker.com
Subject: [PATCH v2 0/2] Add OTG support for Ingenic SoCs.
Date:   Wed, 13 Apr 2022 02:29:59 +0800
Message-Id: <1649788201-87620-1-git-send-email-zhouyanjie@wanyeetech.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

1.Add OTG support for the JZ4775 SoC, the JZ4780 SoC, the X1000
  SoC, the X1600 SoC, the X1700 SoC, the X1830 SoC, and the
  X2000 SoC.
2.Introduce support for disable Ingenic overcurrent detection,
  once selected it enables GOTGCTL register bits VbvalidOvEn
  and VbvalidOvVal to disable the VBUS overcurrent detection.

v1->v2:
1.Add Rob Herring's Acked-by.
2.Add Minas Harutyunyan's Acked-by.
3.Use "activate_ingenic_overcurrent_detection" instead
  "deactivate_ingenic_overcurrent_detection" as Greg's suggestion.

周琰杰 (Zhou Yanjie) (2):
  dt-bindings: dwc2: Add bindings for new Ingenic SoCs.
  USB: dwc2: Add OTG support for Ingenic SoCs.

 Documentation/devicetree/bindings/usb/dwc2.yaml |  7 ++++
 drivers/usb/dwc2/core.c                         |  9 +++++
 drivers/usb/dwc2/core.h                         |  5 +++
 drivers/usb/dwc2/params.c                       | 50 ++++++++++++++++++++++++-
 4 files changed, 70 insertions(+), 1 deletion(-)

-- 
2.7.4

