Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF59B49E472
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 15:17:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242275AbiA0ORK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 09:17:10 -0500
Received: from sonic310-21.consmr.mail.gq1.yahoo.com ([98.137.69.147]:33256
        "EHLO sonic310-21.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237629AbiA0ORI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 09:17:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.ca; s=s2048; t=1643293027; bh=2sqdVYJJNHUIUlV8xWrYxqVRhithPZ//JCLncfzo9Tk=; h=Date:From:Subject:To:Cc:References:In-Reply-To:From:Subject:Reply-To; b=cASN5ei2KF/CqAF7lTVHTeWiQKcpREJEocPk+AUAHkUfp5mk9bTKFwbThMz1sXsrahuuDQtx1crv9JljgVaGAShzuaD23gcrDat/FfNsmwO+1ElnuGAz9IJKDkw0PI/r4qAOyh2PM9LYO77F/7Zi2lY5C8yASVrxCRFL+cp3+Gb0wlu0O1UuJ/MOK5RRCVW7LtBYUe6qHahFr4INAJPRJbnMTHeDmWBk6JPGUrf8vLpW/O4xK0E0Ow191AgIbaS0Hj5IpgreqLMZ1wEQzIjqiRWwOkuVY/3s++ULC5UvzObcAzxQqBnWgRWFGYL/3xYqf/Z1cmq5F9tilDm4DYEdlw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1643293027; bh=q7kPC74pgUiSATKngTVI/KN+eHAtjqcn+fYpV/Z12ZE=; h=X-Sonic-MF:Date:From:Subject:To:From:Subject; b=uI43mbn/KgbRdN8iNNWW93A/62lKMEgdRWIcEBMAOQ5pVAjCBzKGQKZ0/1Pc3oIH4ndoVmeP9gS9a2z75lXOIVf0dA0UHJGmDGRj2lGf51/rmiU7rn7vNmh6xXNer2Y3hwxZSqD/4i5ZaJDKJkoInvAvvxpMU89yI6W8ezoy2gXuMtq+JUp9qhGrRvgVFBwjWt+p7nrOIES/zlp8bWDD6WK3f3idbbEcq6xxFS0Lqhgab00AJszefDRykUVS3NBGMkFduVSUKpRflEQesyQAL/VawZXiuE9UbCuOlyCbMoblpwSOEDD6VYd8oJmfcXMs01CE14lCenGqEnvi7A83YQ==
X-YMail-OSG: .snubEUVM1lUIRTiu10T.b9C5A5ed3ir0cRYOMrRbe41jgqDCS4VoGqucnKwY_I
 RM5.l6.wcPSwohrXVdfSXX7ocrQ3gGEpqm0gTyeQSeSkheldo.EWoIaQyYqVxAzbpSL3pqzfHh.7
 iF_ntOg604WN5x8klXgjI0Gs9e4FKeg9NgY.OSPlfVMv9pRSkokBVMBb.1czS5iogOi.xA0aIohs
 Q.hFH.uJjWHWp7phVO6CRfTsF85nADDtOrOMzrL1umveGxJiHxLuuRNTpdk1.8QP.xRrFtZ5H5Od
 jCTmRIS8YX82iKO8jiHfEzfkV6C1ShBXTr__tKS3JQ.iIlc2vimzjEPo2a9.LenteIhzJK3U_nk3
 1h6DrKuA6Yu65A_9jUPv6IFN7nXNjD6LIC72GU7dc3yYk9r1cuUkcejdV4sW_Y3xddUhV63uy789
 cAygSXaYjBwPxo_KGO2hKHBNd.0adS_wvcVa0ksSiSm5MTuF.yYAwF63JXRrzutvRZqf8DQe2bd0
 lI9E5EXEKPmwz2Id42MCnyyZU_zwe5w7MIjL2ZLwezA8OItlgv6NQx57n_g2JnQHkBRIUfxXKiz4
 cc5oR6RtU7nA4tZ._KRKyU2pprzFd0opnyLAtMrUpoMMGL2RmWvhoPvDdXhaoHZRedW6pkCaW7Mr
 qIQEzYydr17IDMFOLzgdcXjdeWIHGWydkO4z4OiJT56mohtRcy9H8egVjMHM3OuZCNDP7HpwURaF
 49oqqmD7wMLSfCv6R3rojmPOMUWG.vla.lkwgq_yU5vv1gfAKMn639cPeBPEDhzHezoJ3Ut.WSQC
 3uMTyegFb8F2NKoznwU668vR1lQSh8Dm5i4DRhauaKWjwYTStePagMYUoDYQKbHGOGe.YDgTkEsp
 jt7qjMG.Aji3j5WIPwtHz3KKq3pVo2vPmYHNTezsu5O2_A9MysRDsrgIFdSzO1KMSm.wsAa659ab
 r4ruvDjquevbK6DXiWAPbzcMnQW.y0WoO7vff6Me4HS6H1Q8EsVyz4_VaTonYZ8seUnmBB09y.bP
 t8jxWaVcaDWHLP07v7nyVASuYhp1MymNl9d2mRyjOyfFOBmDE4D9LymTQpntH90DQwn8vmBMLg4C
 nsCyRHFS4evkXtCsffH2dAl9wozW1K.Pq1E7rb9rC6FLed6qAb0wOgvVyKg33uCp7svbqQOo6dYB
 OsHilvOzCpqDC.c6QrDmPEVaGrn2TymQwJLEVxUSwGUZ.akPap08.fruEFnufoBvrHQENiynOfYN
 doVS04fHw6xdEpWCBqWic6XZxIqGTNJwYwcch6L2wuM7uvrdM1iFmDFck4OjH8hcUjrtjtu5y7jQ
 yFAwRDwUzUoaFjvzRUmDRw8n3DSgsQvbOUW8maL7IJUmNuOWSpigPAK3I01UX6imJMo6pBUTQXRj
 CyR3ForT1qvE.gKOgJhq4otJHrcezLGQPCt86oLSdB9VklvvgVlQFiWHnsaD9xJ5R9qL2ckxorER
 QfKXQngx3R0qpGWidgByeh9qWB6UrdfXcCCma8NNmv4NmWjHSWMQLlHizsPDiB9.9CtshTx0EOAZ
 J8xLH05Sv1jbXH7.1OqmKZUdtRdmQjAzSHltZRDMYr3crHc.w82NA_hHu3PwKRH0X8HBkWSeTiKT
 jDCuQzv8ZeUd9IYhep5dktwWWjPviKbqYB4DKfLe9XRp92C7.1ovo6wyaSWJA.nG.sWfjMUfbTwR
 h..ALD0m3ObbPPBfFJUdJUsyipZtHpAVDnJE6FeJJHPoi0vwoylpihu_S1HgeTGOIphWeb_Akm5W
 9JMfJ8BATT28vdwqOCRRrUnw_us0eKmv195ovjabwoB6ywDm19f0T7dkaR4yrHaXkIMdbMJppAos
 DsV0K2E3Kn8C2YDYpYZwnUkoSiYZ5WPcXK51DDy6JsMJY7OBRzLKAeOvjggO4d8vGKG6JzVwqWfV
 5wffF5GEBf2PYZtgHaNZFP7W4tFAoHh50DnfJW1wBqj05N75Cx2rO41ASuaoO9umx5GnsASMa.2b
 ZxX2ny.jj7EjpuLGvTn95mYUxgTeTcDSa93G_.P9vC.2N9q5Nm9HJNx9rZjTrYPodtfNRNdgL5Lh
 hy9sEe2yBNLGBPUUXy399CcIQZw2v_JdthJkimLNfwyM1Mr75awR.6K2Mp3REqoeCw.rq3ZqdGYR
 UN_TeHF5zrJmhFWOXWe8Yh5gUjSegwtrYx.4poZA18yVQL7..2tLwPosB70mFz2c5DcaJM7mm2VS
 9vrCBWBA2NjqTGoN1n0MF2SVDyHGLq7Gtc.JN.97VPvqnNKk.063ra_KE4vniwsDvmcY-
X-Sonic-MF: <alex_y_xu@yahoo.ca>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.gq1.yahoo.com with HTTP; Thu, 27 Jan 2022 14:17:07 +0000
Received: by kubenode507.mail-prod1.omega.bf1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 842dd01262e5d9e11c39c1ae79860056;
          Thu, 27 Jan 2022 14:17:05 +0000 (UTC)
Date:   Thu, 27 Jan 2022 09:17:01 -0500
From:   "Alex Xu (Hello71)" <alex_y_xu@yahoo.ca>
Subject: Re: [PATCH -next] blk-mq: Fix wrong wakeup batch configuration which
 will cause hang
To:     andriy.shevchenko@linux.intel.com, axboe@kernel.dk,
        Laibin Qiu <qiulaibin@huawei.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220127100047.1763746-1-qiulaibin@huawei.com>
In-Reply-To: <20220127100047.1763746-1-qiulaibin@huawei.com>
MIME-Version: 1.0
Message-Id: <1643292980.cunltl8w6q.none@localhost>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailer: WebService/1.1.19615 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Excerpts from Laibin Qiu's message of January 27, 2022 5:00 am:
> Commit 180dccb0dba4f ("blk-mq: fix tag_get wait task can't be
> awakened") will recalculating wake_batch when inc or dec active_queues
> to avoid wake_batch is > hctx_max_depth. At the same time, in order to
> not affect performance as much as possible, the minimum wakeup batch is
> set to 4. But when the QD is small (such as QD=3D1), if inc or dec
> active_queues will increase wakeup batch, which will lead to hang.
>=20
> Fix this problem with the following strategies:
> QD          :  >=3D 32 | < 32
> ---------------------------------
> wakeup batch:  8~4   | 3~1
>=20
> Fixes: 180dccb0dba4f ("blk-mq: fix tag_get wait task can't be awakened")
> Link: https://lore.kernel.org/linux-block/78cafe94-a787-e006-8851-69906f0=
c2128@huawei.com/T/#t
> Reported-by: Alex Xu (Hello71) <alex_y_xu@yahoo.ca>
> Signed-off-by: Laibin Qiu <qiulaibin@huawei.com>
> ---
>  lib/sbitmap.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>=20
> diff --git a/lib/sbitmap.c b/lib/sbitmap.c
> index 6220fa67fb7e..09d293c30fd2 100644
> --- a/lib/sbitmap.c
> +++ b/lib/sbitmap.c
> @@ -488,9 +488,13 @@ void sbitmap_queue_recalculate_wake_batch(struct sbi=
tmap_queue *sbq,
>  					    unsigned int users)
>  {
>  	unsigned int wake_batch;
> +	unsigned int min_batch;
> +	unsigned int depth =3D (sbq->sb.depth + users - 1) / users;
> =20
> -	wake_batch =3D clamp_val((sbq->sb.depth + users - 1) /
> -			users, 4, SBQ_WAKE_BATCH);
> +	min_batch =3D sbq->sb.depth >=3D (4 * SBQ_WAIT_QUEUES) ? 4 : 1;
> +
> +	wake_batch =3D clamp_val(depth / SBQ_WAIT_QUEUES,
> +			min_batch, SBQ_WAKE_BATCH);
>  	__sbitmap_queue_update_wake_batch(sbq, wake_batch);
>  }
>  EXPORT_SYMBOL_GPL(sbitmap_queue_recalculate_wake_batch);
> --=20
> 2.22.0
>=20
>=20

Tested-by: Alex Xu (Hello71) <alex_y_xu@yahoo.ca>
