Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3961588076
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 18:48:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234335AbiHBQsq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 12:48:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237699AbiHBQsl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 12:48:41 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 087EDFD0B;
        Tue,  2 Aug 2022 09:48:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C19E0B819F1;
        Tue,  2 Aug 2022 16:48:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3713CC433D7;
        Tue,  2 Aug 2022 16:48:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1659458918;
        bh=M2FZ/DCeu0OKMAWrwlbjHZ6f1ykBiTc/SoCb3EvrMj0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XWwWP2Soi9m2xCDGG/nEfNtRFSKO7aSCqw68ILMYREZYiyY2lIZD8FhevgfmIZPzN
         4FffiHYCfdTJ6loS68B/2NPZE+Ed4bXVk8pkfx2HY18LO/LWVa2xlYRjOwEju3MNID
         1sdGY3MCtd/3QCgMowPE+quMuk73gyUXFTm5p0Ow=
Date:   Tue, 2 Aug 2022 18:48:35 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-input@vger.kernel.org
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        "jingle.wu" <jingle.wu@emc.com.tw>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Input: elan_i2c - convert to use dev_groups
Message-ID: <YulVY/QRFe/ey3tZ@kroah.com>
References: <20220729135816.2306989-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220729135816.2306989-1-gregkh@linuxfoundation.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 29, 2022 at 03:58:16PM +0200, Greg Kroah-Hartman wrote:
> The driver core supports the ability to handle the creation and removal
> of device-specific sysfs files in a race-free manner.  Take advantage of
> that by converting this driver to use this by moving the sysfs
> attributes into a group and assigning the dev_groups pointer to it.
> 
> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Cc: Hans de Goede <hdegoede@redhat.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: "jingle.wu" <jingle.wu@emc.com.tw>
> Cc: linux-input@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  drivers/input/mouse/elan_i2c_core.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)

v2 is now here:
	https://lore.kernel.org/r/20220802162854.3015369-1-gregkh@linuxfoundation.org
