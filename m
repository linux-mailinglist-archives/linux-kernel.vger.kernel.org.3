Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A90D4B4CED
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 12:11:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239889AbiBNKuT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 05:50:19 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349256AbiBNKtp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 05:49:45 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18E9459A63;
        Mon, 14 Feb 2022 02:13:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AB7CF60F60;
        Mon, 14 Feb 2022 10:13:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F0C4C340E9;
        Mon, 14 Feb 2022 10:13:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1644833624;
        bh=Oqs2c+CSy2ojS0blJcmVhdvVTN8pL9wK7YjIOHGRVwU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kldvhzexBmY8f6OKfnUtYfDdTKk2zUEog/QxGa3qXn5IqlEE6S959kOzcsEkpLIS6
         JvekTTu3hVCeH4uQgIzdOrmlCjrfO3XAdyPBtA1ia1+Pd7W6gwMYa6Eb9MT0et89u/
         G5xqsSqQBflZWsbLCueeXcDRNE830a5sJ7bKRTyw=
Date:   Mon, 14 Feb 2022 11:13:41 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Husni Faiz <ahamedhusni73@gmail.com>
Cc:     johan@kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: serial: Fix Coding Style Errors
Message-ID: <YgorVSrt56Xf0fKK@kroah.com>
References: <20220212175510.521072-1-ahamedhusni73@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220212175510.521072-1-ahamedhusni73@gmail.com>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 12, 2022 at 11:25:10PM +0530, Husni Faiz wrote:
> Added a space before the ternary operator.
> Removed the space after the function argument.

That should be 2 different patches, right?

Please learn stuff like this on the drivers/staging/ part of the kernel
first, as patches for this are welcome there and that is a great place
to start.

good luck!

greg k-h
