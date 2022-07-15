Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89F83576522
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 18:10:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232976AbiGOQKh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 12:10:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbiGOQKf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 12:10:35 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58222753B8
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 09:10:34 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id e28so8569500lfj.4
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 09:10:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:sender:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=HfbYB4QQoKk/SqUr9fJ5FGIyk/lKqHIwcC/y2fpzB9o=;
        b=HqQMZOgFGP630fUKSOLiUshHwD+EYfmA19Tls7v/KJu374P1aVKG6MQAnnAZscwGma
         75IONFhCqynmzNjQf2/x8O56/XPPnrnW83XybAh6gpEcNfPJyYZKtFBwyFC1sMZXRsiB
         BrSXVS0Q473V8suRsSZ4LSr6AH3VZnsSrkY5+ASZzfMH36exw1hBTrO2OcJBbBBJxSxj
         6yZkhwhYca4xtSzXrxqgZDta2kDC+u5jAvS/nCIbpBgjX9LljcgAdad2lbrMwQJYnExW
         M/c4XZm5HNNfxHiFQ6Nb8a0W7zC0222LsYQ2hXK4KHkBLl1IMmUYfufSw7i5REfqjFbb
         o6bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:sender:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=HfbYB4QQoKk/SqUr9fJ5FGIyk/lKqHIwcC/y2fpzB9o=;
        b=gvYvyS69r1Kc/ZaGYWmjWZw1kRtscu9qZGwUhucXnURt7KN1tdQT+k0U8jjwoESjkf
         nwNaRljHYarqmsXFZFjT+BB48rsTdzDk31s9e5jMHeBbI0cSylWmNnCCeR9vB5DWzXm9
         v1HFuIpshzOdFdqi/db0hzGQ0Hk2vNJ54U52mwVlcTWBWN5yTjXdIVuQQZvZyKyFMSaW
         aDYN0qNz/NCNtcCASVIdZ37ikhguE9nDvPe5xj14nAoaKml3rIOojgEFDqaZ2rjQq4DO
         5XOVlAVdmvHnRkN0bdfiQFi9Su/T2XAdVw92HI75QgUegGCOdW7pHst4Zwap8uJEwi3H
         xBjw==
X-Gm-Message-State: AJIora9gZ6uMXWGNmNtrgvFtE0MCoB1z1tKeIciRYX9kdjHnERbe2PjR
        +VhfM5aWX1wjj1gHfbBEig7tSzYjAF6eRMzgab4=
X-Google-Smtp-Source: AGRyM1tVrQvr/F75aZ3v57CMgB4aWr7/qeQyEwQxCDdW3UNkAwIYQ/RrdGW0oxVec9PiwTVyQ8ijYXMn6NfhuPU3+r8=
X-Received: by 2002:a05:6512:b1c:b0:489:fc49:f660 with SMTP id
 w28-20020a0565120b1c00b00489fc49f660mr8338796lfu.548.1657901432740; Fri, 15
 Jul 2022 09:10:32 -0700 (PDT)
MIME-Version: 1.0
Reply-To: sgtkalamanthey@gmail.com
Sender: madameyao05@gmail.com
Received: by 2002:a05:6520:25c5:b0:1f8:83bc:9967 with HTTP; Fri, 15 Jul 2022
 09:10:32 -0700 (PDT)
From:   Kayla Manthey <sgtkalamanthey@gmail.com>
Date:   Fri, 15 Jul 2022 09:10:32 -0700
X-Google-Sender-Auth: Yd0LPXaI5R8cI_PDF2BEYA452kg
Message-ID: <CAP8oFyfUinj+WWFT-ZaZWjM2bdAYzsCWMM8hJjWeYPA2mg2Lbg@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

oi, voc=C3=AA recebeu meus e-mails? por favor verifique e me responda
