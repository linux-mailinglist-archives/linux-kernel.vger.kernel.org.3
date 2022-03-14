Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 105514D88A7
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 16:59:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242832AbiCNQA7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 12:00:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241966AbiCNQA6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 12:00:58 -0400
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::222])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67F4741624
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 08:59:46 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id D5BFE40002;
        Mon, 14 Mar 2022 15:59:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1647273585;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kYC1TumYa2PoTn+cMonI8OUD98rDtrkZYlmD5KS7gGk=;
        b=ccG8x6LibDpAjcUmDVJ2k8ZrhsYzxoRilLD1Iz0d0n7F5Y3m4yKS7YdPzd8ano9CGRWmU4
        +q6s6MTQvDG8Q+lGWvOt9RIm+Ihp8c3LnUEic/JFsn4S8ITDDznJJYq36AjGqzciQOthLp
        P1cnYjxkHSjEC6J3v8g4l/GPkiAnsAEPoUG9uWN5SigG0gxdTQyylbpYcZmHkd/S991WNR
        Q35Ep6jDlAz7WE/4wEVdcGGtjhJZoQVTwsdZH6tybdhn7SVeDd2vJwOc8JGl39+KqBtb4+
        oMrkOGEgYB0t0HnBQ3HKlFbePgs6sC2vCybjmdBkx4JCxryaSOJCwTOL17FwdA==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Pratyush Yadav <p.yadav@ti.com>
Subject: Re: [PATCH v2] mtd: core: Remove partid and partname debugfs files
Date:   Mon, 14 Mar 2022 16:59:43 +0100
Message-Id: <20220314155943.77271-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220225144656.634682-1-tudor.ambarus@microchip.com>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'23362093da4e3b0fce515b556df649b59884b4e8'
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

On Fri, 2022-02-25 at 14:46:56 UTC, Tudor Ambarus wrote:
> partid and partname debugfs files were used just by SPI NOR, but they were
> replaced by sysfs entries. Since these debugfs files are no longer used in
> mtd, remove dead code. The directory is kept as it is used by nandsim,
> mtdswap and docg3.
> 
> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
> Reviewed-by: Pratyush Yadav <p.yadav@ti.com>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git mtd/next, thanks.

Miquel
