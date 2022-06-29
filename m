Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A36AA55F5EE
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 07:59:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231195AbiF2F7H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 01:59:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230499AbiF2F7E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 01:59:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F3402AC61;
        Tue, 28 Jun 2022 22:59:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C64E561847;
        Wed, 29 Jun 2022 05:59:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2CA2C34114;
        Wed, 29 Jun 2022 05:59:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1656482343;
        bh=XMyoN7X0TYQI0q///T/+MOg3sOWfMhqEPKgAL/Q93To=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QdQzN4m3seA5b/RQuleY8oI8TdkSeAOPAoBNHw4Eci1dHSQsKigMoAt3ruVHk0MG0
         bCXGs8KNUTcrmlstD2Hyhd3NUYXbMVYVLccxfDCjb046oEshOU6ShDu70cJkNQVD/x
         6pVKLf1LMpJ7X7CEYR/An4LVu3f520VduyvcJ120=
Date:   Wed, 29 Jun 2022 07:59:00 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "Jiapeng.Chong" <jiapeng.chong@linux.alibaba.com>
Cc:     neal_liu <neal_liu@aspeedtech.com>, balbi <balbi@kernel.org>,
        joel <joel@jms.id.au>, andrew <andrew@aj.id.au>,
        "sumit.semwal" <sumit.semwal@linaro.org>,
        "christian.koenig" <christian.koenig@amd.com>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>,
        linux-usb <linux-usb@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-media <linux-media@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linaro-mm-sig <linaro-mm-sig@lists.linaro.org>
Subject: Re: =?utf-8?B?5Zue5aSN77yaW1BBVENI?= =?utf-8?Q?=5D?= usb: gadget:
 Fix unsigned comparison with less than zero
Message-ID: <YrvqJIsnmlol2etP@kroah.com>
References: <20220623084347.38207-1-jiapeng.chong@linux.alibaba.com>
 <YrWjCnNJohij691b@kroah.com>
 <19ba5da7-3e9d-49e1-aa7f-b0834737fbfe.jiapeng.chong@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <19ba5da7-3e9d-49e1-aa7f-b0834737fbfe.jiapeng.chong@linux.alibaba.com>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 29, 2022 at 01:51:01PM +0800, Jiapeng.Chong wrote:
> Sorry, we didn't see this patch.
> commit c09b1f372e746aeeb61ef8ffe0fea3970fd9273e

I am sorry, I do not understand what you mean here at all.

confused,

greg k-h
