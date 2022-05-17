Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71FE3529CDD
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 10:47:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243146AbiEQIrF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 04:47:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234764AbiEQIrA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 04:47:00 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73FEF43ADB
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 01:46:57 -0700 (PDT)
Received: from zn.tnic (p200300ea97465748329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9746:5748:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id D31EB1EC04F9;
        Tue, 17 May 2022 10:46:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1652777211;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=mdteKB+W+Ir+Ek7S24qGhn5AqZt4pAoxK6idhrOXOiA=;
        b=kx86xIz8b/cosxNH/NVq8y6F17zcx9cmbahvqer9Xs8t3gg0p9j0ci4TqmhbaLV+uYE27q
        hBuwBwh/m+VJ3gSJQuhd+nH+B8yXSespQrCHqVLB1Bw2kbIv6VknGdMCQjk49Q/6RvHYwe
        Pb3kaUR51TEWsd1qTwJSdZ6P1Q0C0ag=
Date:   Tue, 17 May 2022 10:46:43 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Stephane Eranian <eranian@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] perf/x86/amd: Run AMD BRS code only on supported hw
Message-ID: <YoNg858+JkwAZvQw@zn.tnic>
References: <20220516154838.7044-1-bp@alien8.de>
 <CABPqkBSL8BLN-mWXNJX9YYCn26kK1J-nz2B_vFjbxLPw+P1uHQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CABPqkBSL8BLN-mWXNJX9YYCn26kK1J-nz2B_vFjbxLPw+P1uHQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 16, 2022 at 05:59:27PM -0700, Stephane Eranian wrote:
> Thanks for catching this. I tested on Zen2 (Fam17h) and it did not
> trigger the problem

That's because Zen2 has this MSR - 0xc000010f - so the write succeeds.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
