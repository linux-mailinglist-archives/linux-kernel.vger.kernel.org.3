Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30AC9595BEE
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 14:42:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234885AbiHPMlt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 08:41:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232507AbiHPMlq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 08:41:46 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B69BA3D58
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 05:41:45 -0700 (PDT)
Received: from zn.tnic (p200300ea971b9855329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:971b:9855:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id DBFEF1EC0258;
        Tue, 16 Aug 2022 14:41:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1660653699;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=uocFOI2yc8DT4I+RzQha6VC3DcbR6nmf8NXaarE90GQ=;
        b=ly8Tp7GTbL2vTpXFu5Rqpi2DZxTa8mXwSUjRxz2re9zrn6ufRitaj3hGw3mZOrHPMEo+d1
        b7hMSnqQmKJnoKN3+LNPv+udoklkxZPz6FVvGJT0pVkPbxs8v84RhJNVHvKEqyq5uYKI1E
        3TkYtr8usZuy3F65p5o7kJepcCpvre0=
Date:   Tue, 16 Aug 2022 14:41:39 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Ashok Raj <ashok_raj@linux.intel.com>
Cc:     X86 ML <x86@kernel.org>, Andrew Cooper <amc96@srcf.net>,
        LKML <linux-kernel@vger.kernel.org>,
        =?utf-8?Q?=C8=98tefan?= Talpalaru <stefantalpalaru@yahoo.com>,
        Ashok Raj <ashok.raj@intel.com>
Subject: Re: [PATCH] x86/microcode/AMD: Attempt applying on every logical
 thread
Message-ID: <YvuQgx698T5cgF+C@zn.tnic>
References: <20220814120026.16118-1-bp@alien8.de>
 <YvtcGEHX8eSFpALX@araj-dh-work>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YvtcGEHX8eSFpALX@araj-dh-work>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 16, 2022 at 09:00:14AM +0000, Ashok Raj wrote:
> A re-application means, you want to apply even if the cpu_rev <= patch.rev

Yes.

> if cpu_rev is > patch_rev, clearly its ahead?. say BIOS has a newer
> version than in the initrd image, do we want to replace the BIOS
> version since we do no revid checks here.

Can you even downgrade the microcode through the MSR?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
