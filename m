Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB35849C9AB
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 13:29:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241310AbiAZM3E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 07:29:04 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:44636 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241298AbiAZM3D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 07:29:03 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 06265619C4
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 12:29:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B78AC340E3;
        Wed, 26 Jan 2022 12:29:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643200142;
        bh=9EaamjmD9vwFtzb754Mi52eXxFzcSc0EN4SmOkuwgGU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=MTOeXEL3N2P95u8T/bFZdMHIjmitx0MxOzCQlqZfEV/rpp+upRBh/SsVBx0dRbfWF
         TyIB9lPtBJNCzyP4ZaCV9VRx+WDN33irj7e5PWaOvpQsdNuVklU0zztKeigEHTeyFV
         bqKvbXOleFGWiLya93HwHE1WJyQNzqgoELbDX1gafSrKFMhCgmQqQyqSMZP+xQ+pis
         HFA0VNto8vc3kHTyfwbwtDTLJjnBBamf2tY1kZwi7xJ3rXnpWywHimEFj7eCBsb3lA
         tnPCbCbzTGD1KvqDHR0JPaFggZchR/+YjrWnHQLc1WWa+a1Y6zGHcHilOcOxeD+I5V
         v13FUGlvM6OLA==
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1nChQ4-003D2u-9y; Wed, 26 Jan 2022 12:29:00 +0000
MIME-Version: 1.0
Date:   Wed, 26 Jan 2022 12:29:00 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Chao Liu <liuchao173@huawei.com>, catalin.marinas@arm.com,
        will@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, hewenliang4@huawei.com,
        zhoukang7@huawei.com
Subject: Re: [PATCH v2] add cpu frequency to cpuinfo in arm64
In-Reply-To: <bf7fdba2-7850-9d38-157d-7a1e726512a5@arm.com>
References: <20220126092349.285642-1-liuchao173@huawei.com>
 <bf7fdba2-7850-9d38-157d-7a1e726512a5@arm.com>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <c73a9fb20b42f2086a0fb9c068ecc272@kernel.org>
X-Sender: maz@kernel.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: robin.murphy@arm.com, liuchao173@huawei.com, catalin.marinas@arm.com, will@kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, hewenliang4@huawei.com, zhoukang7@huawei.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-01-26 12:05, Robin Murphy wrote:
> On 2022-01-26 09:23, Chao Liu wrote:
>> There is cpu frequency in /proc/cpuinfo in x86 but not in arm64
> 
> arm64 cpuinfo also doesn't show the APIC ID or microcode version.
> Different architectures are different.
> 
> Besides, x86 cpuinfo only shows MHz if the CPU has X86_FEATURE_TSC, so
> for compatibility we should only do this on AArch64 CPUs which have
> X86_FEATURE_TSC.

/me prepares a patch to be sent in just over 2 months...

         M.
-- 
Jazz is not dead. It just smells funny...
