Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B8FE5A7FF7
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 16:19:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232060AbiHaOT0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 10:19:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231786AbiHaOTW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 10:19:22 -0400
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24F1F5F84;
        Wed, 31 Aug 2022 07:19:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1661955561;
  x=1693491561;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7Y64+ITKD3t7WxyXsYjghMjwDYMJbKCBeS7pYX8P4GQ=;
  b=nlv6dP767aV2n/y08ZV5WUrqMvidwVB2x+LqhgfsNUG73C95qZ3irOqT
   Gp7S7SAKhsh21yvV4oLfh8X0pVsGZD3jwbuxPCyMfIDPawzK7YrkJUkbq
   KlE1obt+PfGuwzGDGomKLAd0dWxzmVUIMgEQ/Lvk05+Pzs9bojNeqQ9jG
   hL/aBqcLq6+uNJl1MV6Lwu6oAEb2r1/xcnahUfcwa/l1d9z/mnLSsCyUC
   UiyFIqXhFRfP12ZTavcO/6uovXPqWvihzuK1A2YS2rb6IWDl+JptY3ldD
   1e8dXchcPvsIvBDnDo4UuoPhFzkO6wJp048hgCp9GS1JzBxx9+EztFrhY
   g==;
Date:   Wed, 31 Aug 2022 16:19:19 +0200
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     Jonathan Cameron <jic23@kernel.org>, kernel <kernel@axis.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/5] iio: adc: mcp320x: use callbacks for RX conversion
Message-ID: <Yw9t55YVm3YfAs5E@axis.com>
References: <20220831100506.3368103-1-vincent.whitchurch@axis.com>
 <20220831100506.3368103-2-vincent.whitchurch@axis.com>
 <CAHp75Vek8tLnwYWZO91HHr1_i7G_F9tErnRsq-GwfQcpR0FaTw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAHp75Vek8tLnwYWZO91HHr1_i7G_F9tErnRsq-GwfQcpR0FaTw@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 31, 2022 at 02:40:49PM +0200, Andy Shevchenko wrote:
> On Wed, Aug 31, 2022 at 1:05 PM Vincent Whitchurch
> <vincent.whitchurch@axis.com> wrote:
> > Replace the device_index switch with callbacks from the chip_info
> > structure, so that the latter has all the information needed to handle
> > the variants.
> 
> Below are for the further patches, as I see the original code has the
> same disadvantages.

Right, these comments are in the original code that is either being just
being moved or that even just happens to be in the context of the diff.

Just to clarify, do you mean by "further patches" that you expect
patches to fix these comments to be added to this series which adds
triggered buffer support?
