Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59EC0495674
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 23:48:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378118AbiATWs2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 17:48:28 -0500
Received: from mail.skyhub.de ([5.9.137.197]:51970 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1347719AbiATWsU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 17:48:20 -0500
Received: from zn.tnic (dslb-088-067-202-008.088.067.pools.vodafone-ip.de [88.67.202.8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 6D6F11EC04DB;
        Thu, 20 Jan 2022 23:48:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1642718895;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=RF5c4TYC1hPw++nx52jVFiblIAdK9umcAQMhWne90Pg=;
        b=ERJu9R0fw7zz8m9s0R7Kb8OOMQvZfowSMLmHwr3QpgkP9AQwL34qTMEy7wJr3uOCUWU0hn
        PRjjU5FkuybTrakRQ4O0URGjEB+fuhX8sZFUraj1rkTAibWYQNgE698Ga+fOrIhK7bqhmO
        nDDmXXdhknVnVLOq65Mx7g8saVLuj04=
Date:   Thu, 20 Jan 2022 23:48:08 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Smita Koralahalli Channabasappa 
        <smita.koralahallichannabasappa@amd.com>,
        Wei Huang <wei.huang2@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>, patches@lists.linux.dev
Subject: Re: [PATCH 5/5] x86/sysfs: Add PPIN in sysfs under cpu topology
Message-ID: <YenmqFQTOfoS+SfF@zn.tnic>
References: <20220107225442.1690165-1-tony.luck@intel.com>
 <20220107225442.1690165-6-tony.luck@intel.com>
 <YellN/3VCasDI3OD@zn.tnic>
 <Yemjj26elXuOcegg@agluck-desk2.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Yemjj26elXuOcegg@agluck-desk2.amr.corp.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 20, 2022 at 10:01:51AM -0800, Luck, Tony wrote:
> It "looks" unused, But thanks to the obscurity of CPP macros using ## to
> concatenate tokens it is needed.

Ofcourse it is.

It crossed my mind for a second that, hey, that is *probably* used by
some macro magic there... oh well.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
