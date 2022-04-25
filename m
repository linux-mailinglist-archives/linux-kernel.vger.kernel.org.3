Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AFC250D943
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 08:13:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235581AbiDYGPs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 02:15:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232989AbiDYGOc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 02:14:32 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AC723AA6B
        for <linux-kernel@vger.kernel.org>; Sun, 24 Apr 2022 23:11:27 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id x18so19313865wrc.0
        for <linux-kernel@vger.kernel.org>; Sun, 24 Apr 2022 23:11:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:sender:from:date:message-id:subject:to;
        bh=NLijoYwk7hqoA8TsUJbQbQCYzScrvalH7Lc8MykkZrA=;
        b=b85c1Ux8WwhvlFPo3HKkYUeZPpnAUzmKssKUQKMOiC2/IQqgQ/txJJq4xrb1rY8/We
         8BIzTiYFfNEZIEwMPZjwloaAMdwjTUNCUbfSmvrQcKEqbr7QI8psEzvpAgsGKtE3L5O9
         SiguDDfJFEyE4MkRuHrMCUFsiZr0N4r6wcXQrjCOn3gxiGWGDj6oOzCTuLKdf/lYOBVL
         VaLQ3a7OrANjlwQ/TAJBF7LVD7FBeJfAJP+mA0tBQtVHU1iS/xMyvUUgCdq+XP5DDhuH
         aF9q1ZTMXX05HoZmQm4s4Wu+vQ/J7keJ9hdZ/9Z/VNkb0z3Lnw0FXVpcnHZX/UxPMtKe
         vTjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:sender:from:date
         :message-id:subject:to;
        bh=NLijoYwk7hqoA8TsUJbQbQCYzScrvalH7Lc8MykkZrA=;
        b=mTPJuD+Y/N55CfS0PiQfQR2IWayoaeWpq8VbEiCan86WE3lS0QoZhbAKv/640IPvx6
         kmiWV9SyGNrFgaBon2YShfJnO1D5KEHDoCs4elIDAxywb3gWyLokYEWPasxwspzKrO1l
         LGV5/yKM0dYhBGUO2e0Cpf2ZDzkjqSfN7V9F28WxUBo5jhqhcmcptrzBAq6/BOBnnRDo
         rbDWzcCO9t6mFe9JciOZQFc8ZikxU8+SWYDNjP9VPTPt3yYbsBt4B+kJfMTxaksI4pbw
         bB3VxcOmPx1ktrDNbiGNpqijFoEX+XZdvUXa1xCPvPBpCQSvvjmNIZq7WHwPqglwrZNS
         ViHg==
X-Gm-Message-State: AOAM53312rRiQePr1Ldv+lrujPZBzKnOk5AuPnafdi0kllTXURy5X/E1
        1S0UVY3wRcCEZOdPbFc5Xnuqv9GG8+RhOyAhw/w=
X-Google-Smtp-Source: ABdhPJzn9UIeJkcjjKwsBmfCblqWGOlYoSrkuchxRQIP1acArufyZULiwpUrrCErpWOCzv+JFPFmXAU6Otz1W0Rauq8=
X-Received: by 2002:a5d:64e4:0:b0:20a:e005:cc96 with SMTP id
 g4-20020a5d64e4000000b0020ae005cc96mr300967wri.402.1650867085418; Sun, 24 Apr
 2022 23:11:25 -0700 (PDT)
MIME-Version: 1.0
Reply-To: salkavar2@gmail.com
Sender: wunionofficedept@gmail.com
Received: by 2002:a05:6020:a813:b0:1cb:9ed1:ae19 with HTTP; Sun, 24 Apr 2022
 23:11:24 -0700 (PDT)
From:   "Mr.Sal kavar" <salkavar2@gmail.com>
Date:   Mon, 25 Apr 2022 06:11:24 +0000
X-Google-Sender-Auth: Dl5RUcjidwX7MsNwb_D9agnCnmQ
Message-ID: <CAKheY8droNzB4iwCF74mdBcx5DJwwYr44f02DUGzsaZXn8VUQg@mail.gmail.com>
Subject: Yours Faithful,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.4 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        FREEMAIL_REPLYTO_END_DIGIT,LOTS_OF_MONEY,MILLION_HUNDRED,MONEY_FRAUD_5,
        MONEY_FREEMAIL_REPTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_HK_NAME_FM_MR_MRS,T_MONEY_PERCENT,UNDISC_MONEY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I assume you and your family are in good health. I am the foreign
operations Manager

This being a wide world in which it can be difficult to make new
acquaintances and because it is virtually impossible to know who is
trustworthy and who can be believed, i have decided to repose
confidence in you after much fasting and prayer. It is only because of
this that I have decided to confide in you and to share with you this
confidential business.

overdue and unclaimed sum of $15.5m, (Fifteen Million Five Hundred
Thousand Dollars Only) when the account holder suddenly passed on, he
left no beneficiary who would be entitled to the receipt of this fund.
For this reason, I have found it expedient to transfer this fund to a
trustworthy individual with capacity to act as foreign business
partner.

You will take 45%  10% will be shared to Charity in both country and
45% will be for me.

Yours Faithful,
Mr.Sal Kavar.
