Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1C2349795B
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 08:22:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241786AbiAXHWS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 02:22:18 -0500
Received: from verein.lst.de ([213.95.11.211]:54411 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241776AbiAXHWO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 02:22:14 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 898DB68BEB; Mon, 24 Jan 2022 08:22:08 +0100 (CET)
Date:   Mon, 24 Jan 2022 08:22:08 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     palmer@dabbelt.com, paul.walmsley@sifive.com,
        aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, wefu@redhat.com, liush@allwinnertech.com,
        guoren@kernel.org, atishp@atishpatra.org, anup@brainfault.org,
        drew@beagleboard.org, hch@lst.de, arnd@arndb.de, wens@csie.org,
        maxime@cerno.tech, dlustig@nvidia.com, gfavor@ventanamicro.com,
        andrea.mondelli@huawei.com, behrensj@mit.edu, xinhaoqu@huawei.com,
        huffman@cadence.com, mick@ics.forth.gr,
        allen.baum@esperantotech.com, jscheid@ventanamicro.com,
        rtrauben@gmail.com, samuel@sholland.org, cmuellner@linux.com,
        philipp.tomsich@vrull.eu
Subject: Re: [PATCH v5 00/14] riscv: support for svpbmt and D1 memory types
Message-ID: <20220124072208.GA21441@lst.de>
References: <20220121163618.351934-1-heiko@sntech.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220121163618.351934-1-heiko@sntech.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 21, 2022 at 05:36:04PM +0100, Heiko Stuebner wrote:
> So this is my try at implementing svpbmt (and the diverging D1 memory
> types using the alternatives framework).

Please spell out what it does.  While I can remember the original single
letter extensions very well, the new priviliged extension naming is
just letter salad.

You might also want to explain in more detail what it does and why you
want to support it.
