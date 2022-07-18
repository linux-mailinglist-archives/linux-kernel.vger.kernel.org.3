Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42C0F578609
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 17:07:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235098AbiGRPH0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 11:07:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230427AbiGRPHZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 11:07:25 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92945252A2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 08:07:24 -0700 (PDT)
Received: from zn.tnic (p200300ea972976d7329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9729:76d7:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 1434E1EC04DF;
        Mon, 18 Jul 2022 17:07:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1658156839;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=oGRc12uwCW6Zy2C3e0KwL/G5EXioGouDvvRrw6svDcc=;
        b=Cswe+hKCqyjxvev2BMGHOWXir+N2gI+0BSZztkVbTNyIn5cfy1RIdPZq12dO77obeDIcAn
        RIOwMGCRPdPHudk3rgQyhv/MmZIoXLU8QRSVZDLCSc3jwsPnNA18ye7IgJVjnHK6VDwKUo
        upD856RLOWof7pC+qaH32yh8GGSBudA=
Date:   Mon, 18 Jul 2022 17:07:14 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Bharata B Rao <bharata@amd.com>
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
        x86@kernel.org, dave.hansen@linux.intel.com, nikunj@amd.com,
        hpa@zytor.com, Abraham.Shaju@amd.com
Subject: Re: [RFC FIX PATCH] x86/e820: Stop kernel boot when RAM resource
 reservation fails
Message-ID: <YtV3Ipvt96X/iO2J@zn.tnic>
References: <20220718085815.1943-1-bharata@amd.com>
 <E7A3FF43-C49F-415E-81C6-CD14F4107349@alien8.de>
 <be498c32-bed6-d31a-ae94-6006dd59ea1e@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <be498c32-bed6-d31a-ae94-6006dd59ea1e@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 18, 2022 at 08:24:08PM +0530, Bharata B Rao wrote:
> It may be a weird guest configuration, but it looks like
> a kernel bug exposed by QEMU.

I betcha you can generate a lot of "kernel bugs" with weird qemu
options. If it is not a real use case, nobody cares.

And even if it were a real use case, panicking the machine is not the
right fix.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
