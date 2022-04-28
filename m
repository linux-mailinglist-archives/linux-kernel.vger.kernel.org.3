Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F41D5136D1
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 16:24:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348304AbiD1O1c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 10:27:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239271AbiD1O1b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 10:27:31 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C440BAFB22;
        Thu, 28 Apr 2022 07:24:16 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id A118E68AFE; Thu, 28 Apr 2022 16:24:12 +0200 (CEST)
Date:   Thu, 28 Apr 2022 16:24:12 +0200
From:   "hch@lst.de" <hch@lst.de>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Sven Peter <sven@svenpeter.dev>, Hector Martin <marcan@marcan.st>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Keith Busch <kbusch@kernel.org>, "axboe@fb.com" <axboe@fb.com>,
        "hch@lst.de" <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>,
        Marc Zyngier <maz@kernel.org>, Janne Grunau <j@jannau.net>,
        DTML <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-nvme@lists.infradead.org
Subject: Re: [PATCH v3 0/6] Apple M1 (Pro/Max) NVMe driver
Message-ID: <20220428142412.GA19708@lst.de>
References: <20220426201539.12829-1-sven@svenpeter.dev> <CAK8P3a1yJkegvgvzHemBd_dowvpyDmxtUnrpiHob8+hiNeO4sw@mail.gmail.com> <0f6ea2c3-586d-4f5a-9cee-688cd73b96b3@www.fastmail.com> <CAK8P3a3pPxpoOZ0hm9htBRyYc7L38F6egi-0=41tMtcLRGJ_jw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a3pPxpoOZ0hm9htBRyYc7L38F6egi-0=41tMtcLRGJ_jw@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 27, 2022 at 07:39:49PM +0200, Arnd Bergmann wrote:
> The usual trick is to have a branch with the shared patches and have
> that pulled into every other tree that needs these, but make sure you never
> rebase. In this case, you could have something like
> 
> a) rtkit driver in a shared branch (private only)
> b) thunderbolt driver based on branch a), merged through
>      thunderbolt/usb/pci tree (I don't know who is responsible here)
> c) sart driver based on branch a), merged through soc tree
> d) nvme driver based on branch c), merged through nvme tree
> 
> since the commit hashes are all identical, each patch only shows up in
> the git tree once, but you get a somewhat funny history.

Given that the nvme driver is just addition of new code I'm perfectly
fine with sending it through whatever tree is most convenient.
