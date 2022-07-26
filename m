Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBF1658101B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 11:41:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231477AbiGZJlL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 05:41:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231760AbiGZJlC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 05:41:02 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3F3822B1BB
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 02:41:01 -0700 (PDT)
Received: from localhost.localdomain (unknown [10.2.5.185])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9Dxv9Ghtt9i7Wk5AA--.17387S2;
        Tue, 26 Jul 2022 17:40:49 +0800 (CST)
From:   Bibo Mao <maobibo@loongson.cn>
To:     Huacai Chen <chenhuacai@kernel.org>
Cc:     WANG Xuerui <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] Remove clock setting during cpu hotplug stage
Date:   Tue, 26 Jul 2022 17:40:47 +0800
Message-Id: <20220726094049.7200-1-maobibo@loongson.cn>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf9Dxv9Ghtt9i7Wk5AA--.17387S2
X-Coremail-Antispam: 1UD129KBjvdXoW7XFykXrW3Zr4xCF4DAr1fZwb_yoWxZrg_Ja
        4xta4kGry7Jr43Kw1kXFnxJw4qyr18AFn8C3Z8t3y7Jryayr43Zw17Cws7Z34a9FW5Ars5
        Xw43K39xAr1ktjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUUUUUUU
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove clock setting during cpu hotplug stage and remove unused
some hardcoded address variables. And hardware address will be passed
in acpi table if exists.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---------
Changes since v1:
- Modify patch description and make it easier to understand.

Bibo Mao (2):
  LoongArch: Remove clock setting during cpu hotplug stage
  LoongArch: Remove unused variable

 arch/loongarch/include/asm/loongson.h | 12 -----------
 arch/loongarch/kernel/env.c           | 20 ------------------
 arch/loongarch/kernel/smp.c           | 29 ---------------------------
 include/linux/cpuhotplug.h            |  1 -
 4 files changed, 62 deletions(-)

-- 
2.31.1

