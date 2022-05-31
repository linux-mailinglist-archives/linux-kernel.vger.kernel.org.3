Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A28F5394FA
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 18:31:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346164AbiEaQbA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 12:31:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244326AbiEaQa7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 12:30:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A20662BF9
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 09:30:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2593E60BA7
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 16:30:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91B0BC385A9;
        Tue, 31 May 2022 16:30:55 +0000 (UTC)
From:   Huacai Chen <chenhuacai@loongson.cn>
To:     Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <maz@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>,
        Huacai Chen <chenhuacai@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH V2 0/2] irqchip: Adjust to fix build for LoongArch
Date:   Wed,  1 Jun 2022 00:32:34 +0800
Message-Id: <20220531163236.2109556-1-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As suggested by Marc and Arnd, these two patches are the minimal changes
required on irqchip's side to make the LoongArch port build, without
introducing any non-reviewed pieces of code.

V1 -> V2:
Add a cover letter and fix commit message.

Huacai Chen:
 irqchip: Adjust Kconfig for Loongson.
 irqchip/loongson-liointc: Fix build error for LoongArch。

Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
 drivers/irqchip/Kconfig                | 10 +++++-----
 drivers/irqchip/irq-loongson-liointc.c |  6 +++++-
 2 files changed, 10 insertions(+), 6 deletions(-)
--
2.27.0

