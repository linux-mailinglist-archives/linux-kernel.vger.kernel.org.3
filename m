Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD822550EB8
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 04:58:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231582AbiFTC6I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jun 2022 22:58:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235758AbiFTC6C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jun 2022 22:58:02 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9397663E2
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 19:57:48 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id s185so3347715pgs.3
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 19:57:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=/OLidbSnpUHKhyvWAxxwUS8WGsf4gj9nF541RhVwgto=;
        b=kjgxjpRyZerC9ge/Y8B5Uszl03RpWIURc9ceaMaf+kF/FCUxlSbGAV932ogoE+hDAn
         K8HZamB7KAC5+FZZShDkIhu/R0RTH8sPHbOVM2K+TOvBYGBNEK+qoQ7+LVKonkp/UFWX
         8pJ9lVsDhPH1QMcW3gx1ByH70cv+XiFAm1zq4fEZc0Zm6r6318F1w69cQMNW2bJUAEHv
         Kkv3QfH2V3AvrZydQtXsCVzgCHiZBmOkYtlFrQYSdnTxA5ijTA2SmIwfW8Ra60/VRWoU
         HPfvPbJdaiFMC9688eRpFV/8uAVuCe94qKoI6e1y5msBuVM4DyvVHhjA3g0LXZUaZbd5
         NFrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=/OLidbSnpUHKhyvWAxxwUS8WGsf4gj9nF541RhVwgto=;
        b=hLs3aRQbS3AVRv7hZrkfOPR8V4hxIGjjJAIyFct5wNYugZillXDUHrBOJRcKlgOVGm
         Zu+cy+oL3qsxO7Z/BqDNL0LAqANBKYQddHx/BSxcQlg7yiczeouJIoAvsI6Kh//kuSHB
         f+kW7XMCuJ7RbqAHr4RyIIN1QiE9ft+FfnFKtzidlrlFIz2XRmqGvuGRWtgzE8L1Jpyp
         WN+BdhIG/bYZMoKE5AjfnRv1UC6nrko6JPdLku9YHf/c6VxR2MBt4+K+knGmqono32KM
         ChyChoPtWHxADQsXsDDgDcOGTY1BmB0VJTiQEMXFC/QeBVpKqxyGlYIupfviutplw1L/
         izZA==
X-Gm-Message-State: AJIora+ccKBuWgEb1IhTp0F+TND7bd5Sze2+QWFcIKefAIegdBgVuolL
        p5ppaLPnIr6CTpph6G9LPVHrDA==
X-Google-Smtp-Source: AGRyM1totuspkuKuSRwEBCK7UWfynfL88ikTJQdy99vQTYkUBrSuHfct5/eq9QGZB9SxPg5fqhxr4w==
X-Received: by 2002:a63:210e:0:b0:3fd:9c07:7670 with SMTP id h14-20020a63210e000000b003fd9c077670mr19762842pgh.222.1655693868104;
        Sun, 19 Jun 2022 19:57:48 -0700 (PDT)
Received: from n254-073-104.byted.org ([139.177.225.234])
        by smtp.gmail.com with ESMTPSA id jg20-20020a17090326d400b0016a0f4af4b1sm3666803plb.183.2022.06.19.19.57.44
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 19 Jun 2022 19:57:47 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: Re: [External] [PATCH] crypto: testmgr - fix version number of RSA
 tests
From:   =?utf-8?B?5L2V56OK?= <helei.sig11@bytedance.com>
In-Reply-To: <20220619030904-mutt-send-email-mst@kernel.org>
Date:   Mon, 20 Jun 2022 10:57:41 +0800
Cc:     =?utf-8?B?5L2V56OK?= <helei.sig11@bytedance.com>,
        herbert@gondor.apana.org.au, davem@davemloft.net,
        dhowells@redhat.com, arei.gonglei@huawei.com, jasowang@redhat.com,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        pizhenwei@bytedance.com, f4bug@amsat.org, berrange@redhat.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <315B0676-B712-4828-A4F4-0E559DB0DD89@bytedance.com>
