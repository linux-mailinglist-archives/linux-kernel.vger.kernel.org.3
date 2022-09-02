Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3AF85AAA4C
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 10:42:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235833AbiIBImW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 04:42:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235839AbiIBImQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 04:42:16 -0400
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38FBF9C1E8
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 01:42:16 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-333a4a5d495so9874157b3.10
        for <linux-kernel@vger.kernel.org>; Fri, 02 Sep 2022 01:42:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:sender
         :mime-version:from:to:cc:subject:date;
        bh=H/ao5G+PVt8wDPKQYfdi8x2XpfK8kH39cYWGtvDn6KI=;
        b=eJNkxO/xPaBRAUB0CYOOS3wQdf9Jr0gatyvtU5k8Kh96bE4trYoon7NC54pji54k1R
         4y5m+EpYIUeVKyy/BJkF0s+Izkvd7Q8fI8I65JlP6hg6E7wulrKJIrWSDvzApejfk5mY
         tf2E2cFCOd41KDxGP5427iCQWKBUUdoV+zfsYnW9vlHdlp63tBwPICxMA1VnQbXhW4mf
         THVbrNOM15UDM6LDc00D3qlfD0ctAZxl/SWbeilsiOcxjxaTwsCjFjLeRm3pjVXWKkZK
         v/5PK5kD4kIKWdUC8bIEkstzNZ2y06K18CqCMePQp6Uvp76R1qORQWK9mi9KGdUKXnwV
         aZmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:sender
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=H/ao5G+PVt8wDPKQYfdi8x2XpfK8kH39cYWGtvDn6KI=;
        b=x2aB1zoRwZ+wmw/G7kgwz6pQoOKFMNCSkonecgHx9ZKnj7CjdEyehOpMcKU/a7iCFk
         Mcg8GrwezK5rk+2NfpXD9FOrtJfPmk2/VnexKuUCxT8YzofJe4Q3eDnuzSO9IXBlQBwA
         s8QOf/l/gu0S0v+KUBHrx5/Q1714d0hBgHCSsynZVb2YZ5W087iS9B7TEtUkLkfRQUg/
         H8HfnRwbFeIH0/tI/iHtE2cIyfLaimfGo9fT2VdrHBuOxtE+Z2HXgS2etPRhGNYZ+Mx6
         IIzJMapcJPiaS2XbmnhfmMepYVRlyMknMA+u283tBLOw8kZWUhuBewkVClm3vRmrGDyR
         KFJA==
X-Gm-Message-State: ACgBeo110EjmGSere05H7sQYYYE8ZxfKmGvXCaO3cibbQsEypewm0gNC
        aCiGrb67efrlUr4M1SH3Xmqtqupnc3+W7+zbPcc=
X-Google-Smtp-Source: AA6agR4/CV+0wZrfpngPrghyNUxScuvrXyVHClDCPhCEqSN/MhdRqfT1I5i8QeODvmQaqnviN60KKAQzZ5CJ/a5aHac=
X-Received: by 2002:a0d:ee07:0:b0:324:cb8a:130f with SMTP id
 x7-20020a0dee07000000b00324cb8a130fmr25497927ywe.409.1662108135311; Fri, 02
 Sep 2022 01:42:15 -0700 (PDT)
MIME-Version: 1.0
Sender: gudinamrassefa@gmail.com
Received: by 2002:a05:7010:528d:b0:2ed:15b0:eaf7 with HTTP; Fri, 2 Sep 2022
 01:42:14 -0700 (PDT)
From:   Ibrahim idewu <ibrahimidewu4@gmail.com>
Date:   Fri, 2 Sep 2022 09:42:14 +0100
X-Google-Sender-Auth: teEGG30BcRhTmMxQhQyD2hg3iT0
Message-ID: <CALpdxiZiTi6eDkB_WNZWshDqe5nXsWtJtmqYOBNuMHqa8R5xvg@mail.gmail.com>
Subject: GREETINGS
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=2.2 required=5.0 tests=ADVANCE_FEE_2_NEW_FRM_MNY,
        BAYES_50,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FILL_THIS_FORM,FREEMAIL_FROM,LOTS_OF_MONEY,MONEY_FORM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_FILL_THIS_FORM_LOAN,
        T_MONEY_PERCENT,T_SCC_BODY_TEXT_LINE,UNDISC_MONEY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I have a business proposal to the tune of $19.3m USD for you to handle
with me. I have opportunity to transfer this abandon fund to your bank
account in your country which belongs to our client.

I am inviting you in this transaction where this money can be shared
between us at ratio of 50/50% and help the needy around us don=E2=80=99t be
afraid of anything I am with you I will instruct you what you will do
to maintain this fund.

Please kindly contact me with your information if you are interested
in this transaction for more details(ibrahimidewu4@gmail.com)

Your Full Name.

Your Country.

Your Age.

Your Occupation.

Phone Number.

contact address

best regards
mr Ibrahim Idewu.
