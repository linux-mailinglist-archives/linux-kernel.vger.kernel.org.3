Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F399055121B
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 10:04:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239657AbiFTIES (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 04:04:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237469AbiFTIEO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 04:04:14 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C07CF213
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 01:04:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7B04BB80EB7
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 08:04:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5AE7C3411B;
        Mon, 20 Jun 2022 08:04:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1655712251;
        bh=ngCOGSBoTpAJNhtEXwd9BxoP+DCWFvIilL8U9jLFbEI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Sy1gIRm2AlQ+DtESZk/fjBxXhoa4rdZ+J8lKd3nHVRtwamQDKDSGsHQj5btGXX/82
         0uyq2UblpMvM4XWmYNEipu9i6Hp8QcOxaiwuaRj4d+/A3hZTJXttIbuY7yY8Cob+aP
         XYQwN5PqokdieB13/NWW6IcW3bcHwCFpFuyaZJec=
Date:   Mon, 20 Jun 2022 10:04:08 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     daniel watson <ozzloy@challenge-bot.com>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8723bs: remove trailing whitespace
Message-ID: <YrAp+KlogDNwjGVa@kroah.com>
References: <20220620054529.4019-1-ozzloy@challenge-bot.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220620054529.4019-1-ozzloy@challenge-bot.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 19, 2022 at 10:45:29PM -0700, daniel watson wrote:
> From: Daniel Watson <ozzloy@challenge-bot.com>
> 
> remove trailing whitespace found by checkpatch
> 
> Signed-off-by: Daniel Watson <ozzloy@challenge-bot.com>
> ---
>  drivers/staging/rtl8723bs/core/rtw_mlme_ext.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

I've taken this, but you should fix your email server DKIM settings as
it is not correct:

Grabbing thread from lore.kernel.org/all/20220620054529.4019-1-ozzloy%40challenge-bot.com/t.mbox.gz
Analyzing 1 messages in the thread
Checking attestation on all messages, may take a moment...
---
  ✗ [PATCH] staging: rtl8723bs: remove trailing whitespace
  ---
  ✗ BADSIG: DKIM/challenge-bot.com
---
Total patches: 1


