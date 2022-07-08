Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8347956B35E
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 09:20:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237501AbiGHHTc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 03:19:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237276AbiGHHTT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 03:19:19 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92B3E7B352;
        Fri,  8 Jul 2022 00:19:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 29AB8B824EC;
        Fri,  8 Jul 2022 07:19:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 595AAC341CB;
        Fri,  8 Jul 2022 07:19:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1657264755;
        bh=IwOXh+OMWyRPtIQMt78YAlA6CfL3v4Df8DVeuy+JGiQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=emu/UZkqmtofzZX8+aGsZNPCfQdxt6Z3Kg0NWOQI+BbY9hdofm/QzobkwFcdnpwDh
         wQDbtP+ks5fc99VBN2ytY0qbGN5Ada1beMSLEHZmQvQHsG1cNJ3oD70nNufUF4fnZU
         5thBOK5q8WNAqEWXdkctXmOimwTKPqLqQ4CXFZS0=
Date:   Fri, 8 Jul 2022 09:19:13 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Jozef Martiniak <jomajm@gmail.com>
Cc:     Felipe Balbi <balbi@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Jens Axboe <axboe@kernel.dk>, Hangyu Hua <hbh25y@gmail.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Wei Ming Chen <jj251510319013@gmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] gadgetfs: ep_io - wait until IRQ finishes
Message-ID: <YsfacfpE+h/GLTC4@kroah.com>
References: <20220708070645.6130-1-jomajm@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220708070645.6130-1-jomajm@gmail.com>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 08, 2022 at 09:06:44AM +0200, Jozef Martiniak wrote:
> after usb_ep_queue() if wait_for_completion_interruptible() is
> interrupted we need to wait until IRQ gets finished.
> 
> Otherwise complete() from epio_complete() can corrupt stack.
> 
> Signed-off-by: Jozef Martiniak <jomajm@gmail.com>

What commit id does this fix?

thanks,

greg k-h
