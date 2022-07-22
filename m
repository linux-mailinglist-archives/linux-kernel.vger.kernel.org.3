Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9E8057E762
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 21:29:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235178AbiGVT3c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 15:29:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231784AbiGVT3a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 15:29:30 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B1921EAD4;
        Fri, 22 Jul 2022 12:29:29 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id c3so4380672qko.1;
        Fri, 22 Jul 2022 12:29:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=E/lAne3sWA7x+h1qQlZwY2RlcJ4V/1aOGrEnwYJSEqE=;
        b=EOYXN1DWUDR7ro4rrVKShowkaEln3JbgK/2l8Hwjvfnfbp9kMOFo/TRFukmr3/H3Bi
         YwOHSGzhd3Vg9NvflSJFJLW4uzz4yv8qq4ijh3ComKOrXYrUIuo00JmvNMZLcZ9dDOuc
         GC6svKPYQj4wFfD0JHi++H1SuSOHPKlWYUKNpo2daSZAWhvtVy7XzoMmkwuIxUPH8sTG
         J829iLNitSxiAsjX9QFZo5fmAbUjYLC1PSFvBbpjDkB7SL6rzUevhGie5wk+sLxP3Lyu
         DMAtRP6v+S7TaSL7XWqsoeG5GYbOteovu0QA02n/MxHlr7nXx+873emMA/38pTO5PIN0
         tO9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=E/lAne3sWA7x+h1qQlZwY2RlcJ4V/1aOGrEnwYJSEqE=;
        b=QctKpkw1wFADc7qpzTx39DP8wQBKo+msJPW5FEeP/TpA6mtO7iHyuW45P48hdpByVk
         5pJNm1CGlXVbxj8Sj82r8Kn68Rpy6x++sR5OjPuGwySbv/bDQl5PC3kGoMg7XCuyG4RM
         TL3JqFOzU8NezO1Hk17f5JIrKQ5uWTSLr6nIOnmsic8Nx6KRXayRYPEi+s+YHH2wkRK9
         ntMeJXThfAZYLXaADEJvtvIC99jgqSJi5mx7XPe3tDy0lyv6/MXodoSNTfPqB/nVbhQi
         dNpAkWMGUt/f10rsYrG7T+KuQyWYzEEvHEhm3eroXYozq1i9J9WHd3ighwhi0bxdrLlW
         0SNA==
X-Gm-Message-State: AJIora+UOqyop5SBIzuQ+AozVSVkmlgcepcQxg+ca3hCMfJsX/h/zDQl
        w8NWz4ofUpz37cL4LPuQFZsoDhrR1Qw=
X-Google-Smtp-Source: AGRyM1tAezT3qSnSL7vVzjjbYkhwAQwQU9/v5Ht5yxZUm154jcTp4PBelIotRewaRt8XWGdQQt6kPw==
X-Received: by 2002:ae9:e8d0:0:b0:6b5:bee3:51a7 with SMTP id a199-20020ae9e8d0000000b006b5bee351a7mr1131365qkg.345.1658518168509;
        Fri, 22 Jul 2022 12:29:28 -0700 (PDT)
Received: from localhost (c-69-254-185-160.hsd1.fl.comcast.net. [69.254.185.160])
        by smtp.gmail.com with ESMTPSA id ck11-20020a05622a230b00b0031eeefd896esm3413388qtb.3.2022.07.22.12.29.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Jul 2022 12:29:28 -0700 (PDT)
Date:   Fri, 22 Jul 2022 12:29:27 -0700
From:   Yury Norov <yury.norov@gmail.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the bitmap tree
Message-ID: <Ytr6l2CHG8lbU+8Z@yury-laptop>
References: <20220722191657.1d7282c2@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220722191657.1d7282c2@canb.auug.org.au>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 22, 2022 at 07:16:57PM +1000, Stephen Rothwell wrote:
> Hi all,
 ...

> I am not sure which commit caused this.  Though I suspect
> 
>   bbe8fb1a3c53 ("lib/nodemask: inline next_node_in() and node_random()")
> 
> which added the include of random.h to nodemask.h
> 
> I have used the bitmap tree from next-20220721 for today.

Hi Stephen,

You're right. The problem in the last patch of the series. I've got
the fix already, and testing it now.

I'll drop the bbe8fb1a3c53 and submit it separately together with
header fix.

Thanks,
Yury
