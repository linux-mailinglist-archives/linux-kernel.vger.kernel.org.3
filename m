Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB56357AA13
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 00:57:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236268AbiGSW5A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 18:57:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbiGSW45 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 18:56:57 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBE6D61D77
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 15:56:56 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id ss3so29896537ejc.11
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 15:56:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=D5spM2Qx9/pZIqAPtIY4IOlsv/DExEkVOYN91py+lm8=;
        b=P9hTwQOdrgxAijB/JF+UHxNSUKT51Um0qR1jE9nKxJFU1qBXIfusHZQP+sQ6m2GaAy
         obt1onMOyydvBS51JCvS9uePlQmbw2v23nP46XtO/552yTLevVrAM5jQXlspzUuCup6m
         C3wKcWHElCpsi5Dp8/MtOrjdLq1OKT8KIslLEYetVOmJpq1YI3k1HcstqhRv5Zxwhcv5
         PUS91cXXf6P7Aq7jezLE7IWyk2Jrf20GTGNyp4zjWv0L1sJZG1b1HjDPh5ZaBhTYteeV
         bgsAbpKa8fOHw+YkA9lAlEuKPZC3gID6UL6szucrntE3zM4PBfBe0fsbxXuJWG+4sL7w
         aAlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=D5spM2Qx9/pZIqAPtIY4IOlsv/DExEkVOYN91py+lm8=;
        b=Glkiklh8mS//J60xPt4jKsh8mJKTAum9uSuHGSX4bdIERxa7J9FYsZze7rc2WlPi7M
         sLAhOr43rP7QieqexG1B36QNUGvVntuKVaYVIT3o8f5D0X2K4AaPTUnNeJO6WmgFGfjd
         Tm4cyfpPw9ka+bideBcuqQsRcvOhbv28oz5422tiSOXSdy0mEShbXLT0s+cotluBUXb5
         DNOGG9cuDIlDG1rUzYBAhApB/hJXLV6HDqXnR/I+JegWw7FN3NV+WUoU/gIe35/ZCOc/
         2IEQQF3aSqlv74kZSL981RoxUCJKBMT+3O3iIf0ho0XDqYA1ZyFIcM5XWPSEykf8hrHE
         ngmg==
X-Gm-Message-State: AJIora85SiWQhlLYmrWBC8R8aHW1tgO7f7AlJJ9DPy0+JrePkuWIrIpr
        YdhTi2K5e731W9oXKL4WxF0MkhzvieePYypxPOc=
X-Google-Smtp-Source: AGRyM1vtsmMMRkaEtjdBJjVP4xRyXqlM1CRa56kH6RLaRzadZr5OEYLTmCx9pabuf7JD50e4qkgcBGhDcr2VrWIKQ14=
X-Received: by 2002:a17:907:738a:b0:72e:8510:6bfd with SMTP id
 er10-20020a170907738a00b0072e85106bfdmr28413840ejc.688.1658271415294; Tue, 19
 Jul 2022 15:56:55 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:906:8451:0:0:0:0 with HTTP; Tue, 19 Jul 2022 15:56:54
 -0700 (PDT)
Reply-To: krf1470@gmail.com
From:   Olga Bohuslav <jenniferalniston444@gmail.com>
Date:   Tue, 19 Jul 2022 23:56:54 +0100
Message-ID: <CAEjcNx8jswwCdEAU=AdAG2ooQyFyxBT6vs2omqeAhLhSUcsKww@mail.gmail.com>
Subject: A Cry from Ukraine!! and Please Read!
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.2 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:642 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5107]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [krf1470[at]gmail.com]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [jenniferalniston444[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [jenniferalniston444[at]gmail.com]
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        *  3.1 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Good Day Email User!.

A  CRY FROM UKRAINE & PLEASE READ!

I am writing to you because I need you to help me secure the remaining
of my family's life savings kept by my late husband outside Ukraine
for charity work.

As you know, our country has been in an endless war for years. I lost
my husband, children and sisters to this war. All I have left is my
family's life savings kept by my late husband  outside Ukraine which I
am pleading to you in order for you to use it to establish charity
work in any country of your choice.


I have also lost all money and properties my husband and I acquired
over the years, except the money I mentioned above. As I am old and
weak, I want you to help me receive this savings and use 60% of it to
establish charity work while you keep 40% for your self.

I am weak and old and presently in an hospital, I am diagnosed with
Traumatic Brain Injury (TBI) as a result of gun shot and I have
contracted COVID-19..

I really need your help to establish charity work as the hospital
management has confirmed to me that I have limited time to spend here
on earth and as such, I have decided to give back to the society,
service to humanity which is the best work of life.

In your Interest, get back to me in order for me to direct you to the
bank where my family's funds are deposited.

Please pray that almighty God will accept my soul in peace whenever I
depart this sorrowful world.

May God guide and protect Ukraine and bless us all!

Kind regards,
Olga Bohuslav.
