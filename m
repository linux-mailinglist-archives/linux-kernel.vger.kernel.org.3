Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A862558EB1B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 13:18:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231986AbiHJLSI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 07:18:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231961AbiHJLSF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 07:18:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 331FE71BDD;
        Wed, 10 Aug 2022 04:18:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C345E61217;
        Wed, 10 Aug 2022 11:18:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2637C433C1;
        Wed, 10 Aug 2022 11:18:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660130284;
        bh=X/igtBEfqT0CYUtASMjqgR3fyAytacOaSIyuErvKw9M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HlT0P+nYbwJ2flfFtMbHArKjbtrGs2UfSXkG/90BCvZRZhwItH47p0W56db4hjVLX
         qOAwfhPAEQXiEufCZS4mddD/cz2+qTOMhzEEZL9DTQsiAPsrIt5wj+BYpbQbofAlmj
         wqX3yjHG3RV+RUVf3ks8zNgMVzi88wByCEsTX1AVIG0b0ObH2fwN8zGvOguxrZq7ZD
         qp3GZb9CKUs8MVfp+R3f4IhMp3jGVFOpx3eq148DKWYJAyj6qXl2ofJpWgrBVNEnwR
         zD9qKN3lXOXE03Ks1jSsU/kaeYCOOA1DpB+E3QmvAMzA1insIbcg8rpTQpUy0u9KmW
         3H4Y+10QSdHQA==
Date:   Wed, 10 Aug 2022 12:17:59 +0100
From:   Lee Jones <lee@kernel.org>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Samuel Ortiz <sameo@linux.intel.com>, Milo Kim <Milo.Kim@ti.com>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH 2/2] mfd: lp8788: Fix an error handling path in
 lp8788_irq_init() and lp8788_irq_init()
Message-ID: <YvOT5wwHtpm3OGP2@google.com>
References: <18398722da9df9490722d853e4797350189ae79b.1659261275.git.christophe.jaillet@wanadoo.fr>
 <bcd5a72c9c1c383dd6324680116426e32737655a.1659261275.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bcd5a72c9c1c383dd6324680116426e32737655a.1659261275.git.christophe.jaillet@wanadoo.fr>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 31 Jul 2022, Christophe JAILLET wrote:

> In lp8788_irq_init(), if an error occurs after a successful
> irq_domain_add_linear() call, it must be undone by a corresponding
> irq_domain_remove() call.
> 
> irq_domain_remove() should also be called in lp8788_irq_exit() for the same
> reason.
> 
> Fixes: eea6b7cc53aa ("mfd: Add lp8788 mfd driver")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
>  drivers/mfd/lp8788-irq.c | 3 +++
>  1 file changed, 3 insertions(+)

Applied, thanks.

-- 
Lee Jones [李琼斯]
