Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9C624D5E93
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 10:37:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347603AbiCKJip (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 04:38:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347502AbiCKJim (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 04:38:42 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73D9649C85;
        Fri, 11 Mar 2022 01:37:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 804F6612C8;
        Fri, 11 Mar 2022 09:37:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2CD4C340EC;
        Fri, 11 Mar 2022 09:37:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646991457;
        bh=h9t5ker/pif0mihscztts2EzVeCJ38jCD40jobk+fb0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=i0eVLg+GLapWdKbgtyDupNGQaR92Wiyq2wU1c4CUFf7g4xxv7DHJrkw39tAYGaOXj
         fMXSxlkzhDDNlvYnrvkK3285+1Oq2u2JmQzKYViUgCoZktAxGUBu8Msyuwk0PRWrd2
         LfQfRT0HsFZg3kS1E4GJ2a9UMZdmeIWKUUVDMPyLRFQIaNS1GpBE1OnlO9Oi4dq1Oy
         hTGP5J5kuUVf6eA8+yhnJl4HHa66KcXwcMhM6n259C4HlwscebPLGs8wiUpkAMfboU
         K8wtc9hvRH75joMfzOwVdmbS0HtGRxGCfO8nhOfo3dOnlk2y4TZ+StklVqm1GnpsRr
         XTLB9nLovO4zw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1nSbiG-0001wS-LU; Fri, 11 Mar 2022 10:37:32 +0100
Date:   Fri, 11 Mar 2022 10:37:32 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Eddie James <eajames@linux.ibm.com>
Cc:     Joel Stanley <joel@jms.id.au>, linux-usb@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v2] USB: serial: pl2303: Add IBM device IDs
Message-ID: <YisYXEnzOfC7Qsx6@hovoldconsulting.com>
References: <20220301224446.21236-1-eajames@linux.ibm.com>
 <YiB7gz0GJ1Uz0mE2@hovoldconsulting.com>
 <CACPK8XfoCXisL=udkuO-x4LZ3r-9iKA2d7oLb7KmXs3+LkQgnQ@mail.gmail.com>
 <YiCHPuNkMuO4uARu@hovoldconsulting.com>
 <CACPK8XfUCyVgwVYLt_99CgQWuoFTw7O9d2NiuzMzGPa1VFVUyg@mail.gmail.com>
 <YiCN+x2XPiawaweY@hovoldconsulting.com>
 <CACPK8Xc9MnM9_jr7NrNLtqBrN_t8D7G-scQvk51vbpOU6LWeuw@mail.gmail.com>
 <YiCU3KI9Dh2psRnK@hovoldconsulting.com>
 <b1ec9ab3-d621-fa66-0fae-f966242f3f7f@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b1ec9ab3-d621-fa66-0fae-f966242f3f7f@linux.ibm.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 03, 2022 at 03:48:37PM -0600, Eddie James wrote:

> It's a pretty generic pl2303 device and doesn't have to be used for UPS, 
> but that is our use-case. Here is a page with some detail about the 
> device: 
> https://www.ibm.com/docs/en/power9/9009-22A?topic=power-uninterruptible-supply

Could you please also post the output of "lsusb -v" for this device to
this thread for completeness? This may be needed to improve the current
type detection for newer pl2303 devices.

Do you know which type of PL2303 you use?

Thanks!

Johan
