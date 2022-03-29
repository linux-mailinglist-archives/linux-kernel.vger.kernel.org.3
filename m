Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FD5D4EA8D4
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 09:55:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233643AbiC2HzY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 03:55:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231993AbiC2HzW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 03:55:22 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E08DA4E3B4;
        Tue, 29 Mar 2022 00:53:29 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 727F580F9;
        Tue, 29 Mar 2022 07:51:24 +0000 (UTC)
Date:   Tue, 29 Mar 2022 10:53:27 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Daniel Palmer <daniel@0x0f.com>
Cc:     Ansuel Smith <ansuelsmth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-actions@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-omap@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@axis.com, linux-aspeed@lists.ozlabs.org,
        linux-rpi-kernel@lists.infradead.org,
        chrome-platform@lists.linux.dev, linux-renesas-soc@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        kernel@dh-electronics.com, linux-mediatek@lists.infradead.org,
        openbmc@lists.ozlabs.org, linux-tegra@vger.kernel.org,
        linux-oxnas@groups.io, linux-arm-msm@vger.kernel.org,
        linux-unisoc@lists.infradead.org,
        linux-rockchip@lists.infradead.org,
        linux-realtek-soc@lists.infradead.org
Subject: Re: [RFC PATCH 0/1] Categorize ARM dts directory
Message-ID: <YkK691VG6ON/6Ysn@atomide.com>
References: <20220328000915.15041-1-ansuelsmth@gmail.com>
 <CAFr9PXkgrRe-=E=GhNnZ4w1x_FMb97-_RmX6ND1vEd74_TbZSw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFr9PXkgrRe-=E=GhNnZ4w1x_FMb97-_RmX6ND1vEd74_TbZSw@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,WEIRD_QUOTING autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

* Daniel Palmer <daniel@0x0f.com> [220328 08:53]:
> Hi Ansuel
> 
> On Mon, 28 Mar 2022 at 09:09, Ansuel Smith <ansuelsmth@gmail.com> wrote:
> >
> > Hi,
> > as the title say, the intention of this ""series"" is to finally categorize
> > the ARM dts directory in subdirectory for each oem.
> 
> While I agree with this change and think it's for the good (browsing
> the ARM dts directory at the moment is frustrating..) I think
> buildroot and others need to be told about this as it'll potentially
> break their kernel build scripting for ARM and probably messes up the
> configs they have for existing boards.

Yeah.. And ideally this would be done in smaller steps as these will
conflict with all the other pending patches.

For example, I have a pile of pending omap clock clean-up dts patches
posted and tested waiting for v5.19-rc1 to apply. I'd rather not start
redoing or fixing up the patches with sed :)

What I'd like to have see is that at some point when suitable we move
one machine at a time with a script if possible.. Maybe the dtb files
generated would need to remain in the current directory until all of
the machine dts files are moved? That should help with the build
scripting too probably :)

In general I like the idea though and I think we should do it.

Regards,

Tony
