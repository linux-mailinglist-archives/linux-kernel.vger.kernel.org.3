Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA2D64DE160
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 19:51:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240173AbiCRSwT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 14:52:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231321AbiCRSwO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 14:52:14 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C12242DE7AC;
        Fri, 18 Mar 2022 11:50:55 -0700 (PDT)
Received: from zn.tnic (p2e55dff8.dip0.t-ipconnect.de [46.85.223.248])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id B207B1EC05ED;
        Fri, 18 Mar 2022 19:50:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1647629449;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=XFF50C0H+qNuzyfJ9gFvxt706SYnHaCYL4psuRE0jGU=;
        b=R1j43DXNqSrw1JFndx3Q5Q8jRNpNQGD4sZF2femKLhhfDtZeiYLRygOY8Uu8GVGkP1T395
        ZvMslOthL/CMVx46zK3GzRpK4uMZQCCydfI1ZAJ+So8u12iBcSi2seABfFgdiHm2s8DZxM
        Nehk9VGbbEbb5GcldRSMeSp2W8VnNlo=
Date:   Fri, 18 Mar 2022 19:50:45 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Dongli Si <kvmx86@gmail.com>
Cc:     acme@kernel.org, alexander.shishkin@linux.intel.com,
        dave.hansen@linux.intel.com, hpa@zytor.com, joerg.roedel@amd.com,
        jolsa@kernel.org, kim.phillips@amd.com, liam.merwick@oracle.com,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        mark.rutland@arm.com, mingo@kernel.org, namhyung@kernel.org,
        peterz@infradead.org, tglx@linutronix.de, x86@kernel.org
Subject: Re: [PATCH v3] perf/x86/amd: Don't touch the Host-only bit inside
 the guest hypervisor
Message-ID: <YjTUhRLmpP3PQbKr@zn.tnic>
References: <YjIspMR0lm6+W/Pp@zn.tnic>
 <20220318030757.1706799-1-sidongli1997@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220318030757.1706799-1-sidongli1997@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 18, 2022 at 11:07:57AM +0800, Dongli Si wrote:
> Hi Borislav, this is just to more clearly test if the current kernel is
> running directly on the host.
> 
> If this is redundant, I can remove this "wrapper" and resend the patch,
> the v4 patch code will be the same as the v1 patch.

Yes please. Using

	hypervisor_is_type(X86_HYPER_NATIVE)

directly is a lot more descriptive than "run_as_host".

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
