Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BE034F112F
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 10:47:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239340AbiDDItV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 04:49:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239232AbiDDItP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 04:49:15 -0400
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2912130F64
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 01:47:20 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 7B35E20002;
        Mon,  4 Apr 2022 08:47:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1649062038;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=avt89o5SBybcyfyH/lllNg9nEWfcYc2z4/7aYXMyPe8=;
        b=X0l+c/fQTrzF2DfVfbVoKEurx0is05tR2htI35ud21mqJkTSSzypMo55EYQQfrCb6aDREN
        /a3v5hHHPeawz2BwvnxiAisG6ttoBFaDAV3gsZkDFcunX8Ads8FreuSxCfdhgPBVWcD5I/
        XoMYDSulu1nvFBRGhWMJ/zRJrh7gvdTdYYvJxKGIG/zFVgvxOc3yciWzHDKZxEMgO107ck
        aY83os34/j1ODNR7SOgn1nStqCaQkmL0XqMf5gPdsLMDQvZ6qih8KFWoCjjY21OxOhtqbY
        f71c5Jzc0S2T1sJa6EdZiORBOaQwfo231sBwGbp9HaUtR6DqzFmUmtgWDhO1pA==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Chuanhong Guo <gch981213@gmail.com>, linux-mtd@lists.infradead.org
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Reto Schneider <reto.schneider@husqvarnagroup.com>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Stefan Roese <sr@denx.de>,
        linux-kernel@vger.kernel.org (open list)
Subject: Re: [PATCH 3/5] mtd: spinand: gigadevice: add support for GD5F1GQ5RExxG
Date:   Mon,  4 Apr 2022 10:47:16 +0200
Message-Id: <20220404084716.1202690-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220320100001.247905-4-gch981213@gmail.com>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'620a988813403318023296b61228ee8f3fcdb8e0'
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

On Sun, 2022-03-20 at 09:59:59 UTC, Chuanhong Guo wrote:
> This chip is the 1.8v version of GD5F1GQ5UExxG.
> 
> Signed-off-by: Chuanhong Guo <gch981213@gmail.com>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next, thanks.

Miquel
