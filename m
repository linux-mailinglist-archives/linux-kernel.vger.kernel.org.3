Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 301E95A0CCB
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 11:38:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240569AbiHYJhk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 05:37:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237516AbiHYJhi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 05:37:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80145AB06E;
        Thu, 25 Aug 2022 02:37:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1D44161BF8;
        Thu, 25 Aug 2022 09:37:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 711F3C433D7;
        Thu, 25 Aug 2022 09:37:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661420256;
        bh=z5lVsyk0Rl4uKHLgVLm/LJCkioXTtmzNMnheTuDTvjo=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=Ifng65ImYGwz3uyQzDt7551ua7MtN7sa7YXLe/1IuIevUioOjfacU3+tSQLdxE1/4
         eNx+ER6oryfWL+S6+Wou48LkJOYlyc864MiAmhdSZv16t7Iy/QEkCF+Fd9sn5bOADQ
         nSaV/BuJYC1Yd+idnPk3PXn//3zieh3PbcMmMttV9x54d+LVfD0V6kKm+SxvOHkb32
         v2EuNaQHDmbLKVCVZsprKGg4LTn5ut3XF5itOX1OGDBiKmNvDyBTE2Bo63+9nJesyU
         GLqswZAHMsM8EhVJMAgt23sTq9M8Qfye098g+SiotRQtQyNVp6ZKroMNSryxb5v28O
         B6biBb4hCpN5g==
Date:   Thu, 25 Aug 2022 11:37:33 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
cc:     benjamin.tissoires@redhat.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] HID: vivaldi: convert to use dev_groups
In-Reply-To: <20220804113116.1117378-1-gregkh@linuxfoundation.org>
Message-ID: <nycvar.YFH.7.76.2208251137220.19850@cbobk.fhfr.pm>
References: <20220804113116.1117378-1-gregkh@linuxfoundation.org>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Aug 2022, Greg Kroah-Hartman wrote:

> There is no need for a driver to individually add/create device groups,
> the driver core will do it automatically for you.  Convert the
> hid-vivaldi core driver to use the dev_groups pointer instead of
> manually calling the driver core to create the group and have it be
> cleaned up later on by the devm core.
> 
> Cc: Jiri Kosina <jikos@kernel.org>
> Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> Cc: linux-input@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Applied, thanks Greg.

-- 
Jiri Kosina
SUSE Labs

