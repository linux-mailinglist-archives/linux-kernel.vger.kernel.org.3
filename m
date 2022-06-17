Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BE0E54F107
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 08:31:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379667AbiFQGb0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 02:31:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbiFQGbY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 02:31:24 -0400
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35506527FC
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 23:31:23 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id BEE361BF211;
        Fri, 17 Jun 2022 06:31:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1655447481;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=T1tVZgBV3BS0ceFgD+YF9Gee/DGk44tsKYH0k1uppnk=;
        b=VUVcoyT9pSozjb9BYHPWZXfBbhqE4y/2qKtQT2eOsDE1bbWJo4N63U5R2m4/liRqRbW/yJ
        L6AsmeF0B7MbfWdx0EQdt94l3zsvOpQr8jy4F/FjUtw0iGiwIYZ8leqVvOEMpoPnBbQgmH
        5XFvFp54mMtwUd6wybwCWz4ch5ynoeukFAl4kAsc+bWnbih0yw0HJ7V3d3WokJh2yE75IM
        lch1zustOgRMtk3s2GI8d5N7JIRK3w3mzS84EnexBntQ1jAVlu7HoaatbY6xAqSdF/fDrS
        +JHXN6DhpRnYGeGfigQCOO6OI9TvgoGLT1xgwGd648/hocOnuAAvLGDwh+l1hQ==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Yang Yingliang <yangyingliang@huawei.com>,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>, csharper2005@gmail.com,
        drvlabo@gmail.com
Subject: Re: [PATCH -next] mtd: parsers: scpart: add missing of_node_put() in scpart_parse()
Date:   Fri, 17 Jun 2022 08:31:19 +0200
Message-Id: <20220617063119.446659-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220617014008.851583-1-yangyingliang@huawei.com>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'278811d5a7b2af4e737c88ab3137d3ccc0732ac1'
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

On Fri, 2022-06-17 at 01:40:08 UTC, Yang Yingliang wrote:
> of_get_child_by_name() will increase the refcount of 'ofpart_node',
> so add of_node_put() after using it to avoid refcount leak.
> 
> Fixes: 9b78ef0c7997 ("mtd: parsers: add support for Sercomm partitions")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git mtd/next, thanks.

Miquel
