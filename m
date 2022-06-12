Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13871547CC2
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 00:30:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238197AbiFLWaV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Jun 2022 18:30:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237588AbiFLW3k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jun 2022 18:29:40 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F1F915FE0
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jun 2022 15:29:40 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id f9so3696467plg.0
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jun 2022 15:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=H7TfWuJuxniQYZUFW9bvII5Vr1rgNmizaa/XrNQwKLo=;
        b=PevkT1KtDmpu+5443ah1KOAMfbzUh/QovyRLhuW0fp7DUTgjw0kxpWvuVjusLyx3m7
         UeT7Habyc4j7tKJctSzR9P0uPve2FSzoO3vpLq8OLxqUEDJAeOCpNuC0g5mnAJYX09pn
         rl8BFGysDegqNy6YEc7dDir6xETz2SFFyctIOD7hPwtMCpSIknGjUQzbOqI8nch5rDN0
         484E5D0cc1QKRyyr/LlQm+tF9wJaYr4aTBEvFZjqhCoLumzduo/g2a8Mgiqrzuuy9+S7
         yWDZ/EXQ2IRLHTMW+4t/h4icApj8TeMvnLpexUwzJXmpP6zUOKm3zqhl04SXm838zE4T
         oW5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=H7TfWuJuxniQYZUFW9bvII5Vr1rgNmizaa/XrNQwKLo=;
        b=HX5lr5e2IUA1tgyWtmbBlSc1JSivD7hzLuT8+NXhOFiJIkTDneOnozZXigZDGxCcO2
         aeM9BM7haO/G6Bf1KpKCh9UvY3kibBXK0zLYbsUAnUNZHfdtLNBKW8BKfPpYqdPJEQk+
         KE2Iurk/Wh3Q/kpq5XViTW8L/cBY8qSNo+mslDh334SLInFA9CPqOlifC5ehU+6YE+iU
         ULuq/ZvDMKL05Nk/NrR+MUbUowY0axLUlneTg5MaMR0sc90b1VokUvKb9hPOpI5wxFYV
         JWD+EXwiWC7DUTBXZ6wEtRU8cvlvZ6xvWmeYX2mcjzh3rl5P7FAgC8O5ZO4+U2fG+rD6
         6dvQ==
X-Gm-Message-State: AOAM5339TfvEzxF9GaNyyYhrJqmbQP+Qx0iDn/oszSS5JoozopQeaJUg
        vURdMspBCIJeQUwsbYDp3Y7ghJ7H/48964uckZIEYppUqZGBxti+DDg=
X-Google-Smtp-Source: ABdhPJw8ugz4bGzIhbdO49UbOiQrBfATXggJLXwYca1/XjPRcfocLviHFT4FQG+TD0HryLtHLbU4WWqsLFjAdXGIeSY=
X-Received: by 2002:a17:902:c78b:b0:168:8dc5:75a0 with SMTP id
 w11-20020a170902c78b00b001688dc575a0mr27646096pla.48.1655072979552; Sun, 12
 Jun 2022 15:29:39 -0700 (PDT)
MIME-Version: 1.0
From:   "R.F. Burns" <burnsrf@gmail.com>
Date:   Sun, 12 Jun 2022 18:29:28 -0400
Message-ID: <CABG1boOzm2Ya2PphtEXLwUN143HmosfVUt3wAg09hzwJA_59bQ@mail.gmail.com>
Subject: PC speaker
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Is it possible to write a kernel module which, when loaded, will blow
the PC speaker?
