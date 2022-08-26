Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 164D25A29D5
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 16:43:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344538AbiHZOnG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 10:43:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243916AbiHZOnD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 10:43:03 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76A59D632F
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 07:43:01 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id h22so1390863qtu.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 07:43:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc;
        bh=kTnWqPCQ7JZ842fbaIQWezAeKboDsupaMXi3CH+q7qQ=;
        b=Gz5GUtM6XKnbcbJYe9m2fo372C5WN/HGoP1+ZL9t7Vc3t5IdeBim9cpEDk0u0fbdD2
         Ib+8bHn7pdveBms3deDfXuelAv8+bGmaSfP1g/kBjGkt+0HcxpGBkp9aKtQm0Bm4PBCG
         MBh/0f69BjrKsQ/AjDZ+LZIc4er6vFD6Up+Zb+KljhC4r2otLZCMvyTtoI3SApYK6Dks
         o73wxSNQOdv2WxURPSPSj/04ZyX/WrNyrwEIb+s9g0lpzzlbcTd2hAUo/r0TtbIWbYXH
         5IWVdio90ZV0Gy93e0NDrDAtPB/Sckuz2AaJYT2lpjEnLADHIc3RB0k1wsoGfLy3Iato
         FGUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc;
        bh=kTnWqPCQ7JZ842fbaIQWezAeKboDsupaMXi3CH+q7qQ=;
        b=qNYrvM2cUEhtLhP72olCij1ZGYZbmyQRKLgqmUUPuNGu2tDRVGWYpnUgmLxOqeP9pV
         o9v6MmeLPr0Cp8G6olMXoO1ezkVPWs02DLoKG9OXGcJeg6f1S1ZVb7FNslaUnZqg0C0e
         in5+cYJKQjpEfrudRX9SwH8HpeHLr242vrA36dqHyWmGI+S7sKQyYMTcwNLlSOGjE9Na
         ApxWWbOB88t4plT9kjNYFN8YMdjKucrjjqJtprOw8l4vukuBt9CQ5r0R9Gz3bEjLg7ME
         rQPKHl1mFpLaO1ejkloUDUFDXFWZ7OyF0GngXkjaFZXPvVn2y7kNN6re8Of9nsC8tvnu
         Mz1A==
X-Gm-Message-State: ACgBeo1fqU63/oOv7BceRSlFRSM/m6CZ1GjaakyCkRMFYiXtxQcYow5V
        IiujWI836rzbeRSc6Nj71rOIfZAcdBe68Okkw50=
X-Google-Smtp-Source: AA6agR7lOKxjh+ThZe08tEaUJTHLb0NYs9MVH5uJI/AydwR5HeVRwBtkzmXQGJ7fFMDCCyjhfaRJ3+5zagk/9bC4jyI=
X-Received: by 2002:ac8:5f4f:0:b0:344:b3a1:4bb4 with SMTP id
 y15-20020ac85f4f000000b00344b3a14bb4mr7929996qta.139.1661524980659; Fri, 26
 Aug 2022 07:43:00 -0700 (PDT)
MIME-Version: 1.0
Sender: cr.adco.adco@gmail.com
Received: by 2002:a05:6214:7ec:0:0:0:0 with HTTP; Fri, 26 Aug 2022 07:43:00
 -0700 (PDT)
From:   Al muharraq group <al.muharraqgrp@gmail.com>
Date:   Fri, 26 Aug 2022 15:43:00 +0100
X-Google-Sender-Auth: rkS8_AskRhEiKWH5thQITcp41Qk
Message-ID: <CAJyQtkMCbmws8Xde=6YzqjmyL7a=7+=m0CMZ-D1NJeEkgVu7TQ@mail.gmail.com>
Subject: Re: Al-Muharraq Project funding
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.6 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-- 
Greetings from Al-Muharraq Group Ltd.

I have contacted you to consult you for a funding resolution for your business.

My Name is Saif Yusuf. Do you have projects that require funding? We
facilitate the funding needs of private project owners around the
world covering infrastructure, housing, real estate development, IT
parks, industrial parks, film studios, food parks, agricultural
projects, health & wellness, hospitality, education, electronics &
telecommunication, power & electricity and oil and gas sectors.

If you have any queries regarding funding please revert back to me and
find the solution to your financial needs.


Sincerely,


Saif Yusuf
Business Consultant

Al-MUHARRAQ Group.
#sblcproviders #bankguarantee #mortgageloans #unsecuredloan
#projectfinance #startuploan #tradefund
