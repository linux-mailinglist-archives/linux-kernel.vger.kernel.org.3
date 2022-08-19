Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D464B5991BB
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 02:29:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242182AbiHSA2p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 20:28:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229899AbiHSA2l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 20:28:41 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [185.16.172.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8A1245993;
        Thu, 18 Aug 2022 17:28:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=N9AdnJXVSulV2NDRxSIoMMHkLPmTPUvpjuo4a+Kkp2k=; b=QUwTKFZAPfeDoz5e+6ueTCA8QG
        j4lLTVjmhipCbrtjz+8lLoowceemkqhSYjEe+hh5YdHCEZrFSoKfL215fPBIrHPJuTOssKXKfnPuD
        YFRSHPHSNPWbhMu0QVcYf32XVZbdIdK4AvqxKlI3Y9B4MEjJJAQPQWRZI1RGpM2ErMhQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1oOpsI-00DrM4-55; Fri, 19 Aug 2022 02:28:34 +0200
Date:   Fri, 19 Aug 2022 02:28:34 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Michael Walle <michael@walle.cc>
Cc:     Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jason Cooper <jason@lakedaemon.net>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] ARM: dts: kirkwood: lsxl: fix serial line
Message-ID: <Yv7ZMhWoAk75iYEZ@lunn.ch>
References: <20220816001026.830127-1-michael@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220816001026.830127-1-michael@walle.cc>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 16, 2022 at 02:10:24AM +0200, Michael Walle wrote:
> Commit 327e15428977 ("ARM: dts: kirkwood: consolidate common pinctrl
> settings") unknowingly broke the serial output on this board. Before
> this commit, the pinmux was still configured by the bootloader and the
> kernel didn't reconfigured it again. This was an oversight by the
> initial board support where the pinmux for the serial line was never
> configured by the kernel. But with this commit, the serial line will be
> reconfigured to the wrong pins. This is especially confusing, because
> the output still works, but the input doesn't. Presumingly, the input is
> reconfigured to MPP10, but the output is connected to both MPP11 and
> MPP5.
> 
> Override the pinmux in the board device tree.
> 
> Fixes: 327e15428977 ("ARM: dts: kirkwood: consolidate common pinctrl settings")
> Signed-off-by: Michael Walle <michael@walle.cc>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
