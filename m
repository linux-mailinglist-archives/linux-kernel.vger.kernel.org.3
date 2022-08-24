Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5FAD59F50F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 10:21:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235682AbiHXIV4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 04:21:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230293AbiHXIVj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 04:21:39 -0400
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0D8F8F975
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 01:21:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=k1; bh=QZSYy9ZOyYNn4Sbj+9d4hyd/rRC
        F0R9pMJ4odvD5koQ=; b=YjWlbqTLtYbUvEIgtlAow9FBUx0ubdew9ifp0+2omMx
        FhVJfSolrADooA0wev9GAqSeQvf0h1vL9Qw0sk6rhYMzYf8MEkeFpg5xZJ8w17Oc
        9zrhSfi3HRJ4MNe0KSQV6cuA7P9KPPtoejQ4CLkAHtfzSsk9WSW30CEEv2LvW2aQ
        =
Received: (qmail 2131763 invoked from network); 24 Aug 2022 10:21:31 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 24 Aug 2022 10:21:31 +0200
X-UD-Smtp-Session: l3s3148p1@jehDXvjm1OcgAwDPXxw3AFlguiwjsjwa
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-spi@vger.kernel.org
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: [PATCH 0/2] spi: remove "spidev" nodes from DTs
Date:   Wed, 24 Aug 2022 10:21:27 +0200
Message-Id: <20220824082130.21934-1-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There were two DTs left specifying "spidev" directly. Remove them.

Wolfram Sang (2):
  ARM: dts: stm32: argon: remove spidev node
  powerpc/82xx: remove spidev node from mgcoge

 arch/arm/boot/dts/stm32mp157c-emstamp-argon.dtsi | 6 ------
 arch/powerpc/boot/dts/mgcoge.dts                 | 7 -------
 2 files changed, 13 deletions(-)

-- 
2.35.1

