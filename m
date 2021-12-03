Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5756D4676BB
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 12:51:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380568AbhLCLyc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 06:54:32 -0500
Received: from mail.skyhub.de ([5.9.137.197]:48534 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231944AbhLCLyb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 06:54:31 -0500
Received: from zn.tnic (dslb-088-067-202-008.088.067.pools.vodafone-ip.de [88.67.202.8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 7CBBA1EC0570;
        Fri,  3 Dec 2021 12:51:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1638532262;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=zPDfAsiEDZYwc7di78bVJXliTS+tIc4om0YLnQEcosY=;
        b=GuB3HfWhO3KTpiED8bs6HFOYE/kdCXYNV0IAIa/GgJGxBvLy1XPoI22vX8/cYehGvRjAUp
        s/zfjijqvepEcu/ulBjJsbTarW1ueD0/AsvqcqNqAxU4WgGHqWoOLQzIojvj65GV76RGR1
        zq8oLTxaNuCLOS4bNnGvS1ovg32HK7M=
Date:   Fri, 3 Dec 2021 12:51:06 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc:     Dave Hansen <dave.hansen@intel.com>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, dave.hansen@linux.intel.com,
        hpa@zytor.com, chang.seok.bae@intel.com,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 00/10] x86: Allocate AVX512 xstate ondemand
Message-ID: <YaoEqpNkuAqSlPaq@zn.tnic>
References: <20211203003636.11417-1-jiaxun.yang@flygoat.com>
 <822ced92-f165-3c5a-e0bf-dafa6f808b76@intel.com>
 <27b6387f-fa93-484e-a56e-12452a82f069@www.fastmail.com>
 <d7be6ef4-f73e-923e-93b7-ef254bf347c0@intel.com>
 <e249390b-6f87-47f6-8676-fa727b2fa932@www.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e249390b-6f87-47f6-8676-fa727b2fa932@www.fastmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 03, 2021 at 11:42:10AM +0000, Jiaxun Yang wrote:
> If it's improper I'll drop the statement in commit message :-)

Actually you should answer his question about what happens if you clear
those two bits in that MSR.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
