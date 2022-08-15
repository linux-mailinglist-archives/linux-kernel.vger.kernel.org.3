Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46A8959405D
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 23:48:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245706AbiHOUsh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 16:48:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345783AbiHOUrI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 16:47:08 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73ED9B7EC2;
        Mon, 15 Aug 2022 12:08:45 -0700 (PDT)
Received: from dslb-188-096-143-237.188.096.pools.vodafone-ip.de ([188.96.143.237] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1oNfRu-0003rX-SM; Mon, 15 Aug 2022 21:08:30 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Abel Vesa <abelvesa@kernel.org>, Stephen Boyd <sboyd@kernel.org>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH v4 0/2] ARM: imx25: print silicon revision at startup
Date:   Mon, 15 Aug 2022 21:07:46 +0200
Message-Id: <20220815190748.102664-1-martin@kaiser.cx>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220602080344.208702-1-martin@kaiser.cx>
References: <20220602080344.208702-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Resurrect the unused function to print the imx25 silicon revision at
startup.

Now that 6.0-rc1 is out, I hope that the clk maintainers have a moment
to review this simple patch set ;-)

changes in v4:
- rebase against today's linux-next
- add Fabio's Reviewed-by tags

changes in v3:
- rebase against today's linux-next

changes in v2:
- drop the patch about silicon revision 1.2. It has already been merged
  by Shawn Guo.
- send the changeset to the clk maintainers

Martin Kaiser (2):
  clk: imx25: print silicon revision during init
  clk: imx25: make __mx25_clocks_init return void

 drivers/clk/imx/clk-imx25.c | 5 +++--
 include/soc/imx/revision.h  | 1 +
 2 files changed, 4 insertions(+), 2 deletions(-)

-- 
2.30.2

