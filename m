Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEEF75063E5
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 07:32:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237971AbiDSFep (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 01:34:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230301AbiDSFen (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 01:34:43 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D22151277F;
        Mon, 18 Apr 2022 22:32:01 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 253EA68AFE; Tue, 19 Apr 2022 07:31:58 +0200 (CEST)
Date:   Tue, 19 Apr 2022 07:31:57 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Sven Peter <sven@svenpeter.dev>
Cc:     Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Hector Martin <marcan@marcan.st>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Marc Zyngier <maz@kernel.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-spdx@vger.kernel.org
Subject: Re: [PATCH v2 6/6] nvme-apple: Add initial Apple SoC NVMe driver
Message-ID: <20220419053157.GA31530@lst.de>
References: <20220415142055.30873-1-sven@svenpeter.dev> <20220415142055.30873-7-sven@svenpeter.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220415142055.30873-7-sven@svenpeter.dev>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 15, 2022 at 04:20:55PM +0200, Sven Peter wrote:
> +++ b/drivers/nvme/host/apple.c
> @@ -0,0 +1,1597 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Apple ANS NVM Express device driver
> + * Copyright The Asahi Linux Contributors

Is that actually a valid legal entity?

> +#include <linux/io-64-nonatomic-lo-hi.h>

Does this controller still not support 64-bit MMIO accesses like
the old Apple PCIe controllers or is this just a leftover?

The rest of the code looks fine to me:

Reviewed-by: Christoph Hellwig <hch@lst.de>
