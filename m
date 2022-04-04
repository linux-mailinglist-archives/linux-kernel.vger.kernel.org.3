Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9777F4F112E
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 10:47:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239164AbiDDItO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 04:49:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237774AbiDDItL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 04:49:11 -0400
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73D262E9D1
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 01:47:15 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 416E7C0009;
        Mon,  4 Apr 2022 08:47:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1649062034;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fg1Ah0caYm3QrONoHGsl/cEw07odqeM6ZNg7OgLAPxA=;
        b=dA4RhdYWv/SyV2FUWmUjdJf1mfWtcNwwg5ecX4vSjZ+hQ7Mazmag3XjWa1+V4d/0kwZ97r
        0sGqUbcmNF/wEMXtfQy0Jhy8SHhwuOasJA4r3r3EwCrIyTfeb2qoOMFdG6JYLNgV6szzhi
        6XOOqWbcJCxP77ONEEuXlC4xrAq5vuA3c6gMf87Shf/3c0nioWLi3g6IQv7HMtdKqgpCiJ
        T/FeJmmNRl+fZ3cMWDxHworWXylXbDHSqX8hwbv7dSlXoOv93NWVSkE7qKpTk9ZuomTxhX
        7pXUS1EaHzRvEu629Sf1euCP53O6mtGn8yn6/LRfOWIsxVz8UaErtm/hkgxrPA==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Chuanhong Guo <gch981213@gmail.com>, linux-mtd@lists.infradead.org
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Reto Schneider <reto.schneider@husqvarnagroup.com>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Stefan Roese <sr@denx.de>,
        linux-kernel@vger.kernel.org (open list)
Subject: Re: [PATCH 4/5] mtd: spinand: gigadevice: add support for GD5F{2, 4}GQ5xExxG
Date:   Mon,  4 Apr 2022 10:47:12 +0200
Message-Id: <20220404084712.1202351-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220320100001.247905-5-gch981213@gmail.com>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'194ec04b3a9e7fa97d1fbef296410631bc3cf1c8'
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

On Sun, 2022-03-20 at 10:00:00 UTC, Chuanhong Guo wrote:
> Add support for:
>  GD5F2GQ5{U,R}ExxG
>  GD5F4GQ6{U,R}ExxG
> 
> These chips uses 4 dummy bytes for quad io and 2 dummy bytes for dual io.
> Besides that and memory layout, they are identical to their 1G variant.
> 
> Signed-off-by: Chuanhong Guo <gch981213@gmail.com>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next, thanks.

Miquel
