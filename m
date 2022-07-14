Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 686FA57507B
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 16:12:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240452AbiGNOMt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 10:12:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240382AbiGNOM2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 10:12:28 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6EED4E630;
        Thu, 14 Jul 2022 07:12:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 59D0EB82589;
        Thu, 14 Jul 2022 14:12:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59ED8C34115;
        Thu, 14 Jul 2022 14:12:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1657807941;
        bh=2DO5446wC2aEAeNt+jWYJzmvi8x7JR2F58UIO6zUVm0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=z/SJIA8tPVS+VmUs0qe85br/nhJpfqBtb5r95A8IM6Rz3q9o7ViWwWuDJ6Cp/sNo1
         WFf8pDztOvT4lh8oRl5WLd80Xa1yJg4BL/Mb86sWu1zCGGqbXaxC2Ys/YGDLH6trDy
         HmwlDuUxj9zxlOlJoYuVPvgM7PYqnPeyfuxAUbwA=
Date:   Thu, 14 Jul 2022 16:08:34 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Andrey Strachuk <strochuk@ispras.ru>
Cc:     Peter Chen <peter.chen@kernel.org>,
        Pawel Laszczak <pawell@cadence.com>,
        Roger Quadros <rogerq@kernel.org>,
        Aswath Govindraju <a-govindraju@ti.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: cdns3: removed useless condition in
 cdns3_gadget_ep_dequeue()
Message-ID: <YtAjYk41LZCzNfRu@kroah.com>
References: <20220711151032.16825-1-strochuk@ispras.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220711151032.16825-1-strochuk@ispras.ru>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 11, 2022 at 06:10:32PM +0300, Andrey Strachuk wrote:
> Comparison of 'ep' with NULL is useless since
> 'ep' is a result of container_of and cannot be NULL
> in any reasonable scenario.

ep is nto the result of container_of() in this driver, are you SURE this
is correct?

If so, please show the proper callstack where this is determined.

thanks,

greg k-h
