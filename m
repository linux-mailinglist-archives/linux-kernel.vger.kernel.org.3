Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58DA94FF0A3
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 09:36:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233387AbiDMHiU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 03:38:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233367AbiDMHiR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 03:38:17 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 811324D9EF
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 00:35:57 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id i27so2126980ejd.9
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 00:35:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=26iaV007QB9A1mMUPni92FyAXzasRAgZ3iveXMBEbJM=;
        b=FUVsLLWLH1vs/kjgwGlMEqwW5ZagS8QPkV/VDF2XJ9pZYn7aoUBF0Jb25m40IBBLDL
         4fasd7/2swAi+q63Ku/g+15bWZKsNRj2yS8PMWQABw6C9epe0VHmhSNfgtAJABNOxEKE
         u1OGBTkLCduYwKGWTbfQttCGYmPId59chjh1Il6F/uWwQK35cAO4QinsSTzchF1V5VGw
         wu31Qy9m9IpYGfQCqPo/3KZi4q1Xy1Ay81pUoMwy91JkMgQr4eLB0mQfK2ixFu1I/XWq
         PL7AehTocRejK7dW5ZHaT1k3+oLw8SUSa3MngIbrpV+3R01I7tYpHsc5NFUgscrO8PVR
         sx8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=26iaV007QB9A1mMUPni92FyAXzasRAgZ3iveXMBEbJM=;
        b=zcSGCYz+pmtjjV1SRxeEujtpRc7iSMpnVoGTz1i9hOl+0s2wVOyWjhkfPI19M3DKkK
         04mTpj37nqDlldH8PsKog6qDt7gSJ6NY0DPkCgYFtfEbq8hvH6ozA25BqOPI9X1yxaRM
         njyCZ0Uh24Mo5WXQJMAVPBPN5PC6jwWwgBvwrH6rPYuPfoAt7xYZBKb4l4RcGflCElzV
         im+4qHepEbZVjZEJP2W94oHP21ONREhprObeSKtjjdg18lgT3or9qKDrV96xnDlwjdxn
         RGpOjAzv+xi5G19rzSt2BN3ZWU+EvVrKABjCU1F0r3arYMDPpTCqhidSzAbRGICeQJi9
         wDkA==
X-Gm-Message-State: AOAM531sBfV02vbGIJwMk77SxQMgTHsCSgkBYneNJq8fZKYc9ZJFaMO6
        zl2r68KinKhXIGZ2bhltDuZhD3CPy1o=
X-Google-Smtp-Source: ABdhPJwmIH+f1J7+rWhhfC79YiCHoF8bSKK80CbayncPfS92Zmhy1Jtey8+R8P8H0jtjNlva4t5F2g==
X-Received: by 2002:a17:907:d16:b0:6d6:e3b6:9cd8 with SMTP id gn22-20020a1709070d1600b006d6e3b69cd8mr37238068ejc.94.1649835356047;
        Wed, 13 Apr 2022 00:35:56 -0700 (PDT)
Received: from leap.localnet (host-79-43-11-75.retail.telecomitalia.it. [79.43.11.75])
        by smtp.gmail.com with ESMTPSA id mx14-20020a1709065a0e00b006e8bc3ce121sm1002452ejc.6.2022.04.13.00.35.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 00:35:54 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy@lists.linux.dev
Subject: Re: [PATCH] staging: Remove the drivers for the Unisys s-Par
Date:   Wed, 13 Apr 2022 09:35:53 +0200
Message-ID: <3988824.6PsWsQAL7t@leap>
In-Reply-To: <YlZzP5ghZeR1AtIg@kroah.com>
References: <20220412215901.31046-1-fmdefrancesco@gmail.com> <YlZzP5ghZeR1AtIg@kroah.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On mercoled? 13 aprile 2022 08:52:47 CEST Greg Kroah-Hartman wrote:
> On Tue, Apr 12, 2022 at 11:59:01PM +0200, Fabio M. De Francesco wrote:
> > The Unisys sub-tree contains three drivers for the "Unisys Secure 
Partition"
> > (s-Par(R)): visorhba, visorinput, visornic.
> > 
> > They have no maintainers, in fact the only one that is listed in 
MAINTAINERS
> > has an unreacheable email address. During 2021 and 2022 several patches 
have
> > been submitted to these drivers but nobody at Unisys cared of reviewing 
the
> > changes. Probably, also the "sparmaintainer" internal list of 
unisys.com is
> > not anymore read by interested Unisys' engineers.
> > 
> > Therefore, remove the ./unisys subdirectory of staging and delete the 
related
> > entries in the MAINTAINERS, Kconfig, Makefile files.
> > 
> > Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> > ---
> >  MAINTAINERS                                   |    8 -
> 
> You forgot to at least cc: the people/list on the MAINTAINERS entry that
> you are removing here, to give them a hint that this is happening in
> case they want to speak up here (and to give us the ability to point to
> that years later when they complain they were never notified...)

Yes, this is a good idea. I'll submit a v2 and add two "Cc:" lines, one to 
David Kershner and the other to the "sparmaintainer" list at unisys.com.

> Also, if you are in the "delete code" mood, I think drivers/staging/vme/
> and drivers/vme/ can probably also be deleted given that the maintainer
> for that has moved on to other jobs.  Ask them and see!

I can and will do exactly as you just suggested, but only after April 22nd 
(unless others want to do these tasks sooner, and in that case they are 
welcome :)).

Thanks,

Fabio M. De Francesco


