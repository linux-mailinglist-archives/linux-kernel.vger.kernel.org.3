Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBC8B596958
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 08:21:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232974AbiHQGRS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 02:17:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229933AbiHQGRQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 02:17:16 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20A0F6BD78;
        Tue, 16 Aug 2022 23:17:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C3D66B81AD5;
        Wed, 17 Aug 2022 06:17:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E081FC433C1;
        Wed, 17 Aug 2022 06:17:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1660717032;
        bh=6Bd9BwXv3tuxo+nCXxTfzSiPGFvv5j2FzFiQrqXb21M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=q0e+QbBghBjKvmTa1lUwUZNyqC6Gs3b82roBOnMEUfnzA7tXt1JOTdAue8pIPIsUK
         qKUYD24Ygq7WUeNr6wnlcJDd+96OLfNyAAdBR9Nk9uVMXIFwHbHh91uk3yT2hm+zNI
         qla+HwY4Hd7L9Bc1+/nOiDZ7EEQP6l/lPF7DZP54=
Date:   Wed, 17 Aug 2022 08:17:08 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Thierry Guibert <thierry.guibert@croix-rouge.fr>
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        oneukum@suse.com
Subject: Re: [PATCH] CDC-ACM : Add Icom PMR F3400 support (0c26:0020)
Message-ID: <YvyH5JqFtm1pOcid@kroah.com>
References: <CAEzRux_E+EAEkdr8RVGq4BTJ87G75fwXf4gveLTmk_P3nxizvw@mail.gmail.com>
 <YvvDtUi7zgrYlopw@kroah.com>
 <CAEzRux-PG6Fe3qr1kmHqr-tbozmzkpOmM89UAXH-44BuYYcUpA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEzRux-PG6Fe3qr1kmHqr-tbozmzkpOmM89UAXH-44BuYYcUpA@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 16, 2022 at 06:27:24PM +0200, Thierry Guibert wrote:
> Hi Greg,
> 
> I use « git format-patch -1 <commit SHA>[[ » to build a .patch file, and I
> have to use the Gmail web GUI to send it since we have no more access to
> local clients.

You can not use the gmail web gui to send out patches, sorry, that does
not work as it will corrupt it.

thanks,

greg k-h
