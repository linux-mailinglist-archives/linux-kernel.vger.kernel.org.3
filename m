Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CF6D5A9C6D
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 18:02:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234510AbiIAQCo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 12:02:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232420AbiIAQCm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 12:02:42 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A69CB7D782
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 09:02:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 66C17B8229E
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 16:02:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C248C433C1;
        Thu,  1 Sep 2022 16:02:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1662048159;
        bh=twrvMwn8KaRueprBlKTPNqJ+XSXdusw3s2HhmrOk9fs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WZQJUkSMSFLCyxnGs9jvswKFJNiLkivTI3yLL3s7AMcJm1D8zXlRifOz79OI2F7O1
         MjMhhBFCsxno1X5PlDbYEBZr9bULpczOIH0lmCEjwBQQFV6zipFZMO2dhRbYlHMHFJ
         qicSAjHcrvgLJ9EtzFUni9zfpktz1C3bhzW774d4=
Date:   Thu, 1 Sep 2022 18:02:36 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Petr Vorel <pvorel@suse.cz>
Cc:     linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        David Sterba <dsterba@suse.com>,
        Eric Biederman <ebiederm@xmision.com>
Subject: Re: [PATCH v2 1/1] drivers/base/cpu: Print kernel arch
Message-ID: <YxDXnKE5ntQgIlCm@kroah.com>
References: <20220729125141.12786-1-pvorel@suse.cz>
 <YxDBvD5XrbLApWMy@kroah.com>
 <YxDT9xxMSFLu3xDI@pevik>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YxDT9xxMSFLu3xDI@pevik>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 01, 2022 at 05:47:03PM +0200, Petr Vorel wrote:
> Hi Greg,
> 
> [ Cc Eric Biederman as the author of kernel/utsname_sysctl.c ]
> 
> > On Fri, Jul 29, 2022 at 02:51:41PM +0200, Petr Vorel wrote:
> > > Print the machine hardware name (UTS_MACHINE) in /proc/sys/kernel/arch.
> 
> > > This helps people who debug kernel with initramfs with minimal
> > > environment (i.e. without coreutils or even busybox) or allow to open
> > > sysfs file instead of run 'uname -m' in high level languages.
> 
> > > Signed-off-by: Petr Vorel <pvorel@suse.cz>
> > > ---
> > >  Documentation/admin-guide/sysctl/kernel.rst | 5 +++++
> > >  kernel/utsname_sysctl.c                     | 7 +++++++
> > >  2 files changed, 12 insertions(+)
> 
> > Wait, why does the subject line say "drivers/base/cpu"?  That's not a
> > file being touched in this commit at all, so this isn't for me to take
> > :(
> 
> Thanks for info. My bad, I forget to update the subject.
> I can send v3 with corrected subject, but who is going to take this?
> 
> $ ./scripts/get_maintainer.pl kernel/utsname_sysctl.c
> linux-kernel@vger.kernel.org (open list)
> 
> There is listed Author: Eric Biederman, so is it him to Cc ?

Yeah, that would be best, or maybe Andrew?

