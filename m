Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8D1B58206E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 08:50:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229647AbiG0Gu2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 02:50:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229998AbiG0Gtu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 02:49:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 747E4C58
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 23:47:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 073A76148F
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 06:47:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 017A0C433C1;
        Wed, 27 Jul 2022 06:47:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1658904466;
        bh=JfWQUy6Pmm4vrfUtuYPgkbRGh2vrMnsBsWln3MJW0M8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=j2+W2kGCqKIoeTAj+fkWzxsKkdDzmbvxBT5nFiYpbvFsObGm1L4M+FNEbEFsnHAjU
         +JmwSy5fiSwO1yEIAdMq00XxN7QCSpsc28RDHv7CiNpJpxPxoHZhoBlEzS7yZx2slp
         WuUgLrmGGJ2rXhVaz+IZk5m0gssxFP5yJTMGfncM=
Date:   Wed, 27 Jul 2022 08:47:43 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Philipp Hortmann <philipp.g.hortmann@gmail.com>
Cc:     Forest Bond <forest@alittletooquiet.net>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] staging: vt6655: Rename byOrgValue to reg_value in a
 macro
Message-ID: <YuDfjwHJN6n/CZ4i@kroah.com>
References: <cover.1658333350.git.philipp.g.hortmann@gmail.com>
 <83920d919acd7596488943182f37132e479d70f4.1658333350.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <83920d919acd7596488943182f37132e479d70f4.1658333350.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 20, 2022 at 06:24:32PM +0200, Philipp Hortmann wrote:
> Fix name of a variable in a macro that uses CamelCase which is not
> accepted by checkpatch.pl

Why rename something you are about to delete in a later patch?

thanks,

greg k-h
