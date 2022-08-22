Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84CA159BCED
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 11:36:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234513AbiHVJgG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 05:36:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234491AbiHVJf7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 05:35:59 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF9E531237
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 02:35:57 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id u22so9392655plq.12
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 02:35:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:from:to:cc;
        bh=RNqF77wjqF8iy1HAW8fdhj7DkrHd1/Ilt+i0IdRP9TY=;
        b=DMF1AHaz7G5p+sBrA5DoCZZBZUjMJPVM0VwCfg0LowQSSgsW37c+qScS8vyhioq8c+
         tqkawiKKfhTxf56fMQ8GfL6AQNCI9m5d75jPXqj5y8a5SA5VMkXcUfB1pVkK5EQP+t1+
         RKJ07EGgroHG19OzPL/RKE0PX6Wv0p5h0q37/9G4k5i7JmaMzUa+QKT/m0llv/KO24Cp
         Ea9QpHFHcABvgp0NQrlcpeD0GkQE14fSAElaI9uSMdLeHlTGwg6Ds4UUJB7xgGyeBG7u
         yvcNc0QeOxfj2pm+f3V+47yYDKeyP7NnMyCCw18MI8JwnKNd3/6nTAu9H4zzhNK+jR3c
         WAhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:x-gm-message-state:from:to:cc;
        bh=RNqF77wjqF8iy1HAW8fdhj7DkrHd1/Ilt+i0IdRP9TY=;
        b=RUcre6VKwhJJo3FuMrinUFNvLWHSmt+U94hlf7hb3xlPwFy8JK47oxWrjIhp9bA6vu
         PoHBkklGo/S1IDvji90Ni7l/Kd5V/XTfMhln3ZXHn5S2Z17hlgG/VFAMolFurRLiPbzL
         eI2HlvBHImwXlobQ4PjTdE2IkYN+LU4nDeAzE7kTWIU3SzwJeGgfxJ5XxmUetp/CeMdb
         U9f5YyKRCt3Svvomq9IK1WFBk9hTXAHAGaufik+zSGfNyiMYE875jPgiilZT8keGAgh5
         kxVLrbQy07vH0AHl2ZOPgWcNq0M51VC4Spga0PDm9I0wcIfAojQJvzEhnkDeMGmfABMc
         BhsQ==
X-Gm-Message-State: ACgBeo2dB+OfFX66UH8ORTnEnTvfT0HFeszXME0Kfg/4F68GR8WD4cc6
        Om0UGFjyeKpVD0nf5vdYp3pDeAdmkQNG9QocFj8=
X-Google-Smtp-Source: AA6agR64uFQZV4B22EI3dd1A8M1oLdFqOtCsn4fN9SANHg9TRzU8n4sVjCU8roblRh6vUPGyR3ouN1LAby52wzJF1TU=
X-Received: by 2002:a17:902:dac7:b0:172:e189:f717 with SMTP id
 q7-20020a170902dac700b00172e189f717mr6549726plx.129.1661160956938; Mon, 22
 Aug 2022 02:35:56 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6a10:f94f:b0:2d5:2242:724 with HTTP; Mon, 22 Aug 2022
 02:35:56 -0700 (PDT)
Reply-To: info@depfinfinance.co.za
From:   Depfin Finance <williamwinfield60@gmail.com>
Date:   Mon, 22 Aug 2022 02:35:56 -0700
Message-ID: <CAJpWKqwB3Nu6gELU5qfGn_FZU+ZGxHLuJ4+e_GuuNMWT09hUBw@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=1.6 required=5.0 tests=BAD_CREDIT,BAYES_60,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=20

Good day,

To whom it may concern.

Do you need a loan without stress to pay all your outstanding debts,
Depfin Finance is here to help you with the Quick and Easy Application
Process. Apply Now Online via our website https://depfinfinance.co.za/
Instant Loan approval =C2=B7Customer Protection Blacklist Protection =C2=B7=
 Debt
Consolidation =C2=B7 Business Loan =C2=B7 Personal Loan =C2=B7 With No Cred=
it Check
at 6% Interest Rate =C2=B7 Debt Counselling =C2=B7 Flexible Instalment Serv=
ices:
Flexible Repayments, Customer Protection, and Paperless Application.
Instant decision, No Appointments =C2=B7 Apply Now And Get Instant Cash in
your Bank account.

Send Reply To: info@depfinfinance.co.za or Visit our Website
https://depfinfinance.co.za/apply/ and sign up for a quick paperless
application process and immediate approval.

Depfin Finance Contact
Tel: +27 87 510 7793
WhatsApp: +27630900202
Email: info@depfinfinance.co.za
https://depfinfinance.co.za/
Address: 208 De Waal Rd, Southfield, Cape Town, 7800
