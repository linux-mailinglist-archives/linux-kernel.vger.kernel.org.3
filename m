Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84CE9597D70
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 06:34:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243344AbiHRE2r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 00:28:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242748AbiHRE2m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 00:28:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E96E23BE1;
        Wed, 17 Aug 2022 21:28:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BF069615AC;
        Thu, 18 Aug 2022 04:28:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00767C433D7;
        Thu, 18 Aug 2022 04:28:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660796921;
        bh=IPtVqHqmioiUzJYR7uHOzEqp1Lwyn94o0hi1lr0grdg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pievx/WlgRNNWmN7Zz8Dgu5ICXei6mdpUUMTby8p9w+gv/LdbfhXdVp60w2LKnoEI
         a6qxgmOA2h7jWqebjR1vf/lXbfyLQukE7O5JgYiwhFltf3Otqx1L/F3pj5vbUE9h4R
         a3JwNJJYF8QfUGNe4zF/qbRzw6lHNwSGqRv/i9cbjj4za0B+fdlz0xtZg764NM0FDJ
         8SBXbeXuC93zayHHL9dxOvcFQjmiP9XgS2nOTnPEoeQOrgEH/SajRM3DLD6VnXBc+J
         Bf9xoFGrMP5VBKocaAAtOwdQvvKJVruMkJoDrAZhTl7w751+pox7DSWxMtt/SKJtgy
         hSYOzKqUNgyDg==
Date:   Wed, 17 Aug 2022 21:28:39 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     "Elliott, Robert (Servers)" <elliott@hpe.com>
Cc:     "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 00/10] crypto: Kconfig - simplify menus and help text
Message-ID: <Yv2/988ODl9Za9Ob@sol.localdomain>
References: <20220815190608.47182-9-elliott@hpe.com>
 <20220817232057.73643-1-elliott@hpe.com>
 <Yv2oQijegCNFQMO1@sol.localdomain>
 <MW5PR84MB18427C4AA54AE9D69BC70759AB6D9@MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MW5PR84MB18427C4AA54AE9D69BC70759AB6D9@MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 18, 2022 at 03:00:33AM +0000, Elliott, Robert (Servers) wrote:
> 
> 
> > -----Original Message-----
> > From: Eric Biggers <ebiggers@kernel.org>
> > Sent: Wednesday, August 17, 2022 9:48 PM
> > Subject: Re: [PATCH v2 00/10] crypto: Kconfig - simplify menus and help text
> > 
> ...
> > >
> > > Robert Elliott (10):
> > >   crypto: Kconfig - move mips entries to a submenu
> > >   crypto: Kconfig - move powerpc entries to a submenu
> > >   crypto: Kconfig - move s390 entries to a submenu
> > >   crypto: Kconfig - move sparc entries to a submenu
> > >   crypto: Kconfig - move x86 entries to a submenu
> > >   crypto: Kconfig - remove AES_ARM64 selection by SA2UL entry
> > >   crypto: Kconfig - move arm and arm64 menus to Crypto API page
> > >   crypto: Kconfig - sort the arm64 entries
> > >   crypto: Kconfig - sort the arm entries
> > >   crypto: Kconfig - add submenus
> > 
> > What commit does this series apply to?
> 
> 5.19-rc7:
> 
> edbaae5c2910 crypto: Kconfig - move mips entries to a submenu
> 57e81df8165b crypto: testmgr - make WARN prints consistent
> fa99961bb413 crypto: x86/sha512 - load based on CPU features
> 5b2fb3a1500d ghes_edac: fix intermittent warm reset hang
> 661204d2ad01 RDMA/irdma: Fix sleep from invalid context BUG
> 85bdff84e6fd RDMA/irdma: Do not advertise 1GB page size for x722
> c24fa712938f gpiolib: cdev: Fix kernel doc for struct line
> 7f1d458de3ab Linux 5.19-rc7
> 
> I'll try including the git format-patch --base option next time.
> 

Thanks.  v6.0-rc1 would be better as it is more up-to-date.

- Eric
