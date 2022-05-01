Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 059F05166C9
	for <lists+linux-kernel@lfdr.de>; Sun,  1 May 2022 19:48:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353550AbiEARvY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 May 2022 13:51:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241488AbiEARvU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 May 2022 13:51:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6EE1344EE
        for <linux-kernel@vger.kernel.org>; Sun,  1 May 2022 10:47:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 71B5360F9C
        for <linux-kernel@vger.kernel.org>; Sun,  1 May 2022 17:47:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E59BC385AA;
        Sun,  1 May 2022 17:47:51 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="mijpUuTM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1651427269;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=roYIDwenPH7TXgFhpcFK4JNS0ImRSBrMkdPkCk4GtAM=;
        b=mijpUuTM3Gkc1YujdAxFJFvSVY7pxblaOmCz2uI26ihfteBT67l/zO9hWh6JGwR5ay1uOY
        aVhJTFnaYTzlwFRMyP6VbCTVcxvxx6ApytOhYEO+bZ7d7qraBlisVghedMp3dTxuIrmWrA
        Oy6/FQ8rB8QhhXwk0fteCBwX+vHHZv0=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 7e9db5a3 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Sun, 1 May 2022 17:47:49 +0000 (UTC)
Date:   Sun, 1 May 2022 19:47:47 +0200
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: Re: Changes in kernel 5.18-rc1 leads to crashes in VirtualBox
 Virtual Machines
Message-ID: <Ym7Hw9GDPP838JoH@zx2c4.com>
References: <7f01221d-f693-adf8-f5a5-d71944b44162@lwfinger.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7f01221d-f693-adf8-f5a5-d71944b44162@lwfinger.net>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Larry,

Thanks for the report. Several questions:

1) Can you reproduce with 5.18-rc4?

2) Can you send me a stacktrace from the crash or any relevant console
   output?

3) Does the crash happen in the guest or the host?

Question two is very important.

Thanks,
Jason
