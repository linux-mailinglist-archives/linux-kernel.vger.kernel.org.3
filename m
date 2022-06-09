Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8428A544C55
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 14:42:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245756AbiFIMmx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 08:42:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245755AbiFIMmu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 08:42:50 -0400
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 923322EA2D
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 05:42:48 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 5B50CFF808;
        Thu,  9 Jun 2022 12:42:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1654778566;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JKZwr8n3vIHpLZgFH7boPDmbMJP8Hhddlyg9pXWYK4I=;
        b=QsD4VXwo9Dzpd4/zRBANUlUIWkpvTMtIljLZw3UqFo1B09ePQfTQE3UPqY0BJdbvaFr1lb
        FlMp9azxu17IlWU3b5FSD8icCmKR/aBRho5s+Uh54Ezj4srNBGk7dnBXtZ/o6sa+YKla6s
        scH4HwwI/0wwPfym+o7IxlQLTNsc84P/s3b9PNYYCrBijNzusuCnBVDanvhB+59u6YkfVu
        RwpxQM+q8TzKBDrdf9cIdr20JrOjerpaYI9KNzNEi16nuk6wWhAwPU2M1lNnQf/I4gR3/A
        6Aw13QetJFv5ZkcbSNaRjnUKqfD6EUsVV4af+ONJZqK9KqYQUueIkWUKdI+7UA==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Mikhail Zhilkin <csharper2005@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     Hauke Mehrtens <hauke@hauke-m.de>,
        NOGUCHI Hiroshi <drvlabo@gmail.com>,
        INAGAKI Hiroshi <musashino.open@gmail.com>,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        Karim <Karimdplay@gmail.com>, M <x1@disroot.org>
Subject: Re: [PATCH v6] mtd: parsers: add support for Sercomm partitions
Date:   Thu,  9 Jun 2022 14:42:44 +0200
Message-Id: <20220609124244.132975-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220529110714.189732-1-csharper2005@gmail.com>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'9998ee42f9c0d3a30d6936eb84ee7ff04d5f027b'
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2022-05-29 at 11:07:14 UTC, Mikhail Zhilkin wrote:
> This adds an MTD partition parser for the Sercomm partition table that
> is used in some Beeline, Netgear and Sercomm routers.
> 
> The Sercomm partition map table contains real partition offsets, which
> may differ from device to device depending on the number and location of
> bad blocks on NAND.
> 
> Original patch (proposed by NOGUCHI Hiroshi):
> Link: https://github.com/openwrt/openwrt/pull/1318#issuecomment-420607394
> 
> Signed-off-by: NOGUCHI Hiroshi <drvlabo@gmail.com>
> Signed-off-by: Mikhail Zhilkin <csharper2005@gmail.com>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git mtd/next, thanks.

Miquel
