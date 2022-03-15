Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C1514D9F56
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 16:52:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349859AbiCOPxh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 11:53:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344405AbiCOPxf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 11:53:35 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4BB955BD7
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 08:52:23 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id h21so5683703ila.7
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 08:52:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=Cm9q3z6veenE54JZsJK/Uujog+30re99Ep5Qgc02beM=;
        b=Nc0/0K0aEmiwqmJ32//zsVTUEsjL6R9ce1ATVsuLyOl7JJXCHCYVW6/M11XRsgTfeT
         G2nz5e7qA0H28R3PE+qzbWF2+yjHfuDvMVvk7bbv05lAYKWgoXf/gKPcEu6R8tLwF7oD
         C/UsWmmqBS6gAIWUy2VrDKjiBuQDN5BDCx0qAyyMqn81MTCKC9Bl2bRIU2RFC/39AV8Z
         9Khqk7g2ixaaJY4Ky0oufX3ABzCh2h7Xd0wA72H0fmfdOAJfjGn/lVYUt2yv1m/oTGuj
         mZ658zXyjF+NAPaNPNRTypYeWbiN+4iNyPnWvEjVzO8rYTP99e+XaE/yHpkyEvWedQqD
         yd9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=Cm9q3z6veenE54JZsJK/Uujog+30re99Ep5Qgc02beM=;
        b=VuSyg8LTag6IRL8O2/EYdJcc/sY80LmKURxJkLQMmyscOtQJOCDUSmNNxY9DwWSxwx
         VEjsHw4+wAHr09/qx4KrefEs1GHORKZ4H1fDdNpa7kXPselUGmjdxziQ4bA0SjykgGyz
         LvSeLhyjkiCCdQcXl9UA1sXlcTm09b1SqGZ7jYnZsgNHYgvhgNkkWf86JLrO8Jx1LaWl
         9ENTvCWywd28A056mJ0F4DZ1IBXgsRCeTRIC4RJmDoSFbjTJGzN4OubZuhBV661tJN7M
         oVjdGOhyqvrJwsKMSZhKrDJAgiPTDI9a1BjM3wMkd6/bj4Wgn8f8EUndQb5AB5MlCwxM
         cT8A==
X-Gm-Message-State: AOAM531EDh0IZxAbc5um+FY9l0or44jmHeedKw7jxb23MA5d8iEZ9wjw
        ewM+9KyNfGcWoS5/uRJ9cSgWxFvGXW9+xWPGNB4=
X-Google-Smtp-Source: ABdhPJzSiOORyauKS8YrtD+zo+oME9/VocWJiiUbJ+KAFwqMv2JsQeAF78c+oJIKV3/FeW4H7gOzxnSItbEo6PmSKwM=
X-Received: by 2002:a05:6e02:1985:b0:2c6:6351:51a7 with SMTP id
 g5-20020a056e02198500b002c6635151a7mr22039398ilf.205.1647359543186; Tue, 15
 Mar 2022 08:52:23 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6e02:188d:0:0:0:0 with HTTP; Tue, 15 Mar 2022 08:52:22
 -0700 (PDT)
Reply-To: moorephili812@gmail.com
From:   philip moore <janeemily366@gmail.com>
Date:   Tue, 15 Mar 2022 08:52:22 -0700
Message-ID: <CACRERMMGT77p17jn80BCTwsrCJmro2OBsPxqhDL+3R212SzxKg@mail.gmail.com>
Subject: Hello
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.9 required=5.0 tests=BAYES_40,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-- 
Hello,
I will like to make an urgent enquiry. Kindly get back to me at your
convenient time.

Thank you.
philip moore
