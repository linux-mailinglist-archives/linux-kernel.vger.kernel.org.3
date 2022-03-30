Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B8164EBA17
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 07:22:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242923AbiC3FXJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 01:23:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238534AbiC3FWp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 01:22:45 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED26113CEC8
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 22:21:00 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id b17so6434852qvf.12
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 22:21:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=r2CZrBGtbL0Pl7Rh/IEQ3HT4fnj/n9fRqx3pUJSK67E=;
        b=AhpL+aqMBVHNNGN2Gw40yA1FkX4Ei3hlJY50qSZ6SJqCfDg513lSWIvWXf0dyk8dqf
         4x7v1i+JgWt+XWAcaY472vjaSlrQtQNzCzv1qfI15nFlCcbCYo5ks/eMpeQlLedvEdOs
         dw50KUDtL0GkulAfnFMeKmzYkQRUXFc+MDvbIipjLkG1BX0XC0KGqIuJ1UKiOlmO4PPh
         pIqXL/OaSKDRX2qrTJEx3gDjzBis5FNu3ctuXM2tq7UCee+jUOdo/jlt6vlU38n+Cp3j
         DcsGvu2S3fAnegI+pN+Z1Q29OdcKD96dYonCsi9tjlEJqfo2xHj2spOm8vBc+MHnNefn
         7mCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=r2CZrBGtbL0Pl7Rh/IEQ3HT4fnj/n9fRqx3pUJSK67E=;
        b=KnCzws0nsGAxqj2I14tFwIUmv/WZEkvlqVY56LecJj6Xdxw2og+D8kIqGYnkMiocCR
         YmWF7TLrUyouVnQa1YzbKnSIoE2yt+5hj/EP5PfjH4VyIq1gMxE7gZuAoO8RxDAkQ6eS
         RjZ5Oe6qYHLxqjPgqX8pC8eM5N/CA+U1hpYsV/Jm96/hg4+dIUX9huayGG881LTcGc4R
         XB9lizcMabkYnWJ147fPxbjFoF566gtc9VIP93nBOxkwZ0hZIyjckTaA+vgYWuH13NaM
         7eCpfzW7cVftls2nsFLE8fC3ZozhnWpuItVox9L27UaV+nRAHTvUtDVj+OkY2EMpDZnQ
         uSuA==
X-Gm-Message-State: AOAM530XN4Iz86+gBkFU4kfnD0zdmeCJtwdUNjNBZWaAhttlVo9J9LVW
        WXEPv9uN2WsBhLB+Ex/M2cNqFcVUTfNOzYEu9ezrBtguM4I=
X-Google-Smtp-Source: ABdhPJx1LTAItEEalfTaOyheaiJYvi7bHV+3KJUClGJDCJ5nufiEdee9GVh4Mg0zhzpDlOgeVj83n8oBmhUMHCyj+/k=
X-Received: by 2002:a05:6214:52:b0:440:f824:a7f3 with SMTP id
 c18-20020a056214005200b00440f824a7f3mr29124189qvr.125.1648617160892; Tue, 29
 Mar 2022 22:12:40 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ad4:5d4c:0:0:0:0:0 with HTTP; Tue, 29 Mar 2022 22:12:40
 -0700 (PDT)
Reply-To: rgicompanyltd1@gmail.com
From:   RGI COMPANY LTD <antonioman6060@gmail.com>
Date:   Wed, 30 Mar 2022 13:12:40 +0800
Message-ID: <CAHVKXceFN2t1hE7gWcx2wqKpn+8KprPqJrnMKAN--t2P4d_wSA@mail.gmail.com>
Subject: Greetings from Netherlands
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=6.0 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:f2d listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [antonioman6060[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [rgicompanyltd1[at]gmail.com]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [antonioman6060[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  3.9 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-- 
From: RGI Company Ltd
Address, Netherlands

Greetings from Netherlands

RGI Genealogical Investigators particularize in probate research to reveal
missing capital, inherited estate around the globe. We can also help you
find wills, retrieve/secure copies of certificates.

Recently a woman from the Rothschild family, one of the famous families
contacted our firm that we should contact a business minded person who is
capable of establishing her capital in a lucrative sector.

Our professional co-operation is 2% of the capital and we will be settled
after you receive the capital. The capital transfer process should take
just a matter of days as we have the mechanism and expertise to get this
done quickly.

Please if you find this letter offensive ignore it and accept our apologies

Warmest Regards,

Dr.TJ. Wood, CEO
RGI Genealogical.
