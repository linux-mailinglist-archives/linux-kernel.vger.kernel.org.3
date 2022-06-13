Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5506D547F7D
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 08:26:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233908AbiFMGZ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 02:25:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233350AbiFMGZy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 02:25:54 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 601D110B
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jun 2022 23:25:53 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id s37so2221871pfg.11
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jun 2022 23:25:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=kHvqhKfwkSYWgIBUppKUElAVHImwDcI/W0up7OF2SsA=;
        b=N9/7xWdL+HXkVKNIefr4jQkYWZnbgsjUNbgoLWMP4TCLxMIhGeUaY8X6T3BBP3Axqc
         gxQtgwfKmD1ejA90+u8othcUaq4bqsnIhcWOF2fo1TC+ewajCDy+jTRmCYcUifDAiBSX
         FoqCgTMER28/yETHsW++HS37kHkvwI9MBXK3UVHgNLMeGIIApwxt06CW1Cea3crebfWX
         liAszq8zCYTU0DbH/Y0WcZXj1BkCk84A1hqTt7Gd1hQSHR7kA6Jrhch0ms4AibRzZN1F
         5IebhWYoTll7oSPKFw4VC2JIVEZaIgIIBtvyneZrYwS/M9DNbFJPfmgRDtU1b1T9yJ5Y
         7nzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=kHvqhKfwkSYWgIBUppKUElAVHImwDcI/W0up7OF2SsA=;
        b=djssKDrAJTLpNuA0NXZ001OS6ao34XQ+ooPZFS7gMzt+MYy6AY5wLcIrqYaF4n5XBu
         CwvuNUoF81aBWjnIPyXyWz6bnbf6rjgbNdTRht5DL08hGnhKd7HcOri9Zq/ezUS9vysT
         k3xjOKDK4Hxnw/owdQ8Tebn2wsncDJJqX2K0r48O/Q5IQJvJML2NZJr+v78l++e9RRY1
         9EcRWzxavTaiHIDkA8T+4KF2tx39LnwgdWKNMgBORdf4bfx9e1iR1kZJdGpftkkKZyqk
         GfTXWSk+PUP1BTe4daVK2Hx1G0Yhplh1pUgJYqGPzQuGtGpDAOpKdObSMjB7fI1NEbhe
         mrXQ==
X-Gm-Message-State: AOAM533umz+i9tb5PZAXqTa3dNsZj+W7SOkkZP/vy//EmeN5WYEwmwSz
        jcvZLUmL/krUUbmZL+BcS2jWvSzKIans9gdU4Q==
X-Google-Smtp-Source: ABdhPJz9dN8Mrj5SZvaZfuDsIYAAEBjxYZlMoCiHXKewSlf0Nbo1ZYb/1Xl4ZPoynFNiIbmYX0J3UmwUII8lJJhgKLU=
X-Received: by 2002:a63:4853:0:b0:3fa:dc6:7ac2 with SMTP id
 x19-20020a634853000000b003fa0dc67ac2mr50697028pgk.298.1655101552926; Sun, 12
 Jun 2022 23:25:52 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6a20:d2c7:b0:84:398b:ef0b with HTTP; Sun, 12 Jun 2022
 23:25:52 -0700 (PDT)
Reply-To: peterwhite202101@gmail.com
From:   Peter White <petersamuel20118@gmail.com>
Date:   Mon, 13 Jun 2022 06:25:52 +0000
Message-ID: <CACU92gfcpxL-w0b0A8TZaNMRVMMXDAaAcCEnwbKZ7nd0aa9Cwg@mail.gmail.com>
Subject: Hello
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.4 required=5.0 tests=BAYES_50,DKIM_SIGNED,
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

Greetings from here.

I want to know if this email address is still valid to write to you.
There is something important I would like to discuss with you.

Thank you

Mr. Peter White
