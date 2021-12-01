Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 282B8464F4C
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 14:59:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243146AbhLAOCX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 09:02:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238986AbhLAOCV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 09:02:21 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93D44C061574
        for <linux-kernel@vger.kernel.org>; Wed,  1 Dec 2021 05:59:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 590E2B81F54
        for <linux-kernel@vger.kernel.org>; Wed,  1 Dec 2021 13:58:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B04DC53FAD;
        Wed,  1 Dec 2021 13:58:54 +0000 (UTC)
Date:   Wed, 1 Dec 2021 14:58:51 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Todd Kjos <tkjos@google.com>
Cc:     gregkh@linuxfoundation.org, christian@brauner.io, arve@android.com,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        maco@google.com, joel@joelfernandes.org, kernel-team@android.com,
        avakj45@gmail.com, Martijn Coenen <maco@android.com>
Subject: Re: [PATCH v2 3/4] binder: read pre-translated fds from sender buffer
Message-ID: <20211201135851.tv3li4xi5s4hzeeg@wittgenstein>
References: <20211130185152.437403-1-tkjos@google.com>
 <20211130185152.437403-4-tkjos@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211130185152.437403-4-tkjos@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 30, 2021 at 10:51:51AM -0800, Todd Kjos wrote:
> This patch is to prepare for an up coming patch where we read
> pre-translated fds from the sender buffer and translate them before
> copying them to the target.  It does not change run time.
> 
> The patch adds two new parameters to binder_translate_fd_array() to
> hold the sender buffer and sender buffer parent.  These parameters let
> us call copy_from_user() directly from the sender instead of using
> binder_alloc_copy_from_buffer() to copy from the target.  Also the patch
> adds some new alignment checks.  Previously the alignment checks would
> have been done in a different place, but this lets us print more
> useful error messages.
> 
> Reviewed-by: Martijn Coenen <maco@android.com>
> Signed-off-by: Todd Kjos <tkjos@google.com>
> ---

Looks good.
Acked-by: Christian Brauner <christian.brauner@ubuntu.com>
