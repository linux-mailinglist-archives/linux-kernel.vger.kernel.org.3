Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B21A4F9A48
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 18:14:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231365AbiDHQQl convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 8 Apr 2022 12:16:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237821AbiDHQQC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 12:16:02 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5528BE09E
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 09:13:52 -0700 (PDT)
Received: from ip5b412258.dynamic.kabel-deutschland.de ([91.65.34.88] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1ncrEz-0004it-3M; Fri, 08 Apr 2022 18:13:41 +0200
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Christoph Hellwig <hch@lst.de>
Cc:     palmer@dabbelt.com, paul.walmsley@sifive.com,
        aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, wefu@redhat.com,
        liush@allwinnertech.com, guoren@kernel.org, atishp@atishpatra.org,
        anup@brainfault.org, drew@beagleboard.org, hch@lst.de,
        arnd@arndb.de, wens@csie.org, maxime@cerno.tech,
        gfavor@ventanamicro.com, andrea.mondelli@huawei.com,
        behrensj@mit.edu, xinhaoqu@huawei.com, mick@ics.forth.gr,
        allen.baum@esperantotech.com, jscheid@ventanamicro.com,
        rtrauben@gmail.com, samuel@sholland.org, cmuellner@linux.com,
        philipp.tomsich@vrull.eu
Subject: Re: [PATCH v8 10/14] riscv: add cpufeature handling via alternatives
Date:   Fri, 08 Apr 2022 18:13:39 +0200
Message-ID: <5557228.DvuYhMxLoT@diego>
In-Reply-To: <20220331100139.GG23422@lst.de>
References: <20220324000710.575331-1-heiko@sntech.de> <20220324000710.575331-11-heiko@sntech.de> <20220331100139.GG23422@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christoph,

Am Donnerstag, 31. März 2022, 12:01:39 CEST schrieb Christoph Hellwig:
> Can you please fold the somewhat confusingly named vendor patching
> into this instead of keeping that magic standalone function pointer
> mess?

I'm not sure it's what you meant, but I did merge patches 10+11
(cpufeatures + svpbmt), as having them separate created build 
warnings / errors, when a bisected build happens (aka up to patch10
but without patch11)

The vendor-patch-func got an overhaul in patch13
"riscv: don't use global static vars to store alternative data"


> > +static const struct cpufeature_info __initdata_or_module cpufeature_list[CPUFEATURE_NUMBER] = {
> > +};
> 
> Overly lone line.

ok, I'll wrap that line


Heiko


