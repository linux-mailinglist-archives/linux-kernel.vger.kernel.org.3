Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E7C355725D
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 06:58:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233207AbiFWEt3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 00:49:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347613AbiFWEio (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 00:38:44 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D7873465E
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 21:38:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CD8A6B821B2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 04:38:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BF54C3411D;
        Thu, 23 Jun 2022 04:38:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655959120;
        bh=xk1MT6mMBR7zonuHLVIZ1h3abtXVuMx7SSzcmmEd27Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HwBndP8tS4UyFL939NYccjsnjUKzDDm0myyov3H2HSPMVF+qQCJd6vszeRF06GZDq
         xRV3dT/xaH3ctPg7qxr/S4AdKIUW9ppwAQEyW4f5J+LgxcUWlIdBev7GnQup4lcYTp
         tbF42hlgtLQsNVyy652g/SWLBs2WBvIsao+Sx4H1c2l3upw2JtFIdeeaMpZG/VIU3p
         k1FVgw4aS8G669ojHfmR4ksBrBQyTp0Ero6tJEYrf67lZhOTUNTds/ox1qF1UUkvpG
         ChfZXKgGtuifucuN7wfhraoFOxrZ7KHUHD6s4YDAjnJwFznSm9DOAYzhCCoS4iYn/U
         3xNWeyLvoGXpw==
Date:   Wed, 22 Jun 2022 23:38:35 -0500
From:   Mike Rapoport <rppt@kernel.org>
To:     Rebecca Mckeever <remckee0@gmail.com>
Cc:     Ira Weiny <ira.weiny@intel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v3 0/4] memblock tests: add VERBOSE and MEMBLOCK_DEBUG
 Makefile options
Message-ID: <YrPuSxlRrIn9kowB@kernel.org>
References: <cover.1655889641.git.remckee0@gmail.com>
 <YrPeXOgEQq7G4Ctq@iweiny-desk3>
 <YrPp+xMGZ/n1TpTk@bertie>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YrPp+xMGZ/n1TpTk@bertie>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 22, 2022 at 11:20:11PM -0500, Rebecca Mckeever wrote:
> On Wed, Jun 22, 2022 at 08:30:36PM -0700, Ira Weiny wrote:
> > On Wed, Jun 22, 2022 at 04:29:05AM -0500, Rebecca Mckeever wrote:
> > > These patches add options VERBOSE and MEMBLOCK_DEBUG to Memblock
> > > simulator, which can be specified when running make. These patches also
> > > implement the functionality for these options.
> > 
> > I seem to be missing patch 3/4 and I don't see it on lore?
> > 
> > https://lore.kernel.org/linux-mm/004e021cc3cb7be8749361b3b1cb324459b9cb9f.1655889641.git.remckee0@gmail.com/
> > 
> > Did it get sent?  Did it define the ASSERT_*() macros?

I see it on lore in both linux-mm and linux-kernel, and here as well:
 
https://lore.kernel.org/all/39c5c97d2b5c1ab88b7bbbf02633f840fd5dfcdf.1655889641.git.remckee0@gmail.com/

> That's strange, my email shows that it was sent to linux-mm@kvack.org and
> linux-kernel@vger.kernel.org but I'm not seeing it on lore either.
> Should I resend just patch 3/4?

No need to resend.

> For now, you can take a look at v1.  Patch 3 is unchanged from v1, which
> is showing up on lore:
> 
> https://lore.kernel.org/linux-mm/fe34452209f54287023ccacd666eade81ecd9a24.1655878337.git.remckee0@gmail.com/T/#u
> 
> It does not define the ASSERT_*() macros, that happens in patch 2.
> Patch 3 implements MEMBLOCK_DEBUG.
> 
> Thanks,
> Rebecca
> 

-- 
Sincerely yours,
Mike.
