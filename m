Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6B584A58C0
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 09:46:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235692AbiBAIqa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 03:46:30 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:42090 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233828AbiBAIq3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 03:46:29 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4A88BB82D1A;
        Tue,  1 Feb 2022 08:46:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FB0CC340EB;
        Tue,  1 Feb 2022 08:46:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1643705187;
        bh=hxg+MjgE2o1g4a4Hzne5+pONeXvINcOOdgG/it93JIw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Kw0fv/M6mceaNwP3noARL9YXbTMXHSvQuJ7RMY3RIatNUr5L1y35I0pLMdd7PlMVk
         v/QEZpmJ3GdZ1F+0dBzvLzjd6Il/zYwS3hKLZt7A9/HY7dNCtaEEYrt7IRx+60ffOq
         xvMG8rcEvwuZT8zrF1OisO5CXcjEW0p1CFsHQBcI=
Date:   Tue, 1 Feb 2022 09:46:19 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "David E. Box" <david.e.box@linux.intel.com>
Cc:     hdegoede@redhat.com, andriy.shevchenko@linux.intel.com,
        srinivas.pandruvada@intel.com, mgross@linux.intel.com,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        Mark Gross <markgross@kernel.org>
Subject: Re: [PATCH 1/3] platform/x86: Add Intel Software Defined Silicon
 driver
Message-ID: <YfjzW+u18cT8w8CE@kroah.com>
References: <20220201030424.1068816-1-david.e.box@linux.intel.com>
 <20220201030424.1068816-2-david.e.box@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220201030424.1068816-2-david.e.box@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 31, 2022 at 07:04:22PM -0800, David E. Box wrote:
> + * Copyright (c) 2021, Intel Corporation.

You did not touch it this year?


