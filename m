Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B87D47BBE6
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 09:32:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235648AbhLUIcY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 03:32:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232572AbhLUIcX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 03:32:23 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29CA4C061574
        for <linux-kernel@vger.kernel.org>; Tue, 21 Dec 2021 00:32:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DA46AB810F3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Dec 2021 08:32:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E9F2C36AE7;
        Tue, 21 Dec 2021 08:32:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1640075540;
        bh=4edINQsVy17GeOpi3NyT/uMozs1TlHcPmj1KuA/6kxA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sygztg1ycApMwHn01RW3qSNJ7YyacXNLxFyKs3QxfxmtIqWqXjd/HhSCQTXkjQl0W
         v9SqCG3no29VTsMQCEaBijhlgao3x/vQv3r3LHHzbbebDcJZDm2TxU0zBM3+31PzIy
         hlGrcr+AcVv6UBmdaLk4d0G/H0UAd+BZXKmV3hsU=
Date:   Tue, 21 Dec 2021 09:32:18 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     davidcomponentone@gmail.com
Cc:     zbr@ioremap.net, yangyingliang@huawei.com,
        ivan.zaentsev@wirenboard.ru, yang.guang5@zte.com.cn,
        dan.carpenter@oracle.com, unixbhaskar@gmail.com,
        linux-kernel@vger.kernel.org, Zeal Robot <zealci@zte.com.cn>
Subject: Re: [PATCH v3] w1: w1_therm: use swap() to make code cleaner
Message-ID: <YcGREnlqJXORmN8b@kroah.com>
References: <2becaf314c17f5bff4c6af4a8bd05039dde68497.1639988198.git.yang.guang5@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2becaf314c17f5bff4c6af4a8bd05039dde68497.1639988198.git.yang.guang5@zte.com.cn>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 21, 2021 at 08:15:28AM +0800, davidcomponentone@gmail.com wrote:
> From: Yang Guang <yang.guang5@zte.com.cn>
> 
> Use the macro 'swap()' defined in 'include/linux/minmax.h' to avoid
> opencoding it.
> 
> ---
> Changes from v1->v2:
> - Delete the curly {} braces.
> 
> Changes from v2->v3::
> - Add --- line before version info.
> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: David Yang <davidcomponentone@gmail.com>
> Signed-off-by: Yang Guang <yang.guang5@zte.com.cn>

Why the signed-off-by below the --- line?  That means it will be cut off
and not present in the patch at all :(

