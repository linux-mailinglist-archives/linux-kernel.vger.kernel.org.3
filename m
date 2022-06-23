Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19959557DB8
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 16:26:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231651AbiFWO0g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 10:26:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230525AbiFWO0d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 10:26:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A4FE39BB6;
        Thu, 23 Jun 2022 07:26:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 12D0D61E0D;
        Thu, 23 Jun 2022 14:26:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D03DC3411B;
        Thu, 23 Jun 2022 14:26:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1655994391;
        bh=YlvGuM0u+44HGYQttvnCCzYarrZl9YXb3kjIUQY0yFQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eKiJsrjUDs0XSJw/0XW5dE4X2Hff6VHnfWANhsIJvfyVnBjcvizlvxs1oB/1lcIZR
         0VAursb9UNQO6YITitjcylZVdNO7ogNIc6DqnYx8bZENicqJztpGcYJMOSgBY9MJIm
         u1D+4iQU3yq0jHwP8MmYq24ZgPeS+YeWYkeeaea8=
Date:   Thu, 23 Jun 2022 16:26:19 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] USB-serial fixes for 5.19-rc4
Message-ID: <YrR4C2pESBHcv1gT@kroah.com>
References: <YrRYNhpf9GiyxmAQ@hovoldconsulting.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YrRYNhpf9GiyxmAQ@hovoldconsulting.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 23, 2022 at 02:10:30PM +0200, Johan Hovold wrote:
> The following changes since commit a111daf0c53ae91e71fd2bfe7497862d14132e3e:
> 
>   Linux 5.19-rc3 (2022-06-19 15:06:47 -0500)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/johan/usb-serial.git tags/usb-serial-5.19-rc4

Pulled and pushed out, thanks.

greg k-h
