Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BA8357508C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 16:15:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238584AbiGNOPY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 10:15:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239276AbiGNOPP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 10:15:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E43145E31E;
        Thu, 14 Jul 2022 07:15:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 80761616D1;
        Thu, 14 Jul 2022 14:15:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5935BC34114;
        Thu, 14 Jul 2022 14:15:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1657808112;
        bh=ufp535Bz6aEEtkB+7zy8idwzIK4dKpRNCbUtNVDlnvM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=a4bKW1U7dflUBjmnBNrnhh6KZz0OvWufqHW/NBezlQc2bQgMz3enuGtr97hlif6ad
         mMldqC0PuJyMbm91jEKBYbGgQVFMbM4ppIe7vvTfBX6J8kj9h4c12zE7d//x0W1tZx
         vQ/9OZuSzXSFuaRC9NTYMvuluTaXyAWPo8iKnH3c=
Date:   Thu, 14 Jul 2022 16:13:13 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Prashant Malani <pmalani@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        chrome-platform@lists.linux.dev, bleung@chromium.org,
        heikki.krogerus@linux.intel.com,
        Daisuke Nojiri <dnojiri@chromium.org>,
        "Dustin L. Howett" <dustin@howett.net>,
        Guenter Roeck <groeck@chromium.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: Re: [PATCH v4 0/9] Type-C switch driver and Type-C framework updates
Message-ID: <YtAkeQ1Do7CuM/PR@kroah.com>
References: <20220711072333.2064341-1-pmalani@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220711072333.2064341-1-pmalani@chromium.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 11, 2022 at 07:22:54AM +0000, Prashant Malani wrote:
> This series introduces a retimer class to the USB Type-C framework,
> It also introduces a Chrome EC (Embedded Controller) switch driver which
> registers the aforementioned retimer switches as well as mode-switches.
> 
> Patch 1 and 2 introduce the retimer class and associated functions to
> the Type-C common code.
> 
> Patches 3-7 add the cros-typec-switch driver.
> 
> Patches 8-9 update cros-ec-typec to get and use retimer switch handles.
> 
> Submission suggestion (as always, open to better suggestions):
> - Patch 1 and 2 can go through the USB repo.
> - Patch 3-9 can go through the chrome-platform repo. Since they depend
>   on patches 1 and 2, we can create an "topic branch" off of usb-next
>   once Patch 1 and 2 are submitted, and then apply Patches 3-9 on top
>   of that "topic branch" before merging it back into chrome-platform's
>   for-next branch

That's a mess, I can just take all of them into my tree if you want.

thanks,

greg k-h
