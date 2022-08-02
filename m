Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1661587704
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 08:15:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234998AbiHBGPC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 02:15:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230298AbiHBGO7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 02:14:59 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77C3D3C151
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 23:14:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EF5FEB8188E
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 06:14:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43FDCC433D6;
        Tue,  2 Aug 2022 06:14:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1659420895;
        bh=iW4M/0W+Ikl+Cb7PVNHeYPVXODoTlt1pIwf8XA1jcE0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tEG3DoYl9wmnuM94/L+rLf/AoaVtAZ+8WUSLzaTA/yyeWCUyiMaM13LLfJIWZBFlo
         yoXvk4JW3trxcriD++t0N3sBL+9m9becMFNsODtUlcXPPo5ayuGROwrtHSdC70+ubU
         qL4yDflkJ01zL9HAm9ABQqZD3RGyQdGOy8MjayKQ=
Date:   Tue, 2 Aug 2022 08:14:52 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "Hans-Christian Egtvedt (hegtvedt)" <hegtvedt@cisco.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Yury Norov <yury.norov@gmail.com>,
        Allison Randal <allison@lohutok.net>,
        Joe Perches <joe@perches.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        Torsten Hilbrich <torsten.hilbrich@secunet.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [v4.9 PATCH 1/6] include/uapi/linux/swab.h: fix userspace
 breakage, use __BITS_PER_LONG for swap
Message-ID: <YujA3AWbQ3ASJhhD@kroah.com>
References: <20220731182635.1910069-1-hegtvedt@cisco.com>
 <20220731182635.1910069-2-hegtvedt@cisco.com>
 <Yue0Tj+tnXRhCWab@kroah.com>
 <DM5PR11MB0012AB20FEF4F3895792863FDD9A9@DM5PR11MB0012.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM5PR11MB0012AB20FEF4F3895792863FDD9A9@DM5PR11MB0012.namprd11.prod.outlook.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 01, 2022 at 04:33:16PM +0000, Hans-Christian Egtvedt (hegtvedt) wrote:
> On 01/08/2022 13:09, Greg KH wrote:
> > As you are passing on patches from others, it is usually requried that
> > you too sign-off on them.  Can you fix that up on this series and resend
> > it so that I can take them?
> 
> Yes, sorry, we do not add signed-off-by entries internally, so my git
> config does not add it by default. Will resend the series.

You really should do this internally as well, that way you have a "path
of blame" to help keep track of why patches were added to your trees,
and who did the reviewing of them.

I'll go pick up the resent series now, thanks.

greg k-h
