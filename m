Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFCBD57FBC0
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 10:52:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234233AbiGYIw2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 04:52:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234213AbiGYIw0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 04:52:26 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A69B1140D0;
        Mon, 25 Jul 2022 01:52:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5A088B80E0C;
        Mon, 25 Jul 2022 08:52:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F18BAC341C7;
        Mon, 25 Jul 2022 08:52:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1658739143;
        bh=dk4dxGJLEJyeKq9FFm0ufVN4qajcM88UqvIcq9q1f+8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CqeCDrEiSmCNFcu7LfFKRW5AAcdr/sUXlG5b6/loMvdyK+zB3L4HQsDY9wUgKXI4C
         Pkgt9yM8MWpxEhNfMo8JE6JN58kEowdlShOv+YTBkEZBtSyklJKaeAQKbontq7JMNt
         XTtJvPUnttJDNsMdGa2M+tvKLfFFyRwUT06AAvdo=
Date:   Mon, 25 Jul 2022 10:52:17 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     Oliver Neukum <oneukum@suse.com>, Felipe Balbi <balbi@kernel.org>,
        Yan Xinyu <sdlyyxy@bupt.edu.cn>, linux-staging@lists.linux.dev,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/7] USB: cdc: add control and state defines
Message-ID: <Yt5ZwYAI/jy4XW2n@kroah.com>
References: <20220725075841.1187-1-johan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220725075841.1187-1-johan@kernel.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 25, 2022 at 09:58:34AM +0200, Johan Hovold wrote:
> Several drivers use the control-line and serial-state bitmap values from
> the CDC spec, but there were no matching defines in the global CDC
> (UAPI) header.
> 
> This series adds the missing defines and converts cdc-acm and f_acm to
> use them.
> 
> One staging driver also had an unused set of CDC defines which are
> removed.
> 
> The final patch by Yan Xinyu, which triggered this work, converts the
> usb_wwan driver to use CDC defines instead of hardcoded values in its
> line-control handling.
> 
> Greg, are you ok with me taking these through USB serial (where there
> are a few more drivers that could potentially use them) or do you want
> to take the lot through your tree directly?

Many thanks for this, I'll just take this now and you can send future
patches for usb-serial that can rely on these being present.

greg k-h
