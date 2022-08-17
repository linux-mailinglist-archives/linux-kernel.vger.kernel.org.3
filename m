Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2289B596CE8
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 12:42:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235296AbiHQKj1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 06:39:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233736AbiHQKjY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 06:39:24 -0400
Received: from sonic304-23.consmr.mail.ne1.yahoo.com (sonic304-23.consmr.mail.ne1.yahoo.com [66.163.191.149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 238802A736
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 03:39:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=att.net; s=s1024; t=1660732763; bh=OgPrHThNWBuXwsdxCrrp2vWXxxgoK2qPwBix26o3c88=; h=Date:From:Subject:To:References:From:Subject:Reply-To; b=elliI7h+N4Zz3ArwywwdZXSY+5hrNG0iVzr9w3OaXT0JFWACP1VcKujg7attqjExZrUehd+VzsnUvQ7nfiQoBth8YbxL11Y8788WoTXnjQnpPGJb2+e6TCvPWTc2CoREJC6/pWALRuGy63iJNmlphxj0JJG4RuCHk9ZD3jm6bvU=
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1660732763; bh=9HHAEnozu/vVuF4O0LZteMJnyV52V38TfbxqQtQPZDZ=; h=X-Sonic-MF:Date:From:Subject:To:From:Subject; b=EvNObzDPJbJqQjenmBZZK2odOAdnieNL3GMTbt/wD2WG6BLyQFbd6j/tSpuwoUXTAyxmvFNjKvfiCz9ew7knqNTaKQYBRtsOGvjEtJXjQcNJcIxDzoqs8OuyTkYE8IlabHT1oxmhQSU5XxzLNO9eWoP14q0zjcUB39UVK5hUV9Y1CRDg/VvjlILyhAA5BvM5zD9fXG6tmw8npqXifh2yz33OiA2Y5xyEpKLYLUIKPrgRON+NodvLuUnnR1Vvf10t8H4ZqX2dXSTRdbsUrVTz2YWe7w/7/XIssWSaRGy9PrUdXRo8abE86UvNeeiYyKw6/+o9fTPR3VpkKvGOW2y4dw==
X-YMail-OSG: QF5noUQVM1lbehG1iSvUsZ8ZMbEojFSp5PayKIR5iWr45t_EWAjaSGodR0UBAfL
 vynPVyVWzfgYrmQfMMKpNT0Z2Gp..lLWV54AGeK.eTE6dIx7N_1IX9kmwKVzP4RhfjCfliLUC7IC
 u7B044BmFdRZK9Bisu8UlsId160IesDtl7NUvbn_oFkDgnrPWv774mSKaRk6lsUoHpX0vcadWJx.
 r0YqhsPUl9bihTPuRlrcT9eRVgttlvZKQQihsxBBJfE3H966rPTSPrtfhYHoZeDjyDwgDtqxN4ch
 Ds3R.UZapk6_4t480imPA0iVUNaxLTPiSrvgXK2BSvDSIuyOSiklzTunwFAUyaDUYus13Y6etAQi
 YgkKUbb0tE6_oLVWTzg.D.UZYTf.ltHS9M7TukpF_95SxSvsLG.o.fvcwjhqY7FVQtb7Kzf9OweN
 dbmmykHo_MYpjf6ZV0wkwoUj3dTvl9QKSCLOs4trPqA7Ofmn0zznFtUKMajmKS7hB8MJyi3V8tI0
 cngyDSlUe1mTYQitL_CChRDMJsslPpxU.T_jXk4hl3kGFvALSnkwlIH9cS0CT8qz._7BjZ14fbId
 ACjNeavMxGpfpH_TV.LReKeUifJTd7kn1vZacgGRGB8Ym4erS_CzHI5W0tWugWLyJG3DT9MDtQer
 .zbk6LUuSMQGkO9SVzkq5SHFqZPgWYzAciNENbQNSDQ3wv_4OCou7OTiwIDfzqdEqNM7XNOhBidd
 d5RDbduJLP.9VwtS1BnQ5UVLXaQVbA8w49AWC78os3ceqE3vG2RHjSLuKWucxFRhpKFyAtcFf5TJ
 valskMMC_Sfzr5Tm5I17J8aTeFmLW0sklfFGnnhgVjsY1GearzbsGXtxWpGFGka.5tg_P.aSNO2n
 GTD7M45vuSzn8IGdTf0kv0YjtkYnnUsKtZLWwnLQcVqHHlre84TmkTMxhwfrrjSn6XWqRbZFvcey
 mgHJM8PoAJfoqX5PSJuwYjM7bHKIKMiW_r.OIhcPVUMBJIWbdsTnTZf0hDXKELoFvff7ZUyQXewK
 GrJICDL3lr5AdeOuIRty4sSM2IlEvPoiQnRRWwSH8pq_oD5EsxxJp6Fw0HIgUNJBrgPOeqn3G.oy
 HEcBVaABvbqOR2Ynr9y9m9V3lvnekuQnFHhfmhvsCmUHhX78VsvYvwy2ehN9x5CHPm7ies4CDmwO
 vC654pPb9KzoF9Hz80pBgxEm29w.HloKuwem_W_zZuiB9lDsrsrkNQEmU71d9yoyiuTGVfTsrfqj
 qbqq681ByDsjf0RUafbF_5DpSkZFecXfS633c3ZuypyHWNNkv.HEpOKUaL8eD7.5RxQ7RxtBMnOU
 afdJKalfOLTocFfi.SpzoGAp3uXPR.wWr.xB5k4EnsQiAAOGbIkBQAR9EvEpTcp2zY8Px3CEg5w2
 v7.hzkkfKNLHEOnqtJTCI7JZjPLIP3RLNOR151Ps6HjdpVEo3cxG8K311hSizH3Jf8aJ4PcFE5Wl
 cqoVcCgYUCqmx7A1BPWA8x8UQRuG53n1L.tqXQmLQ6oCZk9ScinNpv3lxn_fzUOePvFQQEs55PNm
 aOIFHty0pOa1iR_fhVneb5STCTgHcQV6Cm3b8voro3sGPpEJ5_2HdRoC0Rx67YtfFEz93INLSEcl
 5CZfva.7crudG5_5bZtCtls96vAVv6_LIL17rPkQugQ8gEK584hNNky5yWgfcceRuKU1y.lTeOwC
 uScnjVqyP6Kf77YVvxmnlKCQ3NewQqiA5_0V.TPutJHe3nUcwkQ7oqq55GeZN3JPmAg2iCbD1bmN
 fPjQSlpTh6oONWj4vCdFfrey2VchTYSmp5Ne_.gLn7HnBFI_2TO4M9YhrpNJ188.QCMTF1oeT1a8
 iDTFdnt2mbBEbYJmNsnqpK8Ty6JbfywKT9UuPV2xfNI9XL7UZJ.4CMIXq.aCGAh.LDtlEI9RSbfC
 QmunwK_nVI3an.q1T_S_39DdhZgjvfIGp4kHmQ43L8W0U8vih2gGHdb7cvP0_oOwGKx1VNKlM00O
 npI4xmn0bx2bqvMoe7sXmkDVhe4cUw0D95ySPWBSEJJbCqev.HetIJvT.m6qg003Gr.mYWJ8NLRv
 6LD5NG_T86JxzN0SRxhezDJApDcwbHq1KIBeSEocb3cWv79tskuSirDXtEDhq0wADCLhxmUc3PwO
 GXjcgvurdJAnE1T7H1Zxp2QwE1rOKbaei3Ipz5NbgZAh2oUoSJfoMmIrEr1.PnIHp4hzUghU3b1O
 MxFs-
X-Sonic-MF: <pheonix.sja@att.net>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic304.consmr.mail.ne1.yahoo.com with HTTP; Wed, 17 Aug 2022 10:39:23 +0000
Received: by hermes--production-gq1-686964ccb6-f284v (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 74d72f97b16493d706572a2f98830e11;
          Wed, 17 Aug 2022 10:39:21 +0000 (UTC)
Date:   Wed, 17 Aug 2022 06:39:13 -0400
From:   Steven J Abner <pheonix.sja@att.net>
Subject: thermal driver patch
To:     linux-kernel@vger.kernel.org
Message-Id: <DL9RGR.8W3XFSCFFYXI2@att.net>
X-Mailer: geary/3.36.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
References: <DL9RGR.8W3XFSCFFYXI2.ref@att.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Didn't actually create patch, for you to do and review:

for drivers/thermal/thermal_core.c:397 :

static void update_temperature(struct thermal_zone_device *tz)
{
  (void)tz;
}

stops kernel dmesg of unused function,
from include/linux/thermal.h:429 :

static inline int thermal_zone_get_temp(
  struct thermal_zone_device *tz, int *temp)
{ return -ENODEV; }

If this is a bother, sorry I troubled you.
Per 'Do I have to be subscribed to post to the list?':
I wish to be personally CC'ed the answers/comments posted to the list
in response to your posting, please.
Steve



