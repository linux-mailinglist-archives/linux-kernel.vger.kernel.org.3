Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFC8B55F018
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 23:02:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229634AbiF1VBm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 17:01:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiF1VBk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 17:01:40 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B2C9393D3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 14:01:39 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id c4so12150373plc.8
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 14:01:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=op7eUwnJSuDxiUQ7wEzydCPAKOVz5BBBkZHnysyBNQY=;
        b=nZImfPxtvFd+PtvuuVUOznr+c43CAJNmNug6lKpgDK9tHOSt4DMJN9Qy8zuuoCH+V1
         kzkvURahXkI+/wUpap6n2BFihTGyIBvoC/46tb5oTgrddJXKi+6KDrXonSE4bXSYE1cN
         pwzhrEFPYmLxAAepUTC5ykHV3lE0vT8MW7vxCr7x2zhpRlH7YnXpTBdqCKpTxnYa1Seu
         XZ8eXKygnUttchw6hx6wj6cGzDUQm9V48Tj0WLdQoIwcOW2GylgfiZz+3RxQ93V3dMqb
         RUcDywSmX1kN0ZNYnNxs/Bl39B1IkshcCMbOd3EZzr7/PORZ5hRBKEIpFK/gHyGItGkU
         UNOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=op7eUwnJSuDxiUQ7wEzydCPAKOVz5BBBkZHnysyBNQY=;
        b=UQoRVsYtkQmrnt+oMI3yczqO2f1TkpnZZa+KRY8ReiXd3udsB4VIw6LvCrF8iVKxhB
         Jfl8z/bDPyqPHP1dqOch5uYwWqJV3YxrkhdRpGd4XMz/ElCYTiSrEF9keInnses2LdQk
         FoW07dlSol7qd88DmuB/YLD00lU1D2U4gfy111+9TX06X+8/hcc40ONG+lnQXtbV7O5y
         2uVhqM9sfTi8j/CEx9veeKNy5iG/btTGsyBjg1jKcGisOL1p6GmI51JUTl6wXUKBMpym
         YoOgm5Sqi3b4z9RttpvcOagWyEXUzDAwPasxZlBWaP/8ubNxTsbzLetVH/Vh76Mirz2X
         nvFA==
X-Gm-Message-State: AJIora8MHGHE/jCub85lkBmEklmwjII82lpsQajwBWw04fzssx53fdkn
        myXvzZUPxYXd4nN4vWjmJus=
X-Google-Smtp-Source: AGRyM1tynwG8Qi9BmZsJECoNPZUqjR7PtEj8llMTsNvXuUowRN9ZrBZxWRSCg8ZnSD380rimtq0mjg==
X-Received: by 2002:a17:90a:b701:b0:1e8:6d19:bcb with SMTP id l1-20020a17090ab70100b001e86d190bcbmr1670430pjr.218.1656450098653;
        Tue, 28 Jun 2022 14:01:38 -0700 (PDT)
Received: from localhost ([2409:10:24a0:4700:e8ad:216a:2a9d:6d0c])
        by smtp.gmail.com with ESMTPSA id y201-20020a6264d2000000b0052521a00e69sm9899175pfb.124.2022.06.28.14.01.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jun 2022 14:01:38 -0700 (PDT)
Date:   Wed, 29 Jun 2022 06:01:36 +0900
From:   Stafford Horne <shorne@gmail.com>
To:     Joe R <joelinux1992@gmail.com>
Cc:     openrisc@lists.librecores.org, linux-kernel@vger.kernel.org,
        Jason@zx2c4.com
Subject: Re: [PATCH] wireguard: selftests: support OpenRISC
Message-ID: <YrtsMCYXCkA+oncE@antec>
References: <CANmBqSDd-n2gyvkDgAqOO_Q43dRodrS9_BFmkxDY27O87p=Q=Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANmBqSDd-n2gyvkDgAqOO_Q43dRodrS9_BFmkxDY27O87p=Q=Q@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 28, 2022 at 04:36:34PM -0400, Joe R wrote:
> Thank you for the patch, it seems like you put in a lot of time into it.
> 
> However, I do have one question: on the website
> (https://www.wireguard.com/build-status/) it says that the test is
> still failing. Is that due to the QEMU changes that have yet to be
> upstream, or is it outdated and has already been fixed?
> 
> Thanks again for all the hard work you do!

Hi,

Jason mentioned this to me too.  There are still some stability issues under
load that cause the platform to be unstable.

We will need to sort these out before turning this on. So this is on hold for
now.

-Stafford
