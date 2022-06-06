Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2D2453EC8C
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:10:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239964AbiFFOaN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 10:30:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239943AbiFFO36 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 10:29:58 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CDE8CBD74
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 07:29:57 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id i29so6822853lfp.3
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jun 2022 07:29:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:sender:from:date:message-id:subject:to;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=FY8+/CY/lpu4ZH1JCYbLKweKDg/03oKNg++dw+3w6+KgEDBzV6Mon+9IJSldws5w4A
         pDAoOpi9cJ9EXR8S0qoSmvJMEYAopQv7XIl4dpEKqvXNF00wUXm4tyyLSiOEDmDLDvPR
         aEzUyAlsKNAOVN0pC3+FcWHR9cnAWFHpz+iNZ+TDjlmWJfSfMriCu4Quf6wQNPpkS6LA
         8SUSccgA8FUu7zDhtkqE7OCRwAhnPw+VNQOe+wIRcPjycI/MJxmT3Pa0zvTim+cnk7/l
         YUZuRNbj6c3+1LfeODwTVcCVgI5wV4hAOKIvdND9bRiMHdKK37k24oGZC66FCZEXSgGU
         YcOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=PDgMf5/8+mjEkyPuFzs1M/vXTTsrpFBdNnLNAa6ACHEwhP57LLv5yUVj3d45uQOmBA
         3wDmFMaLpL+3ELWAt1VbRohu9fw2C7p1px/lKZHjn71iwSmeFJLEoUwdh/llZ2kLrtnM
         hcSfO+B+/MAW4dAeYa3p08ELqzMx27v0a0ma1wuSq1tfyJ0u1c3OcsqYi07NEBXe/aea
         TMCtUs5AilsGrkYpEcdaJv73BGIzbgpbsg2uvE133Mvh0hTTvjKj9Oj/i7ogt8rTGIq6
         T5VDx4KrAGKI90sXJcZYnoXMpOgjrRdOxbwtzQIVHdpKrbBRnFkZK5MVrvBjfS3jwxay
         n+Ng==
X-Gm-Message-State: AOAM533/tpa5u4oO5s2CGXO4GCoFL9ays6HtJj4Z4QklRnYZ+tJ7/6rv
        dgjlq8jsMXIxexYZFCe/4IaL+3NOB9OPGK9p1oU=
X-Google-Smtp-Source: ABdhPJxbfZfH1Zd/tFc4qcdtfOnlbJCRpqvwGZBCV4x+iIkV6A4BhsKK7dIaI6pHZLkkailq5po9rfn/fXnGj56pa5I=
X-Received: by 2002:a05:6512:33cf:b0:478:ff22:edef with SMTP id
 d15-20020a05651233cf00b00478ff22edefmr15721034lfg.430.1654525795553; Mon, 06
 Jun 2022 07:29:55 -0700 (PDT)
MIME-Version: 1.0
Sender: bossmouba9@gmail.com
Received: by 2002:a05:651c:1a29:0:0:0:0 with HTTP; Mon, 6 Jun 2022 07:29:54
 -0700 (PDT)
From:   Ahil Lia <mrsliaahil070@gmail.com>
Date:   Mon, 6 Jun 2022 14:29:54 +0000
X-Google-Sender-Auth: gnL4SXA2P-YPhvj6iuX_TwN-0D8
Message-ID: <CAGE14-B1RPge9tF8Y3hkiJHT7tBTFvxc7yqPNy6qGLKbmUg2pw@mail.gmail.com>
Subject: Hello, I need your assistance in this very matter
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.1 required=5.0 tests=BAYES_40,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


