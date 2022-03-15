Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C7784DA3D4
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 21:18:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351636AbiCOUTK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 16:19:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234688AbiCOUTI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 16:19:08 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F516DFEB;
        Tue, 15 Mar 2022 13:17:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:
        Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description;
        bh=JnUa+YRu6mZZPEMLjHBkJ1cwcALvqIyW++Bmuo2cvXs=; b=2fXsfiQkV73mUutJWA7sFKeBeW
        E3OL9EMestEQlmiD0Fzsx52rTPC01+dtQ2InsC1u8f4GFk7Nh4SKqb8n1OvKqZRRcT6fKkfQOQS2q
        FrHfUXZ2B9DhV2tZCJ5u2GBm3IDu/OCCEDyr7BdsFKLY92/OUIbNvUSY1SR/HH37y6vjqX/2Fz5xV
        M3xbO870Xd3AKnJximmfkX9+kJR07Ubt8Hmn2PTJOn5rJl1e43ASEwl2f5io684WV2rqz8s83NyGF
        8FHdP0PgDIZLxc3G/qszTIzdhHDTMjTgq1BxnXe4ehVHjhz8c4mN+Wo2edllrS/PtAyM/5oZXWN7c
        rCb3xLLQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nUDbz-00AYjf-7H; Tue, 15 Mar 2022 20:17:43 +0000
Date:   Tue, 15 Mar 2022 13:17:43 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Zhen Ni <nizhen@uniontech.com>
Subject: Re: linux-next: manual merge of the sysctl tree with the tip tree
Message-ID: <YjD0Z7UQ0psJT7b0@bombadil.infradead.org>
References: <20220315201840.6146f234@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220315201840.6146f234@canb.auug.org.au>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 15, 2022 at 08:18:40PM +1100, Stephen Rothwell wrote:
> Hi all,
>=20
> Today's linux-next merge of the sysctl tree got a conflict in:
>=20
>   kernel/sched/deadline.c
>=20
> between commit:
>=20
>   eb77cf1c151c ("sched/deadline: Remove unused def_dl_bandwidth")
>=20
> from the tip tree and commit:
>=20
>   ebb891f03580 ("sched: Move deadline_period sysctls to deadline.c")
>=20
> from the sysctl tree.

Peter,

to help avoid conflicts I spinned up a sysctl-next tree to collect
different cleanups going on kernel/sysctl.c. I can drop=20
ebb891f03580 ("sched: Move deadline_period sysctls to deadline.c")
but I think we'd still run into conflicts as other sysctls are
trimmed out. Would you be OK in me taking in eb77cf1c151c
("sched/deadline: Remove unused def_dl_bandwidth") to avoid this
conflict?

  Luis
