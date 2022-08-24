Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A14D59F629
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 11:27:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235628AbiHXJ07 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 05:26:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235131AbiHXJ0z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 05:26:55 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4D8183F35;
        Wed, 24 Aug 2022 02:26:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 996CCB822BB;
        Wed, 24 Aug 2022 09:26:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D5C5C433D6;
        Wed, 24 Aug 2022 09:26:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661333211;
        bh=YxiawnL2va2fW+YyVg1ZcwysCojw/B5LKNq1rBTJOMQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hnxGmvKbKonxWfdlG/+mAXtkJDl7TnL6Sq/0eH9H5EARNzHO91EODLA8d8uXmz0TD
         n+kohX98MPphwS/P9johGsCDy/Dsa5sn1Dg55fJEM2qEwTzRYzpdZB4bY5aZ6ZDAmP
         eOTglMFudOZom7QEAf6FidPmHW/ArMopFzjooHpcxnxKyJZ8fG2oLc7nTqbWFJ+9G9
         tp0McRW+vo4X6mXHSWfWaL5r8lw0mVMqt0hdtk2oN7zgEkZ82ivKeZR06KqnIrcE5n
         nEzFbVUxPW+wI9uEh6kedzoeJweLs9sAbJjWv/qW7YCSg/3oznsxN4TE1y5KG2J9q2
         usU7xM25mI8vA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1oQmez-0004nQ-Fm; Wed, 24 Aug 2022 11:26:54 +0200
Date:   Wed, 24 Aug 2022 11:26:53 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Slark Xiao <slark_xiao@163.com>
Cc:     gregkh <gregkh@linuxfoundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-usb <linux-usb@vger.kernel.org>
Subject: Re: Re: [PATCH] USB: serial: option: add support for Cinterion
 MV32-WA/WB RmNet mode
Message-ID: <YwXu3ZDozZczJxuh@hovoldconsulting.com>
References: <20220810033050.3117-1-slark_xiao@163.com>
 <54f2b923.341c.182a606bab3.Coremail.slark_xiao@163.com>
 <YvtoSQUVuUkMCXtl@kroah.com>
 <7491a855.2224.182cf117a99.Coremail.slark_xiao@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7491a855.2224.182cf117a99.Coremail.slark_xiao@163.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 24, 2022 at 04:56:45PM +0800, Slark Xiao wrote:

> At 2022-08-16 17:50:01, "gregkh" <gregkh@linuxfoundation.org> wrote:
> >On Tue, Aug 16, 2022 at 05:40:35PM +0800, Slark Xiao wrote:
> >> Any response？
> >
> >To what?
> >
> >It was the middle of the merge window, we can't do anything with new
> >patches until after -rc1 is out, and then we have a few thousand to dig
> >through afterward.
> >
> >Relax, there is no rush here.
> >
> >thanks,
> >
> >greg k-h
> Hi Greg,
>   Now v6.0-rc2 is out for several days. I still didn't find any progress about this commit.
> Normally such commit would be committed into Johan Hovold's personal project firstly:
> index: kernel/git/johan/usb-serial.git and waitting for merge window.
>   In some sub-system, the merge window would be closed after rc4.
> So Johan or Greg , could you help handle this asap?

Again, relax. I haven't had time to process my queue after the merge
window and some holiday. Nothing is lost and I'll get to your patch in
time.

Johan
