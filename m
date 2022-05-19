Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B24E152D6C6
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 17:04:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240296AbiESPEU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 11:04:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240498AbiESPEA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 11:04:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC16948337
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 08:02:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 858D9619C4
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 15:02:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90D19C34100;
        Thu, 19 May 2022 15:02:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1652972579;
        bh=CO8FvRjgqQRDUZQMWj+zx8s5XWzeklwKdteIGDW8lg4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yUaavQ6cPlzd15+JJhEGulmfqXf5w2PjHyLT4UCu8SjNhRU8m5agbH1Z/i8e5Qv/b
         vfoR7CzKcGBmZbouw/qyqQwKWaWcnZNG8iDgHYNkimACES+I9fVw4xkQeeuxZMdliL
         TGt4LDUmd4HGYmQNjRZhVwNne5DwubgSlEp7dq2M=
Date:   Thu, 19 May 2022 16:57:54 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL]: soundwire updates for v5.19
Message-ID: <YoZa8lde+AT1OrJg@kroah.com>
References: <Ynz9e/Ppp+xbk4Ph@matsya>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ynz9e/Ppp+xbk4Ph@matsya>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 12, 2022 at 05:58:43PM +0530, Vinod Koul wrote:
> Hello Greg,
> 
> Please pull to receive soundwire subsystem updates for v5.19-rc1. 
> 
> Minor updates to Intel and Qcom driver and some core changes in
> power-management. Patches are already in linux-next.
> 
> The following changes since commit 3123109284176b1532874591f7c81f3837bbdc17:
> 
>   Linux 5.18-rc1 (2022-04-03 14:08:21 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/soundwire.git tags/soundwire-5.19-rc1

Pulled and pushed out, thanks.

greg k-h
