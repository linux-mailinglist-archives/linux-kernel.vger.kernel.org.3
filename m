Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B322454CFC6
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 19:29:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354192AbiFOR2S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 13:28:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349646AbiFOR2M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 13:28:12 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A8DD959D
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 10:28:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B057EB820C5
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 17:28:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 017E1C3411E;
        Wed, 15 Jun 2022 17:28:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655314087;
        bh=NGsPa22nNEnE5x5vS8yssNlYfYxkSRU3+UAJVehVMag=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=UiR3VvUJ39a+BVuIQoT3c+3dtQ/zKJLQT2LfcTYRqtvX68wX0kE3cNoGHW3Wx8mq5
         ekxzcWi/PdCSeLBai+XbqoWqwki3dCDMn6E/YQzZRdVQP4X2u278m2XUzoafRt/QG4
         6BDn/HLl+9f+D61T5p7BlpMtqaK1gKZgbKe9hCCyYC1cvLe9y9XCG7jVfGEWebb/Xk
         YXHq+ggIgpGCa/IWZKb6te4iWZL4ecm4NgZV2XVq0IgiU+JBC9iiB82qRYUZRsvqbI
         ihMGNUx/XpiorzvatHyo2ztg/xX2iv4iRN1G192Uv5ml7qtkaXiRUQos3cXHf/F2/h
         8m13vAmKFo2NA==
Date:   Wed, 15 Jun 2022 10:28:06 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     kernel test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Subject: Re: drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1174:29:
 error: enumerator value for
 'i40e_static_assert_i40e_aqc_cloud_filters_element_data' is not an integer
 constant
Message-ID: <20220615102806.1224d227@kernel.org>
In-Reply-To: <CAK8P3a1s-jKfDFo7CXjpM4B6JJS-bV901yCfOxr9qikV7AO_LQ@mail.gmail.com>
References: <202206091828.eNkyL2EI-lkp@intel.com>
        <CAK8P3a3Mu0MDRJU=he=gVxGKQYwzr1wePLKdgN37yLPSqm1iuQ@mail.gmail.com>
        <20220615085128.026f1c56@kernel.org>
        <CAK8P3a1s-jKfDFo7CXjpM4B6JJS-bV901yCfOxr9qikV7AO_LQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Jun 2022 17:56:24 +0200 Arnd Bergmann wrote:
> On Wed, Jun 15, 2022 at 5:51 PM Jakub Kicinski <kuba@kernel.org> wrote:
> >
> > On Wed, 15 Jun 2022 16:11:17 +0200 Arnd Bergmann wrote:  
> > > The bug is that 'i40e_aqc_cloud_filters_element_data' and some other
> > > structures in the
> > > same file are broken when building an ARM kernel without CONFIG_AEABI, which has
> > > unusual struct packing rules and triggers the static assertion.  
> >
> > What are those packing rules, out of curiosity?  
> 
> On the old OABI, each struct member is on a 32-bit boundary.

Oh. GTK!
