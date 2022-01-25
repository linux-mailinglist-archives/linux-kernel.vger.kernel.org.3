Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 073DC49B773
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 16:19:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346984AbiAYPSS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 10:18:18 -0500
Received: from sonic303-24.consmr.mail.gq1.yahoo.com ([98.137.64.205]:40827
        "EHLO sonic303-24.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1359359AbiAYPPx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 10:15:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.ca; s=s2048; t=1643123750; bh=W1FnFYdavyQlYiM/uuwdQDRcOc93SjxE81qWWEYe6Ng=; h=Date:From:Subject:To:Cc:References:In-Reply-To:From:Subject:Reply-To; b=Rhd8KojzEurxfg73PMC4sbMKIsU1JGde39XPt3zJRmZwvFiHackvzQlRcYmtrLPEdGOVLwdY/6GslG9HTu/j8Omz9R3tw9feYyfY06BDZAREKVtuwQU/Dwsf1hKJqInAdHfjtaKlN9GT7JhWIwosewbEdGNJPTuoWTvBq8Ixj5DG83FrwKuJFBQqb4EIGWXzwb4g6vJqyHwCZYop7ieacJZQ7rRKtgvNp8BQFr0pZa432WEpTcMgfvV47g84Y/cjqujxQ0VCFJ08didh5PonSwNxXKFdrL/zKQp+u6iPwX4leysxkF/IKgdM2rkCY+IuwPmZk7FCuyQi2ggo1o+woA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1643123750; bh=Tvc5KMN89e/YUtEJzf53mfd2o5IbWQBRFwtLDH154x5=; h=X-Sonic-MF:Date:From:Subject:To:From:Subject; b=X6UMNPbG+ezRpZ7MpggDt1m06MN97HpNrZHh5jbWSyz6Q8tQg+3rU47iloQBw3JUI/N554gAnqy5WY60AIVFGWFj1lYM+ODNHIJaZw6gelCOCUlRIYLCFoNHWMnCJp3OT1GnIkEzqdzZO30YcxiSm5QpMAbr1wDXrqHMoXSameU7MQux+WcfM2a8jo4vXr2dpI5yksVGCn8OEBgh8DC/fegX2vjGzUgyyG+A1e8glL5Gsdeos2uoYVJwA1K27jfsJWmZPM84iFkP+AOo22YPpLKwvGg+ZCKISW60DZHkP61s79cLADHW4Z5nnZFy7oMJO8zqfHQY8TgPAiNHINv61w==
X-YMail-OSG: IWs0ZA0VM1k4fOZG7KdkFi2uwbleyk1Je1HFy04MFHxqyT6K.Ai4hb1LI_P78X8
 Zidc8kBt.oXGjigqjnr9JFhRt_MVc210InpqlSu71MHl3ESl4aIL51gHWklmlKm1gAzddz_vMVLD
 Wba.X0S80fuxWcpN5iDkheZUKKTHBURybHiHIqTq4qaoJLrMtNt.mKJEvfeRej5leVvUUP6QLieN
 LE9ZSpSfKXdML_QLpqVnk9HQhFJmlR4oHHFuj.1QUEIMFHsvBkdyzyLrxuDGV.Vwc2LCFgUnGf_5
 WmgL2j5cKCbD6YQwDOCH_BsJyIYWk8sFUV5mnfS.oq0xiGAczKw4iv1YHB6oU6vviXk6VNKa9ame
 9ldd7x5IGEMq7d5TMyENYTr1GHnczk_6sEumozdfH4z4edJxIco21RTkhjic0suI8TJMCj_BvXAt
 W0Uw2goYzzpPYTCkNaTzqCJL5WMGdFDU1hFb8kU15VU_oucYUx2vNk87WgN5uGFuygpwr.KLfVAE
 i0COMtAeLTDod0Rf0rbbq7AyLac0DYMpk_QLpVrHbNG0XVC4g0PpfsMWwkP.P6Ly4Iu4otvZPmeg
 OmUM._XY558EbrcxKdotfbDFQBVvOM1qyj0SS2QK40Z6QWqTlWVid2qEM5GoIR9qqur.9o0FYn1I
 3iviTdks9pWA4mhxZes5GHWwhEixSAllR4y3usRCwmmRmyvgg8HdXdRHQciJG64ESRLsXT5MwaNZ
 mAMwmteJycCWqIxdSr9L3DtRAchl56_GHuLWR6RjwB9bt4WYm9w5PSU5IBlcMQaCbeo3TUby2KXD
 jvdqviecBIvhBQea_F2gcWv_4VNjiTvRPBNitvaS4M7dRGQleCq8tsBE126oNfjhTCBmSygNf0C4
 MGyv8hR5xNU0eZYJjLntb4tNtXhJRczYEDRtWsy1jwJxdmXhcyaF05UKW04yRa.tFUVecPjZmgbV
 8Y8ZqiT0oExdpstuOVRjiAms7z6Ttqt93J2vxHfJAupN.3bxYR84t4CEK4X1ob0HVkvI0ZN2.clz
 bx9eqVp_QPeAJ1.NkOonTNp5h0TfCGGlW8Ixr66vHmEUZZFynbiemotxP1pBet981axp5ZuBAxN0
 pwvqBbBK50Vc2oYzyk8iqEG8BP8F7U20lUuvXNlca5kU8OKtBot4EIQNLrIqtrucWbf2x7AnpHP_
 3CJettKRv54QfHeKFkTKzU98u.8CEbK6QCaji2QuzL4JB.EJ2K1n_DQGLpJledCmr_mYRAdu8vqg
 ztgtuyPQOmDwD5Bb4N9R8mPYDkyO2fYoP._RRzgevIm.t2fuBe8A0ISYetu7DEE1WrnoFX7.a95R
 3CHjJOOqqNpeUz0Hc9xp3ydVF6m0RqqZ3r3_Az6ebvOoYH0ckawuRwKL5CQ9fk3BVgaCwnJLc1xd
 eWZ9t7P6_odrXpE2i4KhoqZOiSKRVT.xvLZCmcHh9c6GMb0j1neueztL6KVftzs0XddXx4xM4coO
 97_hV5kRg83rhwyn7t3L.xa63AIPiFyTpOrUmegrTHAcxFExsk_m921N7LOI1.VtdkbiisGeNL_P
 7Ar7n7YFK0yNG4Oscc_a5DnUAhFzFNqMSKQ2Xn59A58_QOyl1JEZFlJCwtBIHGwdlLKOrMg8D5ai
 T5iyGgbph2eYdvYCr7J471akVv2QFGdvAkUsnqv9W98rGmxhQGdoV79i7olJhCqwwNimO4np8gl1
 rS6Ub7bGqGf46OfFw_ab1ExR6Fw8.VMnSXg2KkAtLKbedTeyyGz3IlKhM_e7QXs.b5hPfZxzdF1k
 ObD.Go.U2dXqDz.UJzCx2..YnI8TEMTWA9W7SJb4TKjaQKbp2dzDZ3Jx8jwzH7mzpiFQziCrC99p
 yvZoCNrYENFWsGzAlHw6lbogERBmV6zJLZtQcaO7qiaHZJRf2MkDkcsD99o0FT0puYi5nF1kwNY4
 IAiYyUCS_eBjIVZ0L_2Ke.6kXkxZ3g0oPZlJtkNy1UMLGqseySc0pWEs45cn5Qw5xeymGUnw6PL8
 L9se5n7WsHYPGfLtA5038hAP0NvwOXtX1bVjkoOBP24_2lzVMGzgLcZLgpogbSW_bgArvfL7.9Ly
 ae8qdHr0HdJTgkBjM2zXTI9JfNYR5wGRyhhvHWrQx1SbPopzyb0JOvAsEjUJSOlgsRCeR3Jd7Q0d
 wyWX1z9rxTTBLY6G9aONzXQN1NGp6.12ZhY.77hFQe6s7MwHhmpceZ0FgPbXbpNUUAfafSvLgavl
 8eLeLs5zCO4GUz6L_IJJV9kzRbV2JQgJly.ziaTNVNms6BE2dHXMndXEudkeMs7L6wmLI9tRdp74
 r8SwLitxGeEFU39a0
X-Sonic-MF: <alex_y_xu@yahoo.ca>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic303.consmr.mail.gq1.yahoo.com with HTTP; Tue, 25 Jan 2022 15:15:50 +0000
Received: by kubenode523.mail-prod1.omega.bf1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 12639cd08c3790f326dd7cfd6ce75ecb;
          Tue, 25 Jan 2022 15:15:45 +0000 (UTC)
Date:   Tue, 25 Jan 2022 10:15:41 -0500
From:   "Alex Xu (Hello71)" <alex_y_xu@yahoo.ca>
Subject: Re: "blk-mq: fix tag_get wait task can't be awakened" causes hangs
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        axboe@kernel.dk, linux-block@vger.kernel.org,
        QiuLaibin <qiulaibin@huawei.com>
Cc:     akpm@linux-foundation.org, bvanassche@acm.org, hare@suse.de,
        john.garry@huawei.com, linux-kernel@vger.kernel.org,
        martin.petersen@oracle.com, ming.lei@redhat.com,
        Daniel Palmer <daniel@0x0f.com>
References: <1643040870.3bwvk3sis4.none.ref@localhost>
        <1643040870.3bwvk3sis4.none@localhost>
        <78cafe94-a787-e006-8851-69906f0c2128@huawei.com>
In-Reply-To: <78cafe94-a787-e006-8851-69906f0c2128@huawei.com>
MIME-Version: 1.0
Message-Id: <1643123281.zt4edu32d8.none@localhost>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailer: WebService/1.1.19615 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Excerpts from QiuLaibin's message of January 24, 2022 11:08 pm:
> Hi Alex
>=20
> 1=E3=80=81Please help to import this structure:
>=20
> blk_mq_tags <=3D request_queue->blk_mq_hw_ctx->blk_mq_tags

I don't understand what you mean.

> If there is no kernel dump, help to see the value of
>=20
> cat /sys/block/sda/mq/0/nr_tags
>                 __ <=3D Change it to the problem device

The affected device returns 1. My understanding is that mq does not work=20
with legacy non-UAS devices.

> And how many block devices in total by lsblk.

My device topology roughly looks like:

NAME        MAJ:MIN RM   SIZE RO TYPE  MOUNTPOINTS
sda           8:0    0 [snip]  0 disk
=E2=94=9C=E2=94=80sda1        8:1    0 [snip]  0 part
=E2=94=9C=E2=94=80sda2        8:2    0 [snip]  0 part
=E2=94=94=E2=94=80sda3        8:3    0 [snip]  0 part
sdb           8:16   0 [snip]  0 disk
=E2=94=9C=E2=94=80sdb1        8:17   0 [snip]  0 part
=E2=94=9C=E2=94=80sdb2        8:18   0 [snip]  0 part
=E2=94=9C=E2=94=80sdb3        8:19   0 [snip]  0 part
=E2=94=94=E2=94=80sdb4        8:20   0 [snip]  0 part
sdc           8:32   1 [snip]  0 disk
=E2=94=9C=E2=94=80sdc1        8:33   1 [snip]  0 part
=E2=94=94=E2=94=80sdc2        8:34   1 [snip]  0 part
nvme0n1     259:0    0 [snip]  0 disk
=E2=94=9C=E2=94=80nvme0n1p1 259:1    0 [snip]  0 part
=E2=94=94=E2=94=80nvme0n1p2 259:2    0 [snip]  0 part
  =E2=94=94=E2=94=80root    254:0    0 [snip]  0 crypt /

> 2=E3=80=81Please describe in detail how to reproduce the issue,

1. Plug in the device.
2. Execute Show Blocked Tasks. udev is stuck.

> And what type of USB device?

It is a cheap unbranded USB flash drive.

> 3=E3=80=81Please help to try the attachment patch and see if it can be re=
produced.

From a quick test, it appears to resolve the issue.

> Thanks.

Cheers,
Alex.
