Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AAED5862E7
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 05:03:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239484AbiHADDO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jul 2022 23:03:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239304AbiHADDL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jul 2022 23:03:11 -0400
X-Greylist: delayed 188 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 31 Jul 2022 20:03:08 PDT
Received: from n169-114.mail.139.com (n169-114.mail.139.com [120.232.169.114])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13F5D9FDD
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jul 2022 20:03:08 -0700 (PDT)
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM:                                                                                        
X-RM-SPAM-FLAG: 00000000
Received: from localhost.localdomain (unknown[101.84.184.69])
        by rmsmtp-lg-appmail-40-12054 (RichMail) with SMTP id 2f1662e741abbf1-45039;
        Mon, 01 Aug 2022 10:59:57 +0800 (CST)
X-RM-TRANSID: 2f1662e741abbf1-45039
From:   Kevin Lu <luminlong@139.com>
To:     broonie@kernel.org
Cc:     linux-kernel@vger.kernel.org, shenghao-ding@ti.com,
        kevin-lu@ti.com, Kevin Lu <luminlong@139.com>
Subject: [PATCH v1 0/1]
Date:   Mon,  1 Aug 2022 10:59:38 +0800
Message-Id: <20220801025939.2343-1-luminlong@139.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=0.0 required=5.0 tests=BAYES_20,FREEMAIL_FROM,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

*** BLURB HERE ***

Kevin Lu (1):
  Add a new kcontrol for phase calib, remove unnecessary header file,
    make code more comply with linux coding style

-- 
2.17.1


