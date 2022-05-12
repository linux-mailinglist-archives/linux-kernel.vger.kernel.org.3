Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 929EA525149
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 17:28:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355961AbiELP14 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 11:27:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355959AbiELP1v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 11:27:51 -0400
Received: from relay11.mail.gandi.net (relay11.mail.gandi.net [217.70.178.231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AC57719CD
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 08:27:50 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id D67E9100009;
        Thu, 12 May 2022 15:27:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1652369269;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bTo/5H4S2lfutSVjIFOtxPBKa00dzpI8fzGECTbektk=;
        b=aMsmRGb40cMjNgTpHK9UOyDX84s78UdssoaQX1PkEC+Upxlmnpw92Iujxww/AY3xQwVr07
        guLl1RlV4KHyGHnKTe6wS7jqzazkiWhl/e62oUjw7QHcDmULKa7T3xzX3zOLkefp5MZK5a
        HEIjOJ3CipcCXiou1eKSOanrkOWyWA1H4qDdQOXOrJUhZEBc3QE2YLQ+j3HqeFZS7HKv2O
        xS5rnfKjsKJVl4guSf/1bsPn/bfckpS4JSFYNAt+LAk9j17GWorKyK40jZdGomMD/UcwBU
        sNhlD27RMDxwZdTduVnJ1ga1kZN/8d+XL8G81wvZ3ID/iGs3bqyQeIR0hEr00A==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     cgel.zte@gmail.com, miquel.raynal@bootlin.com
Cc:     richard@nod.at, vigneshr@ti.com, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org, Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: Re: [PATCH] mtd: rawnand: cs553x: simplify the return expression of cs553x_write_ctrl_byte()
Date:   Thu, 12 May 2022 17:27:47 +0200
Message-Id: <20220512152747.245142-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220505022354.61458-1-chi.minghao@zte.com.cn>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'c96f824af0e9f88299430db8360dfc9e6c40df36'
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

On Thu, 2022-05-05 at 02:23:54 UTC, cgel.zte@gmail.com wrote:
> From: Minghao Chi <chi.minghao@zte.com.cn>
> 
> Simplify the return expression.
> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next, thanks.

Miquel
