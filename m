Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 405FB50F297
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 09:35:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344057AbiDZHhp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 03:37:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245231AbiDZHhd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 03:37:33 -0400
Received: from relay10.mail.gandi.net (relay10.mail.gandi.net [IPv6:2001:4b98:dc4:8::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ABA01331AF
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 00:34:27 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 782F5240003;
        Tue, 26 Apr 2022 07:34:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1650958466;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=J7YqhSKrC6vTx6OTh1GjxytRJNzGy9mqDr77XFHjCPs=;
        b=mTJhjFFaz1YVlT4I4REZKOw6I09IhEYF/GucMkR+GC+Pq8BS5ApXyW+cqlY+TbiAyZ8BnV
        Mw80yYVcleIrHonCtHFZHwGojAt6mhnERa+57ZLi7kSTduitPEV8qWAvq0v/1SPsFgb+Va
        9mgQrUBNUs8XTdIsgGKwMtj31vHvGy8Lc2ZI2szNmG2TSQHEtAadO82CSPXIqsjskDhC3m
        DFr5GXb0EiEJ0gsToP0qae+3AVINE3UFLw4B7v2XfXDJ2Bzx/W19P492bpFF7+yr3pprll
        cRQMM7vU81dYe/vL0yhcs/erx4ZkIZ/lbzgaOZzdhwFRf74d0EV2t80lg5SQZA==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Jean-Marc Eurin <jmeurin@google.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/3] mtd: mtdoops: Fix the size of the header read buffer.
Date:   Tue, 26 Apr 2022 09:34:25 +0200
Message-Id: <20220426073425.37044-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220421234244.2172003-2-jmeurin@google.com>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'fbb83e546ea4543ab0c59dcbfc5a5a1471ea1806'
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2022-04-21 at 23:42:42 UTC, Jean-Marc Eurin wrote:
> The read buffer size depends on the MTDOOPS_HEADER_SIZE.
> 
> Tested: Changed the header size, it doesn't panic, header is still
> read/written correctly.
> 
> Signed-off-by: Jean-Marc Eurin <jmeurin@google.com>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git mtd/next, thanks.

Miquel
