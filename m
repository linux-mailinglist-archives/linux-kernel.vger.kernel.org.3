Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81F204AF757
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 17:58:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237557AbiBIQ5v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 11:57:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233939AbiBIQ5t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 11:57:49 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3346AC0613C9;
        Wed,  9 Feb 2022 08:57:53 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: tonyk)
        with ESMTPSA id E42591F44C9C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1644425870;
        bh=kPK11mfNCz4YUzavlXfvC9MVi37djtE4QzmyeYWbNb8=;
        h=From:To:Cc:Subject:Date:From;
        b=fYwgLHo2XtBxvW9a+EUTQJPRfPB5gkEKsPeei1QqBlY0/i9+EnDwLHYE1AHicJzbh
         /cXoUseZl87sDDNRkqAzTkiaiuIFEntrHS+ObqGRKUagrEpUIv6njQX3eW4Wz+qHZL
         XAHLhuYwAnybBzEy7EzLZ2sz/d/0OhG1bhJP3lMptd0bPY8f2/7SsEmqWEHHsvOgRn
         sVteAtNc4/pgnO1BeDr84yvaYcg6pIx0jrbBhYF2DciXgfLmomKzqgOvbHirtvvQeO
         iY1RuVs3H9wVeAt06eGsvpYeVoA0+gCO96EctqvsLpxh/Cd+uOrWzDUYMDAyc3X6Ij
         Jg7r4Iy2XGa8Q==
From:   =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@collabora.com>
To:     Sanjay R Mehta <sanju.mehta@amd.com>,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com,
        Lucas Tanure <tanureal@opensource.cirrus.com>,
        Nehal Bakulchandra Shah <Nehal-Bakulchandra.shah@amd.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@collabora.com>
Subject: [PATCH 0/3] spi: amd: Add support for new controller version
Date:   Wed,  9 Feb 2022 13:57:30 -0300
Message-Id: <20220209165733.43134-1-andrealmeid@collabora.com>
X-Mailer: git-send-email 2.35.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series do some cleanup and add support for new controller version,
AMDI0062.

André Almeida (3):
  spi: amd: Use iopoll for busy waiting
  spi: amd: Remove needless rom_addr variable
  spi: amd: Add support for version AMDI0062

 drivers/spi/spi-amd.c | 79 +++++++++++++++++++++++++++++++++++--------
 1 file changed, 64 insertions(+), 15 deletions(-)

-- 
2.35.0

