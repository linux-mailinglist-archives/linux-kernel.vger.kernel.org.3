Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E780B59752E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 19:36:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241227AbiHQRdA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 13:33:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237692AbiHQRc5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 13:32:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD892D7A;
        Wed, 17 Aug 2022 10:32:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 77BDD610A1;
        Wed, 17 Aug 2022 17:32:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49D9FC433C1;
        Wed, 17 Aug 2022 17:32:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1660757575;
        bh=s7yiZn02abIhKDwpnmk+CyC8nu8kU+wLzcoJI5EyhW8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YMpGH2OqQXp/1EcoS7LVpYSxcswniAXWzzz1YPOv8AdpxyMLC8eDECsG9g9+nVbGt
         j30LkLyA5VY2CtTHikp5HtEobap309m1r2eXy0xkU6bVZymYWSfdrDCaeE9HpC3VNx
         lr1FEXCOpoTGDbm+EeOBoc3NdEQZQDaIz7TaMj9A=
Date:   Wed, 17 Aug 2022 19:32:52 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     akpm@linux-foundation.org, catalin.marinas@arm.com,
        dvyukov@google.com, elver@google.com, glider@google.com,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        max.schulze@online.de, will@kernel.org, yee.lee@mediatek.com,
        stable-commits@vger.kernel.org
Subject: Re: Patch "Revert "mm: kfence: apply kmemleak_ignore_phys on early
 allocated pool"" has been added to the 4.14-stable tree
Message-ID: <Yv0mRPKRB6iEY9kh@kroah.com>
References: <20220816163641.2359996-1-elver@google.com>
 <1660757029198205@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1660757029198205@kroah.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 17, 2022 at 07:23:49PM +0200, gregkh@linuxfoundation.org wrote:
> 
> This is a note to let you know that I've just added the patch titled
> 
>     Revert "mm: kfence: apply kmemleak_ignore_phys on early allocated pool"
> 
> to the 4.14-stable tree which can be found at:
>     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

Oops, wrong branch, this is now dropped, sorry for the noise.

greg k-h
