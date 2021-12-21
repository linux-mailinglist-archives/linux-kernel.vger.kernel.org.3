Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0740047B9F6
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 07:20:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233316AbhLUGUk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 01:20:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230245AbhLUGUk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 01:20:40 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02C60C061574
        for <linux-kernel@vger.kernel.org>; Mon, 20 Dec 2021 22:20:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 15ACF6143A
        for <linux-kernel@vger.kernel.org>; Tue, 21 Dec 2021 06:20:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0DB6C36AE2;
        Tue, 21 Dec 2021 06:20:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1640067638;
        bh=75EcQm5F1ixHXA9iN5o/mzXlI2TASqOMhCOBQksqZgk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ubWJgiA0CLZZy4zwhAwGeRz1DojRQ9opUodMXkzxq5cm0nP8ELXRrZxcbCHk5Y6ZW
         LHkuSU9JVT84zjFgQX+WAhksSjlpad5/evKLv4FWrTKJUGfaPEvSM8/wj1M1WI/4OI
         vptMZ1rTGBLZ/fU3ePZlKQG1hkgp785GkaAQvRIE=
Date:   Tue, 21 Dec 2021 07:20:36 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Gaston Gonzalez <gascoar@gmail.com>
Cc:     linux-staging@lists.linux.dev, nsaenz@kernel.org,
        f.fainelli@gmail.com, rjui@broadcom.com, sbranden@broadcom.com,
        bcm-kernel-feedback-list@broadcom.com,
        juerg.haefliger@canonical.com, rdunlap@infradead.org,
        dave.stevenson@raspberrypi.com, stefan.wahren@i2se.com,
        unixbhaskar@gmail.com, mitaliborkar810@gmail.com,
        phil@raspberrypi.com, linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] staging: vc04_services: avoid the use of typedef for
 function pointers
Message-ID: <YcFyNFR66Ii2tos+@kroah.com>
References: <cover.1639858361.git.gascoar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1639858361.git.gascoar@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 20, 2021 at 06:29:10PM -0300, Gaston Gonzalez wrote:
> This patch set removes some typedefs for function pointers in vc04_services.
> 
> After patches 01 to 03, there are no remaining typedef under vc04_services.
> Hence, the patch 04/04 updates the TODO file removing the 'remove typedefs'
> task.
> 
> Gaston Gonzalez (4):
>   staging: bcm2835-audio: replace function typedefs with equivalent
>     declaration
>   staging: vc04_services: replace function typedef with equivalent
>     declaration
>   staging: vc04_services: avoid the use of typedef for function pointers
>   staging: vc04_services: update TODO file

These are not the name of the patches that you sent out at all :(

Are you sure you created this properly?

Something went wrong.

greg k-h
