Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59BF647BC9A
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 10:10:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236158AbhLUJKb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 04:10:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236204AbhLUJJd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 04:09:33 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C62F1C061574
        for <linux-kernel@vger.kernel.org>; Tue, 21 Dec 2021 01:09:32 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 82EE4CE139B
        for <linux-kernel@vger.kernel.org>; Tue, 21 Dec 2021 09:09:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C8DAC36AE2;
        Tue, 21 Dec 2021 09:09:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1640077768;
        bh=JfjIuSy232VvWzO1GZc9HDFKkU3ZK16X9krZvn2foPo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=C+6GRHw/DWI0+YYMyOQLqa1MxOIreIlmCb90ARRo9HsCi1PIRcvaQ6crjvsqAjoBG
         UJJ3dPRnan9VfSFCuRKWvBg791e7IwDcKdEEEs1B7eVKWajTl8yg2HWIjaKsz4oQAQ
         IAxWbpo8BIOm7oEaEFSAfwixoX85EJ20WsKFaGP0=
Date:   Tue, 21 Dec 2021 10:09:12 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] Coresight changes for v5.17
Message-ID: <YcGZuOQrqqPrVgYR@kroah.com>
References: <20211220173820.244995-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211220173820.244995-1-mathieu.poirier@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 20, 2021 at 10:38:20AM -0700, Mathieu Poirier wrote:
> The following changes since commit fa55b7dcdc43c1aa1ba12bca9d2dd4318c2a0dbf:
> 
>   Linux 5.16-rc1 (2021-11-14 13:56:52 -0800)
> 
> are available in the Git repository at:
> 
>   git@gitolite.kernel.org:pub/scm/linux/kernel/git/coresight/linux.git tags/coresight-next-v5.17

Pulled and pushed out, thanks.

greg k-h
