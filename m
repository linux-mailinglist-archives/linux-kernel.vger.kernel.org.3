Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31CB858206F
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 08:50:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229831AbiG0Gue (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 02:50:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230129AbiG0GuF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 02:50:05 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83F202ADF
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 23:48:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id D3712CE200A
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 06:48:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9702C433D7;
        Wed, 27 Jul 2022 06:48:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1658904497;
        bh=O3pWBNFy+mhF4rfrd3ZoZjiwnupWwUro4mk5hWfHJjM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AJk/I0eR8PRR91+7Srhy7DSl1ravoz8r92rp38zmgS7mYUTDZdrOpnGuJ2ZC/7o0v
         zDsHgXrCqLHOzf9zkc9r6PAoTcmTv7GjXeRST9fW33JM3eO+K1bWxqwXG/HFM/K+sj
         6BpPnco1PkrRrsWwW7EvOX7D4LSJ3gJHyZMB41wI=
Date:   Wed, 27 Jul 2022 08:48:14 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Philipp Hortmann <philipp.g.hortmann@gmail.com>
Cc:     Forest Bond <forest@alittletooquiet.net>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] staging: vt6655: Rename MACvClearStckDS
Message-ID: <YuDfrsZeglr1+y7n@kroah.com>
References: <cover.1658333350.git.philipp.g.hortmann@gmail.com>
 <3bdaf8401f49276c3176d073c7f77da57d7c1e70.1658333350.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3bdaf8401f49276c3176d073c7f77da57d7c1e70.1658333350.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 20, 2022 at 06:24:36PM +0200, Philipp Hortmann wrote:
> Fix name of a macro that uses CamelCase which is not
> accepted by checkpatch.pl

You do have 72 columns to use here, feel free to do so :)

Also a bit better description would be nice.

thanks,

greg k-h
