Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 379774D73AF
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Mar 2022 09:13:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233898AbiCMIOI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Mar 2022 04:14:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233782AbiCMIOG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Mar 2022 04:14:06 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AF9811C14
        for <linux-kernel@vger.kernel.org>; Sun, 13 Mar 2022 00:12:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BB906B80B98
        for <linux-kernel@vger.kernel.org>; Sun, 13 Mar 2022 08:12:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBE90C340E8;
        Sun, 13 Mar 2022 08:12:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1647159176;
        bh=BnTGcmMz/Y21TNlzb/6hhI9xAc8bmaanukxPdoNRNls=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=e0en8zUmtzkg4NzDRJwPNbjzuhjSH3bzwwXPpyR5D6DC0QcUBozomq+BoXHfQrURb
         zck9VYX3aLO3etDrrGJtBUvox9u1XqqYq8m/8ILVLBFSedP5qXDEH+/cvxcaolLo2s
         vRkdA6tnUOK5KH9Gy9rzqjVv4djWn3OQ0CLqYj/E=
Date:   Sun, 13 Mar 2022 09:12:46 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     lizhe <sensor1010@163.com>
Cc:     adrian.hunter@intel.com, cohuck@redhat.com, tomeu@tomeuvizoso.net,
        grant.likely@secretlab.ca, dmitry.torokhov@gmail.com,
        andy.shevchenko@gmail.com, andrzej.hajda@intel.com,
        geert@linux-m68k.org, ulf.hansson@linaro.org, broonie@kernel.org,
        rafael@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers/dd.c : Remove the initial value of the global
 variable
Message-ID: <Yi2nfjH7aph6CuiX@kroah.com>
References: <20220313042442.21539-1-sensor1010@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220313042442.21539-1-sensor1010@163.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 12, 2022 at 08:24:42PM -0800, lizhe wrote:
> The global variable driver_deferred_probe_enable has
> a default value of false and does not need to be
> initialized to false
> 
> Signed-off-by: lizhe <sensor1010@163.com>

Is this the full name you sign documents with?

Also, I got two different copies of this change, which one is correct?

thanks,

greg k-h
