Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F03B546E8A2
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 13:49:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235038AbhLIMwr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 07:52:47 -0500
Received: from mail.skyhub.de ([5.9.137.197]:55330 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230094AbhLIMwq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 07:52:46 -0500
Received: from zn.tnic (dslb-088-067-202-008.088.067.pools.vodafone-ip.de [88.67.202.8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 57AF01EC04DE;
        Thu,  9 Dec 2021 13:49:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1639054148;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=q3M9i0QlpSITzXtwbiQtBavQAFKCEbdUH5cLaclMDsM=;
        b=YQZQyKbsRRMrV3EOEFBkAtyitenanSmDbeonrfDIFMrO3Jeddnugx/m//qc/mUcKNQ+eLS
        IWOGOQ9j05QY5bHcMlSGAhLHfQZZGwMlc5IzdJc2GOb1zCuY2V3MpG/ytPp9uDaaHjWHQ4
        F3tOV90och6JCN5CYhJf6SLGcF7GZBc=
Date:   Thu, 9 Dec 2021 13:49:10 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Hugh Dickins <hughd@google.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Anjaneya Chagam <anjaneya.chagam@intel.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Mike Rapoport <rppt@kernel.org>
Subject: Re: 5.16-rc: "x86/boot: Pull up cmdline" breaks mem=
Message-ID: <YbH7Rlm4/mq0WuTN@zn.tnic>
References: <ae2bb14d-d27a-e76d-adde-ef888d373343@google.com>
 <YbHUW1KTfvJtxNwP@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YbHUW1KTfvJtxNwP@zn.tnic>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Next question: does it boot without having supplied "mem=" on the kernel
cmdline?

And just to make sure I understand correctly: this is 64-bit or 32-bit
kernel?

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
