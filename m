Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18C3B58B918
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Aug 2022 05:41:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230473AbiHGDlO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Aug 2022 23:41:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiHGDlL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Aug 2022 23:41:11 -0400
Received: from n169-112.mail.139.com (n169-112.mail.139.com [120.232.169.112])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40F48CE1B
        for <linux-kernel@vger.kernel.org>; Sat,  6 Aug 2022 20:41:08 -0700 (PDT)
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM:                                                                                        
X-RM-SPAM-FLAG: 00000000
Received: from localhost.localdomain (unknown[61.152.201.158])
        by rmsmtp-lg-appmail-20-12023 (RichMail) with SMTP id 2ef762ef344d672-8c4ae;
        Sun, 07 Aug 2022 11:41:04 +0800 (CST)
X-RM-TRANSID: 2ef762ef344d672-8c4ae
From:   Kevin Lu <luminlong@139.com>
To:     broonie@kernel.org
Cc:     linux-kernel@vger.kernel.org, shenghao-ding@ti.com,
        kevin-lu@ti.com, Kevin Lu <luminlong@139.com>
Subject: [PATCH v1 0/1]
Date:   Sun,  7 Aug 2022 11:40:51 +0800
Message-Id: <20220807034052.2314-1-luminlong@139.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

*** BLURB HERE ***

Kevin Lu (1):
  drivers: Modify some parts

 tlv320adcx140.c | 114 ++++++++++++++++++++++++++++++++++++------------
 tlv320adcx140.h |   7 +--
 2 files changed, 90 insertions(+), 31 deletions(-)

-- 
2.17.1


