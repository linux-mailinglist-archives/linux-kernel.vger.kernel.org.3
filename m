Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A253857647A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 17:34:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233201AbiGOPeQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 11:34:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234964AbiGOPeL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 11:34:11 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91B3713FAC
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 08:34:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 41073B82B41
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 15:34:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BFC1C34115;
        Fri, 15 Jul 2022 15:34:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1657899247;
        bh=QMpWhoIUIhK1Z/dyH+YtAiVzRiSOaseb1eljycKY0O4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AR+uQZZQtz4El9w+VaHoLcxoMCnexYnBgZtCz/DC7Tb1G6USx/JmUK72pmdoXnpOL
         WOAAlLWagNMTYxZ3Y36Hb4WqAy0qaVLZy97SVtRUVQfbqvhzga8MYJxJyEnC/j7++T
         f6NGATmoqBzCCzUnhqIOx7rMzJTlc6mgDUL2/ftc=
Date:   Fri, 15 Jul 2022 17:34:05 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Dinh Nguyen <dinguyen@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] firmware: stratix10-svc: fix kernel-doc warning
Message-ID: <YtGI7SptQvrIoILO@kroah.com>
References: <20220715150349.2413994-1-dinguyen@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220715150349.2413994-1-dinguyen@kernel.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 15, 2022 at 10:03:49AM -0500, Dinh Nguyen wrote:
> include/linux/firmware/intel/stratix10-svc-client.h:55: warning: This comment
> starts with '/**', but isn't a kernel-doc comment. Refer
> Documentation/doc-guide/kernel-doc.rst
>  * Flag bit for COMMAND_RECONFIG
> 
> Fixes: 4a4709d470e6 ("firmware: stratix10-svc: add new FCS commands")
> Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
> ---
>  include/linux/firmware/intel/stratix10-svc-client.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

You forgot the reported-by link :(

I'll go add it...
