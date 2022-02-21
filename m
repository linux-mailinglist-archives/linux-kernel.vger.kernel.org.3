Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CDB74BDF99
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 18:50:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241422AbiBURKF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 12:10:05 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233472AbiBURKC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 12:10:02 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BA0E25EB1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 09:09:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 166A661389
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 17:09:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E65B5C340E9;
        Mon, 21 Feb 2022 17:09:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1645463378;
        bh=TM2fauSe66x2c2zoxsu+MQhxX1uzwMbubNNzf+2HVgk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iXoIawLtNFRUBewCOxAho4n/lt1xdttpqD60+a8jPLH+iOTb3dsO14nQMtlKp6EmI
         LYppBsg2Q/s8ZXo0uU2zNtjLMdoy3L7tECUvB7kE1CJ9owq4nIjFGk39NBYhdutpj3
         jfFtQrl8OxnHUFc0ar0MpsvCHgSikQtTDqsJAEoc=
Date:   Mon, 21 Feb 2022 18:09:35 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Moses Christopher Bollavarapu <mosescb.dev@gmail.com>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: rtl8192e: use BIT macro instead of left shifting
Message-ID: <YhPHT/9KWnUwVO1Y@kroah.com>
References: <20220218163212.7103e9e6@cpi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220218163212.7103e9e6@cpi>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 18, 2022 at 04:32:12PM +0100, Moses Christopher Bollavarapu wrote:
> From eaca0dd8fcbe3ff6daf14ea7a532e53acf840790 Mon Sep 17 00:00:00 2001
> From: Moses Christopher Bollavarapu <mosescb.dev@gmail.com>
> Date: Fri, 18 Feb 2022 16:08:16 +0100
> Subject: [PATCH] drivers: staging: rtl8192e: use BIT macro instead of left shifting

These headers should not be part of the body of the email.

Please use tools like 'git send-email' to send a patch out, it will do
this correctly and not have this extra information in it.

thanks,

greg k-h
