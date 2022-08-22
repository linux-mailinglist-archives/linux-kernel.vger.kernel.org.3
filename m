Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41E1459C18D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 16:25:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235525AbiHVOZY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 10:25:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231395AbiHVOZV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 10:25:21 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07AF72B626;
        Mon, 22 Aug 2022 07:25:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B146FB81215;
        Mon, 22 Aug 2022 14:25:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A414C433C1;
        Mon, 22 Aug 2022 14:25:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1661178318;
        bh=pNi1D6IsPfHbA4OaT5X8Z2eDmluRjMaicFJaFUgPQOA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FoaknaEu1jH9/lxfYGieRE7NsDFaHCXIMDLgAmZPG8ysnwE+8Zpzo0TataGNMPMrY
         3jzeDgI3TbsNSxPAGN2vFMsQu6PYgGMPAqWf/F0j1ChoobzMlLmNdLouZnbTzU6xcg
         BVTF00hiznXj3eqOMP8FpckNdl6WqQ6oRNfhJ9xc=
Date:   Mon, 22 Aug 2022 16:25:15 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Tuo Cao <91tuocao@gmail.com>
Cc:     alcooperx@gmail.com, bcm-kernel-feedback-list@broadcom.com,
        jirislaby@kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RESEND] serial: 8250_bcm7271: move spin_lock_irqsave to
 spin_lock in interrupt handler
Message-ID: <YwORy3QMbRUSlBZE@kroah.com>
References: <20220822141110.17199-1-91tuocao@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220822141110.17199-1-91tuocao@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 22, 2022 at 10:11:10PM +0800, Tuo Cao wrote:
> it is unnecessary to call spin_lock_irqsave in a interrupt handler.

Yes, but it is safer to do so, right?

Why is this change needed?

Did you test it on real hardware to verify it works?

We need a lot more information in the changelog text before being able
to accept this.

thanks,

greg k-h
