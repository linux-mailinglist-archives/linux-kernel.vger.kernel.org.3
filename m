Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A718359FD22
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 16:24:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237373AbiHXOYM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 10:24:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236884AbiHXOYK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 10:24:10 -0400
Received: from mail-ua1-x936.google.com (mail-ua1-x936.google.com [IPv6:2607:f8b0:4864:20::936])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D12F28E10;
        Wed, 24 Aug 2022 07:24:10 -0700 (PDT)
Received: by mail-ua1-x936.google.com with SMTP id c1so1786505uat.13;
        Wed, 24 Aug 2022 07:24:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=ZFk1t9VG25n4eXd4e+kwVH24IY/dKmhk3oRuZM9LUvE=;
        b=DMXSp2qwyIjCGmxLUmRI9fhR7KLBJGZ7rYdGmPten7xdVxqk7PUW7RfJUQgA6Usspm
         dMey3zj7A8QpPPVirLs7PQBmsupnhq5z9ULrBASMUW8xgg5nBP/x35FTB8D7hBVQx11A
         Xy4ZIBiTaombwyP/o5hfUrSRfoO/K2pRaHxXyPTIq9Mmnm6PSczzANNi3qGHazUbm2yo
         7um1CkMFD/JBEr283TI8iZa8x+b1WN1kE4kD9IqCKu71oeDU3IbyNK6aGhJXW9QTuedS
         f0kcLuOeJKxqT99HlyURevem1bMyTSi7HktYNUUaYYxBwrYxdctC0GmAnyG5ZAbkKDbJ
         7Bxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=ZFk1t9VG25n4eXd4e+kwVH24IY/dKmhk3oRuZM9LUvE=;
        b=J8skqmmxVSpJqq1ba7rIl/T5Xgu6y/YAoc4xY4ZcWwjritXIxrZvKn9XuQXw+jUUL8
         Ge7RKnGpIh//KxVUtIIyRQsw9jOdtSR0Sgo5037IBMJeCQE+n01kcInvFMtmaEd/BXNW
         GqdhvUqR5h5GVPI/wXykkGj5dJX4nemghdM+aZ66DXamloZLH7AuTQScwgDeINHZwCDq
         FfyVvtCmkSg4zZnfL541wYNHf803GyWlaudZpagw9cY1YhqwhagKScPa5lJmbAByJhy1
         CmP0DLLrDMYrWUt03AGPCNUBlSWGSDOULKrv3vP+jZVWQbQob+namPZlkKxVLJlhghd4
         ySeg==
X-Gm-Message-State: ACgBeo13iZ8yqfebaftxEqrosqREJ5F5cpAoJFX9DytL8H1iOcT2N8wK
        2H8wINEbm0Kedzk0oP7oSwgy9yHNdtFjTKKuOZPB09KaEIo=
X-Google-Smtp-Source: AA6agR44mu8GqKOoeLHDCUQ8Uo/pNiCoFFJsyQl9y+XnHMTUTBezEAuJwt5YEL+hZmG9OXA/rRS1YzYinWcJ+p75uXo=
X-Received: by 2002:ab0:45c4:0:b0:39f:a73:fb3f with SMTP id
 u62-20020ab045c4000000b0039f0a73fb3fmr5111484uau.4.1661351048908; Wed, 24 Aug
 2022 07:24:08 -0700 (PDT)
MIME-Version: 1.0
References: <20220824163754.1c082f1a@canb.auug.org.au>
In-Reply-To: <20220824163754.1c082f1a@canb.auug.org.au>
From:   Steve French <smfrench@gmail.com>
Date:   Wed, 24 Aug 2022 09:23:58 -0500
Message-ID: <CAH2r5msrqKnGC3FLBhs-HgS+_V7r-dixvx1+t+PeWZ6Fs87Tig@mail.gmail.com>
Subject: Re: linux-next: Fixes tag needs some work in the cifs tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     CIFS <linux-cifs@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

typo corrected and updated cifs-2.6.git for-next

On Wed, Aug 24, 2022 at 1:38 AM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi all,
>
> In commit
>
>   b044b4dd6048 ("smb3: fix temporary data corruption in insert range")
>
> Fixes tag
>
>   Fixes: 7fe6fe95b9360 ("cifs: FALLOC_FL_INSERT_RANGE support")
>
> has these problem(s):
>
>   - Subject does not match target commit subject
>     Just use
>         git log -1 --format='Fixes: %h ("%s")'
>
> --
> Cheers,
> Stephen Rothwell



-- 
Thanks,

Steve
