Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFD224DBA75
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 23:00:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352579AbiCPWCG convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 16 Mar 2022 18:02:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232754AbiCPWCE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 18:02:04 -0400
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8FB3C2C
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 15:00:49 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 8A4596081104;
        Wed, 16 Mar 2022 23:00:48 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id oErL0m0ft9MT; Wed, 16 Mar 2022 23:00:48 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 27A666081107;
        Wed, 16 Mar 2022 23:00:48 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id bASUU7w2xFjh; Wed, 16 Mar 2022 23:00:48 +0100 (CET)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id EC3476081104;
        Wed, 16 Mar 2022 23:00:47 +0100 (CET)
Date:   Wed, 16 Mar 2022 23:00:47 +0100 (CET)
From:   Richard Weinberger <richard@nod.at>
To:     libaokun <libaokun1@huawei.com>
Cc:     David Woodhouse <dwmw2@infradead.org>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        yukuai3 <yukuai3@huawei.com>
Message-ID: <936195660.152787.1647468047915.JavaMail.zimbra@nod.at>
In-Reply-To: <c0d05cca-2827-481c-f534-d4fb30b91533@huawei.com>
References: <20220114102854.3399585-1-libaokun1@huawei.com> <c0d05cca-2827-481c-f534-d4fb30b91533@huawei.com>
Subject: Re: [PATCH -next v3 0/2] jffs2: fix two memory leak when mount
 jffs2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF97 (Linux)/8.8.12_GA_3809)
Thread-Topic: jffs2: fix two memory leak when mount jffs2
Thread-Index: a1UdSK/5tz20GyVR92v+jYiFFKkqVQ==
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
> Gesendet: Donnerstag, 10. März 2022 09:34:35
> Betreff: Re: [PATCH -next v3 0/2] jffs2: fix two memory leak when mount jffs2

> A gentle ping, sorry for the noise.

Patches applied.
Thanks for fixing!

Thanks,
//richard
