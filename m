Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 971334BBAB3
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 15:33:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235421AbiBROdp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 09:33:45 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236086AbiBROdk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 09:33:40 -0500
Received: from relay11.mail.gandi.net (relay11.mail.gandi.net [IPv6:2001:4b98:dc4:8::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FB4425B2CB;
        Fri, 18 Feb 2022 06:33:13 -0800 (PST)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 9DFCA10000D;
        Fri, 18 Feb 2022 14:33:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1645194788;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=P8wreGlX9R9giHg9TtUZfMq1UzO5U2luCRSST3Eos5A=;
        b=PGeF6w9lBkT1hVEhEqQt/p7nOYy2rD2ee18sQ0smT3QRM0pbn3dBzpxRzQMp3L/QTwpKNS
        /m7RrOnm2IiqPOzBpG7O2a0bnQVRCI8+v94LwjRgZhr0g4dsyPAy6aJfZ9GlQAAnh/PanX
        wdlsX26q/F2+DNz5DQz2Dy8QbldHzxpf4v0Le6pYC+egD5qwRaiSmnD5iKHI/GmRYLcumG
        QkNq53+GA+Nc4QjD3tGSY6sdAeUGMo0CxTSVPZEnC1flmx0/zDwkQLNV1bs0Y1SjxaebtR
        3trvHTIkc70ZyPM2hbeNTXVVK7+Rer4X/2TrmpAeR9WqNmkBwbSZSFubUfKzIQ==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Christophe Kerello <christophe.kerello@foss.st.com>,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        robh+dt@kernel.org, srinivas.kandagatla@linaro.org, p.yadav@ti.com
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        devicetree@vger.kernel.org, chenshumin86@sina.com,
        Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v3 1/4] dt-binding: mtd: nand: Document the wp-gpios property
Date:   Fri, 18 Feb 2022 15:33:06 +0100
Message-Id: <20220218143306.322284-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220217144755.270679-2-christophe.kerello@foss.st.com>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'cb57fae479be41d1233f5a49d4760de9a5692b6e'
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

On Thu, 2022-02-17 at 14:47:52 UTC, Christophe Kerello wrote:
> A few drivers use this property to describe the GPIO pin used to protect
> the NAND during program/erase operations.
> 
> Signed-off-by: Christophe Kerello <christophe.kerello@foss.st.com>
> Acked-by: Rob Herring <robh@kernel.org>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next, thanks.

Miquel
