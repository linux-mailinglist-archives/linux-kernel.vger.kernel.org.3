Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 122BD58E113
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 22:29:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245299AbiHIU3E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 16:29:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbiHIU25 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 16:28:57 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [185.16.172.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8CBC15836
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 13:28:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
        Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
        In-Reply-To:References; bh=WzyxwCXTfqk6ud8YARaV8APFRfCdh9+ufb34JO+fLYY=; b=Y8
        I1d9RNBp5P+zWylZEcVdWpBsSzsdKADJN1C48ZzRhVeBzbez5COdHPx3UKmkrrAMDjlnULtCgXJc7
        01N/o2a8uZ68mqxeFrUpKbVhn5ofjz7+XwdY8XdQBgL58likKJI7h49OsHEYFGS2gFqVm3RkmQ2XV
        Yi+auKhHLNK5XJA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1oLVqN-00CsQc-Bw; Tue, 09 Aug 2022 22:28:51 +0200
Date:   Tue, 9 Aug 2022 22:28:51 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Cc:     Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: turris-omnia: Add ethernet aliases
Message-ID: <YvLDg7lbbaTF668e@lunn.ch>
References: <20220727130926.1874-1-pali@kernel.org>
 <20220727131504.avbfyoydzgcf6wyo@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220727131504.avbfyoydzgcf6wyo@pali>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 27, 2022 at 03:15:04PM +0200, Pali Rohár wrote:
> On Wednesday 27 July 2022 15:09:26 Pali Rohár wrote:
> > This allows bootloader to correctly pass MAC addresses used by bootloader
> > to individual interfaces into kernel device tree.
> > 
> > Signed-off-by: Pali Rohár <pali@kernel.org>
> > ---
> 
> Maybe this should have Fixes line?
> 
> Fixes: 26ca8b52d6e1 ("ARM: dts: add support for Turris Omnia")

Is it broken with older kernels? That is a big part of Fixes: to
indicate it needs back porting. Is this a new u-boot feature?

	 Andrew
