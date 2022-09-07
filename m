Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D10705AFE22
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 09:52:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229723AbiIGHwV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 03:52:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbiIGHwB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 03:52:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5D377E338
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 00:51:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6857B615FC
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 07:51:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72D71C433B5;
        Wed,  7 Sep 2022 07:51:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1662537118;
        bh=uSW2ovitghVX/3zIU1kuVb5+1uQH1jIvAvyEfZy+RTU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Xe1hnJfYkMMbQN83hus992shMEWY9M5m0CfWCzVibI6C9X2ywCBguS25aZ+hM77GO
         k3tzS05BARzNxS1VL8NOuzjI/ozMJclx9Fe4fQ7yZew700CV2Oy4t3igxedmr9Daca
         KwmNxTf7Y/gM2Xj5GnB+qLLLhT6hQd7AVBj7pKBc=
Date:   Wed, 7 Sep 2022 09:51:56 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Linux Phy <linux-phy@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL]: Generic phy fixes for v6.0
Message-ID: <YxhNnD/kUA7REvZr@kroah.com>
References: <YxM2f3BCvYm0tvWt@matsya>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YxM2f3BCvYm0tvWt@matsya>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 03, 2022 at 04:41:59PM +0530, Vinod Koul wrote:
> Hello Greg,
> 
> Please pull to receive a single fix to marvell a3700-comphy driver which
> fixes broken reset  in the driver
> 
> The following changes since commit 568035b01cfb107af8d2e4bd2fb9aea22cf5b868:
> 
>   Linux 6.0-rc1 (2022-08-14 15:50:18 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/phy/linux-phy.git tags/phy-fixes-6.0

Pulled and pushed out, thanks.

greg k-h
