Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEBA65A5D6D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 09:54:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231223AbiH3HyH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 03:54:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231308AbiH3HyB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 03:54:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E2D3D11FD
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 00:53:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1F3EB6147A
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 07:53:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 561D1C433C1;
        Tue, 30 Aug 2022 07:53:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661846038;
        bh=3eykAcMDzVJvc0/5jd/vgOG9bymIR4NjVwmgjLLaB1E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YpsHPHJSKbZrS0RzRvv69vJzD/PHw7LDtGduVhef7rmTpqgWw5HcjODgAiV7+KbKw
         Q/flwFAM9CS9/EoVnKTZXgy5BOOfLbwsQpe5vXmacsanTZcXUHnXD6xgvzrbZckn5Y
         M5qWoiwigWtkIwVOIoVm2zFGviGxxIyf7zs56valMCKc6hceUnY+yQR6au1i174AvF
         5TkmlFs4w93rgNxOylt7OL9+xxPPGBLLYOqOSu4f41waVc0yWZP/j59bZ6Ho4FAUbQ
         CoBUOxXZ2plEQJjlFpafVCh1Hi/UGVwE4hHcPzO/83Yob5/ove6dg/EtGjHoGlpAyl
         RcFO2n08qcY5g==
Date:   Tue, 30 Aug 2022 09:53:53 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Carlos Llamas <cmllamas@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arve =?utf-8?B?SGrDuG5uZXbDpWc=?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Suren Baghdasaryan <surenb@google.com>,
        kernel-team@android.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/7] binder: fix trivial kernel-doc typo
Message-ID: <20220830075353.wxd2azo2pfokee6u@wittgenstein>
References: <20220829201254.1814484-1-cmllamas@google.com>
 <20220829201254.1814484-3-cmllamas@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220829201254.1814484-3-cmllamas@google.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 29, 2022 at 08:12:49PM +0000, Carlos Llamas wrote:
> Correct the misspelling of 'invariant' in kernel-doc section.
> 
> No functional changes in this patch.
> 
> Signed-off-by: Carlos Llamas <cmllamas@google.com>
> ---

Looks good,
Reviewed-by: Christian Brauner (Microsoft) <brauner@kernel.org>
