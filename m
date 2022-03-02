Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC9284CA857
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 15:43:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243166AbiCBOnu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 09:43:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233150AbiCBOnt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 09:43:49 -0500
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 145CB237E4;
        Wed,  2 Mar 2022 06:43:05 -0800 (PST)
Received: by mail-yb1-f172.google.com with SMTP id u3so3790772ybh.5;
        Wed, 02 Mar 2022 06:43:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zT1WYVi7FiTrFh9BxoZLrpJe/d9oI6uiEDFzQMsQ1v4=;
        b=K8TxerCD7Lq10y0WP7lIRIQnSEOZfabhQH6TVVspYmwIgoIcIHv+r+cO6JrbysFoTo
         9HEYODxnXV45NPMddVGwanF5f4EoTiync47nY3rkfIyePn8U2nfzuYobhn5fd1nkPlmS
         FPCqBFE8zBDF5Ji5dHQWgQsxq1zqGg4eLFuGcmPD9GuKkjPIPiHdLoV0MY3aDCUtEYby
         3e+MHInfgw9I98sRPgVCzimSXNZCNvEzKE0rZ0zOgVmW5NLhJpymdDLb7taSq86uSpQ0
         XTHIYZ/3tlxv0uWDxlmnMi+F3tveeq/MQCWOcR5mFVn7NdFMD/FJu4E9mcNNuc8Rx7vx
         R6mg==
X-Gm-Message-State: AOAM531BFasKCIkhUKeHFTRzp98YW5pYHfO7LsY3m4QADEpnkyUqomSW
        ThOi/Wc3Tjr1mQXjM4t7KPlPloxul32yt0YDQt0=
X-Google-Smtp-Source: ABdhPJwJ67QHLv2xSeCevuPfdTWfyApFUjE2xansxkQn4G6yH1b6O8qHELEGKlLhgZ1Sy1rMQBALdCOXn7EHDj3WHs4=
X-Received: by 2002:a25:d2d0:0:b0:628:7d69:b598 with SMTP id
 j199-20020a25d2d0000000b006287d69b598mr7554145ybg.381.1646232184272; Wed, 02
 Mar 2022 06:43:04 -0800 (PST)
MIME-Version: 1.0
References: <202203021333.mMJpWPzx-lkp@intel.com> <5f13b914-e309-49ee-4f98-c81780c478b9@intel.com>
 <20220302103219.kvpfhc6qz42t3pvv@pengutronix.de> <CAMZ6Rq+HR=j2mD97etTgSapOix96P=pK70bTr9HeJu2Mjkn3+g@mail.gmail.com>
 <20220302130423.ddd2ulldffpo5lb2@pengutronix.de>
In-Reply-To: <20220302130423.ddd2ulldffpo5lb2@pengutronix.de>
From:   Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Date:   Wed, 2 Mar 2022 23:42:53 +0900
Message-ID: <CAMZ6Rq+J0CH_HvK1ax=VcWKqih+B_0Nfoc9jZMiq7OtuXL06hw@mail.gmail.com>
Subject: Re: drivers/net/can/usb/etas_es58x/es58x_fd.c:174:8: warning:
 Uninitialized variable: rx_event_msg [uninitvar]
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     kernel test robot <yujie.liu@intel.com>, kbuild-all@lists.01.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arunachalam Santhanam <Arunachalam.Santhanam@in.bosch.com>,
        linux-can <linux-can@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed. 2 Mar 2022 at 22:04, Marc Kleine-Budde <mkl@pengutronix.de> wrote:
> I was thinking of this:
>
> | void *foo = bar->baz;
> |
> | if (!bar)
> |         return;
> |
> | printf("%p", foo);
>
> There were/are compilers that optimize the bar NULL pointer check away,
> because bar has already been de-referenced.

Sorry, I do not get your example. If bar is NULL,
| void *foo = bar->baz;
would segfault and thus the check is not reached.

If bar is not NULL, the check succeeds.

In both cases, the return statement of the if branch is never
executed making this some dead code. So I do not see why this is
an issue if the compiler removes it.


Yours sincerely,
Vincent Mailhol
