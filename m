Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8CE053F4AF
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 05:44:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236408AbiFGDoE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 23:44:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236410AbiFGDoB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 23:44:01 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A40BD13DFD
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 20:43:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0AB8DB81826
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 03:43:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A930C385A5;
        Tue,  7 Jun 2022 03:43:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654573432;
        bh=4C9KnsvpxDqmf7of6tmkn2rz7b0ONZkdq9tCM3UQAy8=;
        h=From:To:Cc:Subject:Date:From;
        b=bSfTxZc3/yOz68lp+Y53uUZtDUjuxXhEBSmXbAb7jsDuDWF48baqADLM7PUgQglRl
         R50Z8Dn7UOuH/bRwqt9joV1ogM4mpBzHEs6hHqE2VdZ7Vl6NoQ0+LIYhKWUQ7biAJp
         jiL2XNPYv6PcozqUEeCkNAyU3JTGwWO/FBPEuvg0LUtwcbioajfmlDD9NTFUzsqMQI
         deJQZfgkNKTLziG1f/88SfQdealpcYpmSJROBXSA21ZGaz+4ICAp296eWOqpvSopHJ
         Xk0h3klnJ07fxjd1RWyP0XmqyY/yukgZs0f7Iz5SrdzF2ZUNkwUZ0zNxQ0x9moVeMn
         e+lSikqAGd6gQ==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     David Airlie <airlied@linux.ie>,
        "Rafael J . Wysocki" <rafael@kernel.org>
Cc:     Vaibhav Gupta <vaibhavgupta40@gmail.com>, linux-pm@vger.org,
        linux-pci@vger.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 0/5] agp: Convert to generic power management
Date:   Mon,  6 Jun 2022 22:43:35 -0500
Message-Id: <20220607034340.307318-1-helgaas@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

Vaibhav converted several AGP drivers from legacy PCI power management to
generic power management [1].  This series converts the rest of them.

[1] https://lore.kernel.org/all/20210112080924.1038907-1-vaibhavgupta40@gmail.com/#t

Bjorn Helgaas (5):
  agp/efficeon: Convert to generic power management
  agp/intel: Convert to generic power management
  agp/amd-k7: Convert to generic power management
  agp/ati: Convert to generic power management
  agp/nvidia: Convert to generic power management

 drivers/char/agp/amd-k7-agp.c   | 24 ++++--------------------
 drivers/char/agp/ati-agp.c      | 22 ++++------------------
 drivers/char/agp/efficeon-agp.c | 16 ++++------------
 drivers/char/agp/intel-agp.c    | 11 +++++------
 drivers/char/agp/nvidia-agp.c   | 24 ++++--------------------
 5 files changed, 21 insertions(+), 76 deletions(-)

-- 
2.25.1

