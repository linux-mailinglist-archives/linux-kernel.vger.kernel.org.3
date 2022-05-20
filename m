Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB4E652EDD5
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 16:10:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350133AbiETOKT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 10:10:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350120AbiETOKN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 10:10:13 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38D2B166441
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 07:10:11 -0700 (PDT)
Received: from zn.tnic (p200300ea974657be329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9746:57be:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id AFFDC1EC0432;
        Fri, 20 May 2022 16:10:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1653055805;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=Jw8Jjz7F/KFwbNnn4srCQ68W2G6++y7u/dhV8E5+6KU=;
        b=YKuNyQq5+Wxqlgq1j8eVsbNGFuG5GC1HPYPlVA+ej5bySjFRaLngXPzI4psfQR3nBHlDBK
        GV7UiNzmKppbzkLPb/pZSShOdrqGaB5sS9eO9qvw8S9cTWXe9HlYBuw8M6tPM6+crkuVbG
        nrM+PcXEst6/DRTQD3iDchGEzopo0qc=
Date:   Fri, 20 May 2022 16:10:01 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Shreenidhi Shedi <yesshedi@gmail.com>
Cc:     srivatsa@csail.mit.edu, amakhalov@vmware.com, tglx@linutronix.de,
        mingo@redhat.com, dave.hansen@linux.intel.com, hpa@zytor.com,
        virtualization@lists.linux-foundation.org, pv-drivers@vmware.com,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        Shreenidhi Shedi <sshedi@vmware.com>
Subject: Re: [PATCH v1] x86/vmware: use unsigned integer for shifting
Message-ID: <YoehOWHN7h8cFBK5@zn.tnic>
References: <20220520114712.595583-1-sshedi@vmware.com>
 <YoeA4pf5OWxfjE0J@zn.tnic>
 <f05264ce-e90f-0b1a-4796-ec1f3b75c09c@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f05264ce-e90f-0b1a-4796-ec1f3b75c09c@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 20, 2022 at 07:33:30PM +0530, Shreenidhi Shedi wrote:
> I deliberately did it because I was lacking clarity on using my org
> mail & personal mail id.

You could have a look at Documentation/process/submitting-patches.rst
and everything under Documentation/process/ in case you don't know what
to do.

Using checkpatch.pl on your patch before submitting it, is also
something you should do.

HTH.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
