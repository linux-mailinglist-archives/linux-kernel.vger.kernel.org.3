Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D097958CCCE
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 19:38:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243580AbiHHRiq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 13:38:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236070AbiHHRio (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 13:38:44 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D3D615FC8
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 10:38:43 -0700 (PDT)
Received: from zn.tnic (p200300ea971b98cb329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:971b:98cb:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 320AF1EC0380;
        Mon,  8 Aug 2022 19:38:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1659980318;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=QkI3RA/HMmgr+FifC1RD9i6yt0XDfg84AsVGBhRwcU4=;
        b=UT7H5W6W3k8Hl1lrakgDducomkCaf+Lk5qbTLDbQhLAKFLrFxRKOI1vDSeA3LLo1xkIZ2A
        2LbtU03Rpj1AV1aTxz3wSHb7DU3xWSfznugeYtbqpFJrGxzI36P3/P5VFhrgmLuik5RP62
        X7DSfuVpB2iER8xPv5R636sVRhl96Ko=
Date:   Mon, 8 Aug 2022 19:38:37 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     Rik van Riel <riel@surriel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: Re: [RFC PATCH 1/5] entry: Pass pt_regs to
 irqentry_exit_cond_resched()
Message-ID: <YvFKHaRdOkg5RHtv@zn.tnic>
References: <20220805173009.3128098-1-ira.weiny@intel.com>
 <20220805173009.3128098-2-ira.weiny@intel.com>
 <YvDnkALyHl77R/Ug@zn.tnic>
 <YvFJGxU0k492npYT@iweiny-desk3>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YvFJGxU0k492npYT@iweiny-desk3>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 08, 2022 at 10:34:19AM -0700, Ira Weiny wrote:
> I thought about that but generally have been steered away from using bool
> arguments like this.

The reason being?

> Looking this over I think this may be a reasonable use of a flag like
> that.
>
> I'm not sure if this series is going to land given the discussion of
> performance.

Well, the only way to talk performance is to have something to measure
it with. But let me finish going through the rest of your set first.

> Would this clean up be welcome on its own?  I'm willing to respin
> this patch and submit if so.

Depends on who steered you away from the bool thing and why?

:-)

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
