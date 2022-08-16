Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 384855959C2
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 13:21:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234010AbiHPLUN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 07:20:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233895AbiHPLTr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 07:19:47 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCDD37E025;
        Tue, 16 Aug 2022 02:50:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 32EE6B8165D;
        Tue, 16 Aug 2022 09:50:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BD3FC433C1;
        Tue, 16 Aug 2022 09:50:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1660643404;
        bh=j7OD01BeQky2yyGnFRKJwW2CZrOcLTaiWu0OC6mAhKk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=saKTtlrvrYOUXC5N+ab/ECi+H2W7J6qjYMYJVooEh3opiy1oPj85/x1CaCOAJ7E3R
         lGiuB+rwqesV9DGEja1zPurkclOMxYy99nXkIJgOSsx7TWws5Wj2C/AJdXuH++2a1Z
         Z9ietn+WxBELZXF4vMijO7pFrDjVI0F7Y5guY3wU=
Date:   Tue, 16 Aug 2022 11:50:01 +0200
From:   gregkh <gregkh@linuxfoundation.org>
To:     Slark Xiao <slark_xiao@163.com>
Cc:     johan <johan@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-usb <linux-usb@vger.kernel.org>
Subject: Re: [PATCH] USB: serial: option: add support for Cinterion
 MV32-WA/WB RmNet mode
Message-ID: <YvtoSQUVuUkMCXtl@kroah.com>
References: <20220810033050.3117-1-slark_xiao@163.com>
 <54f2b923.341c.182a606bab3.Coremail.slark_xiao@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <54f2b923.341c.182a606bab3.Coremail.slark_xiao@163.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 16, 2022 at 05:40:35PM +0800, Slark Xiao wrote:
> Any response？

To what?

It was the middle of the merge window, we can't do anything with new
patches until after -rc1 is out, and then we have a few thousand to dig
through afterward.

Relax, there is no rush here.

thanks,

greg k-h
