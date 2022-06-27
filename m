Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D88E155C3A7
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 14:48:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236634AbiF0OC5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 10:02:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236703AbiF0OCw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 10:02:52 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E862911458
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 07:02:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3482BB81664
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 14:02:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A660C3411D;
        Mon, 27 Jun 2022 14:02:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1656338564;
        bh=g1K+PVts9YH1AAO1xNeHNN4w0YsCOWr3ibR68K8QyAA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wMDOAwyniu6s40tHmKGlEmO8ylJrsI5bVnLP6tEPYvdM0vNnx2mAnBXlaPxCbAiu8
         r33srwbKyRibjbaT+vzDWFRfCd39P/tho3RG2Mz2oruZrHJRm2Et41Mt2lAyf82p74
         QM/jGnpWiIjELSRU4t2WP4xryEtKtIqv3aCIV6qQ=
Date:   Mon, 27 Jun 2022 16:02:42 +0200
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
Subject: Re: [PATCH v3 00/14] GSC support for XeHP SDV and DG2 platforms
Message-ID: <Yrm4gtK74t2IRvKr@kroah.com>
References: <20220619133721.523546-1-alexander.usyskin@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220619133721.523546-1-alexander.usyskin@intel.com>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 19, 2022 at 04:37:07PM +0300, Alexander Usyskin wrote:
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

patch 13 in the series obviously needs work, the others are fine with
me.

thanks,

greg k-h
