Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65C9248666F
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 16:01:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240332AbiAFPBZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 10:01:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240274AbiAFPBY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 10:01:24 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 164D8C061245;
        Thu,  6 Jan 2022 07:01:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B38BF61AA5;
        Thu,  6 Jan 2022 15:01:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A686C36AE0;
        Thu,  6 Jan 2022 15:01:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1641481283;
        bh=xgIrLzK988oAekXQpBh/T0gHpcqm8TEJusYJeFnj26w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=A92iI0iB5/KOq7rV9+kXOx8cHZhLPscsNXwRf43MFDbAReQak6JorjorOWngwAMia
         ZKw480S40WIqtIW7X4GKXY9QYQxSxwHES4QJsYCFXKKf/v7Q1fCMKRpVV/KLtPuddl
         S8f78WOudtAycf4N/n8Ruaq5lIYzI9k3CQsb/FG4=
Date:   Thu, 6 Jan 2022 16:01:20 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jiasheng Jiang <jiasheng@iscas.ac.cn>
Cc:     jirislaby@kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tty/serial: Check for null pointer after calling
 devm_ioremap
Message-ID: <YdcEQPS30BHTPQJo@kroah.com>
References: <20220106090631.2714586-1-jiasheng@iscas.ac.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220106090631.2714586-1-jiasheng@iscas.ac.cn>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 06, 2022 at 05:06:31PM +0800, Jiasheng Jiang wrote:
> As the possible failure of the allocation, the devm_ioremap() may return
> NULL pointer.

I do not understand this sentence.

> And the 'port->membase' will be directly used in mlb_usio_startup().

This does not make sense either.


> Therefore, in order to avoid the dereference of the NULL pointer, it
> should be better to add the sanity check.

What do you mean by "sanity check"?

confused,

greg k-h
