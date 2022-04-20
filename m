Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AF27508F8A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 20:35:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381533AbiDTSiN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 14:38:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346657AbiDTSiK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 14:38:10 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03F192252F
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 11:35:23 -0700 (PDT)
Received: from zn.tnic (p200300ea971b58ed329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:971b:58ed:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 191031EC0373;
        Wed, 20 Apr 2022 20:35:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1650479718;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=e8w172fXUDSSYSct237CPu202O+lic5z22jvZf4PDQ0=;
        b=rtfTNyfFZTnCVGHP0M4YMhp9N7AcmE3T/5mlQWBRJ6le5q5is3TibbnScDZ92H8Q4AtFox
        qtM+0PjQVa1qaz8D6ytsXiR2k3LtRqAfrmU0s9dZ4c3f8nA05aNWc/J2buUytpBTG/59eT
        bRB56cCP8PUbLU6NYAyS1Ho8nq94K/k=
Date:   Wed, 20 Apr 2022 20:35:17 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Miroslav Benes <mbenes@suse.cz>
Subject: Re: [PATCH v3] scripts: Create objdump-func helper script
Message-ID: <YmBSZZRyfK4kyD30@zn.tnic>
References: <4d3ab1f17230f0188698cfbc7ba08696fe1abfe9.1650474927.git.jpoimboe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4d3ab1f17230f0188698cfbc7ba08696fe1abfe9.1650474927.git.jpoimboe@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 20, 2022 at 10:16:36AM -0700, Josh Poimboeuf wrote:
> Add a simple script which disassembles a single function from an object
> file.  Comes in handy for objtool warnings and kernel stack traces.
> 
> Originally-by: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
> ---
> v3:
> - Add usage

Thanks!

Acked-by: Borislav Petkov <bp@suse.de>

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
