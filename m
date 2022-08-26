Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CDB05A2D81
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 19:30:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344311AbiHZRaK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 13:30:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343568AbiHZRaG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 13:30:06 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 382EA71716
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 10:30:04 -0700 (PDT)
Received: from zn.tnic (p200300ea971b98b8329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:971b:98b8:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id DA9511EC02F2;
        Fri, 26 Aug 2022 19:29:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1661534998;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=vvVMFlI89rpualyN7e/gvHuiCSprc1rB+wgWOKxX6l4=;
        b=j1DYMTGlpk3KJxMwy6uR6tvjM//U/zy/cKhjhP8/Ltk9U40+W586CVNhbeGMPWkZWdY53v
        68UVQBS9d7FGBS0IaJ2qpm/McJO5HYz7lWkFbIpfQk1m2EWnaQDuhUpZDLleGViPcxye3e
        FP0zZ5wOFV5k1ReSI8DA/4vxIpprtK4=
Date:   Fri, 26 Aug 2022 19:29:54 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Ashok Raj <ashok.raj@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Tony Luck <tony.luck@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        LKML Mailing List <linux-kernel@vger.kernel.org>,
        X86-kernel <x86@kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Jacon Jun Pan <jacob.jun.pan@intel.com>
Subject: Re: [PATCH v3 1/5] x86/microcode/intel: Check against CPU signature
 before saving microcode
Message-ID: <YwkDEkZziOIBRyO6@zn.tnic>
References: <20220817051127.3323755-1-ashok.raj@intel.com>
 <20220817051127.3323755-2-ashok.raj@intel.com>
 <Yv9k6fqRANu4ojK6@zn.tnic>
 <YwS2SXBN2J5FQflG@araj-dh-work>
 <YwZ7u0ljd+AW1P9d@zn.tnic>
 <YwbsPVteXuWVho10@araj-dh-work>
 <YwjzosEnhr3sGKMR@zn.tnic>
 <YwkAaP4O0fospJyI@araj-dh-work>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YwkAaP4O0fospJyI@araj-dh-work>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 26, 2022 at 05:18:32PM +0000, Ashok Raj wrote:
> Sure, the problem is that code base is something I *never* wanted to post,
> since its not architectural.

I don't need the code base - I need the microcode patches you're using
to trigger this.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
