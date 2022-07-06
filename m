Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7E365693A9
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 22:54:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234358AbiGFUyO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 16:54:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231529AbiGFUyH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 16:54:07 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [185.16.172.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ACFE20BD9;
        Wed,  6 Jul 2022 13:54:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
        Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
        In-Reply-To:References; bh=Cn+qe4oiP2jeVARS3ZZalA1ZQM3ZcWF+3cLGOCQIW6g=; b=Fb
        kv18Q9LyGiGlJS2oZq2dTmT5wMOfvxUSXNoM2SkooPf4owOi5EfMUEl+v6TzFPR4/Nc0nyUW7tgbT
        Nf+L0kHfam4g8NF+2pU12gGEMlhAKpOtnZbhGc4/6ddSqeFJMGQEkxi0IprljX04RVheBFA/BxFk/
        QOsAu7OdjH+dLHE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1o9C1q-009W8z-Qk; Wed, 06 Jul 2022 22:53:46 +0200
Date:   Wed, 6 Jul 2022 22:53:46 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Cc:     Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/11] ARM: dts: mvebu: Add definitions for PCIe legacy
 INTx interrupts
Message-ID: <YsX2Wvtz7hEpJ6X+@lunn.ch>
References: <20220706183114.30783-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220706183114.30783-1-pali@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 06, 2022 at 08:31:03PM +0200, Pali Rohár wrote:
> This patch series add definitions for PCIe legacy INTx interrupts into
> every DTS file used by the pci-mvebu.c controller driver.

What you fail to explain in the commit message is Why?

     Andrew
