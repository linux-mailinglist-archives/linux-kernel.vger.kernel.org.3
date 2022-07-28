Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E336583EF5
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 14:36:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238726AbiG1MgC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 08:36:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237841AbiG1Mf7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 08:35:59 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92004683D2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 05:35:58 -0700 (PDT)
Received: from zn.tnic (p57969665.dip0.t-ipconnect.de [87.150.150.101])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C031F1EC064D;
        Thu, 28 Jul 2022 14:35:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1659011752;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=fZH/aHwPNis8ybZaSyXYhkjGxh0r6LUJLJQXCmExCPc=;
        b=sWEY4czH5+ZcnhFRd9TEphxTMLyNW8xdM77Ibauxbu+Dyl1Swgpaca7YLZ9IynqNG9HvAM
        Zmt9/b+zrvVV/INFmC0NbEBumCPisBe3008CTjjE+Qii6b/ainFHzC+9B3A0DnvxplgLd2
        k+eQsuUugtX+boV/l9PDBFcdoQNtuTA=
Date:   Thu, 28 Jul 2022 14:35:48 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Dimitri John Ledkov <dimitri.ledkov@canonical.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] x86/bugs: Do not enable IBPB at firmware entry when IBPB
 is not available
Message-ID: <YuKCpLOLeDOI7GII@zn.tnic>
References: <20220728122602.2500509-1-cascardo@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220728122602.2500509-1-cascardo@canonical.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

drop stable@

On Thu, Jul 28, 2022 at 09:26:02AM -0300, Thadeu Lima de Souza Cascardo wrote:
> Some cloud hypervisors do not provide IBPB on very recent CPU processors,
> including AMD processors affected by Retbleed.

Which hypervisors are those? How relevant is that use case?

How do I reproduce it here?

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
