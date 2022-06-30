Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95B7256132A
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 09:24:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229864AbiF3HXu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 03:23:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229676AbiF3HXs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 03:23:48 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DF352AE13
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 00:23:47 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id m14so16274990plg.5
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 00:23:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=kPj3DJDPahvvDxF0DURO3tVx6ujFEvydZkmaEtn28Rg=;
        b=QaORBQDDJbzqP4G6eVt9wELj+P4mgfHQNbLnVJgBIr0oOT2IpfcB69NR4a8tF0lLlm
         xIo3PekLAOXHFpK5nvAyRJ9SFX7IncdUll2plBAhu2VUIzOxIjU2WrVQR3g0J/Q1G+XP
         E1XgCr4X7QjaSDCnQhaDjlU6yqNeqktMMAeBVqXDzofKyQJysj/hjACRLJdcCYZyMLNA
         HSME5+ytZjhdNCmisSCGj6yLEPy/G1qRQutlUhWqBu/QxP5DzHZuzkXWsJj0wKI3DRKq
         dHBSe4L7BjyKabfr4OV1WLA4Q1ifFMQpKL7gOZc9zPHNRUn19foJrvOGYg6ISHcA//4H
         qvaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=kPj3DJDPahvvDxF0DURO3tVx6ujFEvydZkmaEtn28Rg=;
        b=prUKfkPMbpML+963jxPIXTmdyAPzaZJhpm7h7F3dgfjeasTzwD47oV2UixDjcy2592
         Dw+RxAx06LkSwHk3FeEu5qKKedbKE+seEuNeJRC+QrerAO8jKzotLwCXTHW5zNcCe8PB
         5YScQN7lQqOgyi8+xcpTxb5cIqiUcPm6V6ueXp9Mf9H3sHlH2zAvICmdecWfzIkW3vYG
         EY+A7MisviQ0htx/otAHcOBl0kXI+B83p/gXEXJv7Ub4xJ3czYY9BjcTwKCp6L6vTPQZ
         fvTdwlALPzffiZL/u4pHmbQygujI0eF36+0UdJ/+A1E4kcQFK+8pkDEGJB7GvX3bRLu8
         CcwA==
X-Gm-Message-State: AJIora/io8DMQKC0wgwTSXh5+y7h1Y6EVittd94tyJXRNnRv7oCYw9o9
        hDSJd0RSOF2/NbKEkMH2Q5rtBK9s5dMRFA==
X-Google-Smtp-Source: AGRyM1vf2H5neloO5d3aKoFxRUFceQx95p3IxJsndYQCU7U17oceCA7Hfne4ZjMjm8r2qoDz4TLHiQ==
X-Received: by 2002:a17:902:d706:b0:16b:960e:e689 with SMTP id w6-20020a170902d70600b0016b960ee689mr10659856ply.24.1656573827047;
        Thu, 30 Jun 2022 00:23:47 -0700 (PDT)
Received: from ?IPv6:fdbd:ff1:ce00:422:15e6:97a:66d6:17ac? ([2404:9dc0:cd01::a])
        by smtp.gmail.com with ESMTPSA id q13-20020aa7960d000000b00525161431f5sm12758307pfg.36.2022.06.30.00.23.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Jun 2022 00:23:46 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: Re: [External] [PATCH v2 0/4] virtio-crypto: support ECDSA algorithm
From:   Lei He <helei.sig11@bytedance.com>
In-Reply-To: <Yr1JvG1aJUp4I/fP@gondor.apana.org.au>
Date:   Thu, 30 Jun 2022 15:23:39 +0800
Cc:     Lei He <helei.sig11@bytedance.com>, davem@davemloft.net,
        dhowells@redhat.com, "Michael S. Tsirkin" <mst@redhat.com>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        berrange@redhat.com, pizhenwei@bytedance.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <C7191BC8-5BE0-47CB-A302-735BBD1CBED0@bytedance.com>
References: <20220623070550.82053-1-helei.sig11@bytedance.com>
 <Yr1JvG1aJUp4I/fP@gondor.apana.org.au>
To:     Herbert Xu <herbert@gondor.apana.org.au>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On Jun 30, 2022, at 2:59 PM, Herbert Xu <herbert@gondor.apana.org.au> =
wrote:
>=20
> On Thu, Jun 23, 2022 at 03:05:46PM +0800, Lei He wrote:
>> From: lei he <helei.sig11@bytedance.com>
>>=20
>> This patch supports the ECDSA algorithm for virtio-crypto.
>=20
> Why is this necessary?
>=20

The main purpose of this patch is to offload ECDSA computations to =
virtio-crypto dev.
We can modify the backend of virtio-crypto to allow hardware like Intel =
QAT cards to=20
perform the actual calculations, and user-space applications such as =
HTTPS server=20
can access those backend in a unified way(eg, keyctl_pk_xx syscall).

Related works are also described in following patch series:
=
https://lwn.net/ml/linux-crypto/20220525090118.43403-1-helei.sig11@bytedan=
ce.com/

> Thanks,
> --=20
> Email: Herbert Xu <herbert@gondor.apana.org.au>
> Home Page: http://gondor.apana.org.au/~herbert/
> PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

