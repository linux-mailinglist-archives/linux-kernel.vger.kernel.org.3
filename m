Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EED1A463C34
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 17:47:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244531AbhK3QuN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 11:50:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244408AbhK3Qtk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 11:49:40 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33332C06174A;
        Tue, 30 Nov 2021 08:46:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 28049CE1A2E;
        Tue, 30 Nov 2021 16:46:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E545AC53FC7;
        Tue, 30 Nov 2021 16:46:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638290777;
        bh=zQPHCktACgsZcfiSrGjoCRMRpuryXbvbksApzquh8Ic=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nSbMQGIJUKJRfK139+b1SbVf/LIGiFyIm2Dqvsgdrpq5E1D52EXHO/uedW/Y0KSMn
         BGOP88NLzJZpa4uZMnwZ5sqqPKmGNi0E1ZbX2drse9K+jNtDUJMrL6RL6QeTyBNqs2
         CemZ5X8846/olpyyefDFYDSWvjURZStdoLcMaobbBZDtgGfCqIJY6xR+z75fECwE5a
         ZH3PS8u2couJD1KGTH3wypJ3aBhjgTXC5JJaVC9rqCPROuDATWnH8l8pzISonQKGSb
         tBogMC2hjLag78Mb8jTzPnvPtYtPB9I5R2zA7cqamfmoBd+B0YByjCpf6FjenEkKk1
         8PrFPLzqowxLw==
Date:   Tue, 30 Nov 2021 08:46:14 -0800
From:   Keith Busch <kbusch@kernel.org>
To:     Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     linux-raid@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        linux-accelerators@lists.ozlabs.org, linux-nvme@lists.infradead.org
Subject: Re: Using aGPU for RAID calculations (proprietary GRAID SupremeRAID)
Message-ID: <20211130164614.GB3627665@dhcp-10-100-145-180.wdc.com>
References: <ccdbb0d7-d043-d41f-508b-4a464ffa5fe9@molgen.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ccdbb0d7-d043-d41f-508b-4a464ffa5fe9@molgen.mpg.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 30, 2021 at 12:58:10PM +0100, Paul Menzel wrote:
> If GPUs are that much better, are people already working on a FLOSS solution
> for the Linux kernel, so people can “just” plug in a graphics card to
> increase the speed?
> 
> Does the Linux kernel already have an API to offload calculations to
> accelerator cards, so it’s basically plug and play (with AMD graphics cards
> for example using HSA/KFD)? Entropy sources, like the ChaosKey [3], work
> like that. If not, would the implementation go under `lib/raid6`?

I'm not very familiar with the subsystem, but I think these types of
operation APIs are implemented under crypto/async_tx/.
