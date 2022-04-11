Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EAE74FBFA8
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 16:54:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347546AbiDKO5F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 10:57:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235477AbiDKO5E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 10:57:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E13E167CC;
        Mon, 11 Apr 2022 07:54:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2A2C3613E9;
        Mon, 11 Apr 2022 14:54:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5311C385A3;
        Mon, 11 Apr 2022 14:54:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649688889;
        bh=tpkAJmBOh6qp9PJoQAh6f7ob4kqRBST1+2LzVs/dOrQ=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=HU2tSJgt3/ewUP04Zm0uM1qnJ2tGJK13aHNEXxzGkJu3oBqVgPWJQwEw7UN8oFaEr
         ulpwQZoD/50v08StHInP28Gcmm7uQeIZN202uDpLXZ8KkZOh4UrD3D3q0B6RXc2PIX
         Sn+PxVgSAyewHb3u7xDfEETfcV6CrufRMFyCxUWXfbVCwrYtZpuyC+5Bq1EI6d7HHJ
         pVPnn8QBweRW+KQ9fj5Nor9Vm/w9NeAYL+1JGDOnKChvQLyqU5aBbwo9hNsmwccQS/
         D58kz+dmEdjAssmJ9qqZLCYpDfat+jFV4LAmRlg+FdwSbbPKA5T0n8q161nbi4nSO6
         zxU+cjo0+t1Ag==
Date:   Mon, 11 Apr 2022 16:54:46 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Daniel Bomar <dbdaniel42@gmail.com>
cc:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] HID: microsoft: Report Xbox Guide and Back buttons on
 Xbox One S controller
In-Reply-To: <20220312235230.7498-1-dbdaniel42@gmail.com>
Message-ID: <nycvar.YFH.7.76.2204111653590.30217@cbobk.fhfr.pm>
References: <20220312235230.7498-1-dbdaniel42@gmail.com>
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

On Sat, 12 Mar 2022, Daniel Bomar wrote:

> Signed-off-by: Daniel Bomar <dbdaniel42@gmail.com>

Daniel, thanks for the patch. We however generally don't take patches with 
absolutely empty changelog -- if you could please describe in a few words 
the change, what it does, what user-visible behavior it fixes, etc. it'd 
be appreciated.

Thanks,

-- 
Jiri Kosina
SUSE Labs

