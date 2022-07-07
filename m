Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 766C556A892
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 18:50:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236356AbiGGQuT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 12:50:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236110AbiGGQuP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 12:50:15 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [185.16.172.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49D202A422;
        Thu,  7 Jul 2022 09:50:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
        Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
        In-Reply-To:References; bh=ICKmcbHRvrSyUczplI8Beeso0lINOUsmLC2dkDv7txo=; b=1W
        XLVkE4BimNam9FMNOjWyPAdSc/dGRpLNZ4NxYgKyHqxkskxphYQ9ZTIuTBlFn8t4LPg3Ot4MlkB65
        +qIeMQ5wsdCaoLzzFFJWOMAI1wI5M3iUFe6ZWV8q1OZ+whh2xtALwjZak/wYIbz8cr7oafhgTfDCK
        yx0yc4ncLG1hx6U=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1o9UhU-009bFU-2G; Thu, 07 Jul 2022 18:50:00 +0200
Date:   Thu, 7 Jul 2022 18:50:00 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>
Cc:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/11] ARM: dts: mvebu: Add definitions for PCIe legacy
 INTx interrupts
Message-ID: <YscOuEUws9E9nnmm@lunn.ch>
References: <20220706183114.30783-1-pali@kernel.org>
 <YsX2Wvtz7hEpJ6X+@lunn.ch>
 <20220707163818.620ccb95@dellmb>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220707163818.620ccb95@dellmb>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 07, 2022 at 04:38:18PM +0200, Marek Behún wrote:
> On Wed, 6 Jul 2022 22:53:46 +0200
> Andrew Lunn <andrew@lunn.ch> wrote:
> 
> > On Wed, Jul 06, 2022 at 08:31:03PM +0200, Pali Rohár wrote:
> > > This patch series add definitions for PCIe legacy INTx interrupts into
> > > every DTS file used by the pci-mvebu.c controller driver.  
> > 
> > What you fail to explain in the commit message is Why?
> > 
> >      Andrew
> 
> Hi Andrew,
> 
> this is required for example in a scenario where a driver requests only
> one of the legacy interrupts (INTA). Without this change, the driver
> would be notified on events on all 4 (INTA, INTB, INTC, INTD), even if
> it requested only one of them.

O.K, so please add that to the commit message.

Is this purely theoretical, or are there known broken platforms out
there?  Should a subset of these patches be added to stable?

	Andrew
