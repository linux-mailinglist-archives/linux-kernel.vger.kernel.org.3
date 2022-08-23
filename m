Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1773259D2D1
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 09:58:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241439AbiHWH6A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 03:58:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240214AbiHWH56 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 03:57:58 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CB3D65810;
        Tue, 23 Aug 2022 00:57:56 -0700 (PDT)
Received: from zn.tnic (p200300ea971b98b2329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:971b:98b2:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 8A4D41EC04D3;
        Tue, 23 Aug 2022 09:57:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1661241470;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=3mE3nTXApLjUmImCPqQybp4IqzCsnzvDjXelGFAt42I=;
        b=qU+vii90OWFoZpTwbju3J8CZSUsW/vqp/l9uVNhhSinPQ7im2bebvXu9D3g8Ffl/iutupq
        hfKsC+qpwB/66HuUD423Oei5Glh/ibJ4eUlQIHOMZwU8745hAa24swrDXcKnA6QZoT/ARN
        c19n4ti0xnp8FsNpin+C75FyzggXwhQ=
Date:   Tue, 23 Aug 2022 09:57:46 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     linux-kernel@vger.kernel.org
Cc:     linux-tip-commits@vger.kernel.org, Tony Luck <tony.luck@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org
Subject: Re: [tip: x86/cpu] x86/cpu: Add new Raptor Lake CPU model number
Message-ID: <YwSIeutdDadRgFf5@zn.tnic>
References: <YwO49TDHnLcOyE+F@agluck-desk3.sc.intel.com>
 <166121188787.401.17379235294060223774.tip-bot2@tip-bot2>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <166121188787.401.17379235294060223774.tip-bot2@tip-bot2>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 22, 2022 at 11:44:47PM -0000, tip-bot2 for Tony Luck wrote:
> The following commit has been merged into the x86/cpu branch of tip:
> 
> Commit-ID:     81779270304dd556e1bb9e62561115714c15fa6a
> Gitweb:        https://git.kernel.org/tip/81779270304dd556e1bb9e62561115714c15fa6a
> Author:        Tony Luck <tony.luck@intel.com>
> AuthorDate:    Mon, 22 Aug 2022 10:12:21 -07:00
> Committer:     Dave Hansen <dave.hansen@linux.intel.com>
> CommitterDate: Mon, 22 Aug 2022 16:35:53 -07:00
> 
> x86/cpu: Add new Raptor Lake CPU model number
> 
> Note1: Model 0xB7 already claimed the "no suffix" #define for a regular
> client part, so add (yet another) suffix "S" to distinguish this new
> part from the earlier one.
> 
> Note2: the RAPTORLAKE* and ALDERLAKE* processors are very similar from a
> software enabling point of view.  There are no known features that have
> model-specific enabling and also differ between the two.  In other words,
> every single place that list *one* or more RAPTORLAKE* or ALDERLAKE*
> processors should eventually list all of them.
> 
> Note3: This is being merged before there is an in-tree user.  Merging
> this provides an "anchor" so that the different folks can update their
> subsystems (like perf) in parallel to use this define and test it.

Yeah, then you should probably stick it in x86/urgent so that it goes to
Linus now.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
