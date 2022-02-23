Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9017D4C0F38
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 10:29:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239297AbiBWJ3f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 04:29:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234127AbiBWJ3e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 04:29:34 -0500
Received: from mail-vk1-xa36.google.com (mail-vk1-xa36.google.com [IPv6:2607:f8b0:4864:20::a36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60E9C24BFB
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 01:29:07 -0800 (PST)
Received: by mail-vk1-xa36.google.com with SMTP id k9so5293504vki.4
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 01:29:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:sender:from:date:message-id:subject:to;
        bh=SzEm6i/EwUESKhbVX0osxjmnwu7uiM8aIqN8Ey8PdDw=;
        b=nLA0dvM75/4eSVf0md8dLuKrB2Qva6AFsLJ+RktImjzdCYxrKX//QDVvnuhFgWCbaH
         W0UWKn+ZqstMyDq8wEik8A2M+8CnKSG9M4BIgR8JMgeMLef3lwyLxjFcz4gKUFSqWuDj
         cPFDBdDjlmvzTPqjs7sKlwmTjmy7O48R4w1DgW1UGL8ZyFz4zgIitxvF2GF92j5TuGE2
         3T9OG4Wpls7yKzoiPQO3bsAkcoANp4F3x0Uud2azljxxTtXtxThgtfKoh8QP5494XMOT
         rlz4zL4Xd+/Gy6LcAUon8VzE1kVtO/c4nLl/YD4PP4ZRyVuhNEXxhXLjP3ZK/BnQOWxA
         QYPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to;
        bh=SzEm6i/EwUESKhbVX0osxjmnwu7uiM8aIqN8Ey8PdDw=;
        b=5R5cjsxYVzbreKW/+TgPK81v1/6Aoq5XOA+1FD0yqBEvysUKQcuh27ZRJy7URWbhCm
         6B5Y5f/LckAW6NfTer3f6YmI+QmSbtiTYC5jo6yZiAS2c/kodxetFYn+6dg9KZi1J8Ot
         6QLtkhkQcyutBCqK5na1ai5kd/MnAqegqmDAKxPBESZyHtFNx7ePPaNOA2736uHbrzL9
         nocZrxzUdtqIUX81zPXS1YnzR0VO/2JteD4z5RZtzJzAOk6t+fdvAJUVuUXx9z2Y96NM
         CUlY84gL3wy3KUXazMhinYdxJdpUtEH+3sIrjHCpbAHTrsD02vpDyD6S/M6m3mg72Xa9
         NpBA==
X-Gm-Message-State: AOAM531L0meDBdvNAKudV5/aSzmjhLESbu+Ditdnte2+KD2ABkM+1GLb
        YF0K/6QuG8vocAMltLzB1IV2yOv7XchvLLrN3cU=
X-Google-Smtp-Source: ABdhPJwWQUICr32tmkjTcUZmEHSy1T3xqtKsvqX34SDbBopA0fV64hOWF+CiZHdyiUSQXCXHG9uK6zxs+07RUfyata0=
X-Received: by 2002:a05:6122:635:b0:32d:1046:307f with SMTP id
 g21-20020a056122063500b0032d1046307fmr12410096vkp.0.1645608546443; Wed, 23
 Feb 2022 01:29:06 -0800 (PST)
MIME-Version: 1.0
Sender: edwardcarlos536@gmail.com
Received: by 2002:a59:c708:0:b0:28c:495a:1d41 with HTTP; Wed, 23 Feb 2022
 01:29:06 -0800 (PST)
From:   Aisha Al-Qaddafi <aishaalqaddafi066@gmail.com>
Date:   Wed, 23 Feb 2022 09:29:06 +0000
X-Google-Sender-Auth: BropyyCQQeqBfl-o-zDPkI0SDhA
Message-ID: <CAFyj9jwAv=CJoJZTu5vuLmVXyQgtvO84TspePJA978Mu34jnHQ@mail.gmail.com>
Subject: Investment Proposal
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.7 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,LOTS_OF_MONEY,MILLION_HUNDRED,MONEY_FRAUD_5,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_MONEY autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

My dear friend,

With sincerity of purpose I wish to communicate with you seeking your
acceptance towards investing in your country under your Management as
my foreign investor/business partner.
I'm Mrs. Gaddafi Aisha-Al, the only biological Daughter of the late
Libyan President (Late Colonel Gaddafi Muammar) I'm a single Mother
and a widow with three Children, presently residing herein Oman the
Southeastern coast of the Arabian Peninsula in Western Asia. I have
investment funds worth Twenty Seven Million Five Hundred Thousand
United State Dollars ($27.500.000.00 ) which I want to entrust to you
for the investment project in your country.

I am willing to negotiate an investment/business profit sharing ratio
with you based on the future investment earning profits. If you are
willing to handle this project kindly reply urgently to enable me to
provide you more information about the investment funds.


Best Regards

Mrs. Gaddafi Aisha-Al.
