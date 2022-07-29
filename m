Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56BC5585115
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 15:49:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236331AbiG2NtN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 09:49:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233738AbiG2NtK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 09:49:10 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA2843B962
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 06:49:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 80AD2B80D3F
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 13:49:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA575C433C1;
        Fri, 29 Jul 2022 13:49:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1659102547;
        bh=hJMj5Dy98O77OkMoserXcIeHwyH5pqHw13hQsZ5ddxA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ii12e9qhYUisAs1ChxHhHkdYhlNDUaeoc6YaRqZ904AmyLqk2LuFMo/OjqFc2/oie
         lGXqMbSMKyTrkXA9R42wIwXZk50EPZYWxiE7G6fl2j3uvyJBKZGHe3Eq+pqqQNipLN
         4yxokbi1eL9fRXUaZPPhTnGWRR3d8M28G1VelQEU=
Date:   Fri, 29 Jul 2022 15:49:04 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Petr Vorel <pvorel@suse.cz>
Cc:     linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        David Sterba <dsterba@suse.com>
Subject: Re: [PATCH v2 1/1] drivers/base/cpu: Print kernel arch
Message-ID: <YuPlUOT1nFyT9Fm7@kroah.com>
References: <20220729125141.12786-1-pvorel@suse.cz>
 <YuPYWLD7xxcNmuCx@pevik>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YuPYWLD7xxcNmuCx@pevik>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 29, 2022 at 02:53:44PM +0200, Petr Vorel wrote:
> Hi all,
> 
> > Print the machine hardware name (UTS_MACHINE) in /proc/sys/kernel/arch.
> 
> > This helps people who debug kernel with initramfs with minimal
> > environment (i.e. without coreutils or even busybox) or allow to open
> > sysfs file instead of run 'uname -m' in high level languages.
> 
> > Signed-off-by: Petr Vorel <pvorel@suse.cz>
> > ---
> 
> Changes v1->v2:
> * Add file into /proc/sys/kernel/ (previously it was in
>   /sys/devices/system/cpu/). There are 

Looks like this line ended too soon?

> * Update Documentation/ABI/ (Greg)

This looks good to me, I'll queue it up after the next -rc1 is out
unless someone objects.

greg k-h
