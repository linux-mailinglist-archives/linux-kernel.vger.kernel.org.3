Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C25E25237B1
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 17:51:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343972AbiEKPvB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 11:51:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343928AbiEKPu4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 11:50:56 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 922E0393CD
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 08:50:53 -0700 (PDT)
Received: from cwcc.thunk.org (pool-108-7-220-252.bstnma.fios.verizon.net [108.7.220.252])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 24BFo7FH016599
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 11 May 2022 11:50:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1652284211; bh=vHauuC4he3d+QFIOnFA1W77VZ/VSJaURJ/FYW/LG53s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=j2rBf0BYbvuquAYZa9zhFrTyEk4I4iEUgOri9p5Rlfya50DlbGELYChMbolG62MNk
         S094Su3UP4yBR5beBZsM9RN3hvUkaCeiBOW5llGsH16MsueYycWETes7y0lkKYw1NO
         G4KRkBlxwkneLAI/pKxaprXUK68hodcbdSI3G8kF95evaaa2a2apL0rihkrFppxoK6
         5ei7i63OaKEOkGCWotNi6oAY99WPTUeyxCeOOeb1+3FvbuVjaZpgeypDOM1rGTEVxm
         7pI+QJLllKCW1OaXZ4SVkWfyjvchMx45CdL+BcLI4Yc59aw9SA9Z48rzBr0tqvWBJE
         WRzC+nIg/Z0kQ==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 2330115C3F0C; Wed, 11 May 2022 11:50:07 -0400 (EDT)
Date:   Wed, 11 May 2022 11:50:07 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Thorsten Leemhuis <linux@leemhuis.info>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Zhangfei Gao <zhangfei.gao@foxmail.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>
Subject: Re: Link: tag and links to submission and reports (was: Re: [GIT
 pull] core/urgent for v5.18-rc6)
Message-ID: <YnvbLx9FKgQwZJ/F@mit.edu>
References: <165201148069.536527.1960632033331546251.tglx@xen13>
 <CAHk-=wjMmSZzMJ3Xnskdg4+GGz=5p5p+GSYyFBTh0f-DgvdBWg@mail.gmail.com>
 <ff841fdc-4db7-7a3d-8caf-d0cddd0dfa31@leemhuis.info>
 <Ynt1z0eZ19eMqp8I@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ynt1z0eZ19eMqp8I@zn.tnic>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 11, 2022 at 10:37:35AM +0200, Borislav Petkov wrote:
> - The problem is when the discussion happened somewhere and the patch
> got submitted separately. I can't think of a good way to automate
> that so we have to pay attention and fix the link tag by hand and add
> the relevant one. And I try to do that when I'm especially awake when
> applying the patch.

I would argue that it should be the patch submitter's responsibility
to explicitly add a URL to the problem report.  In some cases this
might be a pointer to a bug tracking system; in other cases it might
be a URL to lore.kernel.org.

					- Ted
