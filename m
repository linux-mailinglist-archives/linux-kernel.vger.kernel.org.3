Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC3324A5AB7
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 11:56:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236999AbiBAK4K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 05:56:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237001AbiBAK4I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 05:56:08 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4945C061714;
        Tue,  1 Feb 2022 02:56:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EDCA1614DE;
        Tue,  1 Feb 2022 10:55:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E231C340EB;
        Tue,  1 Feb 2022 10:55:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643712925;
        bh=+nXX+G97ZyuVMBtoWY1dd7htS4xhjedPyMjW5j4g8sA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eFjvA2t6zrhb+6PW0HZyJMdL+obry1TnzDiuBOqf2vCIH5uNLwns8JMVTyLj5B4qI
         c6tXawLaNKCj9WP7GZqMqzdZlPzsQRmGZMwj+Fy5cTZUz7t3BFh4HHvIDhT89CaGu9
         W66nj9ptpA8hXAgfPakw32/AUDEGPWhR+k0oQv+ChqZQWydCLmVvBUg9FyAjsQvhVi
         LxPCMKFBb51zLgRdHo7VzRmGU3CxeeV2TpIUi+AfCq1ZApoevq96fqxrlaWQrntmiW
         sPuFhpdm9TL4Mln97fL1zjhZAUEsEj5mmsi9Lk7Mx90APXefVUA88TxxB+wh9p+z6b
         eTHozjTd+czWA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1nEqoX-0003nt-Kd; Tue, 01 Feb 2022 11:55:09 +0100
Date:   Tue, 1 Feb 2022 11:55:09 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Cameron Williams <cang1@live.co.uk>
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb-serial: Add support for Brainboxes US-159/235/320
Message-ID: <YfkRjaLh3T4RIyrm@hovoldconsulting.com>
References: <AM5PR0202MB25641C06DA64C54B29F1B8B6C4269@AM5PR0202MB2564.eurprd02.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AM5PR0202MB25641C06DA64C54B29F1B8B6C4269@AM5PR0202MB2564.eurprd02.prod.outlook.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 01, 2022 at 10:12:51AM +0000, Cameron Williams wrote:
> This patch adds support for the Brainboxes US-159, US-235
> and US-320 USB-to-Serial devices.
> 
> Signed-off-by: Cameron Williams <cang1@live.co.uk>

Applied, thanks.

Johan
