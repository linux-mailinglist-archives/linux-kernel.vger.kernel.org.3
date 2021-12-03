Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A88EB4675CA
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 11:57:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380231AbhLCLAd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 06:00:33 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:37690 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237898AbhLCLAb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 06:00:31 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C5FA7B82673;
        Fri,  3 Dec 2021 10:57:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6DA6C53FAD;
        Fri,  3 Dec 2021 10:57:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1638529025;
        bh=oYaJo1Ljpj1D25TR5IWvgEZUmozCy40bktxa1GNxoOQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LgEvRm6l7hODRETS9vKWL2VumlmoVkQq6LFOAsdg572/oDXnA2mkXO2g67Uhhs1tA
         F80573jAk3nb6aY5N/lWRlK24TdZgt2nx2qNRtPeHVwaPpwno8F8D4NpirAHQGqVPT
         dxoEY/V+xENz32WIIYl+90EZWMQuDNuG9QlHpTjw=
Date:   Fri, 3 Dec 2021 11:57:02 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Philipp Hortmann <philipp.g.hortmann@gmail.com>
Cc:     corbet@lwn.net, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH 3/4] Docs: usb: update comment and code of function
 skel_delete
Message-ID: <Yan3/slVnl+tKk1o@kroah.com>
References: <cover.1638152984.git.philipp.g.hortmann@gmail.com>
 <76757c4fc1f5001c3285a9a071055e8715985604.1638152984.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <76757c4fc1f5001c3285a9a071055e8715985604.1638152984.git.philipp.g.hortmann@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 29, 2021 at 09:21:52PM +0100, Philipp Hortmann wrote:
> Put skel_delete function in the document typical form
> Update code according to usb-skeleton.c
> 
> Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
> ---
>  .../driver-api/usb/writing_usb_driver.rst     | 19 +++++++++----------
>  1 file changed, 9 insertions(+), 10 deletions(-)
> 
> diff --git a/Documentation/driver-api/usb/writing_usb_driver.rst b/Documentation/driver-api/usb/writing_usb_driver.rst
> index b16e4e76d472..74bb72a2f0ac 100644
> --- a/Documentation/driver-api/usb/writing_usb_driver.rst
> +++ b/Documentation/driver-api/usb/writing_usb_driver.rst
> @@ -263,18 +263,17 @@ handle smoothly is the fact that the USB device may be removed from the
>  system at any point in time, even if a program is currently talking to
>  it. It needs to be able to shut down any current reads and writes and
>  notify the user-space programs that the device is no longer there. The
> -following code (function ``skel_delete``) is an example of how to do
> -this::
> +`skel_delete` function is an example of how to do this::

As pointed out elsewhere this should be:

	skel_delete() is an example of how to do this::

thanks,

greg k-h
