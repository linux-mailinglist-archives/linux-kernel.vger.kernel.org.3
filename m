Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62B664AF47D
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 15:55:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235314AbiBIOyL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 09:54:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235244AbiBIOyK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 09:54:10 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7ED1C0613C9;
        Wed,  9 Feb 2022 06:54:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6462CB821B8;
        Wed,  9 Feb 2022 14:54:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 763E2C340ED;
        Wed,  9 Feb 2022 14:54:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1644418450;
        bh=x4bYGFvsMugiP7T8MkePReIUpGCmEr89VgVEXKc95SI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mUxwYV3QpYBw1LL4ZTXKWaiM8PSeWvxUo3j2LEtB8f4kzlX7BCT3W7zX+IhVdTFe3
         LYugIMrBWuZpydzaSnELWI7VTFDUUKKgdBt3Zep9NWZKrVJ9Sr+2h4EsGTv5TLOzkL
         wMeYFZ6hgEbPAKP+d9BZ5IscpIn3w3PHacGxmOjY=
Date:   Wed, 9 Feb 2022 15:54:07 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     cy_huang <u0084500@gmail.com>, robh+dt@kernel.org,
        cy_huang@richtek.com, will_lin@richtek.com, th_chuang@richtek.com,
        devicetree@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/2] Add Richtek RT1719 USBPD controller support
Message-ID: <YgPVj3rlc2WnqunG@kroah.com>
References: <1644415355-24490-1-git-send-email-u0084500@gmail.com>
 <YgPOz6pfpFcPmHms@kroah.com>
 <YgPQgtcO22W3vZDw@kuha.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YgPQgtcO22W3vZDw@kuha.fi.intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 09, 2022 at 04:32:34PM +0200, Heikki Krogerus wrote:
> On Wed, Feb 09, 2022 at 03:25:19PM +0100, Greg KH wrote:
> > On Wed, Feb 09, 2022 at 10:02:33PM +0800, cy_huang wrote:
> > > 3. Change MODULE_LICENSE from 'GPL v2' to 'GPL'.
> > 
> > Why?  Either is fine, any specific reason you changed this?
> 
> Because I proposed it. I believe everything scripts/checkpatch.pl
> tells me.

Ah, you believe everything a perl script says, be careful :)

