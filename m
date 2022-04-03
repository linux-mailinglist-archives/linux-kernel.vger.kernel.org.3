Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24CB44F08E2
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Apr 2022 13:04:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356790AbiDCLFc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Apr 2022 07:05:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243942AbiDCLFa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Apr 2022 07:05:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B18CD13D4A
        for <linux-kernel@vger.kernel.org>; Sun,  3 Apr 2022 04:03:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4DF9361030
        for <linux-kernel@vger.kernel.org>; Sun,  3 Apr 2022 11:03:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 551BDC340F0;
        Sun,  3 Apr 2022 11:03:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1648983815;
        bh=K5XSAOxhz8Ysr0NyMrapOBeVb7CDEO/6/xyLqOA8GRI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fcTzXqfZXUkrXz2z9oAtjHuKKmLBeyvjbTxVKCTpN0gRJet1DuQOvS2R34C4dUZvK
         Jlw1Ep5LejLneBJI/TpUUhmU5S8fenKf2upUWuOQSdAlow2ZoEPLzHsLBOGUhW6+LI
         IT25bHkMS1DUfZfz3gs+up9k5aX2cftf6AoDpw8M=
Date:   Sun, 3 Apr 2022 13:03:32 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Sevinj Aghayeva <sevinj.aghayeva@gmail.com>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy@lists.linux.dev
Subject: Re: [PATCH 1/3] staging: rtl8723bs: remove redundant braces in if
 statements
Message-ID: <Ykl/BCgJx1V7OHSI@kroah.com>
References: <cover.1648817213.git.sevinj.aghayeva@gmail.com>
 <d157392b32cbc02455f8c1813a09c5cc8f11fcf7.1648817213.git.sevinj.aghayeva@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d157392b32cbc02455f8c1813a09c5cc8f11fcf7.1648817213.git.sevinj.aghayeva@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 01, 2022 at 09:02:45AM -0400, Sevinj Aghayeva wrote:
> Adhere to Linux kernel coding style.
> 
> Reported by checkpatch:
> 
> WARNING: braces {} are not necessary for single statement blocks
> 
> Signed-off-by: Sevinj Aghayeva <sevinj.aghayeva@gmail.com>
> ---
>  drivers/staging/rtl8723bs/core/rtw_mlme_ext.c | 76 +++++++------------
>  1 file changed, 26 insertions(+), 50 deletions(-)

Does not apply to my tree :(
