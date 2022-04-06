Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6E154F5E03
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 14:46:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233075AbiDFMY2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 08:24:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233802AbiDFMXA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 08:23:00 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 89FCD31BBB6;
        Wed,  6 Apr 2022 01:11:57 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0ACF823A;
        Wed,  6 Apr 2022 01:11:57 -0700 (PDT)
Received: from e122247.kfn.arm.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5F8363F718;
        Wed,  6 Apr 2022 01:11:55 -0700 (PDT)
From:   Gilad Ben-Yossef <gilad@benyossef.com>
To:     Gilad Ben-Yossef <gilad@benyossef.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>
Cc:     Cristian Marussi <cristian.marussi@arm.com>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] crypto: ccree: fixes and improvements
Date:   Wed,  6 Apr 2022 11:11:37 +0300
Message-Id: <20220406081139.1963615-1-gilad@benyossef.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A small fix for a rare registration time and a minor improvment

Gilad Ben-Yossef (2):
  crypto: ccree: rearrange init calls to avoid race
  crypto: ccree: use fine grained DMA mapping dir

 drivers/crypto/ccree/cc_buffer_mgr.c | 27 +++++++++++++++------------
 drivers/crypto/ccree/cc_driver.c     | 24 +++++++++++++-----------
 2 files changed, 28 insertions(+), 23 deletions(-)

-- 
2.25.1

