Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D1C847914F
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 17:18:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238940AbhLQQSZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 11:18:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233570AbhLQQSY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 11:18:24 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B5C0C061574;
        Fri, 17 Dec 2021 08:18:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 35D25B82954;
        Fri, 17 Dec 2021 16:18:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68395C36AE1;
        Fri, 17 Dec 2021 16:18:20 +0000 (UTC)
Date:   Fri, 17 Dec 2021 16:18:17 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [next] arm64: efi-rt-wrapper.S:8: Error: unknown mnemonic `bti'
 -- `bti c'
Message-ID: <Yby4SWI97Qb7D43R@arm.com>
References: <CA+G9fYt-k1daHarGoXKz7uYvsAcDMNM2bk7jRcYBNf0sRE=+LQ@mail.gmail.com>
 <YbyX+I2PBwio0MYk@arm.com>
 <YbyjerZen9CwYKSV@sirena.org.uk>
 <YbyyaX/7S+1PqRYq@arm.com>
 <Yby20BrmNBtb6tIq@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yby20BrmNBtb6tIq@sirena.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 17, 2021 at 04:12:00PM +0000, Mark Brown wrote:
> On Fri, Dec 17, 2021 at 03:53:13PM +0000, Catalin Marinas wrote:
> > On Fri, Dec 17, 2021 at 02:49:30PM +0000, Mark Brown wrote:
> 
> > > That seems sensible to me, especially given the small number of files
> > > affected.  The other thing would be to decide that all assembly files
> > > should have the header included by default but that seems like it's
> > > invasive and probably disproportionate.
> 
> > There's also this:
> 
> True, that's even simpler.

I'll fold this into your bti patch.

-- 
Catalin
