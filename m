Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4A17506800
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 11:47:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350412AbiDSJuS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 05:50:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241742AbiDSJuP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 05:50:15 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E93EBC34;
        Tue, 19 Apr 2022 02:47:33 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 003B75C018F;
        Tue, 19 Apr 2022 05:47:30 -0400 (EDT)
Received: from imap47 ([10.202.2.97])
  by compute2.internal (MEProxy); Tue, 19 Apr 2022 05:47:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
         h=cc:cc:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1650361650; x=1650448050; bh=7F
        H/cZqwHqkstNxttHiwShTx35esBf5x9xB4oSROZV8=; b=RSNMLGBgDgANeCVu2V
        Q5XHDMelTAniUUIJTvqtY/gqFdq49d3ifi6JBihik0CL1OUDgw05mqp0Lpz0zCdB
        S+er/mNixteyESDqYCQ39ReAQ8A+leQO9puqemXGoN2Zi0w1z35IqpUzooo2VO8U
        Woo2Xq/3XBQny8D4RyTA6WFNi17+4VnuLzxnmdZds97G3+cQWHOx8NUYtrndOzeF
        GoR4xruJ1l6FB7qFpFnPRzpAYPsl9j46NGsXquuJQSrTEknQz0PlHZbJHaepc475
        L8fIRYlGbsVULD6+vn4TuZNe0jCW2zsA3CvsmhM/fUwyNykatY0tE9E/vl1Bf5se
        5m/g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1650361650; x=
        1650448050; bh=7FH/cZqwHqkstNxttHiwShTx35esBf5x9xB4oSROZV8=; b=i
        9+RnVzSBgugZuECfHOZAm1xZajUYSMp4J50UH1XscbROtWy7CZbImt4vsnCWwnUm
        VlpB5SZxTQfcXSdNDN01myghMsKbdvumzkPaNt/mMSJgUPTPtNICGu5evM15G8wz
        ASnEMn33h7dmqy7/iYaPMzQHOkBZAU0sls9fnwcgU5/ka7bYzFFvPKzNidqSkuSe
        k3np/lZLQXva9Qqn3e6Lc/WWas0UTmjBXImqcD65lkkwamWNuoHgvRdsyPWiEPbk
        nZ+fu0dR/+Z+3X5BYwNTYAyrdiUIrAy4Frs7tc4a2HVhf2KPn9znXrxIogiB/E/O
        TgCJXAYa/R34WoNYaalQg==
X-ME-Sender: <xms:MoVeYrRJuEmQp9OW8ELRO8bnthEO0E1WFsyNa2BPvqBWi-lWsaeqVg>
    <xme:MoVeYsw1lUdMLnjHiptY3r0o2-ITx7IsrpiOlcxAF8w1eGVx4B7VY_qciHDvKX6y9
    dyyTrIRU_cgvRV5zsg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrvddtfedgudelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvffutgesthdtredtreertdenucfhrhhomhepfdfuvhgv
    nhcurfgvthgvrhdfuceoshhvvghnsehsvhgvnhhpvghtvghrrdguvghvqeenucggtffrrg
    htthgvrhhnpefgieegieffuefhtedtjefgteejteefleefgfefgfdvvddtgffhffduhedv
    feekffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hsvhgvnhesshhvvghnphgvthgvrhdruggvvh
X-ME-Proxy: <xmx:MoVeYg2ITQBfhRV73oNcpoGHcpcUqG9Ou_BT8Fz5l8XLObV8cV1S2w>
    <xmx:MoVeYrAHHsDC-cCyRFihVJpCApcmXoa4_gMeOJUiuJN4EunHGOnB_A>
    <xmx:MoVeYkgqNbqu-9hFaBiAWD3eemd_RJdaMh7oMIr6KozBdnIeNLrmUQ>
    <xmx:MoVeYlbifUtunMt4WlgOCSCylCF2Wp3l0iTAgDoVhfa8tEuOghHmLw>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 500B22740692; Tue, 19 Apr 2022 05:47:30 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-387-g7ea99c4045-fm-20220413.002-g7ea99c40
Mime-Version: 1.0
Message-Id: <866f79b1-6c02-4248-ac98-594829fed204@www.fastmail.com>
In-Reply-To: <20220419053157.GA31530@lst.de>
References: <20220415142055.30873-1-sven@svenpeter.dev>
 <20220415142055.30873-7-sven@svenpeter.dev> <20220419053157.GA31530@lst.de>
Date:   Tue, 19 Apr 2022 11:47:09 +0200
From:   "Sven Peter" <sven@svenpeter.dev>
To:     "hch@lst.de" <hch@lst.de>
Cc:     "Keith Busch" <kbusch@kernel.org>, "axboe@fb.com" <axboe@fb.com>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "Hector Martin" <marcan@marcan.st>,
        "Alyssa Rosenzweig" <alyssa@rosenzweig.io>,
        "Rob Herring" <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzk+dt@kernel.org>,
        "Arnd Bergmann" <arnd@arndb.de>, "Marc Zyngier" <maz@kernel.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-spdx@vger.kernel.org
Subject: Re: [PATCH v2 6/6] nvme-apple: Add initial Apple SoC NVMe driver
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 19, 2022, at 07:31, Christoph Hellwig wrote:
> On Fri, Apr 15, 2022 at 04:20:55PM +0200, Sven Peter wrote:
>> +++ b/drivers/nvme/host/apple.c
>> @@ -0,0 +1,1597 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Apple ANS NVM Express device driver
>> + * Copyright The Asahi Linux Contributors
>
> Is that actually a valid legal entity?
>
>> +#include <linux/io-64-nonatomic-lo-hi.h>
>
> Does this controller still not support 64-bit MMIO accesses like
> the old Apple PCIe controllers or is this just a leftover?

I just checked again and 64-bit accesses seem to work fine.
I'll remove the lo_hi_* calls and this include.

>
> The rest of the code looks fine to me:
>
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Thanks!


Sven
