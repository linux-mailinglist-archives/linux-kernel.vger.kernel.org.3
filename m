Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 601DC5ABF1C
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Sep 2022 15:25:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230506AbiICNYl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Sep 2022 09:24:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbiICNYg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Sep 2022 09:24:36 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 347C3B4A4
        for <linux-kernel@vger.kernel.org>; Sat,  3 Sep 2022 06:24:35 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id bn9so4827165ljb.6
        for <linux-kernel@vger.kernel.org>; Sat, 03 Sep 2022 06:24:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc
         :subject:date;
        bh=S2u9Q+tjkz31iCRfklDeKGl5LtO3Yk8kTNoA3qpbsNs=;
        b=eiY6Qg+IHT46rgzl4Cmogmh3qvEMhB+4LjtHSlFkcuJ1zkCQ+CVRy4i87gYaAJS+J6
         N8Pv0Nk/YK1KP915M2z3p/H6gaw/h30EqWFM8US0LYLGud5g1WklqWT2ct6VCy+bAJGJ
         8kDnSmyewMzHzWEQawmwM3W6fZsytkqvsLl1rnOIpasxhX/smPIfa1ADlz19rXwBw54q
         7/JJ2DliCkidFDjTKuYGlfx7IyTBtjsTd/7uEirFRlmY7gunISAeLQLOiyqj1foJ1FY7
         Gn2mzlt1GLa3x3SkHg8xpHDbhwyMerJ5P1sjUFG0j1nQGPiZDpifm3XlNzeL7BJkzH1g
         dBYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc:subject:date;
        bh=S2u9Q+tjkz31iCRfklDeKGl5LtO3Yk8kTNoA3qpbsNs=;
        b=Ghfkfvu1eftv/yN+r0kMSxZUNVSAgvnQ6ah2yTjlKeUJmVhi92Qc4goUiZ4goxFOdZ
         SAcyrg96amKYoKAsqcxHMErZtMr31Zu0pWyhBYaTyGhybhTszKyU96uijIegnLygX0Mr
         B8zoiMbi5gdZ/z6mUhUKtEVjBxfQ0TJPFaBZpPW0rK8nWeFFQsuQWSL1wLF56kEGrkf1
         DqbG9sOXoozAsPEKQ6VegbkmRh1PduuAfX+9U6tAgwRCwX2nQwWxzaMwB8kdFrhJ9IpB
         2l5kALg2nyyoHMC3oLCMFJiOl1I84+bMNdcGRM5gZzG1j9nPjkMtnekLou1s3ChKw3qN
         mzkw==
X-Gm-Message-State: ACgBeo0lanxvj/otxhqxwhl3nDKWzSzI9VJFxcO9IAUoXiVDFyjj480q
        smL0/buhc4P198T+30cKdMdv1kJfqyrDkktB20o=
X-Google-Smtp-Source: AA6agR5SFTYdo+zjKl8XFofHVph6TR9RRvhCplgBba/lMwtKQ79S2f76Hi+WeaGlGgqyHqSji+PtLNSMgyFXqCyf85g=
X-Received: by 2002:a2e:8181:0:b0:25f:e028:a67 with SMTP id
 e1-20020a2e8181000000b0025fe0280a67mr12996015ljg.89.1662211473196; Sat, 03
 Sep 2022 06:24:33 -0700 (PDT)
MIME-Version: 1.0
Sender: missabibatu@gmail.com
Received: by 2002:ab3:1e0c:0:b0:1db:50d2:db73 with HTTP; Sat, 3 Sep 2022
 06:24:32 -0700 (PDT)
From:   Ariel iah <pb589847@gmail.com>
Date:   Sat, 3 Sep 2022 14:24:32 +0100
X-Google-Sender-Auth: JOMuouFDq26rSDvYUp4nsPhMeiM
Message-ID: <CAHRP2D73OLNYgnntRN1AMzqD6T4L7LWRuqsp-8iqX7c_0qcQTg@mail.gmail.com>
Subject: GOOD DAY
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=1.8 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,LOTS_OF_MONEY,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_MONEY autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

i am Mrs  Benaiah and i was diagnosed with cancer about 2 years
ago,before i go for a surgery  i  have to do this by helping the
Less-privileged,so If you are interested to use the sum of
US17.3Million)to help them kindly get back to me for more information.
Warm Regards,
Mrs. Peninnah Ariel Benaiah
