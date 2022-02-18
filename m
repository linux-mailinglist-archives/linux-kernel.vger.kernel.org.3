Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50E694BB433
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 09:32:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232593AbiBRIcb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 03:32:31 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229923AbiBRIc3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 03:32:29 -0500
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A14F124BC2;
        Fri, 18 Feb 2022 00:32:13 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 6E00D80AF;
        Fri, 18 Feb 2022 08:31:28 +0000 (UTC)
Date:   Fri, 18 Feb 2022 10:32:11 +0200
From:   Tony Lindgren <tony@atomide.com>
To:     Adam Ford <aford173@gmail.com>
Cc:     linux-omap@vger.kernel.org, aford@beaconembedded.com,
        =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm: dts: logicpd-torpedo: Add isp1763 support to
 baseboard
Message-ID: <Yg9Zi2g5DHyCR5xn@atomide.com>
References: <20220210131028.1404851-1-aford173@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220210131028.1404851-1-aford173@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Adam Ford <aford173@gmail.com> [220210 15:10]:
> The baseboard has an ISP1763 USB controller acting as a host.
> Since the pinmuxing for the corresponding IRQ is different
> between OMAP35 and DM37, the pinmux has been placed in the
> kit-level files, while the common code is placed into the
> baseboard file.

Applying into omap-for-v5.18/dt thanks.

BTW, there's a chance that your board has the external dma request
lines wired up to ISP1763, if so you might be able to configure
dmaengine to use it with sdma.

Regards,

Tony
