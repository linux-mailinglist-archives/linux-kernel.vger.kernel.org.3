Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71E6256D769
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 10:09:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229665AbiGKIJV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 04:09:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiGKIJU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 04:09:20 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BDCE64CB;
        Mon, 11 Jul 2022 01:09:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 6FA81CE0EE7;
        Mon, 11 Jul 2022 08:09:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 175D9C34115;
        Mon, 11 Jul 2022 08:09:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1657526956;
        bh=R7vB3J7flbuyqGqcYJUoWzBRx5LCGDGMqM8vVWZ3HXk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=U9LdR+F+5ES3zNGpqOKybVb2/VUmf/fIbxRk/NtAthvxWOWdv1AOpYyBfigVGpunv
         KdWyI8ezwKMUwl9eay+Jfa+UqhLsnGihbdcMGh6TYZ73uHjUul3GF3qVRusxsnk95i
         soKmYso4f3P7WCY8cUwvHdg4uIPuARZl6v+PutoE=
Date:   Mon, 11 Jul 2022 10:09:13 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Maxim Devaev <mdevaev@gmail.com>
Cc:     linux-usb@vger.kernel.org, stern@rowland.harvard.edu,
        corbet@lwn.net, balbi@kernel.org, caihuoqing@baidu.com,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v4] usb: gadget: f_mass_storage: forced_eject attribute
Message-ID: <YsvaqV6LrSg7KR0m@kroah.com>
References: <20220710201605.211434-1-mdevaev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220710201605.211434-1-mdevaev@gmail.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 10, 2022 at 11:16:06PM +0300, Maxim Devaev wrote:
> It allows to reset prevent_medium_removal flag and "eject" the image.
> 
> The patch is a completely alternative implementation of the previously
> proposed [1], the idea of which was born after the mentioned discussion.

Don't force people to go and dig up more context of a change in a
changelog text, just spell it out here as to what you are doing and why
you are doing it please.

thanks,

greg k-h
