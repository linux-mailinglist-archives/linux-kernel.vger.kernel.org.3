Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9079D561A94
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 14:43:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234719AbiF3Mns (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 08:43:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230099AbiF3Mnp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 08:43:45 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77034167D1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 05:43:44 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id a15so18012673pfv.13
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 05:43:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=W7/sSIArA5vCU+4KRemTxV8HSmhG5DT2XBNoW9AstXY=;
        b=vLqN0wB6DTGnBihe4yi3WrwwkWXWc5WUgrNtQ64rXpagC/OynSrfv3k/RccHONXbaV
         5lCaLtelLoYegNsi5mVuBeJ/yC9DBBrJ3Rg3qzZzfaKlqWc+ZC6tiDVq25eT4nvS3uU8
         IxhU4XTYi3NstizUARLlii4W8eFhTb/t5E6TqmCyyJqYAKa5y2ROSiIYF2DKxguIEdnL
         mXqcPMoypk2XK9qNEc1r2QP7/cPBDhGGknTy/tu4wNWQZbEoiMJgKxvu157+0MU7jwOh
         60rYWnWnRPxG41zLQCKxVaEgbj0saViXiFXDzLEjL1+oKehz5z8BdjfSR9YJe5omcdIe
         30ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=W7/sSIArA5vCU+4KRemTxV8HSmhG5DT2XBNoW9AstXY=;
        b=1LVazuDPF3eX9EXBD+FyCB3OfPb8JJ5KjSZS7+MlXdBtPbrPfQoL+7j8NgqWsoQwN/
         jQUi/3fo/gCaXQ+xVmrBmnfLfthpJeCrsDaN4E+lQcveYQqIqorHcoOnvVm0/v7BsRwf
         wSLT1PomPfMURMksoPOQKzquDXuDPRNHHqGybkI3Gtsc0lv54ljX7KV2P3Z4+skc+QX1
         2Zo2TFwir6xuT/dPU3DDK5rOBbrBygrQXRN66jbyZzesu9lr4N3KCDBsqZ8O2zXVYf3/
         hLMRo032m4RKvc1NtHy7m444eDPaqHGkGgrIdD9ICS11hJTd+hPU0Df0qliRtO8SSDyY
         uaUA==
X-Gm-Message-State: AJIora/5VG8CEFMae8feOzgoybkBpYxW2oh5vMHCiw+t/XikYaUHOIZp
        z9PIh4J0SwiGzclgIgbCk4Rzrw==
X-Google-Smtp-Source: AGRyM1u4SDVJ5azQwo2Bji18JFjd0ARXj6QJkSJAARnBHs3CfpMglQDlXsWgxmuhV3MT5/c0TUB9fg==
X-Received: by 2002:a05:6a00:17a8:b0:525:537a:b0df with SMTP id s40-20020a056a0017a800b00525537ab0dfmr15544935pfg.71.1656593023974;
        Thu, 30 Jun 2022 05:43:43 -0700 (PDT)
Received: from [10.76.43.148] ([61.120.150.78])
        by smtp.gmail.com with ESMTPSA id jj22-20020a170903049600b001674d61c1c6sm13225370plb.272.2022.06.30.05.43.40
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Jun 2022 05:43:43 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: Re: [PATCH v2 0/4] virtio-crypto: support ECDSA algorithm
From:   Lei He <helei.sig11@bytedance.com>
In-Reply-To: <Yr1xa4twKn3qFAt9@redhat.com>
Date:   Thu, 30 Jun 2022 20:43:37 +0800
Cc:     Lei He <helei.sig11@bytedance.com>,
        Herbert Xu <herbert@gondor.apana.org.au>, davem@davemloft.net,
        dhowells@redhat.com, "Michael S. Tsirkin" <mst@redhat.com>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        pizhenwei@bytedance.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <E4378D78-C22D-44E7-9490-E31E35286C59@bytedance.com>
References: <20220623070550.82053-1-helei.sig11@bytedance.com>
 <Yr1JvG1aJUp4I/fP@gondor.apana.org.au>
 <C7191BC8-5BE0-47CB-A302-735BBD1CBED0@bytedance.com>
 <Yr1xa4twKn3qFAt9@redhat.com>
To:     =?utf-8?B?IkRhbmllbCBQLiBCZXJyYW5nw6ki?= <berrange@redhat.com>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Jun 30, 2022, at 5:48 PM, Daniel P. Berrang=C3=A9 =
<berrange@redhat.com> wrote:
>=20
> On Thu, Jun 30, 2022 at 03:23:39PM +0800, Lei He wrote:
>>=20
>>> On Jun 30, 2022, at 2:59 PM, Herbert Xu =
<herbert@gondor.apana.org.au> wrote:
>>>=20
>>> On Thu, Jun 23, 2022 at 03:05:46PM +0800, Lei He wrote:
>>>> From: lei he <helei.sig11@bytedance.com>
>>>>=20
>>>> This patch supports the ECDSA algorithm for virtio-crypto.
>>>=20
>>> Why is this necessary?
>>>=20
>>=20
>> The main purpose of this patch is to offload ECDSA computations to =
virtio-crypto dev.
>> We can modify the backend of virtio-crypto to allow hardware like =
Intel QAT cards to=20
>> perform the actual calculations, and user-space applications such as =
HTTPS server=20
>> can access those backend in a unified way(eg, keyctl_pk_xx syscall).
>>=20
>> Related works are also described in following patch series:
>> =
https://lwn.net/ml/linux-crypto/20220525090118.43403-1-helei.sig11@bytedan=
ce.com/
>=20
> IIUC, this link refers to testing performance of the RSA impl of
> virtio-crypto with a vhost-user backend, leveraging an Intel QAT
> device on the host. What's the status of that depolyment setup ?
> Is code for it published anywhere, and does it have dependancy on
> any kernel patches that are not yet posted and/or merged ? Does it
> cover both ECDSA and RSA yet, or still only RSA ?
>=20
> The QEMU backend part of the virtio-crypto support for ECDSA looks =
fine
> to merge, but obviously I'd like some positive sign that the kernel
> maintainers are willing to accept the guest driver side.
>=20

1. We have now been able to provide offload capability for nginx=E2=80=99s=
 TLS handshake in the virtual
machine(with the kctl-engine), and have achieved	about 0.8~0.9 =
times performance improvement.=20
But as you can see, when we were testing, both authentication and key =
exchange only supported=20
RSA at the moment.=20
2. The code for the QAT offload backend is not posted now, it does not =
support the ECDSA, so it also does not=20
depends on any other patches that have not been merged. To support =
ECDSA, this patch is required.
At present, I have only implemented and tested the ECDSA for the builtin =
backend, and the ECDSA support
for another backend that can offload is also in progress.

By the way,  the virtio part of QEMU( for support ECDSA)  is also ready, =
 I will post it soon.=
