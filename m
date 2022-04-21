Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7937D509F69
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 14:11:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383363AbiDUMON (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 08:14:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383374AbiDUMOK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 08:14:10 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [185.16.172.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D2E4DEEF
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 05:11:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=vMeIelgutOkoM8kGotV/fRhUy9MuKferx7rzAQHhNV0=; b=ZwcJMtTjnZT6rw2T4ud3rsGQJe
        vp9nSNnFwAKNK0ObtijyCbICSC6Uu+6vMliLTD3p4oD4xc9XV6t5oC4OStL8Vo0wexUAYNCvj7zCp
        lRYtM3o/QFT+UwkGq+iqXp7TAZxiXmJKD/+WG5xDCDi/pK2MEQ5qK3R7T/P/qiC8xq0s=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1nhVeV-00GnUU-M2; Thu, 21 Apr 2022 14:11:15 +0200
Date:   Thu, 21 Apr 2022 14:11:15 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Nathan Rossi <nathan@nathanrossi.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Nathan Rossi <nathan.rossi@digi.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] irqchip/armada-370-xp: Enable MSI affinity configuration
Message-ID: <YmFJ4zKn/9MpjhOh@lunn.ch>
References: <20220421015728.86912-1-nathan@nathanrossi.com>
 <87mtgfgx7d.wl-maz@kernel.org>
 <CA+aJhH026fR5p6-JBaoQikZwC1F-iLBQWrqAvagauKjQoOqykQ@mail.gmail.com>
 <87fsm6ahnh.wl-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87fsm6ahnh.wl-maz@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> I guess we can get at least some testing from the platform maintainers
> to check that this doesn't regress the UP systems.

I have a 370rd which is single core. Let me know what you want
testing.

	Andrew
