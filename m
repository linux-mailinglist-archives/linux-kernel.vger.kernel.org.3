Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 611F05A5D6B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 09:53:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231294AbiH3HxJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 03:53:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230252AbiH3HxG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 03:53:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C4C6C992B
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 00:53:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CF50661474
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 07:53:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01C33C433D6;
        Tue, 30 Aug 2022 07:53:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661845985;
        bh=I0UQZ+rjBDqNlkAEVgI9JmJZSP1FYGPKwV2mdoAtQrs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iBNfmXDb9CuyoEjd+laK+ndCGGWd9eFU4u4lOQdQ9UiWdjQdvyVtHC9yQEehbe+jK
         Cp5ndgK+21+4RuHoCn2Gb2UTdeiOTfew1XW5+53kx/LOoNRV26bmXWKXskstr7rDzJ
         9McpuMjmKPM8IPK46HxdsQQd56pYnlKWTb5w1RU3vIUVOKuHwNTAsY1eDrZTTMg/3z
         NX/oycpa86nQinXcDkxdyRTsF8SdultmY2vfDcPLssrcCKAqAUkJu+yZJTO7DjQj0T
         6K/yNsw3pRYWa6pg5n4+2W/FirqLkHDyuMjIQj54knMu4uzOBeF5RqVjIorJAFc8qQ
         NUMO+EAM46LYQ==
Date:   Tue, 30 Aug 2022 09:53:00 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Carlos Llamas <cmllamas@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arve =?utf-8?B?SGrDuG5uZXbDpWc=?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Suren Baghdasaryan <surenb@google.com>,
        kernel-team@android.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7/7] binderfs: remove unused INTSTRLEN macro
Message-ID: <20220830075300.uguauat5vhy6wjfb@wittgenstein>
References: <20220829201254.1814484-1-cmllamas@google.com>
 <20220829201254.1814484-8-cmllamas@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220829201254.1814484-8-cmllamas@google.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 29, 2022 at 08:12:54PM +0000, Carlos Llamas wrote:
> Fix the following W=1 build error:
> 
> drivers/android/binderfs.c:42: error: macro "INTSTRLEN" is not used [-Werror=unused-macros]
>    42 | #define INTSTRLEN 21
>       |
> 
> No functional changes in this patch.
> 
> Signed-off-by: Carlos Llamas <cmllamas@google.com>
> ---

Thanks,
Reviewed-by: Christian Brauner (Microsoft) <brauner@kernel.org>
