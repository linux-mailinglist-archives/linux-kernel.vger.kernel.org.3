Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 448BA4EDAF9
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 15:57:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237091AbiCaN7d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 09:59:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236546AbiCaN7c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 09:59:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36D90216FAF;
        Thu, 31 Mar 2022 06:57:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C4B54617E4;
        Thu, 31 Mar 2022 13:57:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B324DC340EE;
        Thu, 31 Mar 2022 13:57:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1648735064;
        bh=kKFP0KHKA72TEtrMcuk7Pg2PVfkLL6KiQWCPUtPpB48=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VRYxW/phDDG/Y6yxs9nFf18742XrhE6Pck15HYEd7BFDAk7dp2O8cOXUA2zgPAkGt
         6b14k/GSOj7FOAbezUC81AUGjJ+FSR/4Teq4d7ifTidYr96lXR0TlTCxrJ+IQ/QMnb
         4aGF/VfkQqejBZBf81FUABL/A38nml2hUgmYioeM=
Date:   Thu, 31 Mar 2022 15:57:39 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     niravkumar.l.rabara@intel.com
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Derek Kiernan <derek.kiernan@xilinx.com>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Add Altera hardware mutex driver
Message-ID: <YkWzU8dFT7Uom8mN@kroah.com>
References: <20220331214911.27194-1-niravkumar.l.rabara@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220331214911.27194-1-niravkumar.l.rabara@intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 01, 2022 at 05:49:11AM +0800, niravkumar.l.rabara@intel.com wrote:
> ---
>  .../bindings/misc/altera-hwmutex.yaml         |  47 +++
>  drivers/misc/Kconfig                          |   6 +
>  drivers/misc/Makefile                         |   1 +
>  drivers/misc/altera_hwmutex.c                 | 321 ++++++++++++++++++
>  include/linux/altera_hwmutex.h                |  42 +++

There is no need for a .h file for a single .c file.  Please fix that up
for your next submission.

I don't think I need to read anymore :)

thanks,

greg k-h
