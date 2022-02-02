Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5099A4A72C5
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 15:12:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344817AbiBBOMs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 09:12:48 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:53046 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233774AbiBBOMn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 09:12:43 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 02F96B830CE;
        Wed,  2 Feb 2022 14:12:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95E56C004E1;
        Wed,  2 Feb 2022 14:12:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643811160;
        bh=ogjzsNyMwo6xtmhQOh1B06vCogdC1BI1El85ZeLtyZQ=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=szYg+xr4UGMEPlBzgkYi5r7cROIzc70qrpbwifqlRP/Pzjnh+NpqpS8aNqXot6Scb
         ZxhtvSMZEnH2rFxAHTuybxEtQye8XTvJQ50WhyyvXStz/o9wJBh1I3zF2UnKXWXwX8
         i0uxlbULFyjH0FiBGJMXBOH0wZOgtKfaOfrUAqjAvdOcPEtbov6xto4BoCeHXyU1j5
         YsNmjM6FUv1fz91jI1y44fWJkhjM50PaMURnXooWiQHuZCjVCOBCD+bUApR8uQ/mxi
         7TskmDckEsQnZZSJFHiTNjVDN2jeqTu+mJ3FFeW81ZwrE9dQw7NZeRKooIMPRZZnPz
         /R9xft3qmUM3A==
Date:   Wed, 2 Feb 2022 15:12:37 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     Desmond Lim <peckishrine@gmail.com>
cc:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Kinglong Mee <kinglongmee@gmail.com>,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Subject: Re: [PATCH v3] HID: add SiGma Micro driver
In-Reply-To: <20211230152758.79104-1-peckishrine@gmail.com>
Message-ID: <nycvar.YFH.7.76.2202021512240.11721@cbobk.fhfr.pm>
References: <20211230152758.79104-1-peckishrine@gmail.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Dec 2021, Desmond Lim wrote:

> Fix for SiGma Micro-based keyboards where all the modifier keys mapped
> to Shift_L.
> 
> Co-developed-by: Kinglong Mee <kinglongmee@gmail.com>
> Signed-off-by: Kinglong Mee <kinglongmee@gmail.com>
> Signed-off-by: Desmond Lim <peckishrine@gmail.com>
> ---
> Changes since v2:
>  - Rewrite commit title and message, and hence supersedes [1]
>  - Additional verification before fixing rdesc
> 
> Changes since v1:
>  - Update commit message
>  - Correct Kconfig dependency
> 

Applied, thank you.

-- 
Jiri Kosina
SUSE Labs

