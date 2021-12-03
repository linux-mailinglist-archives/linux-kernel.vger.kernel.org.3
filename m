Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C253A467917
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 15:07:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381337AbhLCOK4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 09:10:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352478AbhLCOKu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 09:10:50 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C700C06173E;
        Fri,  3 Dec 2021 06:07:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1A6BC62B11;
        Fri,  3 Dec 2021 14:07:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED970C53FAD;
        Fri,  3 Dec 2021 14:07:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1638540444;
        bh=WEsQ0YJT+JFvn7QDLZTVVdMDj0ZbFJUPEDcXxcmqgb4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2DWYXrjYmNzSNDnhxE/MEx/GMkOnZw+kLuV0oub7rrSZ52F9c4mFo6+SauUHZh1PU
         eVkBF3maLXvofb0p27PsEYxte9z0hKrmX5aF9kbQvWv4DRJEklH9CZks4mgJ2q5bKN
         L1t9R9baN2GsSTsj/dZHNBg/ap/ej/hFH0HcHE0M=
Date:   Fri, 3 Dec 2021 15:07:21 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Sergio Paracuellos <sergio.paracuellos@gmail.com>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        sboyd@kernel.org, john@phrozen.org, linux-staging@lists.linux.dev,
        neil@brown.name
Subject: Re: [PATCH v5 4/4] staging: mt7621-dts: align resets with binding
 documentation
Message-ID: <YaokmRHYsazdMByi@kroah.com>
References: <20211107074200.18911-1-sergio.paracuellos@gmail.com>
 <20211107074200.18911-5-sergio.paracuellos@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211107074200.18911-5-sergio.paracuellos@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 07, 2021 at 08:42:00AM +0100, Sergio Paracuellos wrote:
> Binding documentation for compatible 'mediatek,mt7621-sysc' has been updated
> to be used as a reset provider. Align reset related bits and system controller
> node with binding documentation along the dtsi file.
> 
> Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
> ---
>  drivers/staging/mt7621-dts/mt7621.dtsi | 25 +++++++++++--------------
>  1 file changed, 11 insertions(+), 14 deletions(-)

This patch does not apply to my tree :(

thanks,

greg k-h
