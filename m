Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 976854CD17A
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 10:42:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239245AbiCDJna (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 04:43:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239456AbiCDJnH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 04:43:07 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70880C7923;
        Fri,  4 Mar 2022 01:42:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2C9E0B827B9;
        Fri,  4 Mar 2022 09:42:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9195DC340E9;
        Fri,  4 Mar 2022 09:42:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646386937;
        bh=ITQF2S+lola6aOQE8U2dPMabVkkAQToMiu1b8mttRzg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gRrYrKzRTpPLZO4AERpKJAnNI2q/EDRZNYC6qFii5ym6CHa7If/CiXoqC10XePtoR
         KS4OTMguHkQsll0fDBdluiCR4+BUSq5p6NjPokiGqzELH02auxdux4AuHmOBbHo9Ai
         rTVxc+WnmXwLB8bRQjSJl19FKSRkaQkv5dEg9m3vPVKIYFeF7bDjfxDKG4PhXmlahw
         YwnNIW8r/SZvv1ddhHdydbneJRKvQe2bcVZ3BgTimq3eBet2RUlN3GfElDVwwirMrA
         th0IAcAWgPGjqrB3FwTHFGwQUSO8tXfTpTPYRLsT5gQKkME+ia52Qy7KaG3e0hTa9w
         qO3p6wnuLLmvg==
Date:   Fri, 4 Mar 2022 11:41:37 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     linux-sgx@vger.kernel.org
Cc:     Nathaniel McCallum <nathaniel@profian.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" 
        <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH v2.1 01/30] x86/sgx: Add short descriptions to ENCLS
 wrappers
Message-ID: <YiHe0bwFL10vT+fy@iki.fi>
References: <20220304093524.397485-1-jarkko@kernel.org>
 <YiHejzFlR+p14KHN@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YiHejzFlR+p14KHN@iki.fi>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 04, 2022 at 11:40:34AM +0200, Jarkko Sakkinen wrote:
> This is just a bug fixed version of v2, and also the requirement
> to do obsolete round trip with EMODPE has been optimized away.
> I hope that v3 is rolled out quickly because now there is no
> comparison point. We can have speculative discussions whether
> ioctl or #PF is better but no means to benchmark. Thus, a quick
> patch set revision roll out would be such a great thing.
> 
> Based on https://lore.kernel.org/linux-sgx/20220304033918.361495-1-jarkko@kernel.org/T/#u
> 
> BR, Jarkko

The patches are available also in this git branch:

https://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-sgx.git/log/?h=sgx2-v2.1

BR, Jarkko
