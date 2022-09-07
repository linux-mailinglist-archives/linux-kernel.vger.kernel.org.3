Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04BE35B0A18
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 18:30:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229975AbiIGQaD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 12:30:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229980AbiIGQaA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 12:30:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B576B2A732
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 09:29:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4D9696194C
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 16:29:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 992B2C433D6;
        Wed,  7 Sep 2022 16:29:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662568198;
        bh=SyUuqxI7aO6x27tKuLX1Jvc84+ethL9Y8ImhuZD72ic=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=auXUv95Dz+XmRyZv0gH7xXUZMUC5dFxAfKSbn2MrZeUjZTAZWREFVpE9x9DjWE19f
         jIx+0VPR4QR9t1Z4ec8j9SMHtrDwD+4UFTw54M+Y4z0Hp+W7haOdbBZ64RjNpdmH7x
         10tJgw/DU5WqK6Rvn620RNhoBnwSZxMndP/tzcVwPxDnPQ4d9MYx+YLWEfD+DrTsw3
         sELqOvem6CILw35y8gpw/7507lfTTowCGO7RPZYiWzAxWhEx+weeNvpcZ3PWyQqY4a
         WJ3In5P+GF0b+oMPy+7Y/uhHftwps/TfkEQiW6aRTkVi97zslovShUeS8q4fAvU4B5
         t/m6rkA3CNGZg==
Date:   Wed, 7 Sep 2022 17:29:53 +0100
From:   Will Deacon <will@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Liu Song <liusong@linux.alibaba.com>, james.morse@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] arm64: spectre: increase parameters that can be used
 to turn off bhb mitigation individually
Message-ID: <20220907162952.GC30558@willie-the-truck>
References: <1661514050-22263-1-git-send-email-liusong@linux.alibaba.com>
 <YxiqsXjQQGe0dNuA@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YxiqsXjQQGe0dNuA@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 07, 2022 at 03:29:05PM +0100, Catalin Marinas wrote:
> On Fri, Aug 26, 2022 at 07:40:50PM +0800, Liu Song wrote:
> > From: Liu Song <liusong@linux.alibaba.com>
> > 
> > In our environment, it was found that the mitigation BHB has a great
> > impact on the benchmark performance. For example, in the lmbench test,
> > the "process fork && exit" test performance drops by 20%.
> > So it is necessary to have the ability to turn off the mitigation
> > individually through cmdline, thus avoiding having to compile the
> > kernel by adjusting the config.
> > 
> > Signed-off-by: Liu Song <liusong@linux.alibaba.com>
> 
> If people want to disable this mitigation and know what they are doing,
> I have no objection:
> 
> Acked-by: Catalin Marinas <catalin.marinas@arm.com>

Thanks!

> (I guess that's more like 6.1 material)

Yup, agreed. I take it you'll pick it up, then?

Will
