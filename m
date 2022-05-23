Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2C39531926
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 22:54:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230245AbiEWUgw convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 23 May 2022 16:36:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbiEWUgr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 16:36:47 -0400
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D73BFD3F
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 13:36:42 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id EEAF8608110A;
        Mon, 23 May 2022 22:36:40 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id zyipqiJcGFwc; Mon, 23 May 2022 22:36:40 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 6CBA26081119;
        Mon, 23 May 2022 22:36:40 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 00yZaR6kcrDe; Mon, 23 May 2022 22:36:40 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id 4CE06608110A;
        Mon, 23 May 2022 22:36:40 +0200 (CEST)
Date:   Mon, 23 May 2022 22:36:40 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     libaokun <libaokun1@huawei.com>
Cc:     David Woodhouse <dwmw2@infradead.org>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        yukuai3 <yukuai3@huawei.com>
Message-ID: <1917663619.89751.1653338200219.JavaMail.zimbra@nod.at>
In-Reply-To: <c2f49973-e5be-475a-1b92-77fc6e86ba37@huawei.com>
References: <20220412093816.2280678-1-libaokun1@huawei.com> <c2f49973-e5be-475a-1b92-77fc6e86ba37@huawei.com>
Subject: Re: [PATCH -next] jffs2: fix memory leak in jffs2_do_fill_super
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF97 (Linux)/8.8.12_GA_3809)
Thread-Topic: jffs2: fix memory leak in jffs2_do_fill_super
Thread-Index: VWz2X8e4SAV95IUGqJG18OwMjo62Kw==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- Ursprüngliche Mail -----
> Von: "libaokun" <libaokun1@huawei.com>
> An: "richard" <richard@nod.at>, "David Woodhouse" <dwmw2@infradead.org>, "linux-mtd" <linux-mtd@lists.infradead.org>,
> "linux-kernel" <linux-kernel@vger.kernel.org>
> CC: "yukuai3" <yukuai3@huawei.com>, "libaokun" <libaokun1@huawei.com>
> Gesendet: Montag, 23. Mai 2022 08:00:21
> Betreff: Re: [PATCH -next] jffs2: fix memory leak in jffs2_do_fill_super

> ping

Thanks for your time. You patch will be part of the upcoming merge window.
I'm preparing right now my queue.

Thanks,
//richard
