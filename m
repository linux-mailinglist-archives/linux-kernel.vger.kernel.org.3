Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA58F596D6B
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 13:21:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235744AbiHQLRA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 07:17:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234582AbiHQLQ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 07:16:58 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDB4677544
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 04:16:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9C975B81C94
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 11:16:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE732C433D6;
        Wed, 17 Aug 2022 11:16:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1660735015;
        bh=aNqZrRAZpkClXqTDedmn3bH+EuJXIheH2wBY3TTMKCY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=opUJkPmRlUWFO/l9qdUbtKeryG2IQEvbJGyHPNcdr03Fsh5RS8upOksyFsjAtGt+u
         AYTQo8I9LaZ0a4EdN/mGYK8jRaHNu0OjbeT8icLc9R9Ke2jLt7QHoKGxFLF9AzHKvk
         gZbRXlLFR0U2DwAp2qQWEksnTxvg3EKx3xx4prC4=
Date:   Wed, 17 Aug 2022 13:16:52 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Petr Vorel <pvorel@suse.cz>
Cc:     linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        David Sterba <dsterba@suse.com>
Subject: Re: [PATCH v2 1/1] drivers/base/cpu: Print kernel arch
Message-ID: <YvzOJOPUwQ3T4nV0@kroah.com>
References: <20220729125141.12786-1-pvorel@suse.cz>
 <YuPYWLD7xxcNmuCx@pevik>
 <YuPlUOT1nFyT9Fm7@kroah.com>
 <Yvy7QlQtKcIo7whL@pevik>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Yvy7QlQtKcIo7whL@pevik>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 17, 2022 at 11:56:18AM +0200, Petr Vorel wrote:
> > On Fri, Jul 29, 2022 at 02:53:44PM +0200, Petr Vorel wrote:
> > > Hi all,
> 
> > > > Print the machine hardware name (UTS_MACHINE) in /proc/sys/kernel/arch.
> 
> > > > This helps people who debug kernel with initramfs with minimal
> > > > environment (i.e. without coreutils or even busybox) or allow to open
> > > > sysfs file instead of run 'uname -m' in high level languages.
> 
> > > > Signed-off-by: Petr Vorel <pvorel@suse.cz>
> > > > ---
> 
> > > Changes v1->v2:
> > > * Add file into /proc/sys/kernel/ (previously it was in
> > >   /sys/devices/system/cpu/). There are 
> 
> > Looks like this line ended too soon?
> 
> > > * Update Documentation/ABI/ (Greg)
> 
> > This looks good to me, I'll queue it up after the next -rc1 is out
> > unless someone objects.
> 
> Hi Greg,
> 
> gently ping just to make sure you didn't forget on it. I'm sorry if I overlooked
> it (search in next tree and your git trees) or if you remember and are too busy
> (fully understand).

It's only been 2 days since -rc1 is out, and here's my todo queue right
now:
	❯ mdfrm -c ~/mail/todo/
	1733 messages in /home/gregkh/mail/todo/

It's in good company :)

thanks,

greg k-h
