Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B58E44842A9
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 14:41:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232467AbiADNlL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 08:41:11 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:38640 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230389AbiADNlK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 08:41:10 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CA07F61277
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jan 2022 13:41:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DF4EC36AE9;
        Tue,  4 Jan 2022 13:41:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641303669;
        bh=k1sszPy8o1sVSI5nXlpYrRpscf6bCQP8QJV3xy5S7zk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LCsf000MoyqWW9DnGDJ63wqblhqHqFSR6T728VmdJOEY5l3oKgqeJCW4eMesEaUyU
         VS69F0h4iPU1HF9KC8jGJEVYCy/pi4F3MXDGAVHD9Gtle4g8kZBZBO9LHwTRdOFvxD
         y/hRObyaO2zmeXABhVLPxtl4ddotwBQCcRVNSPdNsjDFp2Nd8QEy1yTFqn4BNRCbfP
         Z3XyJwzn8H+7Yommo+slqGSu+LYgIt+61xP+DwnPxVNQhS6KZr8N7lahcPPK4BmGFO
         Q6ishztWIi7JRr+PcVkJ7klR+PJgdSttDD9yCCxoKMPt0J2VtsSP0i1puHrcepAdQs
         2LVfpJedFKvdw==
Date:   Tue, 4 Jan 2022 13:41:05 +0000
From:   Will Deacon <will@kernel.org>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     linux-kernel@vger.kernel.org, boqun.feng@gmail.com,
        peterz@infradead.org
Subject: Re: [PATCH] MAINTAINERS: add myself as reviewer for atomics
Message-ID: <20220104134104.GB1827@willie-the-truck>
References: <20220104095018.1990058-1-mark.rutland@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220104095018.1990058-1-mark.rutland@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 04, 2022 at 09:50:18AM +0000, Mark Rutland wrote:
> As I've fiddled about with the atomic infrastructure a fair bit now,
> Peter suggested I should add myself as a reviewer or maintainer to make
> sure I'm Cc'd on anything I might have an opinion on.
> 
> For now, add myself as a reviewer.
> 
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Cc: Boqun Feng <boqun.feng@gmail.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Will Deacon <will@kernel.org>
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index fb18ce7168aa..2f7126e104c9 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3142,6 +3142,7 @@ ATOMIC INFRASTRUCTURE
>  M:	Will Deacon <will@kernel.org>
>  M:	Peter Zijlstra <peterz@infradead.org>
>  R:	Boqun Feng <boqun.feng@gmail.com>
> +R:	Mark Rutland <mark.rutland@arm.com>

Acked-by: Will Deacon <will@kernel.org>

Will
