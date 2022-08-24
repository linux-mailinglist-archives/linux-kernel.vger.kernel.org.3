Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8DBF59F7F0
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 12:40:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236333AbiHXKkK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 06:40:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbiHXKkH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 06:40:07 -0400
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 488D980F53;
        Wed, 24 Aug 2022 03:40:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1661337605;
  x=1692873605;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Iypsk2nUhwC8TO4v5fBXUx+BdnnNPe5g43NWMsHJBl8=;
  b=PKILT9gqDl2eXAhV/o+dFIKtSkGhGPxIrgyJAH93Ayz+4gulCBif9KGv
   ZuJrfGkkJS594/8MOW85QZ8z01BA3w92VMfzdO9N+Q3wrJ9vhCSUbqbwz
   oHrZHD9oYkChutj0xL1NiU+Hp2R1uL/mx89AJvoO4PH8F+5kwuqrTo5LY
   LDTUMzO9foo2lJ330x48goAn5jshofoxe0qMOISOhwJUQWLqia86xPRNY
   TRI/7MTLDcpFxhOH5/IVCcLHz7Sw1W8kZDHq+5J/Ut1y17oNtF0SSlVJp
   AvVQKR1MS+T58m8wbnkIQvOGH8Kj43Vss+itzLey+C3MVsrHK4qTmNMHD
   w==;
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
To:     <jic23@kernel.org>
CC:     <kernel@axis.com>, <lars@metafoo.de>, <axel.jonsson@axis.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/2] iio: adc: mcp320x: Add triggered buffer support
Date:   Wed, 24 Aug 2022 12:40:00 +0200
Message-ID: <20220824104002.2749075-1-vincent.whitchurch@axis.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds triggered buffer support to the mcp320x ADC driver.  Tested on
MCP3008.

Cc: linux-iio@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

Axel Jonsson (1):
  iio: adc: mcp320x: add triggered buffer support

Vincent Whitchurch (1):
  iio: adc: mcp320x: use device managed functions

 drivers/iio/adc/Kconfig   |   2 +
 drivers/iio/adc/mcp320x.c | 158 +++++++++++++++++++++++++-------------
 2 files changed, 108 insertions(+), 52 deletions(-)

-- 
2.34.1

