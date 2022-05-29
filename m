Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3B41537110
	for <lists+linux-kernel@lfdr.de>; Sun, 29 May 2022 15:12:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230204AbiE2NMY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 May 2022 09:12:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230196AbiE2NMU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 May 2022 09:12:20 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9A9656C0D
        for <linux-kernel@vger.kernel.org>; Sun, 29 May 2022 06:12:19 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id gh17so16380822ejc.6
        for <linux-kernel@vger.kernel.org>; Sun, 29 May 2022 06:12:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=Cr4jqiwCZqgvtQ1mPAG6hA/aEXX0FhXJr8HGvR+MOF4=;
        b=Nt/mJnuBUQbVpYLEEcS8otgx+Y6B8DKZrFDbQOxKREC+NxFxhYnjNOCyG9P1ThZC5j
         dRdosrZPxn8CBggfVYZrDVQGOuwYvg2f1bVYyV1ABUKNPqapJRAOKY27FfYNwVhsKems
         kBL1U5aqQucKblCqHOg2MiR8h0OyZjPOYEadeYbNmdSTq5ET3WTkA+dxXloM7z048TPk
         2E4GYQj9mHqmwOYJ7R1bOljpAU7mdwgKRiZceqOGCyxgAa0rc63usjkUe1r7AjhQebxh
         kwBfE+343C5/kDVGvC3KLDjn53nWmOykR6WztIRH21rP6wRwRNqkv1W3/NI1Dz+NRvtf
         tLtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=Cr4jqiwCZqgvtQ1mPAG6hA/aEXX0FhXJr8HGvR+MOF4=;
        b=AvBQndGGmWFmeStMJ6HlyYdF18Q98wOmMnjMaz0V4v2pZAAUBPs5ChJl60E/A41S0k
         ZCEjYfEumghhReEGomXdTNDsMEgKWucdZa9vVd/WerDxcKZN6fSA4DD8QTSic8PEGsKR
         Z94RpYQguO2kUDy8C+yONReBBloq82gOiMcvAc9T3lPmzERKB8iocO3DCcJymmO7dSaz
         aJh7B4CwBNwt3OZh3UI5EG5ZoMq7RxEcVFF/VfNWDg4+1sbtvfUp3QipJ7NuarUaPhIn
         HBxtpSGxIeYuH4jA8jPgbRqnr91cH0dARNma5iQPverB5JFtQnBb7ULmJLGWQxVxp+xA
         deCQ==
X-Gm-Message-State: AOAM5332FbqETucNpKU9Xb2cvcDUnbbSUaz3d0crhKtSIwpxvsRR0lJg
        kJ8ZOPB8b5rbb16N+C8PRsvqFYSvoblnZRE5CPc=
X-Google-Smtp-Source: ABdhPJyRKi6iTQJpd2Fj1KOfeu+hCzkIoM3Qic3Pw8122XBumQ5LbFOoN/birEIsSd+xhoERiWPbAHB2hTxwzFaXhCs=
X-Received: by 2002:a17:906:7952:b0:6fe:1e0b:6343 with SMTP id
 l18-20020a170906795200b006fe1e0b6343mr46150509ejo.337.1653829938115; Sun, 29
 May 2022 06:12:18 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6400:789:0:0:0:0 with HTTP; Sun, 29 May 2022 06:12:17
 -0700 (PDT)
Reply-To: wijh555@gmail.com
From:   "Mr. David Kabore" <dkabore16@gmail.com>
Date:   Sun, 29 May 2022 06:12:17 -0700
Message-ID: <CANLKR0ux+1e3gPWaeruutBfyR4A2Dhj=7So=Grxb82uS2e8Mow@mail.gmail.com>
Subject: Greetings,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_HK_NAME_FM_MR_MRS,
        T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-- 
Hello,
I'm Mr. David Kabore, how are you doing hope you are in good health,
the Board irector try to reach you on phone several times Meanwhile,
your number was not connecting. before he ask me to send you an email
to hear from you if you are fine. hope to hear you are in good Health.

Thanks,
Mr. David Kabore.
