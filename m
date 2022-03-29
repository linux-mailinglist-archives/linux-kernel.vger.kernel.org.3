Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 435AF4EB432
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 21:39:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241014AbiC2TlA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 15:41:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241010AbiC2Tk6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 15:40:58 -0400
Received: from mail-vk1-xa2d.google.com (mail-vk1-xa2d.google.com [IPv6:2607:f8b0:4864:20::a2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62F2EB7178
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 12:39:14 -0700 (PDT)
Received: by mail-vk1-xa2d.google.com with SMTP id w189so10349836vke.10
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 12:39:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=uII2np7aGNR/estOtrALPN+M9IUmWWFpKjZGABtjl3M=;
        b=eQ16VWP8c91dlUObI1CS3Ok06OZhpadiemzQEqjdhrQfMzG19VUh+Ev312wwgeQ2zr
         UlIzZK80rgxfzIzr1FjICIcpnX/8/RhTJ/EajuKXpZ5XQSMyilIQ/4AkWSkvbvYFFKCm
         RB5nO6yB6lyW3ik7G/D/pbYHUdUaQ6UV0s93h92UF6tWtTlHQdEc8YcZVnUV3SK71A/x
         jnQMM4iIZtLJziP61e7HkUlGtXzElEFsvBlGZKIzvKv3l+B22enHDsEcVQ8dQvPhSFUw
         ulzlm6kbWPYl+Qc2fgljM3O73Uym7KDZz0TgQYGCzA5h1HfMsQNlWBwNFVig9VuWEy1B
         G6DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=uII2np7aGNR/estOtrALPN+M9IUmWWFpKjZGABtjl3M=;
        b=VKR86O80vbWnx5TF2XQB30UzhtZPo6fRVBaQ3TAMrpxpzOToSdoTPe2mI8zJyuKOPG
         BxJecWFYxW4jis35auYOcREOUEyXxptVdq7pYc3doz3+uBRrg33e1puLPBHjbJnG9IvV
         E0UBk9huyNx0DUzzkKNe+zyZ7j6OfGEAxJNJVexdiBHdby4Paof2GWt230ewf6Z/BKT2
         gvf0uCYDYGqCRwTXtmu+sbo03SMUFU5P7sfCJcO6pUW5/d/LVwggLI6qr6KZS+DiM5qE
         SuHTGmknVyq/PpG3ajMlyEW6dpZ4sd1jMn0z2boi4ZVvwvVuGQ8BaPZMAYyVvGRsNQ3Q
         3HUg==
X-Gm-Message-State: AOAM5327DCp93D5YyvHpCjUfsfe4agwzqM26vow8ED1Nb3HEoPuQvMGh
        P7KPgoHeHMKgjSqCOL+9LRCsK9EVu9z85qbnkXM=
X-Google-Smtp-Source: ABdhPJzhQm0kKGKrXYcyTDYL7ND9sUkzHuAJHyoB+adW8MZztpKzRc/hVMQ1tEycoxE6P9CTx7jIgZZfpkkQdoSEaNQ=
X-Received: by 2002:ac5:c9b9:0:b0:33f:4d8a:bf60 with SMTP id
 f25-20020ac5c9b9000000b0033f4d8abf60mr19284194vkm.38.1648582753580; Tue, 29
 Mar 2022 12:39:13 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a59:b841:0:b0:2a3:e2ec:85db with HTTP; Tue, 29 Mar 2022
 12:39:13 -0700 (PDT)
From:   "capt. petry" <oformaugwu67@gmail.com>
Date:   Tue, 29 Mar 2022 19:39:13 +0000
Message-ID: <CANtq_Si0r_NwavnJELA_BCNjiseu0WcFfYAQtrRN_Htb38rc4Q@mail.gmail.com>
Subject: =?UTF-8?B?UmU6IEFob2ogZHJhaMOhLCBqYWsgc2UgZG5lcyBtw6HFoT8=?=
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.0 required=5.0 tests=BAYES_40,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ahoj,

Dostal jsi mou p=C5=99edchoz=C3=AD zpr=C3=A1vu? Ji=C5=BE jsem v=C3=A1s kont=
aktoval, ale zpr=C3=A1va
selhala, tak jsem se rozhodl napsat znovu. Potvr=C4=8Fte pros=C3=ADm, zda j=
ste
toto obdr=C5=BEeli, abych mohl pokra=C4=8Dovat,

=C4=8Cek=C3=A1m na Va=C5=A1i odpov=C4=9B=C4=8F.

Pozdravy,
kapit=C3=A1n Petry
