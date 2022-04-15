Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6133F5028F0
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 13:49:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352722AbiDOLwL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 07:52:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236334AbiDOLwH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 07:52:07 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3781E326DD
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 04:49:39 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id k23so15002563ejd.3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 04:49:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=xuQFioi0dwwWxLZ8FiYEMtP8ec4Uq65GR6esnXuSZW8=;
        b=TKNMRc7Mi+iELQo44tel26V5CNFRfEdztKslugYoy80UiGsGyjVTjD3IrEE9VfPcvV
         6da7i2quxF5LhQY+P8pIvhPN5MFGihOvHWUZf5MkkraQSyhEUTDkQknakNPDwS/a9Jlm
         1YD5YRVtm46NvEzvWiFty8exFbDLFH5WtqVXsTkEPACDNj0BHyo50a1LFWBD99+jR+EL
         Ylp9XWOT5ih+pnHlJZe92JvlV1/ssZSTYevoPjE3dYzMTTWpjlYZI9lgSLF7djlGRn1M
         ZcrAdi3kqi+NP0e0Q8rLQOBt2P4Cuf9gD7VGT4tqfMkdofhS6T979AnKz/HbhgNcQXUk
         0zKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=xuQFioi0dwwWxLZ8FiYEMtP8ec4Uq65GR6esnXuSZW8=;
        b=adX2i5Tyh0PHRFwppECWlycLs0FV+TuNrPSmZ22ClWHBfv+lEav8lJKGzmrzDgGRm/
         H1YKTCDrl1tas3yTPDpLvqCPdWlFKg5NRdjzIOhpNFXqBww8pe0TbYWwiYJsEP90pcgT
         37uaAYdMJCHOb/r4hSfZUGkjZmMvbyF7aIG0GfpNAKssMCzOuQ6xn32LPMHmzLN1oVtC
         keKob9jJWH4pXbr2ctdfsk0ZSgTc4t8YEij0ooz8nBvLzSJNju/O5XIkOxWtJN0kTxW0
         Zg/eXbncp0uePmuArvD2vC0hH+TNSoe7HyYRzan2M8+kEqcG7CL2ZzSbGEmq9h3YgfSJ
         L+bw==
X-Gm-Message-State: AOAM530p6D2vFNoqDMj2K0sL2RtEOZ7y/1xWKA44FjtSqRjEgTbNp+Qk
        rSM9PNZZ5Y0ugds2Vt5lY4Mc+cZTIk2LNdgqvtQ=
X-Google-Smtp-Source: ABdhPJzOFisHc72OBzW56tYN58XH6JoH7XnUK5H3tnRp3bxCrUVDkrBQQxQy6tYa1O1lYxSl2DfbVkbSpn1LToufp5Y=
X-Received: by 2002:a17:907:6d9d:b0:6da:7d4c:287f with SMTP id
 sb29-20020a1709076d9d00b006da7d4c287fmr5725230ejc.741.1650023377583; Fri, 15
 Apr 2022 04:49:37 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a54:284e:0:0:0:0:0 with HTTP; Fri, 15 Apr 2022 04:49:37
 -0700 (PDT)
Reply-To: josephdscb@gmail.com
From:   Joseph Dadzie <medwinbo@gmail.com>
Date:   Fri, 15 Apr 2022 04:49:37 -0700
Message-ID: <CAMnyrf_Z_C_i659KYGX=UQ22UbThApunHNk=A=R1abj2g9ev_Q@mail.gmail.com>
Subject: HELLO
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.3 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:641 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4990]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [medwinbo[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  3.7 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-- 

Attention Please,

My name is Mr.Joseph Dadzie,Branch Manager Standard Chartered Bank.
Are you the real owner of this email address? I have important
information to the owner of this email address.
Due to the sensitivity of the information,I want to be sure I am
communicating with the rightful owner of this email address to avoid
making a mistake.
write to me so that i can give you the important information for your own good.
Congratulations if you are the real owner of this email address.
I am waiting for your speedy response
Thank you for your understanding
warm regards from
Mr.Joseph Dadzie
