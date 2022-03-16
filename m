Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 522AC4DAC0D
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 08:50:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354344AbiCPHvw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 03:51:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344701AbiCPHvu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 03:51:50 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D85B75B3CC;
        Wed, 16 Mar 2022 00:50:36 -0700 (PDT)
Received: from zn.tnic (p5de8e440.dip0.t-ipconnect.de [93.232.228.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 131D81EC056A;
        Wed, 16 Mar 2022 08:50:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1647417031;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=xG00aaFEHjWHCmGyBp8U73MMpXK7Oqyw1ad6T9YHcYo=;
        b=kDBF+oqjLywhB6FXJfOmM6xIvFJi0AhUalvdn0mtrFUFG7Xu9dtwSk4DCqSCWEZzeMhzQ+
        3GCkr+DRpaJA9agMhPalpHWFq7i4dMu8MZtClprqJkndzSJhg6pR1BfhoqXm7hMPSA6n1W
        ALm4KdkSOtaZIVbZDOWNetd/wwABatM=
Date:   Wed, 16 Mar 2022 08:48:14 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     x86@kernel.org, linux-mm@kvack.org,
        Eric Biederman <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: drop entry to removed file in EXEC & BINFMT
 API
Message-ID: <YjGWPh6MSLqeL47e@zn.tnic>
References: <20220316050828.17255-1-lukas.bulwahn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220316050828.17255-1-lukas.bulwahn@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 16, 2022 at 06:08:28AM +0100, Lukas Bulwahn wrote:
> Commit f9444ea5e208 ("x86: Remove a.out support") removes
> arch/x86/ia32/ia32_aout.c, but misses a reference to that file in
> MAINTAINERS.

It seems we're keeping a.out after all:

https://lore.kernel.org/r/4c449fab-8135-5057-7d2c-7b948ce130cc@theinnocuous.com

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
