Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA5954A61FB
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 18:11:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240393AbiBARK5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 12:10:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240423AbiBARKz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 12:10:55 -0500
Received: from gofer.mess.org (gofer.mess.org [IPv6:2a02:8011:d000:212::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7208CC06173D
        for <linux-kernel@vger.kernel.org>; Tue,  1 Feb 2022 09:10:55 -0800 (PST)
Received: by gofer.mess.org (Postfix, from userid 1000)
        id D6507101BFE; Tue,  1 Feb 2022 17:10:53 +0000 (UTC)
Date:   Tue, 1 Feb 2022 17:10:53 +0000
From:   Sean Young <sean@mess.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        kernel test robot <oliver.sang@intel.com>,
        Alexei Starovoitov <ast@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        lkp@lists.01.org, kbuild test robot <lkp@intel.com>
Subject: Re: [PATCH] selftests/ir: fix build with ancient kernel headers
Message-ID: <YflpnYECZE2Kxh+V@gofer.mess.org>
References: <20220128075346.GG8421@xsang-OptiPlex-9020>
 <YfO39Q3mNHMQOkd4@gofer.mess.org>
 <CAADnVQJ3RCPUQ0k9nu2urrRK=U7SUetuPmY0_b17M_PD=j4fkw@mail.gmail.com>
 <e5b72f09-a208-a579-3e51-10935ccee1ff@linuxfoundation.org>
 <YfQqI2ryOYEDuvON@gofer.mess.org>
 <347bae9f-f775-4976-3d27-b0c725211d78@linuxfoundation.org>
 <YflldzHZPVK3OQRJ@gofer.mess.org>
 <YflmyHrYg1xJlW0u@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YflmyHrYg1xJlW0u@casper.infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 01, 2022 at 04:58:48PM +0000, Matthew Wilcox wrote:
> On Tue, Feb 01, 2022 at 04:53:11PM +0000, Sean Young wrote:
> > +/* Support ancient lirc.h which does not have these values */
> 
> Can we have a little more information here, such as "Can be removed once
> RHEL 8 is no longer a relevant testing platform"?  That will save people
> doing archaology to find out when it's safe to remove.

That totally makes sense.

Having said that, I have no idea what platforms are being used for testing,
so I don't know if RHEL 8 is the only one that needs this. Is there anyone
who could shed some light on what platforms should be supported?

Thanks,

Sean
