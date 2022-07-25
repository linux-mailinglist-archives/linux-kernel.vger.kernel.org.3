Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C055957FBD0
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 10:55:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234337AbiGYIzF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 04:55:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234331AbiGYIy2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 04:54:28 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7769D14D18;
        Mon, 25 Jul 2022 01:54:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id E6E7BCE109A;
        Mon, 25 Jul 2022 08:54:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33D44C341CF;
        Mon, 25 Jul 2022 08:54:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658739264;
        bh=vmglcOJClf0/A72Hg+512O5HtnFUTgtTxRtt2NfR754=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pg9VAtsqzV+rIf3YeK4RNTiHnuKIahOCyuBxsvpPj8UNLwaY2mlxWcT+LfBt8ZJLd
         LqJI0jUPzZQrxT9o17WHlYFVYQHUMv8n+BVzvS5KnIwzE4LXxj7mgfUD5o6EZmfkuW
         JscuQKRWYnWnJzDYgZKw+1fegkI8u3PsllWlWtywLZ7iY60m+NhMiZDv8CFz+poi3q
         5vqfGolRURUYORA15di6VJLzJkMVb/fGLG6iNWJ7CFJtabrdba7e0qvobqzQcBEKyj
         mJp69JcBhYRxcjFRw4zduRAr3riu2028AWaesBePcDDEO0dKnfVGJvjd9qRjEC5ZG7
         E6yXetrKkkIcg==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1oFtrH-0000vr-D9; Mon, 25 Jul 2022 10:54:35 +0200
Date:   Mon, 25 Jul 2022 10:54:35 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Oliver Neukum <oneukum@suse.com>, Felipe Balbi <balbi@kernel.org>,
        Yan Xinyu <sdlyyxy@bupt.edu.cn>, linux-staging@lists.linux.dev,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/7] USB: cdc: add control and state defines
Message-ID: <Yt5aSzd9/5HCj2xv@hovoldconsulting.com>
References: <20220725075841.1187-1-johan@kernel.org>
 <Yt5ZwYAI/jy4XW2n@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yt5ZwYAI/jy4XW2n@kroah.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 25, 2022 at 10:52:17AM +0200, Greg Kroah-Hartman wrote:
> On Mon, Jul 25, 2022 at 09:58:34AM +0200, Johan Hovold wrote:
> > Several drivers use the control-line and serial-state bitmap values from
> > the CDC spec, but there were no matching defines in the global CDC
> > (UAPI) header.
> > 
> > This series adds the missing defines and converts cdc-acm and f_acm to
> > use them.
> > 
> > One staging driver also had an unused set of CDC defines which are
> > removed.
> > 
> > The final patch by Yan Xinyu, which triggered this work, converts the
> > usb_wwan driver to use CDC defines instead of hardcoded values in its
> > line-control handling.
> > 
> > Greg, are you ok with me taking these through USB serial (where there
> > are a few more drivers that could potentially use them) or do you want
> > to take the lot through your tree directly?
> 
> Many thanks for this, I'll just take this now and you can send future
> patches for usb-serial that can rely on these being present.

Sounds good. That probably won't happen before the merge window anyway.

Thanks.

Johan
