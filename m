Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77D9F47A5B9
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 09:08:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234758AbhLTIIv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 03:08:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232507AbhLTIIu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 03:08:50 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE8E9C061574
        for <linux-kernel@vger.kernel.org>; Mon, 20 Dec 2021 00:08:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5A2E560C71
        for <linux-kernel@vger.kernel.org>; Mon, 20 Dec 2021 08:08:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A10E6C36AE5;
        Mon, 20 Dec 2021 08:08:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1639987729;
        bh=xyES2AsCi5ZXqtzV0LOap0JJQiRBH5oEVjZlOGo0rgs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=V1yGrCi3gpakIo3bc1SZOga/nXKUeZBFgie+j+6E2jxON6Tvh6bWy8cTLowAQMfqC
         IvT+uo+orG9CaCS+/4piNEIdxYYHhKTFfptFzEaFuQgj7XsLtLyqoAzsfjCPkLjgUv
         Mt0URjOAICIW5zUCNJvzMkouhK5Pt/VzDyb6nUgk=
Date:   Mon, 20 Dec 2021 09:08:46 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     davidcomponentone@gmail.com
Cc:     zbr@ioremap.net, yangyingliang@huawei.com, yang.guang5@zte.com.cn,
        dan.carpenter@oracle.com, unixbhaskar@gmail.com,
        ivan.zaentsev@wirenboard.ru, linux-kernel@vger.kernel.org,
        Zeal Robot <zealci@zte.com.cn>
Subject: Re: [PATCH v2] w1: w1_therm: use swap() to make code cleaner
Message-ID: <YcA6DsF0uyF5zt8u@kroah.com>
References: <cca30ad2a63eb710736b0b968d489c509716ecbc.1639961946.git.yang.guang5@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cca30ad2a63eb710736b0b968d489c509716ecbc.1639961946.git.yang.guang5@zte.com.cn>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 20, 2021 at 03:48:36PM +0800, davidcomponentone@gmail.com wrote:
> From: Yang Guang <yang.guang5@zte.com.cn>
> 
> Use the macro 'swap()' defined in 'include/linux/minmax.h' to avoid
> opencoding it.
> 
> Changes from v1->v2:
> - Delete the curly {} braces.

version info goes below the --- line.  Please fix up and resend a v3.

thanks,

greg k-h
