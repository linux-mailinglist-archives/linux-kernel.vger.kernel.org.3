Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72824488638
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jan 2022 22:02:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229913AbiAHVC0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jan 2022 16:02:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbiAHVCZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jan 2022 16:02:25 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2292DC06173F
        for <linux-kernel@vger.kernel.org>; Sat,  8 Jan 2022 13:02:25 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id r16-20020a17090a0ad000b001b276aa3aabso17101459pje.0
        for <linux-kernel@vger.kernel.org>; Sat, 08 Jan 2022 13:02:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=AgMkKh2nRCL0sWaRzvFbnX57uQaqM5obk1wN1aPXyqs=;
        b=NyvArGJdrnc5MOWILFNQfErNaxxr7AOqU9m8UDaYBjGbjcmfOuxIxooL1vHrca3HNX
         +oETpvAOYpYOLVrHuGr04zJd0UhnTfl1FfR5QshXou2dj7ckg2yky3DSiEYqWtNtOoez
         qrFj9Xv3KPjwb9AVb0DoKsNVSAx+3GViXBjAkxWqTCkTFsmlv0WtrimHInHy4McmXKax
         mN9s+Tdxp4Qu/F7QBJGWqdWWCOgS4UO8ChPK86NvjOBJp59EzaSFr2F+E33ln9XZW89A
         lvn4bNbbXhhJwpTpsKlhooogawAgKa7fr+RlWjEvV3INGIC4ycWf9xoTr6mix9AHsJwQ
         RzYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=AgMkKh2nRCL0sWaRzvFbnX57uQaqM5obk1wN1aPXyqs=;
        b=t5Yt9W5djQHOlRUYn6MfVYBcW17SLICYWflmDvKd/4dLtgW/CaG/tb9oS8ajH89/aQ
         9p249qFFtEAj6gAXRjDHpj7JAUL4job3f2tNU9tIxxIpvaXdVyMFuob6tbczh5SsMRHV
         I1MvTrE3koS60ucecNZjbmhya9pdW+eUZ0cusQS8WjhBJ8iU47ptwldNLOeHuWKaq3Dk
         F/NCGgYc9yzeBPzw9NxsIdUy3VSfZPsHULM2N671OljW4ExhqoeUZNASSdQ2laK2bWSN
         RCkWWGWc3yHbAWXg8HrNrvLMmXgoKBW8ZkMUQPrDOO0nImD47p7pdcjtcyuIUpDY8iEo
         +Dhg==
X-Gm-Message-State: AOAM533oRZ4SwMUPiFLCeOUihrUqoQGHj8LkCmGA+JJwDSZ4+1LBURKf
        n4pcJWh/lETv1l04z94S1yk=
X-Google-Smtp-Source: ABdhPJwf0QXJyWP0Pug2hy49yzRWhKDwGaEEOTJzOQ4syk3iWAWlZBC3Jbtp06U9hhljk1cWgzQVpQ==
X-Received: by 2002:aa7:8084:0:b0:4bc:9423:96b2 with SMTP id v4-20020aa78084000000b004bc942396b2mr31424279pff.45.1641675744668;
        Sat, 08 Jan 2022 13:02:24 -0800 (PST)
Received: from mail.google.com (122-58-164-114-fibre.sparkbb.co.nz. [122.58.164.114])
        by smtp.gmail.com with ESMTPSA id z7sm2273499pgs.4.2022.01.08.13.02.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Jan 2022 13:02:24 -0800 (PST)
Date:   Sun, 9 Jan 2022 10:02:19 +1300
From:   Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
To:     Sidong Yang <realwakka@gmail.com>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: pi433: move get version func to where all
 other functions are
Message-ID: <20220108210219.GB3660@mail.google.com>
References: <20220106201430.GA3416@mail.google.com>
 <20220106213325.GA10767@mail.google.com>
 <20220107085343.GP7674@kadam>
 <20220107192438.GB2693@mail.google.com>
 <20220108111910.GA1978@kadam>
 <20220108163621.GA26654@realwakka>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220108163621.GA26654@realwakka>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 08, 2022 at 04:36:21PM +0000, Sidong Yang wrote:
> On Sat, Jan 08, 2022 at 02:19:10PM +0300, Dan Carpenter wrote:
> > 
> > Yes.  Keep the error handling.  Your way makes the code more complicated
> > to read.
> 
> I totally really agree with it.
> Because the switch clause under this patch catches error with 'default:'
> but it returns '-ENODEV'. I worried that it lost retval from reading
> register if it has error.
> 
I will add it back to the patch.

thanks,

Paulo A.
