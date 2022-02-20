Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D83E94BCE82
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Feb 2022 13:54:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242735AbiBTMyV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Feb 2022 07:54:21 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237878AbiBTMyU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Feb 2022 07:54:20 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CC2435DF7
        for <linux-kernel@vger.kernel.org>; Sun, 20 Feb 2022 04:53:59 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id p184-20020a1c29c1000000b0037f76d8b484so451241wmp.5
        for <linux-kernel@vger.kernel.org>; Sun, 20 Feb 2022 04:53:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=WTndzSyXJ/sZW2lGxgeOIdNZEmLI+JWCR9Vf7oRpeXc=;
        b=LIemdLBJ4TLNhrmuvDjnJcVurY6NU1ujxkUeAT0AbDSg8KMdy1XJp2KuE0V0PwAGmC
         Xqn/z14NbeZ5rDf/SF58NpwGmOtM8eYJhYPd/VnTRIllMRZk2iSJyzxMw+XVXxDtt7cm
         bt7NoBb0yZoDqaMECt+NbmfpWpzBMUCnhrjxMW4PoqllBSy4g7qzkhXEdPsqJs6arFdi
         RusadzO93RXH4hqkKV47lkR4SyVEYpm31uwSxCS4aUGK/iVOwT8v6dxbWm0HQNnWinmU
         DgbFukJWVqCYwAHg58eaczjeFPjY2a+Jw+utwrv79MYadTbkcdiQcj5DuA41zIe80jHA
         X/RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=WTndzSyXJ/sZW2lGxgeOIdNZEmLI+JWCR9Vf7oRpeXc=;
        b=SGQKtShj6mjR3SSrJI/OYczvfkiRwUBXWWCbp8MP5/Zx7uOzerpkLtOfIJCR7RFz5U
         Umf6JnT/62zyyCknHP3HE85F8i9se4u2otK0j6HjiVqzDoyMDfoW8aycfqoTvWJLI0Ew
         YNoPcQhR3h2HvBxVxGkop+SRwtBZd3quA9IE1M8cJUoXrYi9hCp2xC7NISMq2cre7E3N
         yD+PvnGysWGQ5CUccZis1tWWL+jm6bJ/ZeFL7ktp6MobET4G92A6oLGZr5nkap2QbJtr
         SeyUI1SynV1dVDcj6wAiPrW2lq3LXM02ec5yM/KYm0Az+Enca/+5QrLgS9fSJ5NJB6lB
         YNvQ==
X-Gm-Message-State: AOAM531sU0bzTXqqpimAx9LFpj6SHIYXK7d3gz0MEiCTT5zxHrWjexkW
        EOlKp1pCdU+yzoOsP6e46FhhMqBzb6u71USRCiA=
X-Google-Smtp-Source: ABdhPJzndk8M4C9c7ygqp+q06kmZyE021QwrI/pO8rLk2WAHExX9HDaSa1GkzKesjxXgpjk2TfsJOTmPt5MVgLNiFq8=
X-Received: by 2002:a05:600c:4e8d:b0:37c:4e20:baa6 with SMTP id
 f13-20020a05600c4e8d00b0037c4e20baa6mr14171238wmq.19.1645361637617; Sun, 20
 Feb 2022 04:53:57 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:adf:f751:0:0:0:0:0 with HTTP; Sun, 20 Feb 2022 04:53:56
 -0800 (PST)
Reply-To: wijh555@gmail.com
From:   "Dr. Irene Lam" <confianzayrentabilidad@gmail.com>
Date:   Sun, 20 Feb 2022 04:53:56 -0800
Message-ID: <CANrrfX55sERqqs5+FwNcCkg6JY9EnYMjA=VBmoW2e0ajF_HBGw@mail.gmail.com>
Subject: Greetings,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.0 required=5.0 tests=BAYES_05,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-- 
Hope you are doing good?
I'm Dr. Irene Lam, how are you doing ope you are in good health, the
Board director
try to reach you on phone several times Meanwhile, your number was not
connecting. before he ask me to send you an email to hear from you if
you are fine. hoping to hear from you soonest.

Sincerely
Dr. Irene Lam
