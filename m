Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F30D055FA3E
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 10:20:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231789AbiF2IUm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 04:20:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbiF2IUk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 04:20:40 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F1AD3BBD4
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 01:20:39 -0700 (PDT)
Received: from zn.tnic (p200300ea97156ae0329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9715:6ae0:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 990BB1EC04C2;
        Wed, 29 Jun 2022 10:20:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1656490832;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Mn0hjHmyXL6ZtyN0wX6vrOLAaJpD9Bv9ydZ6B4q79qE=;
        b=bs2ffCw+JQHyAdTL7Qn7zV0QnDIQ4In7+KZRHEtFI/lA1jSJOlFfXTQULZBaym5eDVcoJy
        cuKN5cl0lqQYkxadAhaPE9ZJAxHWFItNrosL6nZemtxCOst86uCoKalz9C8qNBWhE8ovjm
        fYl5PWU9AmpPDLD7MQmL14MCGtzwQ+E=
Date:   Wed, 29 Jun 2022 10:20:27 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     NOMURA =?utf-8?B?SlVOSUNISSjph47mnZHjgIDmt7PkuIAp?= 
        <junichi.nomura@nec.com>, Michael Roth <michael.roth@amd.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
Subject: Re: [Regression v5.19-rc1] crash kexec fails to boot the 2nd kernel
 (Re: [PATCH v12 38/46] x86/sev: Add SEV-SNP feature detection/setup)
Message-ID: <YrwLS8qRDhjmeD5Z@zn.tnic>
References: <TYCPR01MB694815CD815E98945F63C99183B49@TYCPR01MB6948.jpnprd01.prod.outlook.com>
 <20220629004114.zn5rurrmqdkiceun@amd.com>
 <OSZPR01MB6953EEF3F8E63330547E031183BB9@OSZPR01MB6953.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <OSZPR01MB6953EEF3F8E63330547E031183BB9@OSZPR01MB6953.jpnprd01.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 29, 2022 at 07:38:09AM +0000, NOMURA JUNICHI(野村 淳一) wrote:
> > If so, can you apply the below potential fix, and retry your original
> > reproducer?
> 
> I tried your potential fix but it didn't work...  The symptom was same
> as before.

I still think the proper fix is to not execute that cc blob code on
anything but AMD...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
