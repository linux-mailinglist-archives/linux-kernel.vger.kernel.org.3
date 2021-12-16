Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 086C44772F8
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 14:17:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237443AbhLPNRR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 08:17:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232210AbhLPNRQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 08:17:16 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BCD2C061574
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 05:17:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BFCBC61DE1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 13:17:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D115EC36AE0;
        Thu, 16 Dec 2021 13:17:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1639660635;
        bh=XbBRQDo3AW/RlwAsMdjxCkJfR9JW1oi5CoKZzO0S6yQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WOq1Y6kiIMdfkT4ZD/VCz+ampS41gbsPMlKTiMGrc5z6tFwUbdbMmOBxm/5z/jfyH
         g/x0jdAjp1a/xpMEQaJpOJ7+p1yJSgV9VmxoOpyqB+8wp4oOhFBKCssk16zoQmFez4
         Yxq3JVzuUXd4LHJKijogXEeitY9CAXb6aF8QGoyI=
Date:   Thu, 16 Dec 2021 14:17:12 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Qi Zheng <zhengqi.arch@bytedance.com>
Cc:     akpm@linux-foundation.org, rafael@kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, songmuchun@bytedance.com
Subject: Re: [PATCH 2/2] mm: reimplement si_mem_available()
Message-ID: <Ybs8WBHt+5TklFe8@kroah.com>
References: <20211216124655.32247-1-zhengqi.arch@bytedance.com>
 <20211216124655.32247-3-zhengqi.arch@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211216124655.32247-3-zhengqi.arch@bytedance.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 16, 2021 at 08:46:55PM +0800, Qi Zheng wrote:
> Reimplement si_mem_available() by reusing si_mem_available_node().

That says what you did, but not why.  Why are you doing this?

And what does it have to do with patch 1/2?

thanks,

greg k-h
