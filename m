Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEA28509945
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 09:38:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385900AbiDUHjc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 03:39:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385903AbiDUHjD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 03:39:03 -0400
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC7E613E27
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 00:35:55 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id B49261BF209;
        Thu, 21 Apr 2022 07:35:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1650526554;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XGsM2GQEMgFdPKCnMpoDRkCkxt3Jk31U76JbVY16cr4=;
        b=c3wNV+oUFLzhCTyd019QDGMZUMk9xLubpdRvZnSyRsVSJmA6m0GU6W23BFXkti6P/OvgPJ
        mQvULURY8F+pcI87t9Fbscyg7spsJ8ZJTCeeOl/SdM/uwW4YW8wqKXnNFBCFnExTD86+Z2
        F+DxBH1ruFhEsc04jsyL8EJ5ShxGXzqJk8p8Xft1iMm2KBZ+eWEdERQTnUvQuk0Uzoe9KV
        abg+2MKHGhzrbCn94TYa/WgP8l3XSO6ykj8HDV99lbW2YUAcnOTwZpROXjqvePrWXwVwac
        pUjpIwBu6CGJfZkgf/cDn5Alx9eAI3DlExsHmHwgh/Xtf8fxU1m+86pQkxJmFA==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Jean-Marc Eurin <jmeurin@google.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/3] mtd: mtdoops: Fix the size of the header read buffer.
Date:   Thu, 21 Apr 2022 09:35:52 +0200
Message-Id: <20220421073552.72015-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220415001321.252848-2-jmeurin@google.com>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'6ae35884007189f7dee68dcc31f0caec30ac2c08'
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2022-04-15 at 00:13:19 UTC, Jean-Marc Eurin wrote:
> The read buffer size depends on the MTDOOPS_HEADER_SIZE.
> 
> Tested: Changed the header size, it doesn't panic, header is still
> read/written correctly.
> 
> Signed-off-by: Jean-Marc Eurin <jmeurin@google.com>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git mtd/next, thanks.

Miquel
