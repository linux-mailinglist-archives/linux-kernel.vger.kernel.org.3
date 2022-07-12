Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 106CB5722A1
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 20:29:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229537AbiGLS3k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 14:29:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbiGLS3g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 14:29:36 -0400
Received: from mail-vs1-xe32.google.com (mail-vs1-xe32.google.com [IPv6:2607:f8b0:4864:20::e32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F44D2F655
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 11:29:36 -0700 (PDT)
Received: by mail-vs1-xe32.google.com with SMTP id 125so1948990vsx.7
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 11:29:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:sender:from:date:message-id:subject:to;
        bh=k7izWfIBBaFev3famyk9p7ENglhF6jIeWP6CHQZlG80=;
        b=K6TCphShMQabD0aKtb87T/lBJ6m3wOqSkJY/mXZAqbu7yJxBM3mwrCv7tjxd0UCLSi
         16Xt2d/fo4Ivd3JiPSTU+GXgsEnBcLgDS/3q9GsfPlyKA9aV1g85Rr6IsFfOFo5wzQ27
         HziZMsOTBededpn9N8d3rXFOiH+C6QKtuZC/tK76TGqYf5rQrbaSuMT8R67Wo1xPRkjl
         FVYrCd1wRFdCANmzBkh1vjvEUVqhmZviWiuwahVNv/FhPBWICx+T1LhfqqJog/07v+Q0
         I5RXws9VShSPcUCYoV5z08ycqmhH0kNSA96qboWFmpRGeHGkuVZKeRENuUC59JcGChOj
         USQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to;
        bh=k7izWfIBBaFev3famyk9p7ENglhF6jIeWP6CHQZlG80=;
        b=VNa71qDV3hlUq5mXb/30bxIW562vGeEeKfiQbgc/0v+ghmKX3cZa8/KTEofHhDtWru
         GLSxbpbpeh1NPsjJTj/lsHT4LnXQ7w9cuEe9Excj2UCdwoX5Vu2A4SNlULfGyqVoFgme
         xosxcgCVZhzG7mHdPgMgdxlGcZaoiMbasb0gVoiF1PEkrRVzhaEnAbBbaT7vWYAH3mbG
         KoDVqkNpSr6MaOY6Eb0UB36tlkfbY1IoHRL2D4lngaxMucGY4Ixm3vJ4S4pAwKrplwvM
         miBPNZmjNHDCZLyB77qqUvSeOJAf2cJ/4SWFGxG/MaehnqtD5OXRNZYEtTIorQeXiQwv
         OQ4Q==
X-Gm-Message-State: AJIora9sTkpwrwLxgy1gc7bMZ0J2FUUKb8HwHefhcxu4R0mFq8Fg9ODG
        xhQBPVA1N2rFjjKYSYCErkhw1WYQOj+NCJtXJVQ=
X-Google-Smtp-Source: AGRyM1sBhYpAocuNI6B/uTnnofXmtJ3Tt3G7In7OoVJ6bvozxZlBtL3Egni/ta8prX5O6xF4sg5Ei6dHqAUpeDLQi/o=
X-Received: by 2002:a67:a648:0:b0:357:3c58:dc0e with SMTP id
 r8-20020a67a648000000b003573c58dc0emr9076476vsh.87.1657650575126; Tue, 12 Jul
 2022 11:29:35 -0700 (PDT)
MIME-Version: 1.0
Sender: andersonmore123456@gmail.com
Received: by 2002:a05:612c:2414:b0:2d0:f8c0:5eda with HTTP; Tue, 12 Jul 2022
 11:29:34 -0700 (PDT)
From:   Armed Zango <mrarmedzango@gmail.com>
Date:   Tue, 12 Jul 2022 06:29:34 -1200
X-Google-Sender-Auth: O0tRLgG1p-9lxTbZplXsAjMjzsI
Message-ID: <CAGRFRQO0a5cYgnTzKZRpCCqDO7QYNCuApkPrk7h4XrsAcyeYOw@mail.gmail.com>
Subject: URGENT RESPONSE AND TRUST
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=6.3 required=5.0 tests=ADVANCE_FEE_5_NEW_FRM_MNY,
        BAYES_50,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FILL_THIS_FORM,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,LOTS_OF_MONEY,
        MILLION_USD,MONEY_FORM,MONEY_FRAUD_8,RCVD_IN_DNSWL_NONE,RISK_FREE,
        SPF_HELO_NONE,SPF_PASS,SUBJ_ALL_CAPS,T_FILL_THIS_FORM_FRAUD_PHISH,
        T_FILL_THIS_FORM_LOAN,T_SCC_BODY_TEXT_LINE,UNDISC_MONEY,URG_BIZ
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:e32 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [mrarmedzango[at]gmail.com]
        *  0.5 SUBJ_ALL_CAPS Subject is all capitals
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [andersonmore123456[at]gmail.com]
        *  0.0 MILLION_USD BODY: Talks about millions of dollars
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        *  0.6 URG_BIZ Contains urgent matter
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  1.6 RISK_FREE No risk!
        *  0.0 FILL_THIS_FORM Fill in a form with personal information
        *  0.0 T_FILL_THIS_FORM_LOAN Answer loan question(s)
        *  0.0 MONEY_FORM Lots of money if you fill out a form
        *  0.0 MONEY_FRAUD_8 Lots of money and very many fraud phrases
        *  0.0 T_FILL_THIS_FORM_FRAUD_PHISH Answer suspicious question(s)
        *  0.0 ADVANCE_FEE_5_NEW_FRM_MNY Advance Fee fraud form and lots of
        *      money
        *  2.8 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: ******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-- 
I am Mr.Armed Zango,from west Africa i have a business deal to share
with You in the sum of US$10,200.000.00 million united state dollars,
that is been held in our Bank here in (B.O.A) bank of Africa the fund
mentioned rightful belong to one of Our late client who deposited the
money in our bank here ever since he died nobody have been able to
apply to claim the fund so I wish that you will come and assume as his
foreign business partner also note this business is risk free not to
be sacred or doubt is real please my dearest one also Noted.Once we
succeed in Transferring this fund to your wish provided account in
your country it will shared among us in agreement of 60%40 i believe
that after this deal joy and happiness will be on our face and
family's please reply to me with your details so we can move on with
this great plan ok.


Your Full Name.......

Your Age&Sex........

Your Marital Status......

Your Country Name.......

Your Phone Number......

Your Occupation.....

Your Bank Name......

Your Account Number......

Thanks Yours Friend
Mr. Armed Zango
REPLY TO-- (mrarmedzango@gmail.com)
