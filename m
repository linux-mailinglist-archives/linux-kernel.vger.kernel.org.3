Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8030584C86
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 09:27:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234356AbiG2H1N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 03:27:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234103AbiG2H1L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 03:27:11 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63C7A80491
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 00:27:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 24FE2B82683
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 07:27:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60D09C433D6;
        Fri, 29 Jul 2022 07:27:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1659079627;
        bh=mNXidyBqhxoR6hoaNGWZwtljkSmbontLwFbTMLJMeSY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jtEPqD4lItHgk91ObDPGgn8sKuevQfWrbxs/NDLxUM/bpODfxFy3TrEV0+IQQS6ot
         /oak3PduZpzEZYN7bC9CJkcdc4TWpl9Cu2Bcgyd7jRycm1qeIFiFOzol3kLLPBLVNz
         qPv+bYMeWcG49de+qLIJm0VGEijpI7GZIs+4pFfI=
Date:   Fri, 29 Jul 2022 09:27:05 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Tong Zhang <ztong0001@gmail.com>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Saurav Girepunje <saurav.girepunje@gmail.com>,
        Colin Ian King <colin.king@intel.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Johan Hovold <johan@kernel.org>, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev, Zheyu Ma <zheyuma97@gmail.com>
Subject: Re: [PATCH v3 3/3] staging: rtl8192u: fix rmmod warn when device is
 renamed
Message-ID: <YuOLybUZ8cBWntY/@kroah.com>
References: <YuDdHMaB6jWARQzA@kroah.com>
 <20220729035230.226172-1-ztong0001@gmail.com>
 <20220729035230.226172-4-ztong0001@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220729035230.226172-4-ztong0001@gmail.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 28, 2022 at 08:52:20PM -0700, Tong Zhang wrote:
> @@ -164,11 +164,19 @@ void rtl8192_debugfs_init_one(struct net_device *dev)
>  
>  void rtl8192_debugfs_exit_one(struct net_device *dev)
>  {
> -	struct r8192_priv *priv = (struct r8192_priv *)ieee80211_priv(dev);
> +	struct r8192_priv *priv = ieee80211_priv(dev);

This change is not relevant for this patch :(

