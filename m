Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA51954BE40
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 01:21:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239457AbiFNXUw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 19:20:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230131AbiFNXUv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 19:20:51 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BBA133A17
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 16:20:51 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id y6so4235665pfr.13
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 16:20:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=mZ3wqB4NmL7z6lpFr/h15h1rYqsZKafJnUpMVahbEPg=;
        b=WXHAuf3ZpLYkD23fJeIqkj5iLHt5hpyjb5ZUviu6Ry1WYXN/2vWwFSPcGuhWHB2TTj
         v0cEjt84Dz/WcOffamyWiqgGsem/iolL0mmy1J+JnnNCJC5r1Sa5ZdX1j+e1v6sMd4xK
         /X0CLm44fa0A0YuzlsFV5zGGS8xOpFHXqP2HVHRiOShzWrtViWs3awGCdnHsAP/T6Yf1
         /8L1oyhdDElv9BlzPXI3K15/DRJ0M4V6F0aVWaZSoczwmvT9jQFC9KH0isKQv03epLZ4
         AL+DjTRrfHsVRazcRCGWAdUdy872sj+F9cjHMKLgwxSinMghhXRB5ElzCpBSQZboHMq1
         v71g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=mZ3wqB4NmL7z6lpFr/h15h1rYqsZKafJnUpMVahbEPg=;
        b=f5H/U6CaM66XzKQHDyXPT6XRmqecWoe4ND6Uz5OaGG31l62VSY6FeVEhPnBC8oDqqp
         jKSNnUawH4gw65ixc5LTTW1X6VqXqSLDEhZEA8f5FlflW4m/KLCtEDmocQNW+3bmWUWS
         ULSclBCo5eVM4Opk8YTM70rrL2cZq4tgYoRXEzz6VznTrtB/mrINAKQoBRg+cjXIY19y
         ISfbxWV1WcAYwaI+SKjbqpg2q2x+96lJlYDw78nIhXtRFXea1zj9U48/f9iOZp+oHaGX
         6q8pNgA7Cne70VX21Md8QGwusPekKrYBX2pCMpxBhHbpSArJYyRguYz3miB5K0RDeaKE
         5txg==
X-Gm-Message-State: AOAM532Cq1Ld5+MtT4mCfMyeZwS8UldAPZu9cQeGqOWKRBfWuSVrH/jZ
        Lx6uW9nqWxpiGIJfdhxfqUhg4MRJ5auK7ZePImg=
X-Google-Smtp-Source: ABdhPJy9hmuvDZV3Hp6JitZbOccUabdcC3iHzryk2SLzg/LHuyoT1iX+WnILIX94A2vyakYbJ2oNRQpZbYMGKXmBbyc=
X-Received: by 2002:a63:de01:0:b0:3fd:9833:cdcf with SMTP id
 f1-20020a63de01000000b003fd9833cdcfmr6260499pgg.315.1655248850889; Tue, 14
 Jun 2022 16:20:50 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:902:8341:b0:15e:be71:f51b with HTTP; Tue, 14 Jun 2022
 16:20:50 -0700 (PDT)
Reply-To: wen305147@gmail.com
From:   Tony Wen <zhericl@gmail.com>
Date:   Wed, 15 Jun 2022 07:20:50 +0800
Message-ID: <CACab1Ei_E9Kf-o_NQ1WT+JyCZiw+=gwpBudiHFv976MsaJeW2g@mail.gmail.com>
Subject: services
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=3.3 required=5.0 tests=BAYES_40,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Can I engage your services?
