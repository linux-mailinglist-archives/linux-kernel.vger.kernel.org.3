Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90B48473DF9
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 09:07:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231730AbhLNIHd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 03:07:33 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:32914 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231713AbhLNIHc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 03:07:32 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3366C6134F
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 08:07:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C605DC34601;
        Tue, 14 Dec 2021 08:07:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639469251;
        bh=XXkC7Q2463t2WWEDTlpY2qHzCT5oxbEAcAHkYIsIJCw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SKCDg9xsvVwwaMjNV5RKcE8ymsUACZDQ4m3L7WPyRz9Cf6I1lun3XOLpHAvxRDS/Q
         MnBAlht15jndsb79Rge+SxKMABsgQ9MH/fKFHZ/5BtxLCxtqyqdzLNO5KiflWl8qL2
         5EeLc7nslTY+vS8Y7YIHLHOZ4/1sX7gEsU4G4GfDOK5+HxJHErhqGCp7raXW3n0Geg
         dXT2i5YU/64GIVB+a++uzM3R6CK8EgXQua0qI4ZRRzuwo5ormibU4ZWzd8tR7dsTPk
         QLw3IwratBSgQ/dkzVSTyS8fpqs58UxVkJlblCipMokN5ZTEWaqij2/pXkcd8Xy1W1
         zkK1oJHkNuW2A==
Date:   Tue, 14 Dec 2021 16:07:26 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Li Yang <leoyang.li@nxp.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Ashish Kumar <Ashish.Kumar@nxp.com>
Subject: Re: [PATCH 1/2] arm64: dts: ls1088a: Add reboot nodes
Message-ID: <20211214080725.GA14056@dragon>
References: <20211204011537.8963-1-leoyang.li@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211204011537.8963-1-leoyang.li@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 03, 2021 at 07:15:36PM -0600, Li Yang wrote:
> ls1088a has a separate reset register block.  Define it in dts and use
> it for reboot.
> 
> Signed-off-by: Ashish Kumar <Ashish.Kumar@nxp.com>
> Signed-off-by: Li Yang <leoyang.li@nxp.com>

Applied both, thanks!
