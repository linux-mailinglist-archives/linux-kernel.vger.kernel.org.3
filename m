Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DFA65A599B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 04:58:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229997AbiH3C5v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 22:57:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbiH3C5s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 22:57:48 -0400
Received: from mail-vk1-xa31.google.com (mail-vk1-xa31.google.com [IPv6:2607:f8b0:4864:20::a31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD40574DD2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 19:57:47 -0700 (PDT)
Received: by mail-vk1-xa31.google.com with SMTP id o12so382413vkn.7
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 19:57:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc;
        bh=wiRP3+4701gkVkIW6ayhPZh8Cir1ojpTE8CU1lGoVJI=;
        b=KXiNqUk3dclTQIVovJ2cDzJh0bGqAf66D1skKyaXpsSJTRzhV7mpEHdPKFJGN+6JAC
         o2cf45vKSCMq90amkhXTAUJvFfFgyLE1sqxVozBQSaJDCsMF9jkcL+mv5OxqqejRlZfy
         55DHAZEiQJGjPqlqIxf2EJDH/OU/GI6iuhf+CdwCERhAQWynXkMCWgZfyJBaC0wtRg0i
         88d7RHNkGpYDgW4sGG14tKQQpDnyVvRRs8DGY115uPcYsjF5PbMelyoByiEcuYqYTCbS
         +TkSykPzZEsN102qVQzqEC95U0dSi0gBGpLzhRx9K6IWbnDqElG95tbHhHATGEykNXsp
         jbwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc;
        bh=wiRP3+4701gkVkIW6ayhPZh8Cir1ojpTE8CU1lGoVJI=;
        b=hvn3oWS3dbcqZMFEsrkogkim201FWqrKrwZwJJwZB20rIY7CiB4MnTdTOHfAEaEUTy
         s9xxZ6ICsuJieQXsXUwNd9hTBsaASsjjaKRlOkwPNE6kIIg1anLGgEr/4U8AWEIxIfiX
         8in7M1j723VkWylod919AJx/jMWzX+BfzI2wdVwsHH3U6JYItWTNSkPdP+j6wyiruZ9H
         IvilVMAd4jg0HH9kusDqtsJo9NJpn8TyOFxXSFmGXNcxIxul25lE5VJZ4f3OybvyMPsz
         J/QG/bfq7in3gO+k5Uz8aoDCg7f39VbZaOe5+DefoZaL1NWgT1W8i22VOS0tZC1EywHi
         8XSA==
X-Gm-Message-State: ACgBeo1xz2pRWsOLh7+rTVajsx3UDvcCIJN6HvsA9ML3excC1RttBsxF
        dU3OfnsngGgwR7/T2vLPVrXuT0q+o72cyK7PgE4=
X-Google-Smtp-Source: AA6agR66sqDHX2xeAZtzAbR/VqVkZx3TLHcy7SPVltEvn3v9qr/J8kFfvJy4WXiB8w0Y3xTNVqoHEiIT2xL5UJ4z2w4=
X-Received: by 2002:a1f:9f50:0:b0:394:9d41:72f2 with SMTP id
 i77-20020a1f9f50000000b003949d4172f2mr34836vke.16.1661828266584; Mon, 29 Aug
 2022 19:57:46 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6124:c81:b0:30d:f703:98ec with HTTP; Mon, 29 Aug 2022
 19:57:45 -0700 (PDT)
Reply-To: te463602@gmail.com
From:   "Mrs. Mimi Aminu" <mimiaminu319@gmail.com>
Date:   Mon, 29 Aug 2022 19:57:45 -0700
Message-ID: <CAD-C4f4F3NapYzNsMyChWgAgc13_n80Zo1b3jMCfyi_qhVccQA@mail.gmail.com>
Subject: Good Day,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.3 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_HK_NAME_FM_MR_MRS,
        T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:a31 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [mimiaminu319[at]gmail.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [mimiaminu319[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [te463602[at]gmail.com]
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.0 T_HK_NAME_FM_MR_MRS No description available.
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  3.2 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-- 
Hello,
We the Board Directors believe you are in good health, doing great and
with the hope that this mail will meet you in good condition, We are
privileged and delighted to reach you via email" And we are urgently
waiting to hear from you. and again your number is not connecting.

My regards,
Mrs. Mimi Aminu.
