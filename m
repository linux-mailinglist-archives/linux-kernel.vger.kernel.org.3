Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC720598673
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 16:55:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343735AbiHROwS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 10:52:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343729AbiHROwR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 10:52:17 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA84EBCC15
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 07:52:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 62C67B821CD
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 14:52:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0796C433D6;
        Thu, 18 Aug 2022 14:52:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1660834334;
        bh=1T6Tmayu9evgPNeUmBytJlgEdaqiC+oynr73HGK4v7A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OYOsPDgMG0tScLxntfDR/UjNDMqlk596ljbpviARA1QZFBJhucYNQcronQIzL2VGa
         KC4+jLDP8TB/JstBK5HUF60aDZczBJNrfNUaQDPgymU4ev78lCtBrVPttY2PhtgmQR
         UgyLsBEYVXiyNJAOsrRSq6MlvK8UM9+GhDEOsp/0=
Date:   Thu, 18 Aug 2022 16:52:11 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Paul Lemmermann <thepaulodoom@thepaulodoom.com>
Cc:     arnd@arndb.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers: char: mem: changed 'unsigned' to 'unsigned int'
Message-ID: <Yv5SG8XMR2mZGAqG@kroah.com>
References: <YvxF0yn07ztg9r4A@gus-fring.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YvxF0yn07ztg9r4A@gus-fring.localdomain>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 16, 2022 at 08:35:31PM -0500, Paul Lemmermann wrote:
> found with checkpatch.pl

That is a very sparse changelog text.

Why make this change?  Please be descriptive.

thanks,

greg k-h
