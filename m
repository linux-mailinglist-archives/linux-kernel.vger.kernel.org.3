Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A7D250B725
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 14:20:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1447371AbiDVMXG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 08:23:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1447508AbiDVMW7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 08:22:59 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [185.16.172.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15205DED9
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 05:20:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=ur/6ta9Iw9bxRMlZt+hvIOUDYWZduFBQUiH0mLU7qSU=; b=c30keb6HOw79gCSMJzNttvTcxU
        r7jaFsqdWcsnDxtttN5je79ekda+VUpN7IAKpcbV4mu6i7w9nYpTPUkR45cM6H/mEH6jcb6doX50h
        dln5oQ5MzFPplsVabJDu8DMKcQ/mtiP0yQs1OAVgn13E3ggS8rkfCFw6WyxoIaLPeFvk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1nhsGR-00GyEV-0Z; Fri, 22 Apr 2022 14:19:55 +0200
Date:   Fri, 22 Apr 2022 14:19:54 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Nathan Rossi <nathan@nathanrossi.com>
Cc:     Marc Zyngier <maz@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Nathan Rossi <nathan.rossi@digi.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] irqchip/armada-370-xp: Enable MSI affinity configuration
Message-ID: <YmKdajB8ufVz5meG@lunn.ch>
References: <20220421015728.86912-1-nathan@nathanrossi.com>
 <87mtgfgx7d.wl-maz@kernel.org>
 <CA+aJhH026fR5p6-JBaoQikZwC1F-iLBQWrqAvagauKjQoOqykQ@mail.gmail.com>
 <87fsm6ahnh.wl-maz@kernel.org>
 <YmFJ4zKn/9MpjhOh@lunn.ch>
 <CA+aJhH1uRWrW1+WJiWoH7pge49gc=SvWQ1L+UpLk+Hin5eo4uQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+aJhH1uRWrW1+WJiWoH7pge49gc=SvWQ1L+UpLk+Hin5eo4uQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> If you have a PCIe device that you can use with the 370 rd.

Sorry, nothing on its bus.

The only device i have which might make sense testing is a
WRT1900ac. That has an Armada XP dual core. I could try building a UP
kernel for it, but i guess you have tried that already with your
machine in order to test a UP setup?

	Andrew
