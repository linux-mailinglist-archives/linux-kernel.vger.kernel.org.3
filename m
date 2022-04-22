Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D813A50B918
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 15:50:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1448195AbiDVNxT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 09:53:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443102AbiDVNxR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 09:53:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 155A55623A
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 06:50:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A7CD860EED
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 13:50:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0462C385A4;
        Fri, 22 Apr 2022 13:50:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1650635421;
        bh=FHvIn6MJLGSh/ZKjufz8f4j/1Vbm/yH4KiDcpmJUk1k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cD4YJmdJQK3uVlHt7UXDgcx7ngYH0uLxiRzBZcyfXhH7EUS0vdp3XdQfEEKnxZ/Mf
         JrLgb3+KqhdoPUnGtymGSpKjnu8rPkklr+vjRFs75UrFDRpqgtApAGsWC4obA6On6M
         fDHZVuDqLJmFANRbYSfdJzMSI7kp+HtrqAKEWKeY=
Date:   Fri, 22 Apr 2022 15:49:46 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Linux Phy <linux-phy@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL]: Generic phy fixes for v5.18
Message-ID: <YmKyeqqvoZFmBU+Q@kroah.com>
References: <YmFQonkAlGNUx+OY@matsya>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YmFQonkAlGNUx+OY@matsya>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 21, 2022 at 06:10:02PM +0530, Vinod Koul wrote:
> Hello Greg,
> 
> Please consider pull to receive the generic phy fixes for v5.18 which
> contains bunch of driver fixes for error patch handling, missing
> device/of_node_put etc.
> 
> The following changes since commit 3123109284176b1532874591f7c81f3837bbdc17:
> 
>   Linux 5.18-rc1 (2022-04-03 14:08:21 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/phy/linux-phy.git tags/phy-fixes-5.18

Pulled and pushed out, thanks.

greg k-h
