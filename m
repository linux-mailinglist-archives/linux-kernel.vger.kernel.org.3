Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 432EA59FD5B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 16:35:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239151AbiHXOfi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 10:35:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233460AbiHXOfb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 10:35:31 -0400
Received: from mail-vs1-xe32.google.com (mail-vs1-xe32.google.com [IPv6:2607:f8b0:4864:20::e32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C17C832DA5;
        Wed, 24 Aug 2022 07:35:24 -0700 (PDT)
Received: by mail-vs1-xe32.google.com with SMTP id k2so17725561vsk.8;
        Wed, 24 Aug 2022 07:35:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=VWBr3bFEkd6K1ywJM69hwnJgFUM5ggFfJVDdTA7IdJY=;
        b=liBj4gUIELSjcwsxTp7sfR1UiJZGs6eGJTDkLwptqPVYZJqVYRge+0k9SeKOZyh6B7
         89VbuNdytO9677FIhsBykMmmnfGQxZzULjyDDdbTNNoJGVfvqBystvVMu7VF23blfNFe
         zUAI6PK4HEV37CHbgARcGFKu1WgQywMJI2Wx6NR893NGjagF8EwEXRjFpQ9zb41vQ4YO
         ISpZH0I3nE3NTCQnxJCD34IaFo3EKjK95jGB+8/sJ2dOyFJm7/hTQf0F8yP5aTwYdzZ2
         9W0NlcWW9NFGKfrPmnVcMDre9yanL9taLV/NviUUi28w/8oZQFa+ip5tJTvnbTZpPNz3
         AEzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=VWBr3bFEkd6K1ywJM69hwnJgFUM5ggFfJVDdTA7IdJY=;
        b=R1IekI21pQvPvMoj/+nuOcTkbO6FEY+O1Y1MmCE2uO+7hNJsUNt1Une8601Akvv1Ih
         2gbRAkeNl3SWdjTH/g6rqPt4Ex5f0DvP9SSQvY49Shl3SZLqg4UZhxPBOU5WIuWyRpXk
         bBhw/fYPZeO0JTWU66DnLhEzGRePZXUau+zFwNItYWSINJ3/Z5sEwnOAtYkCmPbh5WSG
         EMNjBgiADilQcuV9/m1MgTnpgUADpXiaXt40Y5obr0czJBcxgivNiopBTRZ6v+kQJsDW
         s4iRD/TMKTNtMJy5Bm+2uCoJi5H0am1BLAbZeJl2DNifOrlPRbi5LIay2lANzbABLoDH
         v0aA==
X-Gm-Message-State: ACgBeo3kvLf0u+JVGqqrtx2Gf/qisrSNsmvRgVHsnY1YQ69n0fwnqIfy
        tnRZQQj0d7ENdmXhuZCkV2IjLMhJ8WC53TLzdnY=
X-Google-Smtp-Source: AA6agR7no4ALsScoYOQNIECDUYMHBrW2b4U39IGLIvJ45G+l80wo90otV+f8AVBe1zOkyUa0dj2CNxlZQwgIwbqHuWo=
X-Received: by 2002:a05:6102:1626:b0:390:2616:663e with SMTP id
 cu38-20020a056102162600b003902616663emr9025087vsb.6.1661351723637; Wed, 24
 Aug 2022 07:35:23 -0700 (PDT)
MIME-Version: 1.0
References: <20220824163936.58b58ad3@canb.auug.org.au>
In-Reply-To: <20220824163936.58b58ad3@canb.auug.org.au>
From:   Steve French <smfrench@gmail.com>
Date:   Wed, 24 Aug 2022 09:35:12 -0500
Message-ID: <CAH2r5muqb4SnL6YDSOUqfPqY9g-x3-=aRXxpRmjxxXPCOrOx7w@mail.gmail.com>
Subject: Re: linux-next: Signed-off-by missing for commit in the cifs tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     CIFS <linux-cifs@vger.kernel.org>,
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

fixed.  updated in cifs-2.6.git for-next

On Wed, Aug 24, 2022 at 1:39 AM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi all,
>
> Commit
>
>   b044b4dd6048 ("smb3: fix temporary data corruption in insert range")
>
> is missing a Signed-off-by from its author.
>
> This is another case of a mailing list munging the From: header of
> an email.
>
> --
> Cheers,
> Stephen Rothwell



-- 
Thanks,

Steve
