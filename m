Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5B404CFC23
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 11:59:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241677AbiCGLAH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 06:00:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237606AbiCGK5n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 05:57:43 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17AD913D6D
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 02:18:47 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id gb39so30735687ejc.1
        for <linux-kernel@vger.kernel.org>; Mon, 07 Mar 2022 02:18:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=t6DcQhfFfmQsTksI9MS4VLvsVDH6vcj7lwbO1DMdjXk=;
        b=gN/WZ4SG1iuZO1PrFNTgdInO35WIdE03MwgG9h1W4nYVDu+UUMYoUuDbQtsxl105S8
         onm0rswjQExopt8ZyDFxNgFhOao9/HlSePOv3e9bFN/YNNeRHkuR+HrNtCEbq2RpUoTo
         uCXY83fNIPolDCobdq1RgBl61RtKlKQ0E84AMCHwp9nd+jGztCgsjbxQb2jhz8cnAZpH
         ck7BIXB2iL9UcbV60pIsZeigyzYpy1q50GwKOnwpsMRMeB6spG/RiEx0ImDq8wcSc54A
         dKJQzjjxIWt4PKzZUKMNlEyPGlKcYon8Foe/erPXuzXCGM2OVwibNYhbTxQxfuXHamAy
         C5Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=t6DcQhfFfmQsTksI9MS4VLvsVDH6vcj7lwbO1DMdjXk=;
        b=DIp4rbbiw4Z/ZUpNvLR6b8hZAdNN8Xo0XUlxx7qbuGpLqvSmBSRfT6obgBE3YU7+08
         nuoy1E5RX/h3HmaIuIhpixvU074KjuXdpbbpiuW1wTKaQxClsyEgs/vfuhzY2lEJ4qpM
         s557Pl3opDMoCH8Wx9WSySnmCnu0FZsoMHP8tm8amGtHM8ZUq/6eI4IpRzOibMPVJtRR
         HzH3XgAz10Xvf1o55NdrpYi2BZqDBj+wWybhRYSTnKDNLUCrwY+UeyeyDif+VqC16y5I
         uSFlsa1oWELYaVu+xgi5DiPA0Crnf5Ey6j289TcrApRCQnYwmJZ0tfLDuwrh2kFXiruq
         J4Ow==
X-Gm-Message-State: AOAM533gpVL4V5qxR/jg/WrRIMSrO6rdjaWATCTZBqsSH9YiM/Ep5kPi
        I83thkfiEaH7HGTFg555RKh36TOi1J1yO6odqsU=
X-Google-Smtp-Source: ABdhPJxF1qDr9htAtIeKGg2EryZobSpEiEX0uCo1aP7Rn8nhlBVeqQF+DO6pZ1w5QzLtAAEFCTXD3SHnbgmuk/4loyE=
X-Received: by 2002:a17:906:1645:b0:6ce:de9:6eb1 with SMTP id
 n5-20020a170906164500b006ce0de96eb1mr8344963ejd.616.1646648325617; Mon, 07
 Mar 2022 02:18:45 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a17:907:2d20:b0:6da:73ad:bd17 with HTTP; Mon, 7 Mar 2022
 02:18:44 -0800 (PST)
Reply-To: brookw094@gmail.com
From:   William Brooks <businessoffer11@gmail.com>
Date:   Mon, 7 Mar 2022 23:18:44 +1300
Message-ID: <CAH35tw21qCDoGO2ZKH+8bWr6Ej8uOcXyxk8FHd3x9TOfRGdcdA@mail.gmail.com>
Subject: Urgent message
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.7 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:633 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4209]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [businessoffer11[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [brookw094[at]gmail.com]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [businessoffer11[at]gmail.com]
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  3.6 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-- 
Hi,

I am a banker working with one of the leading banks here in the United
States. I write to contact you over a very important  business
transaction which will be in our interest and of huge benefit to both
parties. Kindly get back to me for more details.

Thanks.
Mr. William Brook
