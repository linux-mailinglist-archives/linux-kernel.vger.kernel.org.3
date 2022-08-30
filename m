Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E33C5A5D6C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 09:53:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229947AbiH3Hxr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 03:53:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231304AbiH3Hxi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 03:53:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEABCBA17F
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 00:53:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5C2FB60ED9
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 07:53:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AC80C433D7;
        Tue, 30 Aug 2022 07:53:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661846016;
        bh=E2v4tstoXUgaReX2qvEiHJ+2nFl+4fE6cPlXF8zZgME=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=F8RTXMoc+U7dMqpyaBVG0XCjDwy6RkfcbGvqDd0wyguLDPmJJhRQLGPHz4X52aTvj
         sTmNag9gjQvRsGuoXWGYr0OXZknz0UbkcaQzxoYOXBnd8oBzyB7cdw5Fa4jVmWysob
         orhPqnZfSY1i8YJCeT2JOiKimc4d4zIO40kBGXBBD9b1a4TvZZBphZmrzknKhjQ+h4
         8uPTRJ0W3z+VFS1S3GY1oUCMCPaVEzbUUPw8FygEFel7NG2tZkbL+ebubTub7ZUswm
         AwpcG6Btpl3lYh7hBKWwePjI1A0GtJFfszI7+Nk7NJIkf6t09hjzaHQD3aPPwcefm3
         Ojplho73ZPaKg==
Date:   Tue, 30 Aug 2022 09:53:31 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Carlos Llamas <cmllamas@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arve =?utf-8?B?SGrDuG5uZXbDpWc=?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Suren Baghdasaryan <surenb@google.com>,
        kernel-team@android.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/7] binder: fix binder_alloc kernel-doc warnings
Message-ID: <20220830075331.77genqmsse3g4vhd@wittgenstein>
References: <20220829201254.1814484-1-cmllamas@google.com>
 <20220829201254.1814484-7-cmllamas@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220829201254.1814484-7-cmllamas@google.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 29, 2022 at 08:12:53PM +0000, Carlos Llamas wrote:
> Update the kernel-doc section of struct binder_alloc to fix the
> following warnings reported by ./scripts/kernel-doc:
> 
>   warning: Function parameter or member 'mutex' not described in 'binder_alloc'
>   warning: Function parameter or member 'vma_addr' not described in 'binder_alloc'
> 
> No functional changes in this patch.
> 
> Signed-off-by: Carlos Llamas <cmllamas@google.com>
> ---

Looks good,
Reviewed-by: Christian Brauner (Microsoft) <brauner@kernel.org>
