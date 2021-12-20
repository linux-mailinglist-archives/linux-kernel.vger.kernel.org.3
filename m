Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A16B247B056
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 16:31:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239880AbhLTPbh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 10:31:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239377AbhLTPbR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 10:31:17 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21CA5C06175F;
        Mon, 20 Dec 2021 07:29:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B3272611E7;
        Mon, 20 Dec 2021 15:29:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AE22C36AE7;
        Mon, 20 Dec 2021 15:29:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1640014189;
        bh=JSMsteKLUvTazhPFo/ZPr9o+AZtXZDArQosyGGdJtyo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HpocV6rEHoBhz35iaW9HS17zGJF5AAmGipdnkcRismpeIPDHYdY5TjRK+ozUceMiN
         b9Y+gF1zX9HRjHxI0qZ7/m871hpFB/pdynzts0G5Pov9X7YA/356OzRUuPHt4J/ZXn
         bdBVJxFvPOMaEGk3GZ+9T0pivq17YnNYlKYdGatU=
Date:   Mon, 20 Dec 2021 16:29:46 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jiasheng Jiang <jiasheng@iscas.ac.cn>
Cc:     ok@artecdesign.ee, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] USB: host: Check for null res pointer
Message-ID: <YcChajETF+S4lluY@kroah.com>
References: <20211220151524.1001845-1-jiasheng@iscas.ac.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211220151524.1001845-1-jiasheng@iscas.ac.cn>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 20, 2021 at 11:15:24PM +0800, Jiasheng Jiang wrote:
> The return value of platform_get_resource() needs to be checked.
> To avoid use of error pointer in case of the failure of alloc.

Should be all one sentence, right?

> 
> Fixes: 4808a1c02611 ("[PATCH] USB: Add isp116x-hcd USB host controller driver")
> Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>

What driver is this?  That needs to be in the subject line at the very
least.

