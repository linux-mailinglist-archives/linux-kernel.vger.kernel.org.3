Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 193734E92C4
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 12:50:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240365AbiC1Kvk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 06:51:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235000AbiC1Kvj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 06:51:39 -0400
Received: from mail-ua1-x933.google.com (mail-ua1-x933.google.com [IPv6:2607:f8b0:4864:20::933])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70FAF3DDDB
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 03:49:58 -0700 (PDT)
Received: by mail-ua1-x933.google.com with SMTP id i26so6100188uap.6
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 03:49:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=se0Iqy7PBjDTiqb7BMo9NRQR8iF51TKjLrU4uubKJq0=;
        b=PH3OOm1DLSmLEfVyBClCqbOetntcGPjesRnBObLtYc2liu5QTHsYUbGY64fmSUyZRW
         8vHxDg4xs/uwucr5nlAT4iklWl0dxzAcFBpj4RRikACPjpJes62IdVXAYgthtTQYoC0l
         KzYVb+Ql55shVr0dLhDU/Qzd3hnyxsbGvjbt8XtYPY6orDxpQ6/i27dzrsqzPci5nm59
         lhgtYm7KO3vKZPyjqposaVT5eilBINo2kcsIjjfxUYZmGiluSpfylVmHs0SWGsGfO5CJ
         oo5HIRQ+PhPIxy67mDQKmr392jLlszW1J20Wx+OjbwYiguprO3r6xdO4Phbn4UX+CIul
         X9hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=se0Iqy7PBjDTiqb7BMo9NRQR8iF51TKjLrU4uubKJq0=;
        b=GnHPjmDEznt31jyenRxwf0wqF2/iyMC6NyHUuWG3NJtJQR6Fg8egnts4V0Z9/BHcoq
         A87UXiAi25mEuBNhslDNmjmAp/0dod0aN0vH/T0zh5KSa3a4Gq5CiRqASe5ptL/1lBsR
         DKZwYALkRrPE9hqUfkrPhLnUvEOG3hhb3YfQa9CVawkOvz1RTxMf5U1LhsEznRGHs/9G
         7n3c58FlvxMp+2fCd3HQcwa37o5kRFuvgf7ClVskPQqTMxtS7pD+vPx8gQfZph+w4msF
         Batf6lfBn6FPo8DaWvrxyxLPvuCz8ExjbFbti99+TjU3bFDXKDTYXPsuBbhgU7C8m7/q
         UOhw==
X-Gm-Message-State: AOAM532a36lWxV+2KQOvDVX+rPkc3KvKFzM9uAID0Z4XMCXcNbqlfWlU
        A+q5MVRLLFHq3osVQPxnwE0+jP5/oMdpN+9Cyqk=
X-Google-Smtp-Source: ABdhPJzI21a8jKIHHpd37K+/6mSZm2hV4ZFHS1USjoEMENn9F6JZVirJb1YL9OI44fnkC1KeQ/PIWgaAZYAmGeIOu1c=
X-Received: by 2002:ab0:71cf:0:b0:352:34d3:ffcd with SMTP id
 n15-20020ab071cf000000b0035234d3ffcdmr9294496uao.92.1648464597365; Mon, 28
 Mar 2022 03:49:57 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a59:c783:0:b0:29d:c6c8:bcd0 with HTTP; Mon, 28 Mar 2022
 03:49:57 -0700 (PDT)
From:   Heggins Kate <hegginskate7@gmail.com>
Date:   Mon, 28 Mar 2022 10:49:57 +0000
Message-ID: <CAEAJ=VwV24WPLJVjMw4pZknGVQgj38Wc-4G6UySoFMA0Cf2=5g@mail.gmail.com>
Subject: Danke
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hallo, wie geht es dir, ich brauche dringend deine Antwort
Ich muss dir etwas erkl=C3=A4ren
Danke
Katie
