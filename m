Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FB744FC522
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 21:30:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348663AbiDKTdJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 15:33:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230134AbiDKTdH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 15:33:07 -0400
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8462E20F4F
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 12:30:51 -0700 (PDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-2ec42eae76bso27976067b3.10
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 12:30:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=TnOSx7MpJwYPLSsBnV/1sbzqCxqBI2PMvS0FvTHp5UwLPq2vvOPUXLypaKtjd2N9lb
         qB0fILK6BLjXLtUAzCxEiWKq6tQWdejdKB5ERpSrJZqcP31xpSWIUsUjm3rpAju0Cptm
         M6m9dYBJhVBR0ItZD+ntdLUWzOQ29ounAmG/2LHJk9/wECiRuWQFfTI6rogp7tRH8Zuh
         y3+djzRvpf8C/7zjNIa6uT4TZ7xO3G2gkT7BmNmyto33BkyRUWw2MG7TfpYPxzk9DUCN
         b/UTcYScOHJE3eurqMXoZ6iX2koDxYab0nSYxsTrrHpky1u95WXoh6KtYSUscxAqNqmL
         d5AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=C0TIHTDu+1BWdrfXV3ZuNIaq2NUGVWtlY4Egcdsr4TyEeE7Wk54pRE8UfDeyGbpNMp
         DwnAJZ95xaGIsFJxPtakESpBaUZyjITRygtxZmKR8OAS4UkCR3qSyJJ0IU6yxVB/EG8X
         jR96CnWPmhimOKv8hZGhc8+ZDrnR1UQpLWsbGRV2W8luMwG4lJHclafyX4B8Vk9RERuh
         lZN3Y6pgrlFqtxv3pDjUmt0/0ocrcoAU0lOgAUjl0RvPkQHO7uJzmYP79Kk+m7ZBrA9P
         xQQS6Iy+KrHPf5CPtQHwcj4rEdGAHJdFVkSf8gC58Kj4BTcr9OEhE1P5SWu+gwZp32ss
         Yg8g==
X-Gm-Message-State: AOAM531dO2wymhLAqJ4Cp2sXURF9vqHG9zSgsxY6Tv3ispb7bGSEeUmz
        PLGnZ3wL9AgSpxx8mmE8TiGKHus9zZ2LcM0589o=
X-Google-Smtp-Source: ABdhPJzDAD85QouBsUm2kUspjtdq9VxqBqncoVDariZgy4liy4miUhDrVuOfgS2he64wSH/ckEcjfbAt78bW8SwISFk=
X-Received: by 2002:a05:690c:13:b0:2e4:da22:27d9 with SMTP id
 bc19-20020a05690c001300b002e4da2227d9mr28737222ywb.298.1649705450778; Mon, 11
 Apr 2022 12:30:50 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:7000:2c16:0:0:0:0 with HTTP; Mon, 11 Apr 2022 12:30:50
 -0700 (PDT)
Reply-To: robertsodjo63@gmail.com
From:   Roberts kodjo <shayelynnehaverhaver@gmail.com>
Date:   Mon, 11 Apr 2022 19:30:50 +0000
Message-ID: <CANJj0mnbt_kGSbOKPun6=UpDZ-87DJimhDOnujN_YJume6Ro0Q@mail.gmail.com>
Subject: Hallo, hoe gaat het vandaag hoop dat je in goede gezondheid bent, heb
 je mijn laatste bericht ontvangen?
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.5 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:1131 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4882]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [shayelynnehaverhaver[at]gmail.com]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [robertsodjo63[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  3.7 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


