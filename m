Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03F725A5D72
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 09:56:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231251AbiH3H42 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 03:56:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230132AbiH3H4Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 03:56:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3B70B728A
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 00:56:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6720E612EE
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 07:56:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CCFFC433D6;
        Tue, 30 Aug 2022 07:56:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661846183;
        bh=ClH0uZ3WvtsB2fuNjWROFkm0zb3g1QhJWyLa0PMoU1Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sR1PBXb2UbrpDb9xq+X4wzftc4fJzpZj0F3Jsmra2+I0p9pK+jZ/koCR9p8dJSAE0
         Wdc3vtWqPTiYmeB0rsWIDZy9iH/btVufTU7DCEzpIn82pAhSXsSzB8XLjBeZsX9bDE
         wrUsP+uY7Zcgta+jNpdImiXr60jsr1D92G3zVmENaLOKjeWIOXeEAoP1tn1zqERkOf
         +h/5IF+tpku782x2pb/EjWlTpmH+4u7MdwvufUaQART0DTA0cTpIIVNYvK1mp7Y71j
         x4gMsTH/Mj54WuehYWI7sOSN6szuWmZboDTPCOvU7EyZKqo4fm39AKas+fbE6mVQyj
         e5KaKtCrOjM2Q==
Date:   Tue, 30 Aug 2022 09:56:18 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Carlos Llamas <cmllamas@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arve =?utf-8?B?SGrDuG5uZXbDpWc=?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Suren Baghdasaryan <surenb@google.com>,
        kernel-team@android.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/7] binder: rename alloc->vma_vm_mm to alloc->mm
Message-ID: <20220830075618.t2o6nwayvrnkxy4j@wittgenstein>
References: <20220829201254.1814484-1-cmllamas@google.com>
 <20220829201254.1814484-4-cmllamas@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220829201254.1814484-4-cmllamas@google.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 29, 2022 at 08:12:50PM +0000, Carlos Llamas wrote:
> Rename ->vma_vm_mm to ->mm to reflect the fact that we no longer cache
> this reference from vma->vm_mm but from current->mm instead.
> 
> No functional changes in this patch.
> 
> Signed-off-by: Carlos Llamas <cmllamas@google.com>
> ---

Looks good,
Reviewed-by: Christian Brauner (Microsoft) <brauner@kernel.org>
