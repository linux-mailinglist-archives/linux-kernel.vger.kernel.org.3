Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 719874FF1FE
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 10:34:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233841AbiDMIfM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 04:35:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233833AbiDMIfK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 04:35:10 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99DF54EA1D
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 01:32:44 -0700 (PDT)
Received: from zn.tnic (p200300ea971b584e329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:971b:584e:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 32F8F1EC0373;
        Wed, 13 Apr 2022 10:32:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1649838759;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=7N0c7cMtTCXb/jmMXg/es4pM3AWnTv6zgUNAth27G00=;
        b=T/jxG08Bt2BKNAlqZ8Rgs/P7e4VhGWxECUn6TLF67P11UtdiOxt60tymIndIgZ6yDDOC6W
        ardzHbaArhakWKrv5onl4WLhSfHsrLY2k0er0PKjERbmBIAc0WwukeRBF1W2YPgR05Bath
        gEVo2Ornw3qoAXt8XVDibDB5OtuUm3o=
Date:   Wed, 13 Apr 2022 10:32:38 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Baoquan He <bhe@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
        dyoung@redhat.com, linux-mm@kvack.org
Subject: Re: [PATCH v2 0/2] x86/kexec: fix memory leak of elf header buffer
Message-ID: <YlaKpuRQfIZsyBtL@zn.tnic>
References: <20220223113225.63106-1-bhe@redhat.com>
 <YkWRQdp7TxV22ygO@MiWiFi-R3L-srv>
 <20220412192734.fcda8988d189c8e2e2830b03@linux-foundation.org>
 <YlY51XjPFN1vMvQV@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YlY51XjPFN1vMvQV@MiWiFi-R3L-srv>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 13, 2022 at 10:47:49AM +0800, Baoquan He wrote:
> Since it's also MM related, so ping you and x86 maintainers to see who
> can help pick them.

I'd leave that decision to akpm. :-)

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
