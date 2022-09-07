Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5BFE5AFD7A
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 09:27:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229630AbiIGH1w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 03:27:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbiIGH1t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 03:27:49 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFD6098599;
        Wed,  7 Sep 2022 00:27:48 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id 130so14705461ybz.9;
        Wed, 07 Sep 2022 00:27:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date;
        bh=a+qBpx2zVHwONpDZbD5IdP7xuHp6gJRVMjL0HK11eCc=;
        b=Vfsv8IJLXJe8qQbEGn6v9olTMB+mhbCGqwOnHlTuL0Kg0t+s25/6EWcxhjcrl1h81Y
         TI9zTX/mzZkKGmUM5vsdJdv0PKOEvK+ee2GSbszDzxfshngq/FirGjjRdJ+JExX7UgRO
         0EM6b1Y4IEjI01C1PgzTYFNlcnHjQkmE/xLi+tAXXdJorliG8E9LVMFNeXUCatJX2RKu
         HFBvB7MNvGdBhH1Jhglvpfws1Deu5geKhcy8lFNCQcGD05srmM9vkYri7GJ8pFmPlDWt
         FJV7I/9G+VO+TP2VKtog1G2XLvWeCWx7LtKjD3dKMzrb34lZJWPi9R0+4VJbcqDBxqsx
         NW7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date;
        bh=a+qBpx2zVHwONpDZbD5IdP7xuHp6gJRVMjL0HK11eCc=;
        b=7pC8S3ostXEdChx7F0KAQLXfnavnX1kLudB3hSPdasQqyeljxbSxtxxFr2uxCBIz/g
         V1qbUEsXAPb/ucltzgOKPgC/osLsCPvmLkBIfA2LuUvTfNbLufubAk/Magp4K+3Fxzgb
         s2PYa3TXPVbYCJvsQd8JWXjs1rm7QcbeggB5y7Od1uvQkKFLEgBHfpeBE4ELnVu6w7N7
         My/US/5TlbC5N3LFdt0zsfWwewQID6NYCQNrciVK4kjnWQAA8SEfwhK1V78ot/Y56+il
         xNi5fS+y4BlXa0tSVccgOyhiws6ut8uEWmFXQM9ejhfw1OHwvjCygSJivZIvOW+2vufD
         bzHQ==
X-Gm-Message-State: ACgBeo0rQdj99ih2RROOsySA+F1HGnCCxRwnD3zelF+p7pwHsELK8SNv
        o7zCZhd4Z6EZYGAyaXvRPx0s9nyZi/NQz5425KGsj4iXalY=
X-Google-Smtp-Source: AA6agR6bWsKAX8wywSDR5EaRlLALwVwMtbm5EibP7NPM527LIY8amu7kDIwVd+txvYEusi3TgNRQEFNVFf7YpfiPkoE=
X-Received: by 2002:a25:d3c6:0:b0:6ac:c87f:3dd2 with SMTP id
 e189-20020a25d3c6000000b006acc87f3dd2mr1249956ybf.389.1662535667950; Wed, 07
 Sep 2022 00:27:47 -0700 (PDT)
MIME-Version: 1.0
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date:   Wed, 7 Sep 2022 09:27:37 +0200
Message-ID: <CAKXUXMyMUNgra_B47Qk3kjqgmR-FcCbDpEZMH5rv=whrQDRQww@mail.gmail.com>
Subject: Accidental config renaming in commit 3f342a23257d ("crypto: Kconfig -
 simplify hash entries")
To:     Robert Elliott <elliott@hpe.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        linux-crypto@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

Dear Robert,

I noticed that:

Commit 3f342a23257d ("crypto: Kconfig - simplify hash entries") makes
a lot of changes to the config descriptions, but among all those
changes, it also renames CRYPTO_SHA1_ARM64_CE to CRYPTO_SHA1_ARM64.

Given that you did not touch the corresponding Makefile, it seems that
this config renaming was unintended and accidentally.

Could you please confirm that?

Best regards,

Lukas
