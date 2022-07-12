Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 123B057217D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 18:59:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233524AbiGLQ7g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 12:59:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231321AbiGLQ7f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 12:59:35 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [185.16.172.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68E14DEE7;
        Tue, 12 Jul 2022 09:59:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
        Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
        In-Reply-To:References; bh=HUhWfnGEox2/HCo9PEzTsvKGjQ6EBjpsz0Yndja9NZM=; b=Ep
        sxnW5MGBYWBmxGFwxMClpi0GfrQWE+l8RciaaicdBmaJVZR19x3efheTGNPBSQU3uy2VrrsXq508a
        taa/+Go1MQ98907VUYTKtDBApBZ8XIGBzpPF9ZYn5CknU4gUulp9y29QMRhLMLC96xnBHc1Ksnk8q
        4ZUr0b3Wq8hyVFY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1oBJEG-00A4be-HE; Tue, 12 Jul 2022 18:59:20 +0200
Date:   Tue, 12 Jul 2022 18:59:20 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>
Cc:     Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 00/10] ARM: dts: mvebu: Add definitions for PCIe
 legacy INTx interrupts
Message-ID: <Ys2oaL7U7Ue5syU4@lunn.ch>
References: <20220712164108.30262-1-kabel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220712164108.30262-1-kabel@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 12, 2022 at 06:40:58PM +0200, Marek Behún wrote:
> As suggested by Gregory [1] (although he suggested it only for armada
> 380), add definitions for PCIe legacy INTx interrupts into every DTS
> file used by the pci-mvebu.c controller driver.
> 
> It was tested on 88F6820 (A385) and 88F6281 (Kirkwood) SoCs.
> 
> [1] https://lore.kernel.org/linux-arm-kernel/87wnhxjxlq.fsf@BL-laptop/
> 
> Changes since v1:
> - dropped armada-385 patch, which was already applied
> - added commit messages

Thanks for updating the commit message.

I don't see any Fixes: tags here. So from that, can i assume that
there are no known broken devices? We don't need to involve stable.

      Andrew
