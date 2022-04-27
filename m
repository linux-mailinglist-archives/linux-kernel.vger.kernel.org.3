Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C98CA5120CD
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 20:39:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239717AbiD0P3Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 11:29:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239688AbiD0P3W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 11:29:22 -0400
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97E263459DC;
        Wed, 27 Apr 2022 08:26:10 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 37C5FFF809;
        Wed, 27 Apr 2022 15:26:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1651073167;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4wTZZPinydjcjv1I4AgdUoYpVwYx1Dn3FddOafhqD5Y=;
        b=QWGmZPBP5zuKML1STJVjCP2ZYTRb+zr+JLX8/DOlI80QVASlR5kcTXua9ARdiWCNbuE9I3
        cQmXalTI45lGAFEMWzjRYYsyW7hdlQjWsIBUo1kswZimYqjPKqzZ0rMD7sroV72KO7YbW5
        rCyBZXHGfb/M3BtmEkKtieUGVRFKuYreynNW4ZIIe9OhtftJltXMSKLZNoRsjUCSVn+tCn
        NdXB9P1MCMn9aGdjnC0o88sLQCDplCOtJW5HCA4g7DXtApkxVpUAsXovXBkxVDtJ499qwW
        HXoRBAmWPNcA+7uWJ2xXHOzq9D2BNhkOLlR25Ew4zTozG7UQ/W1xUX85BAOP6Q==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Yang Yingliang <yangyingliang@huawei.com>,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linaro-mm-sig@lists.linaro.org
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>, richard@nod.at
Subject: Re: [PATCH 3/3] mtd: rawnand: tmio: check return value after calling platform_get_resource()
Date:   Wed, 27 Apr 2022 17:26:05 +0200
Message-Id: <20220427152605.100908-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220426084913.4021868-3-yangyingliang@huawei.com>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'9b2152f96f4a243bdfb89027c0d920aa0af810e7'
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2022-04-26 at 08:49:13 UTC, Yang Yingliang wrote:
> It will cause null-ptr-deref if platform_get_resource() returns NULL,
> we need check the return value.
> 
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next, thanks.

Miquel
