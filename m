Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C1AB4EDCC0
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 17:25:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238237AbiCaP1U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 11:27:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238219AbiCaP1R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 11:27:17 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB3791BBF40
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 08:25:29 -0700 (PDT)
Received: from zn.tnic (p2e55dff8.dip0.t-ipconnect.de [46.85.223.248])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 7D6E91EC050F;
        Thu, 31 Mar 2022 17:25:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1648740323;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=K39xzJCzMIfJZm6eIoQb2BiBcAhIWHVyv80OXULZPaI=;
        b=I3agSK1WyGR8JKtRZPvCMXfaK9HUh7GgMPfYa7uGV8jY2f60AVvq1y2E8rz8csw10uH48N
        Dk2/vF8paPOChaQOG503eZ5xK6IJOgNayvQK35VgMnaOx0u8rRnXz8j0piwS5vXVkauVlm
        U3aFoGI+lbM8ltsWRz8pRTpvFA/5nKw=
Date:   Thu, 31 Mar 2022 17:25:27 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Ricardo =?utf-8?Q?Ca=C3=B1uelo?= <ricardo.canuelo@collabora.com>
Cc:     Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        linux-kernel@vger.kernel.org,
        Thadeu Lima de Souza Cascardo <cascardo@canonical.com>,
        Mark Gross <mgross@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        John Johansen <john.johansen@canonical.com>,
        Steve Beattie <sbeattie@ubuntu.com>, kernel@collabora.com
Subject: Re: [PATCH v2] x86/speculation/srbds: do not try to turn mitigation
 off when not supported
Message-ID: <YkXH5+Js+qRbqou9@zn.tnic>
References: <20220330082026.1549073-1-ricardo.canuelo@collabora.com>
 <YkS3OKLS1Cixs9up@zn.tnic>
 <87o81mzhoh.fsf@rcn-XPS-13-9305.i-did-not-set--mail-host-address--so-tickle-me>
 <20220331084536.y4sl7qcfzltsnnew@guptapa-desk>
 <87lewqz2dp.fsf@rcn-XPS-13-9305.i-did-not-set--mail-host-address--so-tickle-me>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87lewqz2dp.fsf@rcn-XPS-13-9305.i-did-not-set--mail-host-address--so-tickle-me>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 31, 2022 at 03:18:42PM +0200, Ricardo Cañuelo wrote:
> Just to clarify, this changes the behavior wrt the hypervisor case:
> currently it just bails out of update_srbds_msr(), with your patch it'd
> clear RNGDS_MITG_DIS from MSR_IA32_MCU_OPT_CTRL. Is that what you
> intended?

Just do the simple thing I pasted earlier - no need to rewrite the whole
function for no good reason.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
