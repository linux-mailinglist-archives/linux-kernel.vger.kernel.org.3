Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A818554F50F
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 12:13:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381736AbiFQKNl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 06:13:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381655AbiFQKNh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 06:13:37 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB98D20BEE
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 03:13:35 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id g25so7839014ejh.9
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 03:13:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:sender:from:date:message-id:subject:to;
        bh=KhgoAFL4YE8/w5osrKBBcrivW48W7YCjIa5U+90LszM=;
        b=IozZi4thPYspyRFGAM0wEZ8bu1mpvv+hdz/lhFfVezJ+JiVd8vVSydQ75GmcJxGW7O
         trKDElyiWZRBVGEGKzDNTRc0RrILQgBWDxz255YZotxdkw0Sw30TbjmXImnKIq8FhZKl
         SI7YoyzSDqsrqiQsydG/znxopzzJoiM8DHYNBj5bbrHFnH6OQEM11nFKUF7nx6e+ekpk
         OHK8BuBhP/lQQKpP9i2uqUsLivnjcoH3+tMQK4fVFCXdW8dS5aJ3yVEGxkdwimSh7K4P
         gpIhHNmiVTmhSE17Yy6J3BvkSBx+K+KiPVuC4lYQQHHEtbI0RqcZI/Vdv9EVs9AS0GTh
         Ti5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to;
        bh=KhgoAFL4YE8/w5osrKBBcrivW48W7YCjIa5U+90LszM=;
        b=Ji1Im9ZrED4N57Y6Z0Yb06pi88MWWkhUS8U0nQML+J7WvXmuPDUIfwsuW24Q7bLM3X
         JurDDjEgT1hvscBBG2Niy9WlFCjGny2CK2R5HmBsyFt86MprIA8xHkq1fgj3atSVxFih
         7G08SfauQeGh72HOtKfeo87vpJvgTPoiISOcVJQ2Do9QPW673Rd0ZqJ7MjNmj9gpJc5L
         S6nWAVMKiI8kx/LoTXsYK8uyze/s3IdDn8yzEyBigH8BaPn12C2zIZTVKT6AFBb/6JvE
         kVE1XqVEEeX8HVnU11+s9C/DeMfdZSl+vfZFOJJjTYWHlaEqX5nNAU1wZDKqMTZ5rTV3
         ZPhA==
X-Gm-Message-State: AJIora++CFggE/vWjwvUQRzozJRxugav4NFOBxvtbkMJJfyHoIvtgtqw
        Rloai53yUbk9HhfmlRVPmvIYDU7NfNKFMYs8CO8=
X-Google-Smtp-Source: AGRyM1tcq0FpysLJ+7FKgbQo7IbAmjHKoQctDpgHQUviNlD4fPIEREcNkQGw6xGLFjqiI+gXutuCeBAL9j5COp50Q4M=
X-Received: by 2002:a17:907:868f:b0:702:f865:55de with SMTP id
 qa15-20020a170907868f00b00702f86555demr8718964ejc.24.1655460814192; Fri, 17
 Jun 2022 03:13:34 -0700 (PDT)
MIME-Version: 1.0
Sender: barpeterkobby4@gmail.com
Received: by 2002:a17:906:cc46:0:0:0:0 with HTTP; Fri, 17 Jun 2022 03:13:33
 -0700 (PDT)
From:   "Mr. Jimmy Moore" <jimmymoore265@gmail.com>
Date:   Fri, 17 Jun 2022 13:13:33 +0300
X-Google-Sender-Auth: -nl26qL9x8My2eNuDwwHowqP2js
Message-ID: <CAKSfp-zyRRn4QHrw=wPEm3xogrcjwNOeNe3DnVEXCdjSw1fY0A@mail.gmail.com>
Subject: UNITED NATIONS COVID-19 COMPENSATION FUNDS.
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.1 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLY,LOTS_OF_MONEY,LOTTO_DEPT,MILLION_USD,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,SUBJ_ALL_CAPS,
        T_HK_NAME_FM_MR_MRS,T_SCC_BODY_TEXT_LINE,UNDISC_MONEY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:632 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5110]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.5 SUBJ_ALL_CAPS Subject is all capitals
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [jimmymoore265[at]gmail.com]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [barpeterkobby4[at]gmail.com]
        *  0.0 MILLION_USD BODY: Talks about millions of dollars
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  0.0 T_HK_NAME_FM_MR_MRS No description available.
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        *  1.0 FREEMAIL_REPLY From and body contain different freemails
        *  2.0 LOTTO_DEPT Claims Department
        *  0.8 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

UNITED NATIONS COVID-19 OVERDUE COMPENSATION UNIT.
REFERENCE PAYMENT CODE: 8525595
BAILOUT AMOUNT:$3.5 MILLION USD
ADDRESS: NEW YORK, NY 10017, UNITED STATES

Dear award recipient, Covid-19 Compensation funds.

You are receiving this correspondence because we have finally reached
a consensus with the UN, IRS, and IMF that your total fund worth $3.5
Million Dollars of Covid-19 Compensation payment shall be delivered to
your nominated mode of receipt, and you are expected to pay the sum of
$12,000 for levies owed to authorities after receiving your funds.

You have a grace period of 2 weeks to pay the $12,000 levy after you
have received your Covid-19 Compensation total sum of $3.5 Million. We
shall proceed with the payment of your bailout grant only if you agree
to the terms and conditions stated.

Contact Dr. Mustafa Ali for more information by email at:(
mustafaliali180@gmail.com ) Your consent in this regard would be
highly appreciated.

Regards,
Mr. Jimmy Moore.
Undersecretary-General United Nations
Office of Internal Oversight-UNIOS
