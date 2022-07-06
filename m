Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80B2A56952C
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 00:19:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232212AbiGFWTq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 18:19:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230320AbiGFWTn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 18:19:43 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B83E19003
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 15:19:43 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id be10so21448177oib.7
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jul 2022 15:19:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=tX3wiMJEVMJyc1WS8xul4yOJ13z03UObiU/AucT1s0Y=;
        b=ZDqMXcxuSVYA1j3kkfF/W+7pGl+IxPyft8Nmvy4W/itlSc9lY1MOGv3WZKeHpSnQjC
         InaocHgBH0QMamZeUaAzUQ9JJHEgkF5SIJbfw34DmqNWkcRsXondLNCcTNWWWOe9AqRS
         Ie38l+zztR7mbh4PPpoeyXbm3v4SFr79Y2OfSiMWzE+R3tNHXcFEmMEzTrHyt+iFap//
         VCYXALewst0jc3GMtGEYFR0NrPFQoF357rXEp0WjFf0yytQF0iEB6NmFQ06Lnw64bV15
         /N9C2Qc7/R9jOlYEiaUBVCf8oMXNOdzMfV1LY09ytZk7wvT9IdLYpqecq9mTencyHzz0
         MRBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=tX3wiMJEVMJyc1WS8xul4yOJ13z03UObiU/AucT1s0Y=;
        b=CKlnv9ZYg1KSXn+8qDugEYJvVOq3mdY6ZUMZtuz5lCtfAtnV8bIKCe3SeTR0Cbzy1n
         LxVadCrURR7ARsS55SYPMOzIrkKMFULNbGK1pbFE0sZZcth7ctkTB345ryvtlgfIz7Pa
         NeRzwzux69jy5+9CrYiYawc4DGyUibYZ+GverRyGTFG6camjeshB4r+ks4BTYATTU0tH
         jbAB6qQyjo5Fkj1x72kXOBxGC3a1G4L36Pz+Rlweizq7D/1N4gdO3vPyEhzdm8cnMlRS
         UnM1C+9hWJeCv62bXMvm90WQ9xC8HBLJJBBkQ4cVVk9i49Nz2rltNDFr8vXkiIR5SQ1R
         eRuA==
X-Gm-Message-State: AJIora/Aalfh6lHlC4y1LZZjnar0ILyPBSU14wP3qkiPay32z9HbGpJL
        8nDUjtj78Pcpmza+CIrD4OCr2TlK2mzvui6xK4I=
X-Google-Smtp-Source: AGRyM1sO9ZktLCuWMGNhH5RJfSf4Bta6++QuwLYdQ8ZKtm4k5Xj/qPfMkgCFUG1/iAIKZYGc4Co+CN/Wuf7HJF7u9rI=
X-Received: by 2002:a05:6808:e8b:b0:322:4c21:6ba3 with SMTP id
 k11-20020a0568080e8b00b003224c216ba3mr539074oil.204.1657145982672; Wed, 06
 Jul 2022 15:19:42 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6358:7e81:b0:a1:c5e:b2e5 with HTTP; Wed, 6 Jul 2022
 15:19:42 -0700 (PDT)
Reply-To: mrsmargaret1960c@gmail.com
From:   "Mrs. Margaret Christopher" <miraclesus39@gmail.com>
Date:   Thu, 7 Jul 2022 00:19:42 +0200
Message-ID: <CAGYy9RfH3s+E40CPzTfCMu-JnLH47t+nt3PaGKPZJHS43A4fgg@mail.gmail.com>
Subject: Hello Dear
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.7 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_HK_NAME_FM_MR_MRS,T_SCC_BODY_TEXT_LINE,UNDISC_FREEM
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-- 
Hello Dear

  Am a dying woman here in the hospital, i was diagnose as a
Coronavirus patient over  2 months ago. I am A business woman who is
dealing with Gold Exportation, I Am 59 years old from USA California i
have a charitable and unfulfilling  project that am about to handover
to you, if you are interested to know more about this project please
reply me.

 Hope to hear from you

Mrs. Margaret Christopher
