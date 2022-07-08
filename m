Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81F5256BADA
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 15:34:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238049AbiGHNev (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 09:34:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237622AbiGHNeu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 09:34:50 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 858A61D304
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 06:34:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4878DB827E7
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 13:34:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 728E0C341C0;
        Fri,  8 Jul 2022 13:34:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1657287286;
        bh=0TVtvkj/Gc10aNNAK5BHMVbvIVabgkYAknLcnLd0zmA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tCbQGhefhxTa46/E8o1cUrVPbQ744kanv53sb8WiwhNEeJXhC7FyuIp8/WC1G4nP2
         e0AThzTItckMqmOqxiCKX+9qqZ31SEZoIdGSNJ6PUU7eVnRcmp9l5D0+Cr4dn4WQ7o
         mZu5fKdR0x6DZFX9nxu8/oDFLCB5ZG0EBdwS+YPQ=
Date:   Fri, 8 Jul 2022 15:34:43 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Alexander Usyskin <alexander.usyskin@intel.com>
Cc:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Tomas Winkler <tomas.winkler@intel.com>,
        Vitaly Lubart <vitaly.lubart@intel.com>,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 00/14] GSC support for XeHP SDV and DG2 platforms
Message-ID: <Ysgyc70ctolFl46S@kroah.com>
References: <20220706114345.1128018-1-alexander.usyskin@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220706114345.1128018-1-alexander.usyskin@intel.com>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 06, 2022 at 02:43:31PM +0300, Alexander Usyskin wrote:
> Add GSC support for XeHP SDV and DG2 platforms.
> 
> The series includes changes for the mei driver:
> - add ability to use polling instead of interrupts
> - add ability to use extended timeouts
> - setup extended operational memory for GSC
> 
> The series includes changes for the i915 driver:
> - allocate extended operational memory for GSC
> - GSC on XeHP SDV offsets and definitions
> 
> Greg KH, please review and ACK the MEI patches.
> We are pushing these patches through gfx tree as
> the auxiliary device belongs there.
> 
> V2: rebase over merged DG1 series and DG2 enablement patch,
>     fix commit messages
> 
> V3: rebase over latest tip
> 
> V4: add missed changelog in pxp dbugfs patch
> 
> V5: rebase over latest tip
>     fix changelog in pxp dbugfs patch
>     put HAX patch last to the ease of merging

You did more than just this from v4 to v5 :(

It's as if you want to make it hard to review these...

greg k-h
