Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6185B51589E
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Apr 2022 00:40:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381582AbiD2WnL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 18:43:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232481AbiD2WnK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 18:43:10 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [185.16.172.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B17FDCE36
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 15:39:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=fDPoKt+HrSsLHV1IWf+WwrupFNb/c978eaEw5ObuD88=; b=r/mE0w700R7ZiQYVvmxZBE6/Gh
        IwDp0rKfmddkPo40JF9IIkDSKnYIXdCpmJTmu7sOu86Dvucrka3WyvHDUZQMG98IKPm60IAtqi/R3
        DHGX+7NcMtQnWiYwJczGQ7KPuEhvX9QoipFaOqMXzHHEABHIeUYMBiDKVB5uia+fWYGQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1nkZH6-000Ybh-1s; Sat, 30 Apr 2022 00:39:44 +0200
Date:   Sat, 30 Apr 2022 00:39:44 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Cc:     Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] irqchip/armada-370-xp: Do not touch Performance
 Counter Overflow on A375, A38x, A39x
Message-ID: <YmxpMDyPEp7neM4L@lunn.ch>
References: <20220425113706.29310-1-pali@kernel.org>
 <YmvYrFUfIUvfjrmY@lunn.ch>
 <20220429130524.vs6mlzvotvaortbw@pali>
 <YmxlZncjVnym4kfc@lunn.ch>
 <20220429223145.4rubhuiu64ktgklp@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220429223145.4rubhuiu64ktgklp@pali>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On those new Armada SoCs that register is used for unmasking interrupts
> from another hierarchy. Until you start using those new interrupts there
> probably could not be any issue. But in any case unmasking unwanted
> interrupt is not a wise idea...

O.K. Please add the Fixes tag.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
