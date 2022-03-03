Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF2D34CC486
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 19:01:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235584AbiCCSB5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 13:01:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235559AbiCCSBv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 13:01:51 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 298341A1C55;
        Thu,  3 Mar 2022 10:01:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D897CB81E67;
        Thu,  3 Mar 2022 18:01:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B491C340F0;
        Thu,  3 Mar 2022 18:01:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646330463;
        bh=HXB8WvVn38SLYE0M/BOlh6qLUFc7dMz6hOUpC59yqeg=;
        h=From:To:Cc:Subject:Date:From;
        b=P6mehJQ3pPdhqJNut2i/BbTPhTEEd42xS2ahyiToif24ccOqxud1KzsfZM5jJcY0H
         f6F+WR3xvUXLRy5B/mQI1nVDbCm7ce6dJ8yA3ddmqdu2NKE/AZHGEaOwgKwc11SbEz
         knaBGtKUUZxZ8e2iFkO9xSwfdb0w+ONk9Wbwn4EKRZmIr3lHaQJDbEPj9zkBrXjqnf
         LjdV30nHCsb4Ntjb65t7ZyefwCcECYGmtOaT6Il9ixFrrw8NFTyUUXsRd/QD2wYxeg
         5dKMrnOT17+P2eqV7kLgIlQY17iRB3b/foS20fS85Fw+8uVajKR/N7iv0dlJ2RctZR
         j0ZoDN5BDcpxA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1nPpl7-0000im-Dy; Thu, 03 Mar 2022 19:01:02 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Tony Lindgren <tony@atomide.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>
Subject: [PATCH 0/2] ARM: OMAP2+: omap-device cleanups
Date:   Thu,  3 Mar 2022 19:00:12 +0100
Message-Id: <20220303180014.2639-1-johan@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When fixing some platform-device leaks to due to missing error handling,
I stumbled over the omap_device_register() helper which is no longer
used and can be removed.

Johan


Johan Hovold (2):
  ARM: OMAP2+: drop omap_device_register() helper
  ARM: OMAP2+: drop hwmod-clock helper comment

 arch/arm/mach-omap2/omap_device.c | 20 --------------------
 arch/arm/mach-omap2/omap_device.h |  1 -
 2 files changed, 21 deletions(-)

-- 
2.34.1

