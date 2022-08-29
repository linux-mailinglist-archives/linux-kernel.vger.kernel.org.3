Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 357AC5A558E
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 22:31:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230009AbiH2Ub3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 16:31:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbiH2Ub0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 16:31:26 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E62F7C52A
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 13:31:24 -0700 (PDT)
Received: from nazgul.tnic (unknown [78.130.214.203])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 78A201EC01D4;
        Mon, 29 Aug 2022 22:31:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1661805078;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=HXFKR/sxXQucLU5gtUUqwBnf67dn8lwb4P6VLiQ/YJk=;
        b=YbaGHoOFde3Z6EYNQeGuj5DR7qBgiDlrxxBW+vSKeHZ8MApGT+7pzR/vzfGsS+Pa/bRc3i
        5X263c1OKknyUoWrsRWe6EYxskm32UdBn8r/Up/0IcBjCSxFqG8j1yd52NP9yiHP6gpl5P
        OVW01JYrPjLhhuUxm2PRglzDiPsh2Ck=
Date:   Mon, 29 Aug 2022 22:31:22 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Ashok Raj <ashok.raj@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML Mailing List <linux-kernel@vger.kernel.org>,
        X86-kernel <x86@kernel.org>, Dave Hansen <dave.hansen@intel.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Ingo Molnar <mingo@kernel.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Tony Luck <tony.luck@intel.com>
Subject: Re: [PATCH] x86/microcode/intel: Allow late loading only if a min
 rev is specified
Message-ID: <Yw0iDnZ+dB4ULSs/@nazgul.tnic>
References: <20220829180436.716672-1-ashok.raj@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220829180436.716672-1-ashok.raj@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 29, 2022 at 06:04:36PM +0000, Ashok Raj wrote:
> @@ -886,7 +905,7 @@ static bool is_blacklisted(unsigned int cpu)
>  }
>  
>  static enum ucode_state request_microcode_fw(int cpu, struct device *device,
> -					     bool refresh_fw)
> +					     bool late_loading)
>  {

Until the refresh_fw's function hasn't been clarified:

https://lore.kernel.org/all/YwaBim3Xt3Il3KXm@zn.tnic/

NAK,

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
