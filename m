Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED7775025DC
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 08:49:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348388AbiDOGvP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 02:51:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239658AbiDOGvM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 02:51:12 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF8F4B18B2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 23:48:45 -0700 (PDT)
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id F3FAE1F47D9A;
        Fri, 15 Apr 2022 07:48:43 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1650005324;
        bh=XzQWK68/dZeCa/nbUidr9XmW77fjBlg9fKK77YRt9bw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Y50odSd+CkLjCRqX3DCAIsCG+FVEujjyOFfwTAp2yeIbsA5UML5ok536TC8CGe5Hm
         moEKM8NoHTGLR5rxX0IHz5NuTEh65uHj5Z8uzoWBwqVVIJB7SUqXuOJaV3gouJU/zF
         GDO4O5eM2bErYPBubluQb9TD+MUorjVCELo/qtCR3lJNA36cgUoNJRbnGeAO2Y1YGa
         9FsVI70v4bbMyDfxCVQOvIXzgUT4aqYJE68c4j5SIGz1DduoI8jYItiTMdslRrfh+T
         mAYuUc5jlUB504KKTuAIoBrhXZ96jFV64vbey7VPYhHxUgbvLQUFqTPUz0YfQRL88z
         oRZOsLnuo51ug==
Date:   Fri, 15 Apr 2022 08:48:40 +0200
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     Chuanhong Guo <gch981213@gmail.com>
Cc:     linux-mtd@lists.infradead.org,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Patrice Chotard <patrice.chotard@foss.st.com>,
        Christophe Kerello <christophe.kerello@foss.st.com>,
        Mark Brown <broonie@kernel.org>,
        Daniel Palmer <daniel@0x0f.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: Re: [PATCH v2 2/3] mtd: spinand: add support for detection with
 param page
Message-ID: <20220415084840.72a2bc9a@collabora.com>
In-Reply-To: <20220415034844.1024538-3-gch981213@gmail.com>
References: <20220415034844.1024538-1-gch981213@gmail.com>
        <20220415034844.1024538-3-gch981213@gmail.com>
Organization: Collabora
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Apr 2022 11:48:43 +0800
Chuanhong Guo <gch981213@gmail.com> wrote:

> +#define SPINAND_IDR_EN BIT(6)

Looks like you're redefining CFG_OTP_ENABLE, why not use that
definition directly?

> +#define SPINAND_PARAM_PAGE 1
> +#define ONFI_PARAM_PAGES 3


