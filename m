Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8B97578541
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 16:23:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235243AbiGROW7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 10:22:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235161AbiGROW4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 10:22:56 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1D4C17056
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 07:22:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6A7D3B81618
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 14:22:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51C7DC341C0;
        Mon, 18 Jul 2022 14:22:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1658154173;
        bh=Fqub0gkwDWlNfMKT567baTYJxdJF6oYJFy8SvGoM+Lc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cIu4Pa4Qn6eg4S1HPmfZefeFjgZ0yXHEE81t5NTkVxJHY8g7djw5MlWRCUb8BSbcd
         bt0xOaIhhY7sMFe4Rrn0X+0qGUqNs8iOnKaxEl1BstvPBmSaGeolq/L0kvCdQ7pSgF
         sGLwOJsVEgNDAF32eMEL6UxZyao/OD7Kl2pomUfw=
Date:   Mon, 18 Jul 2022 16:22:49 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Gaosheng Cui <cuigaosheng1@huawei.com>
Cc:     srinivas.kandagatla@linaro.org, rafael@kernel.org,
        linux-kernel@vger.kernel.org, gongruiqi1@huawei.com,
        wangweiyang2@huawei.com
Subject: Re: [PATCH -next] nvmem: node: using put_device to replace
 kfree_const
Message-ID: <YtVsuS1J4h5F+KCG@kroah.com>
References: <20220718130612.3122982-1-cuigaosheng1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220718130612.3122982-1-cuigaosheng1@huawei.com>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 18, 2022 at 09:06:12PM +0800, Gaosheng Cui wrote:
> We should never be touching the name pointer of a kobject
> directly like this, the device structure itself should be
> cleaning up the memory, not a kfree_const, so using put_device
> to replace kfree_const.
> 
> Signed-off-by: Gaosheng Cui <cuigaosheng1@huawei.com>
> ---
>  drivers/base/node.c | 2 +-

Please slow down.

Your subject does not match the file name you changed.  Stop and wait a
few days, fix up your patches based on the review, and send a patch
series and then wait for others to review them.

While you wait, take some time and review patches from others, so that
you can get some experience here.

good luck

greg k-h
