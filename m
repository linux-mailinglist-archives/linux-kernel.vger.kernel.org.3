Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F22D0564E08
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 08:56:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231830AbiGDG4k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 02:56:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiGDG4i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 02:56:38 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7ABF55B6
        for <linux-kernel@vger.kernel.org>; Sun,  3 Jul 2022 23:56:37 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id z16so6217714qkj.7
        for <linux-kernel@vger.kernel.org>; Sun, 03 Jul 2022 23:56:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=Zr7FJr/ROqrH3KPFcIbpCq/ZL9h+i4UX28KOdEhJPUU=;
        b=WNdUuSQIRzW8mLLL9XLBLx9N02jUsaNJ1c0XgzXzI+1BH7dYl+bKZ2JMWXGdaiiimd
         jlTi8TQYfPB8wvlZJiNE6hcJWNvGJOxYs1SKRP2E5qaC2uaQ5CC6yoJ+XUCM0iS7YNYm
         DYDFQvIK/GWbHdbg3YD73aX7FdmOSLmnZwWaAvGslC59mwfOBIU3RrZL9Nyu9z5KNvGP
         BOPE8/mAAkUj3uDEww8V9CvGRVSsISLdbAO4I/VOXrA5EgiyKcrG4FkEDbf5E6EwW9TZ
         Oi2/NtyKQnXxSMnb6D+Z7nCKC03B/yokwBWq3Gr0KBoRkQnTGmQilE5aoerPKVzsNs0y
         QQFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=Zr7FJr/ROqrH3KPFcIbpCq/ZL9h+i4UX28KOdEhJPUU=;
        b=53f2NHYAR6QsIdhhJgSJgNmlJsZ1doJFhdYUNHson/s5ysG45gqTeuimpPV1+hENI0
         HQwcsZPoo52u/wZNkq7gb8W+YIxwdoCYxO9iD35BaAyXRQ2FamEjfzTNQsbpW7sHAFzG
         NqfOdmFnouQzdbFxn/nOF9Y+Y8ey6NNHX6P3EQk88KHYh6eyn1X/bJ34wl/qZ9fotL0G
         l3wLnr5v836NQG3WQab2N4+dq/EVUDFoKoe+HdNzybp3zJax5su6jKJOfkhU5go3BnHH
         2ja4l9CPqfgnFC6Xv5GTPDVsuF1AeRbpY85GhyWi1mKWkIzhQsyFQSOGi+OgFd0SaJ9P
         D9mg==
X-Gm-Message-State: AJIora/dv/+fqRfBl/b3umA39uau5ecRqgTIb4CxA21SVfwivjbF+O9A
        rRqNWqF2Bz/FfRSFciskh/clxLEscegGtoU7EFI=
X-Google-Smtp-Source: AGRyM1uTtgBHeq4KoTw9fxdJfBGsNbFVKwkzrXmxDsPlGNZA6TmQQZ5G0LD1/AmOA4ryP5eJSjwjQ5su13dreAr11Xo=
X-Received: by 2002:a05:620a:bc3:b0:6a7:9e01:95ac with SMTP id
 s3-20020a05620a0bc300b006a79e0195acmr18860279qki.91.1656917796590; Sun, 03
 Jul 2022 23:56:36 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6214:e89:0:0:0:0 with HTTP; Sun, 3 Jul 2022 23:56:36
 -0700 (PDT)
Reply-To: mariam002musa@gmail.com
From:   "Miss. Mariam Musa" <aziztiemtore91@gmail.com>
Date:   Sun, 3 Jul 2022 23:56:36 -0700
Message-ID: <CAB3j9a6bhx8tbLSat0px3xHmJKDv2-pOdP7Dwd-aHRvPJtgNHw@mail.gmail.com>
Subject: Good day frined and happy new day.
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
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

Good day,

Can I write you here? I have urgent information for you here, With
utmost good faith?, as you know that my country have been in deep
crisis due to the war,

Miss. Mariam Musa.
