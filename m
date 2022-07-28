Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40F4C583ADD
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 11:02:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235339AbiG1JCL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 05:02:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234654AbiG1JCJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 05:02:09 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DDA965581
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 02:02:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C4E07B8236F
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 09:02:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C0B5C433C1;
        Thu, 28 Jul 2022 09:02:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658998924;
        bh=GRgdNTJ8PYQp/lGN9oA41yePt1HnQHalvV+J4FRauOU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bYjds+F/mT8xbCAb8xnhSIbva+I4XQG4q8eLZb092m7gPpKrTB0IM91BGjYZ8J3xO
         ZK51pJxeBbCyGQkFreBQh+AGC8sbPsIkiH98omsmCgJo2tz7WBD1vgzwmFGkWmw92y
         qaueSsNXJUsCJgqoZGEjxAX8Vxkv/NF5n9Zo+VYFth8Yvik3Px8SkLOJctkYWesmx9
         mrJZn75evlcJWowAzEncawFJB3C/JhABKdqVNWo/48OUjRijOGie0iKwrHO3X2jQZt
         9GKBAByRjeJWgeQ+Fzdqd88HmlilA2qZA8OtPEzcj1CJyNn4ce+eWc532gcDVXzveb
         0JqTHQ8rn6mEA==
Date:   Thu, 28 Jul 2022 12:01:52 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     "Huang, Shaoqin" <shaoqin.huang@intel.com>
Cc:     Rebecca Mckeever <remckee0@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] memblock test: Modify the obsolete description in
 README
Message-ID: <YuJQgAJBxQkkooVT@kernel.org>
References: <20220728011228.23691-1-shaoqin.huang@intel.com>
 <YuIK7cU8uH7zVP+S@bertie>
 <bcff18b0-5da7-860a-410c-3868b019c717@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bcff18b0-5da7-860a-410c-3868b019c717@intel.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 28, 2022 at 01:08:25PM +0800, Huang, Shaoqin wrote:
> 
> 
> On 7/28/2022 12:05 PM, Rebecca Mckeever wrote:
> > On Wed, Jul 27, 2022 at 07:12:28PM -0600, shaoqin.huang@intel.com wrote:
> > > From: Shaoqin Huang <shaoqin.huang@intel.com>
> > > 
> > > The VERBOSE option in Makefile has been moved, but there still have the
> > > description left in README. For now, we use `-v` options when running
> > > memblock test to print information, so using the new to replace the
> > > obsolete items.
> > > 
> > Thanks for catching this!
> > 
> > > Signed-off-by: Shaoqin Huang <shaoqin.huang@intel.com>
> > > ---

...

> > >   This will print information about which functions are being tested and the
> > >   number of test cases that passed.
> > > -To simulate enabled NUMA, use:
> > > +For the full list of options from command line, see `./main --help`.
> > 
> > --help will display the list of command line options by default, but a
> > help command line option isn't explicitly implemented. I'm planning to add
> > the help option, so if you want to remove this sentence, I will add it when
> > I implement the help option.
> 
> Hi, Rebecca.
> 
> That's ok. I didn't notice the --help has not been implemented. So I can
> remove the line:
> -For the full list of options from command line, see `./main --help`.
> 
> But after remove it. There seems a little stranger about how to get the full
> list of options at the time. How do you think about it?

I '--help' option is implemented, it just does not list help for itself.
I think it's fine to keep the "For the full list..." line.
 

-- 
Sincerely yours,
Mike.
