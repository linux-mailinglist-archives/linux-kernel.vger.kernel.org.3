Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99DAA575770
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 00:12:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241020AbiGNWMP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 18:12:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241009AbiGNWMO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 18:12:14 -0400
Received: from mx1.riseup.net (mx1.riseup.net [198.252.153.129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B275F7099F;
        Thu, 14 Jul 2022 15:12:13 -0700 (PDT)
Received: from fews2.riseup.net (fews2-pn.riseup.net [10.0.1.84])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256
         client-signature RSA-PSS (2048 bits) client-digest SHA256)
        (Client CN "mail.riseup.net", Issuer "R3" (not verified))
        by mx1.riseup.net (Postfix) with ESMTPS id 4LkTHd1QyHzDqCr;
        Thu, 14 Jul 2022 22:12:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
        t=1657836733; bh=TOYGHJVemM3HdzYUR0ZWD2+ERLLCMqlGatn1gDT1m68=;
        h=From:To:Cc:Subject:Date:From;
        b=n/ZbLbnp/LT8Q1IIhi7t3T4asTarA5KEnvFjgKYn1LxBwlYX233QZdgCRX3CaS4m6
         w/sXzjer4lg4AbEnOuxGDvTCSmTv2g+DhIgZXy3s2NKex8CrmPUW7ueC5T3J862DVj
         cWP75eFxXyATq48S1rXxREVi0jmZBWoOhwDdSe+A=
X-Riseup-User-ID: AE9E7F6A7455B84571D8DF2DA9A93E0FA0778D6D7066110693261CA032224D42
Received: from [127.0.0.1] (localhost [127.0.0.1])
         by fews2.riseup.net (Postfix) with ESMTPSA id 4LkTHY5wxcz1yWZ;
        Thu, 14 Jul 2022 22:12:09 +0000 (UTC)
From:   =?UTF-8?q?Ma=C3=ADra=20Canal?= <mairacanal@riseup.net>
To:     mchehab@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, s.nawrocki@samsung.com,
        andrzej.hajda@intel.com
Cc:     devicetree@vger.kernel.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Ma=C3=ADra=20Canal?= <mairacanal@riseup.net>
Subject: [PATCH RESEND 0/2] media: s5c73m3: Update gpio interface and documentation
Date:   Thu, 14 Jul 2022 19:12:00 -0300
Message-Id: <20220714221202.86768-1-mairacanal@riseup.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As suggested by Andrzej, all s5c73m3 specific gpio code is completely removed
and replaced by the gpiod framework. Moreover, the documentation is updated by
fixing the misplaced gpio property.

This patchset was originaly sended on April 2022 [1].

Best Regards,
- Maíra Canal

[1] https://lore.kernel.org/linux-media/20220429123740.147703-1-maira.canal@usp.br/

Maíra Canal (2):
  media: s5c73m3: Replace legacy gpio interface for gpiod
  dt-bindings: media: s5c73m3: Fix reset-gpio descriptor

 .../bindings/media/samsung-s5c73m3.txt        |  2 +-
 drivers/media/i2c/s5c73m3/s5c73m3-core.c      | 95 ++++++++-----------
 drivers/media/i2c/s5c73m3/s5c73m3.h           |  9 +-
 include/media/i2c/s5c73m3.h                   | 15 +--
 4 files changed, 45 insertions(+), 76 deletions(-)

-- 
2.36.1

