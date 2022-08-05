Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F6C058A95E
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 12:16:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240741AbiHEKQr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 06:16:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240559AbiHEKQb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 06:16:31 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E3FBA1AF
        for <linux-kernel@vger.kernel.org>; Fri,  5 Aug 2022 03:15:34 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id dc19so4127877ejb.12
        for <linux-kernel@vger.kernel.org>; Fri, 05 Aug 2022 03:15:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc;
        bh=pSKuz9BJS/Qwel4yBJUKsJP++c1z8gtIosTtEbMtN5I=;
        b=gck0UKShMSLbdV0VdCDOVnjiBdRKrTWHxqVV7aTCZPW1myRkWHqrohk6ZF99OoZsIL
         0fo6ALIq3qtEUUYOonJgS9bMPrageprovDad0j8LMqPE9/vr/KGlBv4NelP8hDtqO3yr
         UjjcxiB8lzCpolAL7ra0fSaQD6aIb0W676brgcdWID5CvYgteZZNRwvfX/t/DCnEGHuv
         d4TeQY7n4X1uNchsvMXQ0BMXuwRwjJ1Dym7TJxvOGx6amzfnGnjV4Z/qixqk0Ig3Pex3
         I/3rmXuM7UqhEdS8ZEhkKj9DGUnqQfVDwu0xqe+8MYytk0XuNn7Yl2KBKrnuC0vsXZU3
         zMpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc;
        bh=pSKuz9BJS/Qwel4yBJUKsJP++c1z8gtIosTtEbMtN5I=;
        b=lQbNjH1sYMUigZX7es4q9jyYYRiz2lgt6JhZzrEfKkZNAd7dALV/Up0QlQjmfWPerU
         USItfcHFUCxg9slJM52CNh62FyVkJ1TDCyAZ1NkBDwAjG7KSUvvFn5sUQG6JMXpOeicb
         cxbeEg84bj1YqyTXB+EGps2sUTFCmb0lrcpInk6fe0Odq97+Rl3cOazaxtNJpZXo7cFq
         WDW7sHTHa5zXLb2LTSQAGZqHFIdpvXlaEynGyBNJG2YUw1+chUNs19VZ9P/RTGgqsfuc
         vAOjRiXrbfoI28AGTZWZBg2Hmed+7CxOLGJUJcXyCwPZYMx6sVu6GFGwZeIsvyJyDeWu
         /BfQ==
X-Gm-Message-State: ACgBeo3FRDwJ2Dv3RL4HuOi4ZnI7qRq0pQa71jGQmL4/2sL+Aji/NYmR
        jqDTJhEABYEDFxkCRcCJxMwMuXNf5gbuoiJzU3Y=
X-Google-Smtp-Source: AA6agR6VSjIbagy4oKHaOhED/UilEBrSkBmwL1CWlU5mz69lKDUVcBMzyMKt/TW5mqqRTj4G3Z2jW6nrKuulanI8CV8=
X-Received: by 2002:a17:907:d25:b0:730:cdec:ab12 with SMTP id
 gn37-20020a1709070d2500b00730cdecab12mr5017860ejc.263.1659694532521; Fri, 05
 Aug 2022 03:15:32 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:906:2745:b0:730:d730:f98a with HTTP; Fri, 5 Aug 2022
 03:15:32 -0700 (PDT)
Reply-To: davidnelson7702626@gmail.com
From:   Alio Baare <aliobaare1990@gmail.com>
Date:   Fri, 5 Aug 2022 11:15:32 +0100
Message-ID: <CAEqq5SsL7=o7=uE_oKwX4_sE0So0ANXQjirsQOnx5xphAxkF+w@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.3 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:62c listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5272]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [aliobaare1990[at]gmail.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [aliobaare1990[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [davidnelson7702626[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  3.2 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello friend, I want to send money to you to enable me invest in your
country get back to me if you are interested.
