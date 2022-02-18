Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECCC44BBAAE
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 15:33:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236091AbiBROdX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 09:33:23 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236084AbiBROdW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 09:33:22 -0500
Received: from relay11.mail.gandi.net (relay11.mail.gandi.net [IPv6:2001:4b98:dc4:8::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B522C25AE6D;
        Fri, 18 Feb 2022 06:33:04 -0800 (PST)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id F401B100002;
        Fri, 18 Feb 2022 14:33:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1645194783;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IF+bBotb8aWY1Kt+8zVVFsrxJD/Qv2pWkySdFRv0E2A=;
        b=UUQl85JcyGBt47wLgD57UsAYqU8DebleUhgDNJs5+u1WzG9uV0IxVeUh+eiWFXC7I55332
        S2HIrAb88CM8z5IqavD0fFygRI2Rb9LeHGB5iYNfztGhJ3zi+0AQkf2sj7sPggw8ZLkEnt
        UeKWszGs5WzG5ux77IhBoPMVxqn2n1hUwRXi49YUyl1svtg5e/znT5cq0hyGwO5FpasbFp
        G+DE4ETy+9IpKkQDbyAN8gl9F9RwRYrDfCg2azGWwH6ceRDR2nfLcTzurKYOQp//TgfsDm
        EP5TFzr34OaXVmBF++UuS/VvPVE2KCytwT/ir2l5PTPqG9JieFbZ/zLNw3W3Sw==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Christophe Kerello <christophe.kerello@foss.st.com>,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        robh+dt@kernel.org, srinivas.kandagatla@linaro.org, p.yadav@ti.com
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        devicetree@vger.kernel.org, chenshumin86@sina.com
Subject: Re: [PATCH v3 2/4] mtd: rawnand: stm32_fmc2: Add NAND Write Protect support
Date:   Fri, 18 Feb 2022 15:33:00 +0100
Message-Id: <20220218143300.322209-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220217144755.270679-3-christophe.kerello@foss.st.com>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'ffb16c1c42670356c579926aabdac0ac7bbc16d8'
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2022-02-17 at 14:47:53 UTC, Christophe Kerello wrote:
> This patch adds the support of the WP# signal. WP will be disabled in
> probe/resume callbacks and will be enabled in remove/suspend callbacks.
> 
> Signed-off-by: Christophe Kerello <christophe.kerello@foss.st.com>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next, thanks.

Miquel
