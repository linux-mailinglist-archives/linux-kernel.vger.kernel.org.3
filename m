Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3B3E4F4C43
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 03:13:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1577723AbiDEXQW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 19:16:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1455602AbiDEQAO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 12:00:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E67C74613
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 08:17:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9D6C661762
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 15:17:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB01DC385A0;
        Tue,  5 Apr 2022 15:17:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1649171821;
        bh=Cich/PHVbJy1g1hE9OTZvkfzNrroc5Eii9MGYzlSdHA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HZbw2bh9MUvLP8PBamL48xqQ7M4cBuV7W4wP62eLOLQscc8DjUWE9F7laPxmuXEC2
         d4osBx2IPKfWCkjLtwFNEr+5h7TW+Lbi3bajiQd8InKVAYuaf/nHPst2jZRtiWfGFt
         bJfRaXeg7ye3vzYDPsRmdQ+UTbiOm6PZwy5C1hTc=
Date:   Tue, 5 Apr 2022 17:16:58 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Sevinj Aghayeva <sevinj.aghayeva@gmail.com>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy@lists.linux.dev
Subject: Re: [PATCH v2] staging: rtl8723bs: fix indentation
Message-ID: <YkxdasBGZ3m2Yu66@kroah.com>
References: <20220405150912.GA625670@euclid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220405150912.GA625670@euclid>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 05, 2022 at 11:09:12AM -0400, Sevinj Aghayeva wrote:
> Adhere to Linux kernel coding style.
> 
> Reported by checkpatch:
> 
> WARNING: suspect code indent for conditional statements

You are also removing unneeded comments, right?  Please explain that as
the documentation link the bot pointed you to showed.

thanks,

greg k-h
