Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EE274D1E89
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 18:19:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229686AbiCHRUb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 12:20:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348918AbiCHRUQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 12:20:16 -0500
Received: from mail-vs1-xe44.google.com (mail-vs1-xe44.google.com [IPv6:2607:f8b0:4864:20::e44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8357153B79
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 09:19:03 -0800 (PST)
Received: by mail-vs1-xe44.google.com with SMTP id a186so10195724vsc.3
        for <linux-kernel@vger.kernel.org>; Tue, 08 Mar 2022 09:19:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=5GMDusrPuPOgRhBgh+L7N04qkMMbjZutnt2cfhtCkGA=;
        b=eGhetHvm2TjrrQ75aAsIUFSaLQBDszWnJOkIKA/FC+mCtSErfd1NnSNDvwJuVW7pgX
         9/e+hprskJaN9YKyZUhvMlUFI4S3MkmBYDxoCySuugiy/etP35iwGNvFQ3JWExxhxv/m
         tmfg5GMWixj4fC+FliZLL3SsHyuKVgEeiA4y21Ma6Nq0BhZcWM4owcMGSj+Pdl/8d8th
         mrc2s1oU2lzJhH72KaL80qQ+OeCfBjPQTi0nw+AheFHoAXH/6/73mnpOpGW34VEZv0iQ
         reWLYdOl1bRmPPs0k3NorndpaEoh3mRBYyuD0KkfU++eA1y5A+aYZP1XJAGlPUju6DgD
         ZAQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=5GMDusrPuPOgRhBgh+L7N04qkMMbjZutnt2cfhtCkGA=;
        b=QLFc1kO+rG1dM446Tks4s5LsMVg79H4dazVZrDRk5Ir7TCQpBKX4lJtG/71vSVUkyH
         9RAViUsltiHpJPEgRTzR52pF64O7/R54iGn9WbsFnwLAW4gcoy2n68UG1EwP/BzhnhU/
         f/bkb5/WqyjTKGWnQiW0CmNv+0tbuVkW7ck1r8dhpr92qUpcRFIv6nadem2QubrUTAca
         z932QPcG7z4OboH6uwHW3ghhyBU7qqBwFSWWS9qOJs7Ix0lSuvYK/aNoF5T6F5ahCJBA
         HnYmpMUvwVEjd9EwU6wWFaON2aVdBI4j/oyGhIha8mjspTFUQOkmlLeBi9hb29eZLJgL
         1HeQ==
X-Gm-Message-State: AOAM533qOdZyOtMDRMvngPh92gGVGlqdUFDASNrXHEAV1qVnI0ycsyDW
        lKCPcmbUDU/LBGb6LGELz9aj+vGjFJllaDPNVpI=
X-Google-Smtp-Source: ABdhPJzzyRsSCF71LnQlWqMTIRY3xa70LpLBuvMApieR0jZu3CIF1YWlugKLIhrYssDnMYc+bnuPsPwht5q2T3GToVc=
X-Received: by 2002:a67:d29d:0:b0:31b:82c5:9718 with SMTP id
 z29-20020a67d29d000000b0031b82c59718mr7099993vsi.27.1646759942526; Tue, 08
 Mar 2022 09:19:02 -0800 (PST)
MIME-Version: 1.0
From:   Lara Jack <getdatalist0@gmail.com>
Date:   Tue, 8 Mar 2022 11:18:51 -0600
Message-ID: <CA+9eHWp1Aqzw2S7C+jM75iKXmQDd7xFr48YbADCGRWwruU52-A@mail.gmail.com>
Subject: RE: NADA Show Attendees Email List-2022
To:     Lara Jack <getdatalist0@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=2.8 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FILL_THIS_FORM,
        FILL_THIS_FORM_LONG,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I hope you're doing great and staying healthy!

Would you be interested in acquiring NADA Show Attendees Data List 2022?

List contains: Company Name, Contact Name, First Name, Middle Name,
Last Name, Title, Address, Street, City, Zip code, State, Country,
Telephone, Email address and more,

No of Contacts: - 35,526
Cost: $ 1,726

Looking forward for your response,

Kind Regards,
Lara Jack
Marketing Coordinator
