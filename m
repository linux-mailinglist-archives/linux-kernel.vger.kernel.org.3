Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB20259FEE5
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 17:55:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238914AbiHXPzg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 11:55:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237392AbiHXPzQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 11:55:16 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E5025F214
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 08:55:13 -0700 (PDT)
Received: from zn.tnic (p200300ea971b9859329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:971b:9859:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 335641EC056A;
        Wed, 24 Aug 2022 17:55:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1661356508;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=FwQUi4dAp845Zd5RUWtjKFuLCwxIp02ZFGB49oZzfCQ=;
        b=DxozawXWXxCJzoXKJjOk/15zCoTDRv0kazS3Xi0xdHiCKdJqu4jhU5UeGNz5EOl2ZEAQwg
        fLg278POT2YIHMORXoNXCAgzDeTVJdvzaycPm/tHqyljMSs3N0ov4hmsJj1dmoHMIIyWv4
        PVSwLio6gb5fN/S6vh8Sq0GHlTeJFkA=
Date:   Wed, 24 Aug 2022 17:55:07 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kai Huang <kai.huang@intel.com>,
        Wander Lairson Costa <wander@redhat.com>,
        Isaku Yamahata <isaku.yamahata@gmail.com>,
        marcelo.cerri@canonical.com, tim.gardner@canonical.com,
        khalid.elmously@canonical.com, philip.cox@canonical.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 1/6] x86/tdx: Add TDX Guest attestation interface
 driver
Message-ID: <YwZJ22gOWG0OyZB2@zn.tnic>
References: <20220728034420.648314-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20220728034420.648314-2-sathyanarayanan.kuppuswamy@linux.intel.com>
 <Yv5KNyX992ddvVtD@zn.tnic>
 <c8262af7-1552-98e0-fb35-4cf17228b039@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c8262af7-1552-98e0-fb35-4cf17228b039@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 23, 2022 at 12:36:43PM -0700, Sathyanarayanan Kuppuswamy wrote:
> Do you want to me to leave it to Kirill to handle the cleanup, or
> submit a new patch here?

Yeah, leave it to him - the less confusion the better.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
