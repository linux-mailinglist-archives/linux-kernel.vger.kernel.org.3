Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 431DC5AA7CC
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 08:09:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235400AbiIBGIu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 02:08:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235363AbiIBGIr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 02:08:47 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C621B9590
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 23:08:47 -0700 (PDT)
Received: from nazgul.tnic (dynamic-089-204-154-243.89.204.154.pool.telefonica.de [89.204.154.243])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 506BB1EC0666;
        Fri,  2 Sep 2022 08:08:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1662098921;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=XqvWIssnONBu3zWZPR20jV9qRuNqCibj8y+9a6GR4xc=;
        b=hI845j3kY7FODItUQuMwniKeTefhH9dZ+ATVKMrIBviyvf8PE+UHbFtaJmcjbRXQlvigkv
        0023IQ00q08wrJB9g1nA8ta8ib5ntrum4Ujsn20ICDLmX8OQjOHeHO5BbqafGscMZ+lYFI
        qmDno/RPRahKMaNUSiVs5zpgehzRFwY=
Date:   Fri, 2 Sep 2022 08:08:47 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Ashok Raj <ashok.raj@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML Mailing List <linux-kernel@vger.kernel.org>,
        X86-kernel <x86@kernel.org>, Dave Hansen <dave.hansen@intel.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Ingo Molnar <mingo@kernel.org>, Tony Luck <tony.luck@intel.com>
Subject: Re: [PATCH] x86/microcode/intel: Drop wbinvd(), no longer required
Message-ID: <YxGd5faN0hAamU+j@nazgul.tnic>
References: <20220829182557.729300-1-ashok.raj@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220829182557.729300-1-ashok.raj@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 29, 2022 at 06:25:57PM +0000, Ashok Raj wrote:
> Depends on Link below:

Please send patches together in a set like everyone else. This one
should simply be part of the min_rev set - not sent separately.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
