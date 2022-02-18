Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5E9B4BBAB1
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 15:33:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236115AbiBROdm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 09:33:42 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236087AbiBROdh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 09:33:37 -0500
Received: from relay11.mail.gandi.net (relay11.mail.gandi.net [IPv6:2001:4b98:dc4:8::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D4D025B2C7
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 06:33:17 -0800 (PST)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 4241A100007;
        Fri, 18 Feb 2022 14:33:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1645194793;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=T1dnR8Czxi29X/52zcUWqpPxP9yVrLF/lYUdiVn/ts4=;
        b=ZLE+Fkg+gI1PoYzz8vf27GCg4YYSgXOqSknjTDNKXX/1O839kUa7mUMDfP0HCZYPozDTbK
        TlpAxL78PbSYMP4YDDymY7GYKDFhMqS/EFn1tTQOhX+xgUA8W1uSyyqRk6sIaYEMYN0rex
        sEuEzQCADjaXXk8Tmphahrs2fHhbN60KhONrw0TrxkmfPTAtR6HDgB2NBVed2Atmi+8MYL
        OGXXhC/oLYMUkjIpgRQmuGyZYa84KsTzoi7DBpH4sLYjdT/H7c3V3hlosIMNXyZnAWh/QL
        uhvOnFzvPIe+uZftzY0j89xqZ/f6Yfmx8Pa+eb9MpCeszA6io1bSoybHh6YRDw==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>,
        miquel.raynal@bootlin.com, nagasure@xilinx.com, vigneshr@ti.com
Cc:     richard@nod.at, git@xilinx.com, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mtd: rawnand: pl353: Set the nand chip node as the flash node
Date:   Fri, 18 Feb 2022 15:33:11 +0100
Message-Id: <20220218143311.322348-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220209053427.27676-1-amit.kumar-mahapatra@xilinx.com>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'a1fe2ace2c39dcdc7c053705459a73b7598b1e4f'
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

On Wed, 2022-02-09 at 05:34:27 UTC, Amit Kumar Mahapatra wrote:
> In devicetree the flash information is embedded within nand chip node,
> so during nand chip initialization the nand chip node should be passed
> to nand_set_flash_node() api, instead of nand controller node.
> 
> Fixes: 08d8c62164a3 ("mtd: rawnand: pl353: Add support for the ARM PL353 SMC NAND controller")
> Signed-off-by: Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next, thanks.

Miquel
