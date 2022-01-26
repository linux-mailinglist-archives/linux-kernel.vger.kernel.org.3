Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58FE449C6BB
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 10:43:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231927AbiAZJnV convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 26 Jan 2022 04:43:21 -0500
Received: from lithops.sigma-star.at ([195.201.40.130]:51946 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230306AbiAZJnU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 04:43:20 -0500
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 7400E62DA600;
        Wed, 26 Jan 2022 10:43:19 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id Mj5u7YB1Sny4; Wed, 26 Jan 2022 10:43:19 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 2852062DA5FD;
        Wed, 26 Jan 2022 10:43:19 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id V602CWnTQ0xT; Wed, 26 Jan 2022 10:43:19 +0100 (CET)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id 080E26089354;
        Wed, 26 Jan 2022 10:43:19 +0100 (CET)
Date:   Wed, 26 Jan 2022 10:43:18 +0100 (CET)
From:   Richard Weinberger <richard@nod.at>
To:     David Decotigny <ddecotig@google.com>
Cc:     David Decotigny <decot+git@google.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd <linux-mtd@lists.infradead.org>
Message-ID: <892667198.295852.1643190198952.JavaMail.zimbra@nod.at>
In-Reply-To: <CAG88wWZYbMLYRa9iebAeWtBdLtNWdL4djbPRq36EHrXeNzMsiw@mail.gmail.com>
References: <20220126085735.575625-1-decot+git@google.com> <1788102040.295765.1643188123063.JavaMail.zimbra@nod.at> <CAG88wWZYbMLYRa9iebAeWtBdLtNWdL4djbPRq36EHrXeNzMsiw@mail.gmail.com>
Subject: Re: [PATCH RFC v1 1/1] mtd_blkdevs: avoid soft lockups with some
 mtd/spi devices
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF96 (Linux)/8.8.12_GA_3809)
Thread-Topic: mtd_blkdevs: avoid soft lockups with some mtd/spi devices
Thread-Index: TfhhA1QsuslokIrhxg+yldyMEyrYEw==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- Ursprüngliche Mail -----
> Von: "David Decotigny" <ddecotig@google.com>
> Yes, it is a real problem for us, sent v2 with splat in the commit description.
> The most annoying for us is not the RCU splat per-se, it's the netdev timeout,
> but the trace is not relevant (detected on another core).

Okay. But then it isn't a false positive as you write in the commit message.

Thanks,
//richard
