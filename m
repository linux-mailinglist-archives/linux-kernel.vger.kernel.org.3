Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3242758E14E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 22:45:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343544AbiHIUp1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 16:45:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343714AbiHIUpW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 16:45:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B990360E5
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 13:45:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4A85060EE2
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 20:45:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FB39C433C1;
        Tue,  9 Aug 2022 20:45:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660077917;
        bh=9KJdonOg4u1iSkkOzi21IONx6muGEp+9s546Vhnx15Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=f0dw6ZFU6iW5hCI1Mou34KdaBR06Qk85oO0GD+xFfyP+dP8MNRN8avo4amp3GZ7EE
         gT2b+bDpw5gwz8zH3+D5m3kLgbDAm41VJLqax4TOBRYi4ZZQiaMWa8a/cN+atGSTrU
         usVeI7l7RZhenk5OakuJnlEToTfk8LLXpOVNmARWHRZ+iXNZW/1of5qug6hWYw+wyY
         +RKS1Y3U41SJIEaHQXOvcdKhe8b347NrSZtj49t4iSq7EQnbNkJJLMvjoAIAPJYgUx
         WfZwQr+4ESAK/1lNBjvamXU3eJOExTrce7bsvRQpOOYImPTakjM30VmBm4M1P3rqAs
         1pYmP56JTNpoQ==
Received: by pali.im (Postfix)
        id 9D6F4C1F; Tue,  9 Aug 2022 22:45:14 +0200 (CEST)
Date:   Tue, 9 Aug 2022 22:45:14 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: turris-omnia: Add ethernet aliases
Message-ID: <20220809204514.wu2om56mljsw4flz@pali>
References: <20220727130926.1874-1-pali@kernel.org>
 <20220727131504.avbfyoydzgcf6wyo@pali>
 <YvLDg7lbbaTF668e@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YvLDg7lbbaTF668e@lunn.ch>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 09 August 2022 22:28:51 Andrew Lunn wrote:
> On Wed, Jul 27, 2022 at 03:15:04PM +0200, Pali Rohár wrote:
> > On Wednesday 27 July 2022 15:09:26 Pali Rohár wrote:
> > > This allows bootloader to correctly pass MAC addresses used by bootloader
> > > to individual interfaces into kernel device tree.
> > > 
> > > Signed-off-by: Pali Rohár <pali@kernel.org>
> > > ---
> > 
> > Maybe this should have Fixes line?
> > 
> > Fixes: 26ca8b52d6e1 ("ARM: dts: add support for Turris Omnia")
> 
> Is it broken with older kernels? That is a big part of Fixes: to
> indicate it needs back porting. Is this a new u-boot feature?
> 
> 	 Andrew

This is old u-boot feature. I was investigating why u-boot is not able
to correctly modify loaded omnia dtb file when booting linux kernel and
I found out that it is because it cannot due to missing ethernet
aliases.

Also there is a new u-boot feature for omnia to correctly put
phy-reset-gpios property into eth 2 node based on board hw revision. So
this is another purpose for which we should have those aliases, to allow
kernel to correctly reset wan (eth 2) PHY.

I would suggest this change for backporting into stable.
