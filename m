Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3067747FD23
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Dec 2021 14:00:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232286AbhL0NAF convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 27 Dec 2021 08:00:05 -0500
Received: from lithops.sigma-star.at ([195.201.40.130]:36440 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230178AbhL0NAE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Dec 2021 08:00:04 -0500
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 4F12C62DA5F3;
        Mon, 27 Dec 2021 14:00:02 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id HN3e-WWCzBZK; Mon, 27 Dec 2021 14:00:00 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id D7F0862DA5E9;
        Mon, 27 Dec 2021 14:00:00 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id F-fq7s-YxLAv; Mon, 27 Dec 2021 14:00:00 +0100 (CET)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id AE53A62DA5F3;
        Mon, 27 Dec 2021 14:00:00 +0100 (CET)
Date:   Mon, 27 Dec 2021 14:00:00 +0100 (CET)
From:   Richard Weinberger <richard@nod.at>
To:     chengzhihao1 <chengzhihao1@huawei.com>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        mcoquelin stm32 <mcoquelin.stm32@gmail.com>,
        kirill shutemov <kirill.shutemov@linux.intel.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <386802593.207123.1640610000622.JavaMail.zimbra@nod.at>
In-Reply-To: <adc72750-7aca-bb6e-6921-fcaad89485bd@huawei.com>
References: <20211227032246.2886878-1-chengzhihao1@huawei.com> <1020444725.206730.1640599987424.JavaMail.zimbra@nod.at> <adc72750-7aca-bb6e-6921-fcaad89485bd@huawei.com>
Subject: Re: [PATCH v6 00/15] Some bugfixs for ubi/ubifs
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF95 (Linux)/8.8.12_GA_3809)
Thread-Topic: Some bugfixs for ubi/ubifs
Thread-Index: /47XJNMuQTXoGeu4dNvT3yEbYre1rw==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- Ursprüngliche Mail -----
> Von: "chengzhihao1" <chengzhihao1@huawei.com>
>> Thanks a lot for all this fixes! I will start reviewing/picking them an
>> as soon the series is stable.
>> So please don't resend everything if you only add a new patch.
> OK. New patches(If I find new bugs) will be sent indepently. v6 series
> is closed.

Thanks! Your fixes are most appreciated!

Thanks,
//richard
