Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB54652D684
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 16:55:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240026AbiESOzu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 10:55:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240020AbiESOzr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 10:55:47 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AAFB2F2;
        Thu, 19 May 2022 07:55:45 -0700 (PDT)
Received: from zn.tnic (p200300ea97465796329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9746:5796:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id B60771EC03AD;
        Thu, 19 May 2022 16:55:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1652972139;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=gEAUc/oSAswStwEUGP5dwi9M8GZZjOw0Nff+YSdujV0=;
        b=X3lfeEW4EmV7aiEe1ZwjoiAvE2c4oi5qQ64LYOg/A6mn/E1uWNFLhijAok/tFzywrYsohH
        ouI5XGfNylJsiDuj3yxBlhw7SRNtzskwnjbBkhLzoV9X0tHtJfFU4QZdcnTrOQRL+sbnnk
        ZRJRfo/cxSwtHntxx2NYXQIRlTU8wPE=
Date:   Thu, 19 May 2022 16:55:35 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        X86 ML <x86@kernel.org>, Tony Luck <tony.luck@intel.com>
Subject: Re: linux-next: Tree for May 18
 (arch/x86/kernel/cpu/microcode/intel.o)
Message-ID: <YoZaZ+HVyjKrwtSQ@zn.tnic>
References: <20220518202934.730a8aba@canb.auug.org.au>
 <8ead0da9-9545-b10d-e3db-7df1a1f219e4@infradead.org>
 <YoVlwN/IeVXoMaq1@zn.tnic>
 <df5ed1d0-6304-89b8-ad68-0cf6a59d8614@infradead.org>
 <YoVzUxSwhoim9TOX@zn.tnic>
 <65f17e84-83e4-c33a-1718-fbb5841cef46@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <65f17e84-83e4-c33a-1718-fbb5841cef46@infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 18, 2022 at 03:40:06PM -0700, Randy Dunlap wrote:
> Thanks. If you like this patch, you can add
> 
> Tested-by: Randy Dunlap <rdunlap@infradead.org>
> Acked-by: Randy Dunlap <rdunlap@infradead.org>
> 
> to it.

Thanks.

However, the patch needs to be splitted and the IFS piece needs to go
through the platform tree. Sending them both as a reply to this message.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
