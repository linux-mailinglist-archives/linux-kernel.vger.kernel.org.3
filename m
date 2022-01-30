Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90BDE4A36A3
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jan 2022 15:28:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354986AbiA3O2D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jan 2022 09:28:03 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:58580 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354942AbiA3O2B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jan 2022 09:28:01 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 76FBD611D3;
        Sun, 30 Jan 2022 14:28:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46A30C340E4;
        Sun, 30 Jan 2022 14:28:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1643552880;
        bh=9n+Aej34FCVMukev6/1ASkZcvRdCG22WgQlY7LcmWqs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IVajGh+JzGnWjkfepEabhx1lEbYnVmhTEkQlYg1KQBuMxrUh7tgJvhrvCROiLn1GE
         qR5sFgkMuJXzcnPvUul2SC5Mk3htp8Jdy2F5yQqu0edLodqxJm1+iGqVVuBq0KjUAb
         TFWI2ZT5jJNI4rmMjQwBKss6k3jD4yaWTqiPxg4o=
Date:   Sun, 30 Jan 2022 15:27:57 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     felipe.contreras@gmail.com, lorenzo@kernel.org, nbd@nbd.name,
        stable-commits@vger.kernel.org
Subject: Re: Patch "mt76: connac: introduce MCU_CE_CMD macro" has been added
 to the 5.15-stable tree
Message-ID: <Yfagbdm23OI2LXEA@kroah.com>
References: <164354739721825@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <164354739721825@kroah.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 30, 2022 at 01:56:37PM +0100, gregkh@linuxfoundation.org wrote:
> 
> This is a note to let you know that I've just added the patch titled
> 
>     mt76: connac: introduce MCU_CE_CMD macro
> 
> to the 5.15-stable tree which can be found at:
>     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> 
> The filename of the patch is:
>      mt76-connac-introduce-mcu_ce_cmd-macro.patch
> and it can be found in the queue-5.15 subdirectory.
> 
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.

Oops, no, this did not get added here, only in 5.16.y
