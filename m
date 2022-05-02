Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CD735168FD
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 02:11:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378790AbiEBAOt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 May 2022 20:14:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230252AbiEBAOo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 May 2022 20:14:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F4F820F5A
        for <linux-kernel@vger.kernel.org>; Sun,  1 May 2022 17:11:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D0E9A60F90
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 00:11:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFCE5C385AA;
        Mon,  2 May 2022 00:11:16 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="cD5AkLYr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1651450275;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wNLpETAYxoyTBvaxvFNvB3XiCawLoRAilFEEs/m/JWY=;
        b=cD5AkLYrqbU6wr5RLWDSHduYrN50wzPWjZNfdj9A8Wp1NI629hNpbrd9vE9Ix4/P8jGv35
        lV/QamT3TLIHxzVZGApjHI9jHqj/YC63KBTB37S5mNdEdM2Gg4OxXt6E2JxKH2qAUQCcIf
        GG5v1aAgu2GB5AmSQf9kH8hjKoci5PA=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id d53cc448 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Mon, 2 May 2022 00:11:15 +0000 (UTC)
Date:   Mon, 2 May 2022 02:11:13 +0200
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: Re: Changes in kernel 5.18-rc1 leads to crashes in VirtualBox
 Virtual Machines
Message-ID: <Ym8hoW7J60xAQv8f@zx2c4.com>
References: <7f01221d-f693-adf8-f5a5-d71944b44162@lwfinger.net>
 <Ym7Hw9GDPP838JoH@zx2c4.com>
 <6bd35831-2d7a-77ee-55e9-755ca752b0c8@lwfinger.net>
 <Ym8YlXYM4HQg8tq7@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Ym8YlXYM4HQg8tq7@zx2c4.com>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey again,

I just installed VirtualBox ontop of 5.18-rc4, and then I made a new VM
with a fresh install of OpenSUSE, and everything is fine. No issues at
all.

So you're going to have to provide more information.

Jason
