Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E782F5785AA
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 16:41:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233680AbiGROly (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 10:41:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233240AbiGROlx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 10:41:53 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17D2423BF4
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 07:41:52 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id ss3so21592430ejc.11
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 07:41:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:sender:from:date:message-id:subject:to;
        bh=qTzzEFqVqfVSZJ7ChklAwZBx0KgyDZHBHrQ6Tlza+GA=;
        b=BghSdIiZM2RrwPGN2KXuSQOWvpk2KgnIhKD9YBKgtJlPh3Tg4nhr/n41/OO0+wCQKy
         rXCffi4/JYtRBO3sGWU6INQRU2Ua7aq/V1AFHmNRA4gCsCjRtLNpbkfw6yaHcFA9xqVN
         gVvVojpJrVtObQdy0F8AOX9g1gJWyvkvvyV+7VloDupkMluBE0Vc+drUetm8NhK6OjPu
         IneW0oBgaGFmT37gCHSozR4uGK53Zq4XT1vg5NK/Z1Qe5YtZxf47vvo+8p8CYhhBu6Wn
         3peLF/+HbRWyYRK0VFCclO3DnAmoyzfxCPwtkgKlbfcBkTV1Gj98tWg53yFO7YdQidxj
         5nrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to;
        bh=qTzzEFqVqfVSZJ7ChklAwZBx0KgyDZHBHrQ6Tlza+GA=;
        b=plDR2KVImyX8ZHrsBPh6upk6rfcPjmL9jg9RgKd1Kj548ejZMCkzQ0jzCW/EHPQplH
         dZwhP6OncK8mgm69v+LV+oRi/vGupt8clJ1Itm0krrNmx+Op29hm2nE6XIv0U0t1paiq
         VbuKD2mnrZGjO5EuNwe4lzv6Qe4TB+3hIjKPY+S6yUODrZMdXZCHfI+ZdYqU7HVae9Ia
         qAn6BoAiGziotSZRIk6NbiHvSMGpV6ZOJskmkRSLHWkmYpJyn736RAaC1b7c2lktGi+k
         bzoPXbbHDGtMRyf1PwTcUkdUdM7EHGLQLJ6OsiHXJ8taSQOFf24R5lSXhrDEoABJ7Q5I
         P7SQ==
X-Gm-Message-State: AJIora8t+pP9egJdgesBuZbh0l7HYCsnohYB7JkRSl+uQnBEEpj/Kuld
        2jV85Ll2F1i8a4Gi5HYIF7TbVWDSBi7FumVIG44=
X-Google-Smtp-Source: AGRyM1v5ZP5/509OMx27fmijTfqif/QhP/CI6gCbzFC4sClzmGmmmUvmuCyObh5zJFyTR7YNSSqdQX9zzEAhyMJBRfM=
X-Received: by 2002:a17:906:cc5a:b0:72b:1459:6faa with SMTP id
 mm26-20020a170906cc5a00b0072b14596faamr26445753ejb.221.1658155310504; Mon, 18
 Jul 2022 07:41:50 -0700 (PDT)
MIME-Version: 1.0
Sender: reymonddennis@gmail.com
Received: by 2002:a17:907:c03:b0:718:82e3:2298 with HTTP; Mon, 18 Jul 2022
 07:41:49 -0700 (PDT)
From:   andriybohuslava <andriybohuslava05@gmail.com>
Date:   Mon, 18 Jul 2022 15:41:49 +0100
X-Google-Sender-Auth: xkT7gB7cuJQm1-8yhKlaBZVI4ac
Message-ID: <CAOOE2sGtkXAz7jTWQKDES20WmHbTW3bi9nc56TLJkmsCmVJsKA@mail.gmail.com>
Subject: Dearest,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=7.3 required=5.0 tests=ADVANCE_FEE_5_NEW_MONEY,
        BAYES_80,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FREEMAIL_FROM,LOTS_OF_MONEY,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        UNDISC_MONEY autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:62e listed in]
        [list.dnswl.org]
        *  2.0 BAYES_80 BODY: Bayes spam probability is 80 to 95%
        *      [score: 0.9221]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [reymonddennis[at]gmail.com]
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        *  3.0 ADVANCE_FEE_5_NEW_MONEY Advance Fee fraud and lots of money
        *  2.5 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dearest,

    My Dearest Please read carefully, I know it is true that this
letter may come to you as a surprise. I came across your e-mail
contact through a private search while in need of your assistance. am
writing this mail to you with heavy sorrow in my heart, I have chose
to reach out to you through Internet because it still remains the
fastest medium of communication,

am Bohuslava Andriy, a 20 years old girl from Ukraine and am presently
in a refugee camp here in Poland. I lost my parents in the recent war
in Ukraine, right now am in a refugee camp in Poland.  Please am in
great need of your help. in transferring my late father fund, the sum
of $3.5 MILLION UNITED STATES DOLLARS, He deposited in a bank in
United State.

The deposited money was from the sale of the company shares, death
benefits payment and entitlements of my deceased father by his
company.  I have every necessary document for the fund, I seek for an
honest foreigner who will stand as my foreign partner and investor. I
just need this fund to be transferred to your bank account so that I
will come over to your country and complete my education over there in
your country. as you know my country has been in a deep crisis due to
the recent war and I cannot go back.

Best Regard,
Bohuslava Andriy,
