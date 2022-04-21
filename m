Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8415B50994A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 09:38:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385905AbiDUHjg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 03:39:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385924AbiDUHj0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 03:39:26 -0400
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::228])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18C601AD94;
        Thu, 21 Apr 2022 00:36:01 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 9AA8A1BF205;
        Thu, 21 Apr 2022 07:35:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1650526560;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=e9ZQakAlm+CSj2qFh7po/Pr9DPdMQhOqjSdYOtnNW7I=;
        b=FWsQAqlTFYLNe3SiSYEGFAlXtHXFYrpKXy9UJuNF4Z+s18kFrkupi4xt1YVK+GX+A/dcBF
        wjyGgwF38NajzBHOLrjvdoHDGk0pjY4O46BFPQEnioTbqaAeVuyAyHpDnEWtw8h7yHSRAb
        DapeU2j4EZ2lwRAsx4uPBZ4kF1bfFFVhzGze1lQ3RHiN/fNbc/Oeie1nklyXFh6mKHmTow
        HWbGmNb81hLeKd1HWmuLD4gU/VdiTn6poFPTCL52Ay22HhYpqR1U90zb+f9iJcr1c0AtTp
        vvysKGkuw0/Ynob7R0PgD1ProF8yvDd+Y5MV7drj0iwneuTWrm878QHH4pjVfg==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Vincent Whitchurch <vincent.whitchurch@axis.com>, vigneshr@ti.com,
        richard@nod.at, miquel.raynal@bootlin.com, joern@lazybastard.org
Cc:     kernel@axis.com, linux-mtd@lists.infradead.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org, krzk+dt@kernel.org,
        frowand.list@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/4] mtd: phram: Allow cached mappings
Date:   Thu, 21 Apr 2022 09:35:57 +0200
Message-Id: <20220421073557.72082-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220412135302.1682890-5-vincent.whitchurch@axis.com>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'ec8615bcd6f3a02e983bbafb3a4e4d35cd7e8c47'
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2022-04-12 at 13:53:02 UTC, Vincent Whitchurch wrote:
> Currently phram always uses ioremap(), but this is unnecessary when
> normal memory is used.  If the reserved-memory node does not specify the
> no-map property, indicating it should be mapped as system RAM and
> ioremap() cannot be used on it, use a cached mapping using
> memremap(MEMREMAP_WB) instead.
> 
> On one of my systems this improves read performance by ~70%.
> 
> Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
> Reported-by: kernel test robot <lkp@intel.com>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git mtd/next, thanks.

Miquel
