Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FFB44FA758
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 13:39:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241661AbiDILli (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 07:41:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238441AbiDILlg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 07:41:36 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7A3F13FAB
        for <linux-kernel@vger.kernel.org>; Sat,  9 Apr 2022 04:39:29 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id ku13-20020a17090b218d00b001ca8fcd3adeso14102328pjb.2
        for <linux-kernel@vger.kernel.org>; Sat, 09 Apr 2022 04:39:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:sender:from:date:message-id:subject:to;
        bh=OE0cJSkFezf+YJwrcp188z4Lj5GTucq0T2aibHnjxt0=;
        b=N6fsSR9U0Nx0KQlpbm3lx3i7+c8AwEtiGQy9cU3PZG7hdC6T4bgQvzF85D3iO2eHE/
         gllHV8VT44N+ucuVwWllGjTgcVBr/C+X2lkPsSNLaDA+zjT3iqYKpPHSWPT08a43E7uz
         oznLaqvb8TllaxsCmmJLmNSMZHpC8/G15t1Ul4QtPm487lcD9Xn2UW8dQJXNvwfaGXIK
         rk1FK1QPgx61V9neJlIy2P2bxlzDwSY2MgmUElJWJuHBXfqutMBNPYFvt/RoqUlZBfAD
         rcbiiC/KK8zY9wo5hTe3O/VVuM40AfikbMnhV85iRJLF79DeKbjimme8lepGAXQJUEZI
         QZEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to;
        bh=OE0cJSkFezf+YJwrcp188z4Lj5GTucq0T2aibHnjxt0=;
        b=4PJ02dv0jcrh5eWTDWGQOzw46XAJhHasNXi6WYNkB6u4arPktax93BnaIHKbtz+xLo
         od4mP3tazdpOvN9zd5vwOLgIw6OY4ynSDO6ns5ES3wQG7A1hMHmmv8avrAsvZLXflLmI
         N5OMc4dH0Gd5K3srWXkMbg7yl/9sgeBGngMk8pVQlrOjTRdzWtUx8GPodCKMFpxzKYkn
         ctc9DyRk5rNdI/hC/V142FOUI7rRWLt4O/zLWT7F136qphDeYoxKqQ1nu8Mr4RDiQkf/
         VSfgWF/knMRjBSyFUrRA6kuoJm5pjo1p6EuYbsVuXlUV/DdOeHsCFz2T//w4bnqGJYHF
         QxWA==
X-Gm-Message-State: AOAM533qV3YsTzGMXfvtRybaCg2JLUWe5YSqqbyN0ZDaTBcurZppCtue
        U1v9lFuZYUAafXIWz1F3P/zrsD9eqU9K2EX/FQ==
X-Google-Smtp-Source: ABdhPJw/LmEp16TKn6i3ItM/bPNh3/l6gq8uru341M5qAdm8QvDbiTWdhfD5KtiDEfBOJXHXerBzJ8U3V513X5XFTAc=
X-Received: by 2002:a17:90a:94c7:b0:1ca:a0e3:356d with SMTP id
 j7-20020a17090a94c700b001caa0e3356dmr26579303pjw.171.1649504368847; Sat, 09
 Apr 2022 04:39:28 -0700 (PDT)
MIME-Version: 1.0
Sender: alamsalman2000@gmail.com
Received: by 2002:a05:6a20:b713:b0:7b:8f60:6112 with HTTP; Sat, 9 Apr 2022
 04:39:28 -0700 (PDT)
From:   Miss Qing Yu <qing9560yu@gmail.com>
Date:   Sat, 9 Apr 2022 11:39:28 +0000
X-Google-Sender-Auth: Ki4h0wyZ15wtdHwU1hxPJfq9qcg
Message-ID: <CALH+dLBTw8JwpvQwa6tB=7MOwSpHm+XiQV=aQW6DLedK2zPCRg@mail.gmail.com>
Subject: Hello!
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.6 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,HK_SCAM,LOTS_OF_MONEY,MILLION_USD,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_HK_NAME_FM_MR_MRS,T_SCC_BODY_TEXT_LINE,
        UNDISC_MONEY autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I am Mrs Yu. Ging Yunnan, and i have Covid-19 and the doctor said I
will not survive it with the critical condition am in because all
vaccines has been given to me but to no avian, am a China woman but I
base here in France because am married here and I have no child for my
late husband and now am a widow. My reason of communicating you is
that i have $9.2million USD which was deposited in BNP Paribas Bank
here in France by my late husband which am the next of kin to and I
want you to stand as the replacement beneficiary beneficiary.

Can you handle the process?

Mrs Yu. Ging Yunnan.
