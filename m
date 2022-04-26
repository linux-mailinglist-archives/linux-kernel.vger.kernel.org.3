Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DABA550F299
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 09:35:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243384AbiDZHhe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 03:37:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344072AbiDZHh0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 03:37:26 -0400
Received: from relay10.mail.gandi.net (relay10.mail.gandi.net [IPv6:2001:4b98:dc4:8::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 669AD133E60
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 00:34:19 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 0C36624000E;
        Tue, 26 Apr 2022 07:34:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1650958457;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YzyxMk1kPqBBPS6IQztRw56tbzHTTECunJO3rUI8MUI=;
        b=eNGbFIm160Xi1yaYFf8MfVy63nyGDbu4M2ks5NTiLbgI7ppjat+GpNBgwuCWhRdJuKavPB
        pGstTKhrNKo7gFQiSMix01OUKbY7fOobIsf9pVH5rsILXWCfJZaDSIevWk1VhXPb2NZYaK
        RF468+wBZ8fhLgRcwX46AeKWnw03SyjNBDPefwM7HHZ7Cuw8aEeUc9b1TfVw2PR1P8lHlK
        bt6Io9QlezmkeKAhb8i+w0e3jA0Xj7JSSwh4QTqOHDit2yxoRKMwkQOXqpADSA/sxDhfFE
        JzN5Y6Dweb08gCh0utiKh3iYkQd7W4uctE+1MUQXowAp2XuzeIB6eMI4eIt1Xg==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Jean-Marc Eurin <jmeurin@google.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 3/3] mtd: mtdoops: Add a timestamp to the mtdoops header.
Date:   Tue, 26 Apr 2022 09:34:16 +0200
Message-Id: <20220426073416.36906-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220425160927.3823016-1-jmeurin@google.com>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'aa641a22bb5b1971a459b37746b845e3f5f084ca'
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2022-04-25 at 16:09:27 UTC, Jean-Marc Eurin wrote:
> On some systems, the oops only has relative time from boot.
> 
> Signed-off-by: Jean-Marc Eurin <jmeurin@google.com>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git mtd/next, thanks.

Miquel
