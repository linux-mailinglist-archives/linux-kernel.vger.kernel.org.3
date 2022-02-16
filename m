Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8813C4B86EC
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 12:43:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232035AbiBPLnv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 06:43:51 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231810AbiBPLnu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 06:43:50 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F7546E347;
        Wed, 16 Feb 2022 03:43:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 900C3CE26A5;
        Wed, 16 Feb 2022 11:43:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8ECC9C340EC;
        Wed, 16 Feb 2022 11:43:34 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="LsSpo4WY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1645011811;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+TIK57YCWj0YL1rIP//XivfP7LrVK4qsS2scdF+CZvA=;
        b=LsSpo4WYNj+KxmirfIN5auxzuivYpBPPujiS2AfWZBnbVhHGsvNn5+92BzAt6gtADCmAJW
        zybq4MO9nacJLUVAdATMvLcoAOuYf3B9I7QQr8cExbxn98z6viHHtfX/prU+PTiM6AlePf
        IQdrt5EcT5LvLECmkvGnAAmeyF59ZV0=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id feb170be (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Wed, 16 Feb 2022 11:43:31 +0000 (UTC)
Received: by mail-yb1-f178.google.com with SMTP id l125so5213171ybl.4;
        Wed, 16 Feb 2022 03:43:30 -0800 (PST)
X-Gm-Message-State: AOAM530MBMIFvYi/YIKQYGBB3DIxCWzjUfpxMJEjtQZka28NJMes0K7k
        FVnsDeK3Iyw45yMKPJwUCRSCSwb9MZ40tzAqnBQ=
X-Google-Smtp-Source: ABdhPJyhcD+XSXq1FZOOph80BOoHwM3sAr9xAJAsCU5IyqDu8wgsMhiROpk1/ifefm7BC0PPK1911zn6Suql9HDv+R4=
X-Received: by 2002:a81:4405:0:b0:2d6:46c6:c9a5 with SMTP id
 r5-20020a814405000000b002d646c6c9a5mr2001455ywa.100.1645011809875; Wed, 16
 Feb 2022 03:43:29 -0800 (PST)
MIME-Version: 1.0
References: <20220213152522.816777-1-Jason@zx2c4.com> <8735klbrm5.fsf@tynnyri.adurom.net>
In-Reply-To: <8735klbrm5.fsf@tynnyri.adurom.net>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Wed, 16 Feb 2022 12:43:19 +0100
X-Gmail-Original-Message-ID: <CAHmME9rqe70NNWEpBJ7nUAUKiDYOFUpEnA+SoC4M=ySNp+muww@mail.gmail.com>
Message-ID: <CAHmME9rqe70NNWEpBJ7nUAUKiDYOFUpEnA+SoC4M=ySNp+muww@mail.gmail.com>
Subject: Re: [PATCH] random: pull add_hwgenerator_randomness() declaration
 into random.h
To:     Kalle Valo <kvalo@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Matt Mackall <mpm@selenic.com>,
        ath9k-devel <ath9k-devel@qca.qualcomm.com>,
        "Theodore Ts'o" <tytso@mit.edu>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kalle,

In light of https://lore.kernel.org/lkml/20220216113323.53332-1-Jason@zx2c4.com/
I'm going to drop the ath9k part of this patch here (and your Ack
along with it), so that there's no chance of merge conflict. It turns
out that the header that this patch added isn't 100% required because
it includes "hw.h" which includes <linux/if_ether.h> which includes
<linux/skbuff.h> which includes <linux/net.h> which includes
<linux/random.h>. So at least if there are a few commits between my
change going in and the driver rewrite from that other patch, the
build won't break.

Jason
