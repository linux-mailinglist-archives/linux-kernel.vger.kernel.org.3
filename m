Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67CE25A6938
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 19:04:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231200AbiH3REX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 13:04:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230486AbiH3REM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 13:04:12 -0400
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com [IPv6:2001:4860:4864:20::32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 920E12B267
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 10:04:10 -0700 (PDT)
Received: by mail-oa1-x32.google.com with SMTP id 586e51a60fabf-11ee4649dfcso11772132fac.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 10:04:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=CpmYHqjjLAsEUaG6HFnKO39hG/hT70NRnNiCHPR3d4Q=;
        b=UAMJ5e0wZQHP0Qrdblv4L5fg6+RfIwSdQ3fe27cwa5KS+jZdGuaKyMqmpyLxdB9e/n
         5Wgjxa1+0AzXueoX3k/5NwyZVfli2BCiyMCv6FPDybxdYf+vTqNgheH93saIJBGm59kF
         sMkdxl4IyzrbKrHNZkflTkKXT9jVaIsIPtEaDiOAoiWKQhne6GenKzN/d2sC00tO+Jp+
         ONegh7O5UqUgQuUG7HUfTgfADdHH+jyGWJE1Jste6HbIHiSgL1Gj7cRw0qvH6mbjaXLx
         NURqC5xi/RKM371LzdmCaHv28edOSNowe0gvAPPny5zEhJ9osF04e+eOFuMqjhJKCBLh
         bX/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=CpmYHqjjLAsEUaG6HFnKO39hG/hT70NRnNiCHPR3d4Q=;
        b=dFms8LJe6QlU0HDyNBZBv5u1i5h8PaO4esNJ382BnQf6AT/CbAcUDG/gRVUbiLEk03
         SYd7uU+81qU+bNGjPXA6Q88LVWmAFoZA0+bnyipeZy36RP8f3/PBQVBIN/M5dSYvcjaM
         ssqAjPdrxp64Jj6nkOcf+S8RiguKAvTL5iotiQsPmF3syat+4pMkUqIp0mLM1UAaAsex
         aQiljINMa2DKmx0MrfaJAP3jwUNpT1NFcEIwrXgQKJk4uTUgqjF8rG01w0cMsMJx4QHF
         CXkiVqWAYqtnnbWsXJp953yQg459Vw2bJA81qJozccDLFz1/jIE9K+HYjpVqGZ8dzX5K
         X+/g==
X-Gm-Message-State: ACgBeo0pEWor3Zs9pUMj3iOGFHk+i6Xz6ZhNw1XMkZAJnyavBaVl5SBB
        xKWDl3nMzKpObXEudVhUQ3bPzwG1E2uiaP3U0zhp
X-Google-Smtp-Source: AA6agR7131KnDlFs/EuQ8kOJG5v/nCkN0ixGqCAMioJjGRu9u5t84nkkDzeGpbBTCq3xBWF6TwyTCYTksjs7r51ULg4=
X-Received: by 2002:a05:6808:bd1:b0:345:da59:d3ae with SMTP id
 o17-20020a0568080bd100b00345da59d3aemr5998170oik.136.1661879049639; Tue, 30
 Aug 2022 10:04:09 -0700 (PDT)
MIME-Version: 1.0
References: <20220830105001.68478-1-wuchi.zero@gmail.com>
In-Reply-To: <20220830105001.68478-1-wuchi.zero@gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 30 Aug 2022 13:04:14 -0400
Message-ID: <CAHC9VhSq7P8oHE5dQXdaYx33yMBFEASKgRngSZyNYMr96UYT_A@mail.gmail.com>
Subject: Re: [PATCH] audit: remove obvious unnecessary header files
To:     wuchi <wuchi.zero@gmail.com>
Cc:     eparis@redhat.com, linux-audit@redhat.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 30, 2022 at 6:50 AM wuchi <wuchi.zero@gmail.com> wrote:
>
> With updating the code, some header files are unnecessary. Remove
> obvious header files.
>
> Signed-off-by: wuchi <wuchi.zero@gmail.com>
> ---
>  kernel/audit.c          |  3 ---
>  kernel/audit_fsnotify.c |  5 -----
>  kernel/audit_watch.c    |  4 ----
>  kernel/auditfilter.c    |  2 --
>  kernel/auditsc.c        | 11 +----------
>  5 files changed, 1 insertion(+), 24 deletions(-)

Hi Wuchi, can you explain what process you used to determine that
these header file includes were unnecessary?

-- 
paul-moore.com
