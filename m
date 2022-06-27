Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5101655CB42
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 14:59:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236779AbiF0OK2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 10:10:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236765AbiF0OK0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 10:10:26 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5BBE13DDF
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 07:10:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 77A90B80D32
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 14:10:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E511FC3411D;
        Mon, 27 Jun 2022 14:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1656339023;
        bh=qMUwohhlHARUhNHLE9bGM9ZIS6WIDOrJL7LQvqtJRnw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KzALHXDlOIZttvb9tnzrMDlHbQ81x/A4/AqqcJid6RdQc2Cm4kTVGI6w5IxQF6JyH
         qziJCIgjjlv8K8QT8KNJ8uiAxCKMZJwviXEMcxk//YMuVuRfjRxYq5ZQY1ay8z2ZV9
         b5rK+uiTDrE/o1AbRmxgG8d+ktlgiARyhqwB7uFU=
Date:   Mon, 27 Jun 2022 16:10:20 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Agam Kohli <agamkohli9@gmail.com>
Cc:     arve@android.com, tkjos@android.com, maco@android.com,
        joel@joelfernandes.org, brauner@kernel.org, hridya@google.com,
        surenb@google.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers: android: binder_alloc: Fixed include warning
Message-ID: <Yrm6TErI3atNbgCd@kroah.com>
References: <20220610175048.79446-1-agamkohli9@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220610175048.79446-1-agamkohli9@gmail.com>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 10, 2022 at 01:50:48PM -0400, Agam Kohli wrote:
> Changed include from asm/ to linux/

This says what you did, but not why you did it.

Please document why.

thanks,

greg k-h
