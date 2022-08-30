Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99EC35A5D82
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 09:58:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231324AbiH3H6E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 03:58:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230506AbiH3H6B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 03:58:01 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BE5BD11E2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 00:58:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BBA23B816CE
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 07:57:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B516C433D6;
        Tue, 30 Aug 2022 07:57:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661846278;
        bh=tMezW17H30QYH+rtqSZLpnK9Zmp87zjX0uCL3+xUkqU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tV6oBMpm8Q7OvzGU0kdTL7C8kgKDOwa39BWo+lhO5mOdnUsOAVhk52V2fbzv24ZnQ
         +RnMsJ0TIPrf/uhtoyHS/EbpuMYrm9G5MwcYfWEoK3W+UHXmFclIvIvH8VMtQxhzy6
         D513r5dPHqTXnSZhZPHRQBuoANbJdhdfgNmLG+nmUT9Uwl8YHhZp1QvKjgcybZ2cAw
         iwW4MVZBn9ND7Tp3nu2VWNfbvF96sNTvb2Djlg4eTm7Gp9GziKL6T6Kx6dqfgBTVmn
         ba4YAOPC7QMXH8xlJSCF0vjwNUF+cnkO+BgOSLIQyD/tFhh7eqM9/NcNK7nSZZI2Wj
         I1KlExypp76kQ==
Date:   Tue, 30 Aug 2022 09:57:52 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Carlos Llamas <cmllamas@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arve =?utf-8?B?SGrDuG5uZXbDpWc=?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Suren Baghdasaryan <surenb@google.com>,
        kernel-team@android.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/7] binder: remove unused binder_alloc->buffer_free
Message-ID: <20220830075752.6lueoqmaskhygb5z@wittgenstein>
References: <20220829201254.1814484-1-cmllamas@google.com>
 <20220829201254.1814484-6-cmllamas@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220829201254.1814484-6-cmllamas@google.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 29, 2022 at 08:12:52PM +0000, Carlos Llamas wrote:
> The ->buffer_free member was introduced in the first revision of the
> driver under staging but it appears like it was never actually used
> according to git's history. Remove it from binder_alloc.
> 
> Signed-off-by: Carlos Llamas <cmllamas@google.com>
> ---

Looks good,
Reviewed-by: Christian Brauner (Microsoft) <brauner@kernel.org>
