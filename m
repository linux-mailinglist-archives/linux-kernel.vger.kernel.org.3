Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35E0753C4DD
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 08:30:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241468AbiFCGaZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 02:30:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241164AbiFCGaX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 02:30:23 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2401377C3
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 23:30:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 76F18B82223
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jun 2022 06:30:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99ACAC385A9;
        Fri,  3 Jun 2022 06:30:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1654237819;
        bh=wJoXsG2RPBwclkRP8gaAfeuQoJpr57pBr0KXeRN2rpQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sjd6rD6TTK3zqmb6VU4PqSZhC32BPFGdpVhPVEz0ex6AhrNtO9gHVF7imJ/iJAEcE
         OABayRGLHl++LP6yvyZsBNdT7VNHGMpN0Fm1tFTSKp2N1/wJYzrfcFZQ+o7nSrur6o
         addh5w0jDbV6wtburirQ70H0dbg63PkXwaWCAgxk=
Date:   Fri, 3 Jun 2022 08:30:16 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     kah.jing.lee@intel.com
Cc:     arnd@arndb.de, dinguyen@kernel.org, lftan@altera.com,
        linux-kernel@vger.kernel.org, tien.sung.ang@intel.com
Subject: Re: [PATCH 1/2] drivers: misc: intel_sysid: Add sysid from arch to
 drivers
Message-ID: <YpmqeHt5Y31ffh5Q@kroah.com>
References: <YpkaTFywg+GkPElr@kroah.com>
 <20220603045732.3073983-1-kah.jing.lee@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220603045732.3073983-1-kah.jing.lee@intel.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 03, 2022 at 12:57:33PM +0800, kah.jing.lee@intel.com wrote:
> From: Kah Jing Lee <kah.jing.lee@intel.com>
> 
> > On Thu, Jun 02, 2022 at 08:22:13PM +0800, kah.jing.lee@intel.com wrote:
> > > From: Kah Jing Lee <kah.jing.lee@intel.com>
> > > 
> > > Add sysid driver. The Altera(Intel) Sysid component is generally part of an
> > > FPGA design. The component can be hotplugged when the FPGA is reconfigured.
> > > This patch fixes the driver to support the component being hotplugged.
> > > 
> > > Usage:
> > >   cat /sys/bus/platform/devices/soc:base_fpga_region/
> > > 		soc:base_fpga_region:fpga_pr_region0/[addr.sysid]/sysid/id
> > >   cat /sys/bus/platform/devices/soc:base_fpga_region/
> > > 		soc:base_fpga_region:fpga_pr_region0/[addr.sysid]/sysid/timestamp
> > > 
> > > Signed-off-by: Ley Foon Tan <lftan@altera.com>
> > > Signed-off-by: Kah Jing Lee <kah.jing.lee@intel.com>
> >
> > Please work with the Intel open source group as there are some internal
> > Intel requirements that you have not met here in order to be able to
> > submit a patch for external people to review.  I'll refrain from
> > reviewing or even considering this to be able to be accepted this until
> > that happens.
> 
> Will update the license header and commit message, and resent.
> Thanks for pointing out =).

That is not the requirements that you need to follow sorry, please
contact the Intel open source group to find out the rules that Intel
submissions must follow at this point in time.

thanks,

greg k-h