References: <20220617070754.73667-1-helei.sig11@bytedance.com>
 <20220617070754.73667-3-helei.sig11@bytedance.com>
 <20220619030904-mutt-send-email-mst@kernel.org>
To:     "Michael S. Tsirkin" <mst@redhat.com>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

My mistake, please ignore this commit. I will resubmit and fix the bug =
reported by the bot

> On Jun 19, 2022, at 3:09 PM, Michael S. Tsirkin <mst@redhat.com> =
wrote:
>=20
> On Fri, Jun 17, 2022 at 03:07:51PM +0800, Lei He wrote:
>> From: lei he <helei.sig11@bytedance.com>
>>=20
>> According to PKCS#1 standard, the 'otherPrimeInfos' field contains
>> the information for the additional primes r_3, ..., r_u, in order.
>> It shall be omitted if the version is 0 and shall contain at least
>> one instance of OtherPrimeInfo if the version is 1, see:
>> 	https://www.rfc-editor.org/rfc/rfc3447#page-44
>>=20
>> Replace the version number '1' with 0, otherwise, some drivers may
>> not pass the run-time tests.
>>=20
>> Signed-off-by: lei he <helei.sig11@bytedance.com>
>=20
> Why is this posted as part of the virtio-crypto patchset thread =
though?
>=20
>=20
>> ---
>> crypto/testmgr.h | 6 +++---
>> 1 file changed, 3 insertions(+), 3 deletions(-)
>>=20
>> diff --git a/crypto/testmgr.h b/crypto/testmgr.h
>> index 4d7449fc6a65..d57f24b906f1 100644
>> --- a/crypto/testmgr.h
>> +++ b/crypto/testmgr.h
>> @@ -186,7 +186,7 @@ static const struct akcipher_testvec =
rsa_tv_template[] =3D {
>> #ifndef CONFIG_CRYPTO_FIPS
>> 	.key =3D
>> 	"\x30\x81\x9A" /* sequence of 154 bytes */
>> -	"\x02\x01\x01" /* version - integer of 1 byte */
>> +	"\x02\x01\x00" /* version - integer of 1 byte */
>> 	"\x02\x41" /* modulus - integer of 65 bytes */
>> 	=
"\x00\xAA\x36\xAB\xCE\x88\xAC\xFD\xFF\x55\x52\x3C\x7F\xC4\x52\x3F"
>> 	=
"\x90\xEF\xA0\x0D\xF3\x77\x4A\x25\x9F\x2E\x62\xB4\xC5\xD9\x9C\xB5"
>> @@ -216,7 +216,7 @@ static const struct akcipher_testvec =
rsa_tv_template[] =3D {
>> 	}, {
>> 	.key =3D
>> 	"\x30\x82\x01\x1D" /* sequence of 285 bytes */
>> -	"\x02\x01\x01" /* version - integer of 1 byte */
>> +	"\x02\x01\x00" /* version - integer of 1 byte */
>> 	"\x02\x81\x81" /* modulus - integer of 129 bytes */
>> 	=
"\x00\xBB\xF8\x2F\x09\x06\x82\xCE\x9C\x23\x38\xAC\x2B\x9D\xA8\x71"
>> 	=
"\xF7\x36\x8D\x07\xEE\xD4\x10\x43\xA4\x40\xD6\xB6\xF0\x74\x54\xF5"
>> @@ -260,7 +260,7 @@ static const struct akcipher_testvec =
rsa_tv_template[] =3D {
>> #endif
>> 	.key =3D
>> 	"\x30\x82\x02\x20" /* sequence of 544 bytes */
>> -	"\x02\x01\x01" /* version - integer of 1 byte */
>> +	"\x02\x01\x00" /* version - integer of 1 byte */
>> 	"\x02\x82\x01\x01\x00" /* modulus - integer of 256 bytes */
>> 	=
"\xDB\x10\x1A\xC2\xA3\xF1\xDC\xFF\x13\x6B\xED\x44\xDF\xF0\x02\x6D"
>> 	=
"\x13\xC7\x88\xDA\x70\x6B\x54\xF1\xE8\x27\xDC\xC3\x0F\x99\x6A\xFA"
>> --=20
>> 2.20.1
>=20

