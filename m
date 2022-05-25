Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 620C2533851
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 10:22:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233472AbiEYIW1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 04:22:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230366AbiEYIWR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 04:22:17 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90A742659
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 01:22:14 -0700 (PDT)
Received: from zn.tnic (p200300ea97465795329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9746:5795:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 2F3071EC0445;
        Wed, 25 May 2022 10:22:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1653466929;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=QcL5ageH+TVfM0qhjG8xtlLWdt6Nr3m73/bgXrC5YkE=;
        b=TzB9Djtlk6+HSegFejIrT7HxVnPzcTCzoLUpMbfvHOi2AELV+iQqbnsgebRlrGBApdHXyP
        WrimFI4YpOoO/t94gEb1vFdakc/P3yqnngvxfRaC64FHFPHZM2LUUrcnQwEvJ4JMjF8gSE
        t0u4fH5Ayvmi46l8I3d8kf5Si/Yixa0=
Date:   Wed, 25 May 2022 10:22:04 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     baskov@ispras.ru
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] x86: Parse CONFIG_CMDLINE in compressed kernel
Message-ID: <Yo3nLFcaGQCKERHx@zn.tnic>
References: <20220505103224.21667-1-baskov@ispras.ru>
 <20220505103224.21667-3-baskov@ispras.ru>
 <YnztqAtNEvnF5YcX@zn.tnic>
 <d783442602a1c546d3727b939f5cd199@ispras.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d783442602a1c546d3727b939f5cd199@ispras.ru>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 25, 2022 at 08:25:30AM +0300, baskov@ispras.ru wrote:
> There are currently no arch/x86/include/asm/shared/ directory,

There is now - it was in tip but wandered upstream two days ago. :)

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
