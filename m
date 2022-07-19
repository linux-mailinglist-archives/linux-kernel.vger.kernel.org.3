Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A81A5794A9
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 09:57:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237037AbiGSH4u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 03:56:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236889AbiGSH4n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 03:56:43 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB4CA18E18
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 00:56:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1658217402; x=1689753402;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kPn+jVbdHDbOQa9qOPTliLwITlhniYkXD6SqjIgKME0=;
  b=YQ4sbmud/zNRJwBsdeWsFv+gF+cnKA/w1oMC9TU7h2kDVRCbRMmtrMXR
   k36GcMAtby98iR8DuAC57MN9+/fjQD4yjDVB/imCCyup+iYz0EbpSC2NW
   P/LiMf0sQi8JgZ2q3rpD+1gVFjJVlYB+ir9mxaAMfDFnxNUNawmpkMPcu
   vuAfpD5reXeqNjn4UzBtQ91Xl5I4sRr2ElMEpwLZhbEuwYMKiu2a4WhrJ
   auWw+XXauTs+RSg4kpSqwd0S4lETe9FEdu6nUol+IsGSBbUQObKgI7lpm
   j/kFejauJDiPwcmszdru61qMKsImsoxuYP0wr7vMvk60hlX+nj8BEbyrU
   g==;
X-IronPort-AV: E=Sophos;i="5.92,283,1650956400"; 
   d="scan'208";a="165362018"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 19 Jul 2022 00:56:42 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Tue, 19 Jul 2022 00:56:42 -0700
Received: from ROB-ULT-M18064N.mchp-main.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Tue, 19 Jul 2022 00:56:39 -0700
From:   Tudor Ambarus <tudor.ambarus@microchip.com>
To:     <p.yadav@ti.com>
CC:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        <linux-kernel@vger.kernel.org>, <richard@nod.at>,
        <michael@walle.cc>, <vigneshr@ti.com>,
        <linux-mtd@lists.infradead.org>, <miquel.raynal@bootlin.com>
Subject: Re: [PATCH] MAINTAINERS: Use my kernel.org email
Date:   Tue, 19 Jul 2022 10:56:37 +0300
Message-ID: <165821627887.113797.8074554472699520278.b4-ty@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220718151243.1149442-1-p.yadav@ti.com>
References: <20220718151243.1149442-1-p.yadav@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Jul 2022 20:42:43 +0530, Pratyush Yadav wrote:
> Use the kernel.org email I have for reviewing patches.
> 
> 

Applied to spi-nor/next, thanks!

[1/1] MAINTAINERS: Use my kernel.org email
      https://git.kernel.org/mtd/c/92714596cdbe

Best regards,
-- 
Tudor Ambarus <tudor.ambarus@microchip.com>
