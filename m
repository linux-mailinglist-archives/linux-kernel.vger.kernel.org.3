Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67C8E4865DF
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 15:14:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240001AbiAFOOm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 09:14:42 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:43810 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239752AbiAFOOi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 09:14:38 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E52ECB82192
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jan 2022 14:14:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 366EBC36AE0;
        Thu,  6 Jan 2022 14:14:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1641478476;
        bh=slmfr7V9LUKvIHn0GZI1NJ4IhCLh4V1HhpAF4FS8DR0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vZHpgAydIbN26uTloIMdOlFTa1huYlZu6ehyfM6eQrSl10qbeCtHktJawpllz6xt3
         uM1dGPZ3LxijZjPLKiWi3CfEVciJ1Jhasme2QReCliHNO5EcAa+SThBPSum85n9Nfu
         7jHxSkTY/EmnHJMrNz5EqIQSwva1thwiuDV6gllg=
Date:   Thu, 6 Jan 2022 15:14:34 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Alberto Merciai <alb3rt0.m3rciai@gmail.com>
Cc:     linuxfancy@googlegroups.com,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        Martin Kaiser <martin@kaiser.cx>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Saurav Girepunje <saurav.girepunje@gmail.com>,
        Ivan Safonov <insafonov@gmail.com>,
        Yang Li <yang.lee@linux.alibaba.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Zameer Manji <zmanji@gmail.com>, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/56] staging: r8188eu: remove dead macro ClearToDs
Message-ID: <Ydb5SrclLcYzUrsC@kroah.com>
References: <20220103190326.363960-1-alb3rt0.m3rciai@gmail.com>
 <20220103190326.363960-4-alb3rt0.m3rciai@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220103190326.363960-4-alb3rt0.m3rciai@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 03, 2022 at 08:01:38PM +0100, Alberto Merciai wrote:
> Remove dead macro ClearToDs.

"dead"?  Was it ever alive?

I think you mean to write something like:

	The #define ClearToDs() is not used anywhere in the r8188eu
	driver, so it can be safely removed.

right?

thanks,

greg k-h
