Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C66149C5D7
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 10:08:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238770AbiAZJIq convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 26 Jan 2022 04:08:46 -0500
Received: from lithops.sigma-star.at ([195.201.40.130]:51450 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231573AbiAZJIp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 04:08:45 -0500
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id CD33060F6B7A;
        Wed, 26 Jan 2022 10:08:43 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id dIlqLNVsVTqD; Wed, 26 Jan 2022 10:08:43 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 5043362DA600;
        Wed, 26 Jan 2022 10:08:43 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id EiNRw8Th-YAu; Wed, 26 Jan 2022 10:08:43 +0100 (CET)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id 2A48A62DA5F6;
        Wed, 26 Jan 2022 10:08:43 +0100 (CET)
Date:   Wed, 26 Jan 2022 10:08:43 +0100 (CET)
From:   Richard Weinberger <richard@nod.at>
To:     David Decotigny <decot+git@google.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        David Decotigny <ddecotig@google.com>
Message-ID: <1788102040.295765.1643188123063.JavaMail.zimbra@nod.at>
In-Reply-To: <20220126085735.575625-1-decot+git@google.com>
References: <20220126085735.575625-1-decot+git@google.com>
Subject: Re: [PATCH RFC v1 1/1] mtd_blkdevs: avoid soft lockups with some
 mtd/spi devices
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF96 (Linux)/8.8.12_GA_3809)
Thread-Topic: mtd_blkdevs: avoid soft lockups with some mtd/spi devices
Thread-Index: 7VNwHvC77lwvVOD8Pm7M1mqeog4vaw==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

David,

----- Ursprüngliche Mail -----
> Von: "David Decotigny" <decot+git@google.com>
> An: "linux-kernel" <linux-kernel@vger.kernel.org>
> CC: "Miquel Raynal" <miquel.raynal@bootlin.com>, "richard" <richard@nod.at>, "Vignesh Raghavendra" <vigneshr@ti.com>,
> "linux-mtd" <linux-mtd@lists.infradead.org>, "David Decotigny" <ddecotig@google.com>
> Gesendet: Mittwoch, 26. Januar 2022 09:57:35
> Betreff: [PATCH RFC v1 1/1] mtd_blkdevs: avoid soft lockups with some mtd/spi devices

> From: David Decotigny <ddecotig@google.com>
> 
> With some spi devices, the heavy cpu usage due to polling the spi
> registers may lead to netdev timeouts, RCU complaints, etc. This can
> be acute in the absence of CONFIG_PREEMPT. This patch allows to give
> enough breathing room to avoid those false positives.

is the problem real or not? From your description it is not clear to me.
Please include lockdep splats and/or hung-task logs in the commit message.

I have no problem with adding a cond_resched() but first we need to
understand the issue a little better.

Thanks,
//richard
