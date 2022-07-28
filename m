Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0E4F5839E7
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 09:58:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234913AbiG1H6P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 03:58:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234883AbiG1H6N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 03:58:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9173950738
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 00:58:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3068461B86
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 07:58:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38DE3C433D6;
        Thu, 28 Jul 2022 07:58:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1658995091;
        bh=NRDlReSxaH3MXcpkruof6LY61Urf42FbUwrqniO6oA4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rxFXZeGimqHr+TZ9ritLDZrBQUdFPgZCr8BvAJMt0cb/h2+5m9X47xDFUr85cy1Or
         n829ZToOpSDJRZRUe0WPzEtGRCKyl+QbQoE4br3qsoM1iR13Rakm36mtb4rQB5qCcq
         FfiEzJkY7rnxnS4V6NGa1E9wtiIJ1JqjZVeEQBCk=
Date:   Thu, 28 Jul 2022 09:58:03 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     kah.jing.lee@intel.com
Cc:     linux-kernel@vger.kernel.org, arnd@arndb.de,
        rafael.j.wysocki@intel.com, tien.sung.ang@intel.com,
        dinh.nguyen@intel.com
Subject: Re: [PATCH v2 0/3] New driver for Intel(Altera) FPGA System ID softIP
Message-ID: <YuJBi3Q4213e+Ntt@kroah.com>
References: <20220602122008.3021030-1-kah.jing.lee@intel.com>
 <20220721123017.416438-1-kah.jing.lee@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220721123017.416438-1-kah.jing.lee@intel.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 21, 2022 at 08:30:19PM +0800, kah.jing.lee@intel.com wrote:
> From: Kah Jing Lee <kah.jing.lee@intel.com>
> 
> Hi,
> 
> I would like to request review for the new System ID driver for Intel FPGA
> platform.
> 
> New sysid driver for Altera(Intel) Sysid component is generally part of an
> FPGA design. The component can be hotplugged when the FPGA is reconfigured.
> 
> There are two basic ways to use the system ID core:
> - Verify the system ID before downloading new software to a system. This
> method can be used by software development tools, before downloading a
> program to a target hardware system, if the program is compiled for
> different hardware.
> 
> - Check system ID after reset. If a program is running on hardware other
> than the expected Platform Designer system, the program may fail to
> function altogether. If the program does not crash, it can behave
> erroneously in subtle ways that are difficult to debug. To protect against
> this case, a program can compare the expected system ID against the
> system ID core, and report an error if they do not match.
> 
> Documentation link:
> https://rocketboards.org/foswiki/Documentation/AgilexSoCGSRD#PR_Files
> 
> Feedback from maintainers:
> https://lore.kernel.org/lkml/YpmqeHt5Y31ffh5Q@kroah.com/#t

That does not describe what changed from the previous version at all, it
just points to a response from me saying you all need to work on this
driver.

thanks,

greg k-h
