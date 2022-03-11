Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1329A4D60F8
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 12:45:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244533AbiCKLqu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 06:46:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348507AbiCKLpt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 06:45:49 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8F59FE421;
        Fri, 11 Mar 2022 03:44:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3ACF861BD9;
        Fri, 11 Mar 2022 11:44:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C01EC340E9;
        Fri, 11 Mar 2022 11:44:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1646999049;
        bh=Qo0pYXQkpsqk2ayJN7OcM7+oOlvo4lNXRvqJ28RyUyM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BqCa5DhEdXcrp0tY3BRr42h50DU1IDZV/3S7D5tP8N1zu7tL8edxc49nxilW0OwuV
         VY3e2Wt6djhu4HVUmbZRngs8ssromAB02BkxU/AmmlyqezX5VpDumEJ8OeY4XK12TC
         fw5o6O5vKy8c/RMJP/z25ekR2ZlEmftn/eL9mYgU=
Date:   Fri, 11 Mar 2022 12:43:51 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] USB-serial updates for 5.18-rc1
Message-ID: <Yis191W8c49vAobD@kroah.com>
References: <YisUIF1uXOs5g/tw@hovoldconsulting.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YisUIF1uXOs5g/tw@hovoldconsulting.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 11, 2022 at 10:19:28AM +0100, Johan Hovold wrote:
> The following changes since commit 7e57714cd0ad2d5bb90e50b5096a0e671dec1ef3:
> 
>   Linux 5.17-rc6 (2022-02-27 14:36:33 -0800)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/johan/usb-serial.git tags/usb-serial-5.18-rc1

Pulled and pushed out,t hanks.

greg k-h
