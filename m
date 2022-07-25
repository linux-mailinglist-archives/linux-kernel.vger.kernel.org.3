Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0627757FC6B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 11:30:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233171AbiGYJar (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 05:30:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229869AbiGYJao (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 05:30:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D4D213E8A;
        Mon, 25 Jul 2022 02:30:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B52C061277;
        Mon, 25 Jul 2022 09:30:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F577C341C6;
        Mon, 25 Jul 2022 09:30:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1658741443;
        bh=Zk+gKxWUkOi8wRytnYj22Y4hBUOdSQ9wVN26/kVSE8g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZPcpB7wAuxyTywDu8cveEWpSHzIZJs/i7/vsUf2hKBWe+rSjS12CPQkIKM0WUQRvm
         7R/YaZnl4Y3lFh9UU+VpUvS6pauk4WXoEkf9/Ks382mh7nmT8usMHGsxNxdB5UaeRN
         ASAvOQP5VvnqYpmt+gM/k3QKSUiMvGezzi4HLlEM=
Date:   Mon, 25 Jul 2022 11:30:34 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] USB-serial updates for 5.20-rc1
Message-ID: <Yt5iupcHj8S6CLQV@kroah.com>
References: <Yt5fhOsVMClQhuti@hovoldconsulting.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yt5fhOsVMClQhuti@hovoldconsulting.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 25, 2022 at 11:16:52AM +0200, Johan Hovold wrote:
> The following changes since commit a111daf0c53ae91e71fd2bfe7497862d14132e3e:
> 
>   Linux 5.19-rc3 (2022-06-19 15:06:47 -0500)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/johan/usb-serial.git tags/usb-serial-5.20-rc1

Pulled and pushed out, thanks.

greg k-h
