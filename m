Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3688464F37
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 14:55:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349716AbhLAN6T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 08:58:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239004AbhLAN6P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 08:58:15 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3A62C061574
        for <linux-kernel@vger.kernel.org>; Wed,  1 Dec 2021 05:54:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id BC253CE1ECD
        for <linux-kernel@vger.kernel.org>; Wed,  1 Dec 2021 13:54:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E0FFC53FCC;
        Wed,  1 Dec 2021 13:54:46 +0000 (UTC)
Date:   Wed, 1 Dec 2021 14:54:42 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Todd Kjos <tkjos@google.com>
Cc:     gregkh@linuxfoundation.org, christian@brauner.io, arve@android.com,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        maco@google.com, joel@joelfernandes.org, kernel-team@android.com,
        avakj45@gmail.com, Martijn Coenen <maco@android.com>
Subject: Re: [PATCH v2 2/4] binder: avoid potential data leakage when copying
 txn
Message-ID: <20211201135442.d4r3va2q75rressv@wittgenstein>
References: <20211130185152.437403-1-tkjos@google.com>
 <20211130185152.437403-3-tkjos@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211130185152.437403-3-tkjos@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 30, 2021 at 10:51:50AM -0800, Todd Kjos wrote:
> Transactions are copied from the sender to the target
> first and objects like BINDER_TYPE_PTR and BINDER_TYPE_FDA
> are then fixed up. This means there is a short period where
> the sender's version of these objects are visible to the
> target prior to the fixups.
> 
> Instead of copying all of the data first, copy data only
> after any needed fixups have been applied.
> 
> Fixes: 457b9a6f09f0 ("Staging: android: add binder driver")
> Reviewed-by: Martijn Coenen <maco@android.com>
> Signed-off-by: Todd Kjos <tkjos@google.com>
> ---

Looks good.
Acked-by: Christian Brauner <christian.brauner@ubuntu.com>
