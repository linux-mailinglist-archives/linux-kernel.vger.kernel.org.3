Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A410D50DF32
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 13:45:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235226AbiDYLsX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 07:48:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232326AbiDYLsT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 07:48:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 748BF17062;
        Mon, 25 Apr 2022 04:45:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B1AB36126B;
        Mon, 25 Apr 2022 11:45:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA850C385A7;
        Mon, 25 Apr 2022 11:45:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1650887115;
        bh=TubYRACby4DfXTsYTUATAzONV9WlD1ntBK3W3J8hxPI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BbhMxyfGE5Bg19bY4gkFP47VrK56JGd2y2c66dhb6O0sveqSJGfP4W9XhCsUJ+4Vp
         0wuLUY2skaBHXtujPgM+CzlmSTaHmIVD4gWgbDoJJMG/Oz+88SC6ZDoDIWB+Mm1vWr
         IHAaDMXnAM4WUSOx4AkS/tCTkcK42D1Fd41ag18M=
Date:   Mon, 25 Apr 2022 13:45:12 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     20220420013732.3308816-4-seanjc@google.com, kangel@zju.edu.cn,
        mlevitsk@redhat.com, pbonzini@redhat.com, pgn@zju.edu.cn,
        seanjc@google.com, stable-commits@vger.kernel.org
Subject: Re: Patch "KVM: x86: Pend KVM_REQ_APICV_UPDATE during vCPU creation
 to fix a race" has been added to the 5.10-stable tree
Message-ID: <YmaJyGgxzfx+MbgY@kroah.com>
References: <20220420013732.3308816-4-seanjc@google.com>
 <165088643415117@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <165088643415117@kroah.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 25, 2022 at 01:33:54PM +0200, gregkh@linuxfoundation.org wrote:
> 
> This is a note to let you know that I've just added the patch titled
> 
>     KVM: x86: Pend KVM_REQ_APICV_UPDATE during vCPU creation to fix a race
> 
> to the 5.10-stable tree which can be found at:
>     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> 
> The filename of the patch is:
>      kvm-x86-pend-kvm_req_apicv_update-during-vcpu-creation-to-fix-a-race.patch
> and it can be found in the queue-5.10 subdirectory.
> 
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.
> 
> 
> >From 423ecfea77dda83823c71b0fad1c2ddb2af1e5fc Mon Sep 17 00:00:00 2001
> From: Sean Christopherson <seanjc@google.com>
> Date: Wed, 20 Apr 2022 01:37:31 +0000
> Subject: KVM: x86: Pend KVM_REQ_APICV_UPDATE during vCPU creation to fix a race
> 
> From: Sean Christopherson <seanjc@google.com>
> 
> commit 423ecfea77dda83823c71b0fad1c2ddb2af1e5fc upstream.

Oops, no, this breaks the build, now dropped.
