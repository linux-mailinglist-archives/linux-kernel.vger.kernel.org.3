Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9CFB4D1F79
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 18:53:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349314AbiCHRyU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 12:54:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349307AbiCHRyR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 12:54:17 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 227F827B20;
        Tue,  8 Mar 2022 09:53:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7913761484;
        Tue,  8 Mar 2022 17:53:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D49F7C340F4;
        Tue,  8 Mar 2022 17:53:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646761998;
        bh=qQ1IfZm1nAcpdIyRWU7BdrNKZacU5ouB40x5DtnLP6A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kJLIktdPxyfYCo6l/52ECC3cCKSIaBxIE+ehICq1BJir3dtPxXcYOhgmKMMaewZcp
         hK2n/GMaXK7GTImfE51ZzVnodt+C3ZE2veRFpkxxXkwKOqLqLMwDDlePqj731uktGH
         IQHFSOJhnboo1OcHg2h3DfL771HtqjCKQ7kHT1R3YjtU5mmVCaB8eOJ/uopKMcdVK8
         4fKLGUjw6yneE9fHnW3N72CkS2OyT5Veqvxvc6WIvmUW1r9tSFjQdouKLQIk19r/DC
         +vwMsyTTT6yb+Qwopze6UPxyJGa9uryJJuT4tTCmF7ipRdjh6sRhotB3mEYxkdOcHq
         25/Nsks5RvVpA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1nRe1H-0000OC-TD; Tue, 08 Mar 2022 18:53:12 +0100
Date:   Tue, 8 Mar 2022 18:53:11 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Colin Ian King <colin.i.king@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH] USB: serial: usb_wwan: remove redundant assignment to
 variable i
Message-ID: <YieYB+D2aAGB7FHV@hovoldconsulting.com>
References: <20220307183100.150082-1-colin.i.king@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220307183100.150082-1-colin.i.king@gmail.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 07, 2022 at 06:31:00PM +0000, Colin Ian King wrote:
> Variable i is being assigned a value that is never read, it is being
> re-assigned two statements later in a for-loop. The assignment is
> redundant and can be removed.
> 
> Cleans up clang scan build warning:
> drivers/usb/serial/usb_wwan.c:151:2: warning: Value stored to 'i'
> is never read [deadcode.DeadStores]
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>

Applied, thanks.

Johan
