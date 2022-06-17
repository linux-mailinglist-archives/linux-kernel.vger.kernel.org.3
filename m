Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1EDC54F10B
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 08:31:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234144AbiFQGbj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 02:31:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380180AbiFQGb3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 02:31:29 -0400
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CF5F532D7;
        Thu, 16 Jun 2022 23:31:28 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 2436D1BF203;
        Fri, 17 Jun 2022 06:31:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1655447487;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BQ0wrFYdrXuojklvNl1658c5ZfBL7raN6sTUE6g4Wvo=;
        b=jM5HRtQcblG3I+IejYt28V8RRQQQkuVicdg2nSebNL1ramoLUFWoIpllPtjAgLfQo9hfCP
        PIq6hRZO9NJWNgehYoPv1q8zzaVNto01sRnVdxNjz4tD0EVQ38kO7ZDllcddDTiB2svRwi
        eVe8820gGhTQBskyxpND4O/WlSlRC6bxRa2PBApgfCEJVo83a9qvERbCIIAdD5urKmAhDt
        h4trIsPqxFCgKrNkdMl32F7GtFyMTqIhnJnOQKRjm27/wpPoTm3q5C79kYh906Yl2u+4Sw
        NFFUTEP5euG8A5UvFoms/dMwgtgQ+HSnzHZEnES2GmdPpvgteDiGwdCb4piEIA==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Christian Marangi <ansuelsmth@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-mtd@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 3/3] dt-bindings: mtd: qcom_nandc: document qcom,boot-partitions binding
Date:   Fri, 17 Jun 2022 08:31:24 +0200
Message-Id: <20220617063124.446689-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220616001835.24393-4-ansuelsmth@gmail.com>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'5278cc93a97f7b7b9e69632e52503e956153d944'
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

On Thu, 2022-06-16 at 00:18:35 UTC, Christian Marangi wrote:
> Document new qcom,boot-partition binding used to apply special
> read/write layout to boot partitions.
> 
> QCOM apply a special layout where spare data is not protected
> by ECC for some special pages (used for boot partition). Add
> Documentation on how to declare these special pages.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next, thanks.

Miquel
