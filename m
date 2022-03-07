Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75C544CFF39
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 13:55:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240773AbiCGM4R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 07:56:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234370AbiCGM4P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 07:56:15 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4578365827;
        Mon,  7 Mar 2022 04:55:19 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id c20so1307133edr.8;
        Mon, 07 Mar 2022 04:55:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:mime-version:content-transfer-encoding
         :content-description:subject:to:date:reply-to;
        bh=wED+eWLQLB6bp6vblTijazqg1Hux3PHwQ5el6jf8r/s=;
        b=AFRphGXxj00LAlzAgNpKlJhBsNslpwTLRcEuVv+K7d0xKHopfJ4W+cOfeJJR7oQ/dC
         isrrBURX8FOKRqntFGzVVK2oWWpLs9OC7TBOlcElEVMu7LrxZ5mmXDO7P4jKFuAdFUgr
         6FPxqCvwTrga2ikZW6nZEXghmMyIz47GyCxW9Yh/PZoDYCU/UuoCkmsW+XuEfFKfo2rR
         jVeub8GXPyLal+wHQusBNZL+LfwQb12Z27CUSamNzqUT0033NcrXphQR6VfAqubkUR+2
         vLOuvIVgkH6ygBGQtuoaBDtIBlSu+fcO84upgJ9S4bithw/jXgdDtSr/ufuWpLEOwwCd
         kGKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:mime-version
         :content-transfer-encoding:content-description:subject:to:date
         :reply-to;
        bh=wED+eWLQLB6bp6vblTijazqg1Hux3PHwQ5el6jf8r/s=;
        b=XqqjZmvNHEz0+vmpjKAdX9MYQYmgE2hiUB1B1iYa/cg7Vnutdmcrbvz5QokVUcMc3d
         jTDaP86vvH9rq6nZNSSUIzC2t/7J3S6cqTLZxC+Dl2GHAj4Q4dYJvJbvpRQPWl9S/w1N
         MS9X4VQazErobpM06p1zt2tnOeThsAXZ9eaUqYeeP6ITcWmGlQhQGgQzCG/Ui34hessT
         2mT9W6OC8vB6/hZsRNqGoyhu6VI8VMBoU/mG7X9Yjq8iRC9J3SL2AptbYkDZumE7O1fv
         IgkekW8UikZzTWlUxAkPr6g3nOlVcZEz/+svPF4pfFmwagy4zJN0AbgI7gO+wiuL7Gm9
         yi4A==
X-Gm-Message-State: AOAM530IgQ7Fvlg5ej4BSxgJ2MkGbCbfhpED+VI/oy+hgOanrJJXYore
        ESGHhVtg0aU/8U8k5yOO8lo=
X-Google-Smtp-Source: ABdhPJyE5qQq/YL+87E4J7PY7oKWkUeqUb2jzlocT3lFok2yZRioExJh8w68UFCS9AdD0uWBCvhIqw==
X-Received: by 2002:a50:9fa6:0:b0:415:fd95:6afa with SMTP id c35-20020a509fa6000000b00415fd956afamr10912814edf.200.1646657717885;
        Mon, 07 Mar 2022 04:55:17 -0800 (PST)
Received: from [192.168.8.102] ([197.210.52.74])
        by smtp.gmail.com with ESMTPSA id v22-20020a170906859600b006daa190edb6sm4208293ejx.224.2022.03.07.04.55.10
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Mon, 07 Mar 2022 04:55:15 -0800 (PST)
Message-ID: <622600b3.1c69fb81.153ab.25bd@mx.google.com>
From:   "DR. TORGNY LEBENBERG" <barryhinkle5572@gmail.com>
X-Google-Original-From: "DR. TORGNY LEBENBERG" <indi@domain.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Description: Mail message body
Subject: RE
To:     Friend <indi@domain.com>
Date:   Mon, 07 Mar 2022 20:55:02 +0800
Reply-To: dr.torgnylebenberg5572@yahoo.com
X-Spam-Status: Yes, score=6.6 required=5.0 tests=ADVANCE_FEE_4_NEW_MONEY,
        BAYES_50,DEAR_FRIEND,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
        DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,LOTS_OF_MONEY,
        MILLION_HUNDRED,MONEY_FREEMAIL_REPTO,RCVD_IN_DNSWL_NONE,RCVD_IN_SBL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:536 listed in]
        [list.dnswl.org]
        *  0.1 RCVD_IN_SBL RBL: Received via a relay in Spamhaus SBL
        *      [197.210.52.74 listed in zen.spamhaus.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [barryhinkle5572[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [dr.torgnylebenberg5572[at]yahoo.com]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [barryhinkle5572[at]gmail.com]
        *  2.6 DEAR_FRIEND BODY: Dear Friend? That's not very dear!
        *  0.4 MILLION_HUNDRED BODY: Million "One to Nine" Hundred
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
        *  0.0 MONEY_FREEMAIL_REPTO Lots of money from someone using free
        *      email?
        *  1.4 ADVANCE_FEE_4_NEW_MONEY Advance Fee fraud and lots of money
X-Spam-Level: ******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Friend,

I'm Dr. Torgny Lebenberg. Contacting you in regards to a Claim of  (Eightee=
n Million Two Hundred Thousand Dollars) $18,200,000.00 connecting you to my=
 late client.

Kindly respond swiftly.

DR. TORGNY LEBENBERG
LEBENBERG ADVOKATBYR=C5 AB.
Attorney at Law; LL.M.; Partner
Address: Grev Turegatan 44, 114 38
Stockholm, Sweden.
