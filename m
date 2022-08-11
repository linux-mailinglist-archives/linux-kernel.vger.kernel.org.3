Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE54758F5FA
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 04:50:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233301AbiHKCug (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 22:50:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229867AbiHKCud (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 22:50:33 -0400
Received: from mail-vs1-xe33.google.com (mail-vs1-xe33.google.com [IPv6:2607:f8b0:4864:20::e33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C16025C6A;
        Wed, 10 Aug 2022 19:50:32 -0700 (PDT)
Received: by mail-vs1-xe33.google.com with SMTP id 125so17072015vsd.5;
        Wed, 10 Aug 2022 19:50:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=N/33hPn6tDAKCWVmHpkejeQE0V41RDo2Av4gkTzMuDY=;
        b=nxWexnljkYzQ+5te/vIjYMPEY5br6krwB3fZcMuTsjR7a8MKOY7Mo0Fc/YdzzsNwPy
         pSMN2R4iV7Xef+M58MT9g97iwG7MWuRoIexGkOMc12POdKsn+mllx6E4FAlmkU5+wOUw
         nPHz9YbQA3w6djQ20ErTn9Q6GGVzfYrGlkzEYegBapODi1G0+nJGZ6vHKPSHypTpPtGc
         k7Ri36dg0zpp5l56XgCCvPX+pVQGuPIZEScsP6s/bUYsKWiAoMJ03UA/XMJI1As1dpSn
         s1P9JZq1sRrepLuxNrsNF9+PfZnBV6CsulkBPK0mV4q8hSUGONKvPIC5zLgRhlA3vpuz
         Si+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=N/33hPn6tDAKCWVmHpkejeQE0V41RDo2Av4gkTzMuDY=;
        b=m9oI+pRrgQ62wTH/lDJa1UjqqffcGybTe+l9YWAVbFcKP1uCTv4AcG7udnhadSh3Qs
         yamyB0MTnoK5yTUMRs3RBKDkS8RSnhXfv1JH8EgXGBxdxCzupHJoP9XVWf2wjqcLh+Gz
         UP0Zd0BEkqoUpls7hoVI6U6JfgdN4dizaERsuPXnRY/MPLQOcPcvsplLGIUOvmdQT0h4
         c0jwenvvfiat3koTmjo/favX4tAnaq/XZKyR/CY9F+vZM62mcm3NTIXGaIcCQQ24YChM
         18DJd5x2JYqi4p+bbPOAQjYzsgNgKA8EWnK0m9E7pd0rJi3DfFfQEPdJ3FwsShezMPF4
         6yiQ==
X-Gm-Message-State: ACgBeo0ypxB5Iam/n2k72OvynuhtO7uszGnPsXcHF/tvrSEOsqFWT5mS
        1SfqNUUoRqKD+BePP4wt0ozWff09U8QGV9ye8lfdKY1h
X-Google-Smtp-Source: AA6agR66K3FOQ18XAxQo2BkH8tCoenaYOif/po6aBX0piEDgxW6J5pR6CkoPp1z/ALHtAezTv/hmjhVJCvkaS4AoaMc=
X-Received: by 2002:a67:f751:0:b0:388:82bf:aaea with SMTP id
 w17-20020a67f751000000b0038882bfaaeamr11704018vso.55.1660186231569; Wed, 10
 Aug 2022 19:50:31 -0700 (PDT)
MIME-Version: 1.0
References: <20220811124522.68968e81@canb.auug.org.au>
In-Reply-To: <20220811124522.68968e81@canb.auug.org.au>
From:   Yury Norov <yury.norov@gmail.com>
Date:   Wed, 10 Aug 2022 19:50:20 -0700
Message-ID: <CAAH8bW8uuMyDybXkeyBtztP+VMys4akVZbmH1qShE-kKu2bX+A@mail.gmail.com>
Subject: Re: linux-next: Signed-off-by missing for commit in the bitmap tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
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

On Wed, Aug 10, 2022 at 7:45 PM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi all,
>
> Commits
>
>   3876987b68a6 ("lib/cpumask: drop always-true preprocessor guard")
>   878d1d41e207 ("lib/cpumask: add inline cpumask_next_wrap() for UP")
>   27d2e18339c2 ("cpumask: align signatures of UP implementations")
>
> are missing a Signed-off-by from their committer.

Fixed, thanks!
