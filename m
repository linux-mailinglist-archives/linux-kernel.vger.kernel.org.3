Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E41649F3EC
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 08:01:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346608AbiA1HBk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 02:01:40 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:37326 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232306AbiA1HBi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 02:01:38 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CA1A261B1D;
        Fri, 28 Jan 2022 07:01:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E512BC340E0;
        Fri, 28 Jan 2022 07:01:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1643353297;
        bh=z2I2Um866BGasCtCvh1o4l4DwVYcayzXqVnPJxw8USM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=katFI5tB4zQhYjo3ZimrLAk7w+U4bGAqB+36RB5Kqwi4UqQP8mIftfIEKHQzAzx+M
         aVeM/+dnxyLA8AE/sf7rT+Rgonzf9oHcDZdgUOoxxOu3Y1qDJzzYAA/H7pW/0+Hq+o
         ahp7H8Wf7pLYBDfCIk4UTcleHQ7RUWxk2aXvBXZo=
Date:   Fri, 28 Jan 2022 08:01:33 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Zichar Zhang <zichar.zhang@linaro.org>
Cc:     john.stultz@linaro.org, krossmo@google.com, lee.jones@linaro.org,
        len.brown@intel.com, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, nayakvij@google.com, pavel@ucw.cz,
        rafael@kernel.org, sumit.semwal@linaro.org, amit.pundir@linaro.org,
        kernel-team@android.com
Subject: Re: [PATCH 1/1] [RFC] wakeup_reason: Add infrastructure to log and
 report why the system resumed from suspend.
Message-ID: <YfOUzZ4scTZAWnxl@kroah.com>
References: <CAE9iGoiCZZBkyX9ZWnhSDMjWmucOmybCOp=XTr6Hz5rN9GNyrw@mail.gmail.com>
 <20220128045522.3505336-1-zichar.zhang@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220128045522.3505336-1-zichar.zhang@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 28, 2022 at 12:55:22PM +0800, Zichar Zhang wrote:
> 
> Signed-off-by: Zichar Zhang <zichar.zhang@linaro.org>
> Change-Id: Id70f3cbec15f24ea999d7f643e9589be9c047f2b

Please always run checkpatch.pl on your submissions so that you do not
get people asking you to run checkpatch.pl on your submissions.

thanks,

greg k-h
