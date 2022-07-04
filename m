Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E3A7564DAB
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 08:25:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231986AbiGDGZj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 02:25:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbiGDGZi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 02:25:38 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C921C62C7;
        Sun,  3 Jul 2022 23:25:37 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 57A228061;
        Mon,  4 Jul 2022 06:20:12 +0000 (UTC)
Date:   Mon, 4 Jul 2022 09:25:35 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Yu-Tung Chang <mtwget@gmail.com>
Cc:     Benoit Cousson <bcousson@baylibre.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-omap@vger.kernel.org,
        devicetree@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] ARM: dts: am33xx: Fix MMCHS0 dma properties
Message-ID: <YsKH3xLpWw4X1h2P@atomide.com>
References: <20220620124146.5330-1-mtwget@gmail.com>
 <YrmMdcz9mJS1sXyS@atomide.com>
 <CAHRgzyOsxaC2HM=xAMxFUadTEdTBk-yiMjC=-Y=UynoiULSXDw@mail.gmail.com>
 <CAHRgzyOgmxTVV6sqSk_ZWYytergDj5haW=EdFCKCyTg+r6Zd-A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHRgzyOgmxTVV6sqSk_ZWYytergDj5haW=EdFCKCyTg+r6Zd-A@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Yu-Tung Chang <mtwget@gmail.com> [220701 06:09]:
> Yu-Tung Chang <mtwget@gmail.com> 于2022年7月1日周五 14:04写道：
> >
> > Tony Lindgren <tony@atomide.com> 于2022年6月27日周一 18:54写道：
> >
> > >
> > > Hi,
> > >
> > > * YuTong Chang <mtwget@gmail.com> [220620 15:36]:
> > > > According to technical manual(table 11-24), the DMA of MMCHS0 should be
> > > > direct mapped.
> > >
> > > Could this be a bug in the manual assuming mmchs0 is working? Or does this
> > > fix something for you?
> > >
> > It modified in commit b5e5090660742c838ddc0b5d1a001e6fe3d5bfd5,
> > the dma of mmc1 was changed to edma_xbar and did not explain why it should
> > not match the document.
> > > Regards,
> > >
> > > Tony
> No evidence of any official documentation error, before submitting
> b5e5090660742c838ddc0b5d1a001e6fe3d5bfd5, the mmc1 dma properties
> matches the official documentation.

OK thanks for clarifying. will apply to fixes with a fixes tag.

Regards,

Tony
