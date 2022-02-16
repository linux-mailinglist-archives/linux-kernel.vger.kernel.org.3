Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 970264B8510
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 11:00:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232586AbiBPJ6u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 04:58:50 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:44650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232024AbiBPJ6t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 04:58:49 -0500
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17622245679
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 01:58:37 -0800 (PST)
Received: from zn.tnic (dslb-088-067-221-104.088.067.pools.vodafone-ip.de [88.67.221.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 9FAE61EC054C;
        Wed, 16 Feb 2022 10:58:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1645005511;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=Rrn0t54hroyu1hUgeZMu9iTtKpOa5yYCLOVjxyIzNK0=;
        b=mMtOhRt/7Mal67lEGWMbLBXDP8hrZIPlU1cjWsjBLmguVrjIcTZeBTP79EUuHYNXjxot29
        VvvOhjqzMqCS7ip9K8V38ayvWRPwU+3a7xUHXuZ7+RdTGvneaasKFv0vWGDkc2mxBW0JGB
        U1enel+HlOWIfWfgidloP3Aetcfy73M=
Date:   Wed, 16 Feb 2022 10:58:34 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>, tglx@linutronix.de,
        mingo@redhat.com, luto@kernel.org, peterz@infradead.org,
        sathyanarayanan.kuppuswamy@linux.intel.com, aarcange@redhat.com,
        ak@linux.intel.com, dan.j.williams@intel.com, david@redhat.com,
        hpa@zytor.com, jgross@suse.com, jmattson@google.com,
        joro@8bytes.org, jpoimboe@redhat.com, knsathya@kernel.org,
        pbonzini@redhat.com, sdeep@vmware.com, seanjc@google.com,
        tony.luck@intel.com, vkuznets@redhat.com, wanpengli@tencent.com,
        x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv2 22/29] x86/tdx: Make pages shared in ioremap()
Message-ID: <YgzKymHnbAUAVSMT@zn.tnic>
References: <YgFIaJ8ijgQQ04Nv@zn.tnic>
 <1d77e91c-e151-7846-6cd4-6264236ca5ae@intel.com>
 <YgFWpGQfA84Y0mW/@zn.tnic>
 <20220214220926.fjwlyieatwjhcpij@black.fi.intel.com>
 <f1dfc268-7b2f-9980-27ce-0b5bb1aea962@amd.com>
 <20220215154118.ldpvvk5seljntl44@black.fi.intel.com>
 <dd21e54a-a431-4d6f-47b7-ab1a3e8e0cc8@amd.com>
 <20220215162722.cvzik5r57spr2krz@black.fi.intel.com>
 <52e34ee2-e6a8-5b5c-41f9-5fcf21902a25@intel.com>
 <20220215173321.lwvfl6rxifrkcoit@black.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220215173321.lwvfl6rxifrkcoit@black.fi.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 15, 2022 at 08:33:21PM +0300, Kirill A. Shutemov wrote:
> Like cc_mkencrypted()/cc_mkdecrypted()? I donno. Looks strange.

cc_mkenc/cc_mkdec probably.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
