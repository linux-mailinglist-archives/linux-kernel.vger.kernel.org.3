Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A2545B0EE7
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 23:09:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229723AbiIGVJN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 17:09:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbiIGVJJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 17:09:09 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6536B07C4
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 14:09:08 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id l14so9761581eja.7
        for <linux-kernel@vger.kernel.org>; Wed, 07 Sep 2022 14:09:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date;
        bh=FcyQcUXi9xALQQ6Lm7VNXiWYStBjH/LCUTADg6v4m+k=;
        b=qJ9O4nSXAP2HkXlzkSydlwpAdZ0/fzUik4a08qPR2dSl0RcUg1SxmMUwqV6fJ/UUfk
         FE3ze+5QZt5/0W/i0NNXYKeSa35FXX76g55j5k23yQL5HwIT5vc4Bw1nfTPZTitBojsD
         HO1ne3BaB1rISbA065OLuQH18H2qz9zakaFjabK7+vUp0kLUv37kdHsyp7Y9wvK2Gyyf
         MByYcBOoGy0BP9B/Z+r7VkvrJFR7rthviQKiQT7YBNo0vMMETiRnemGmBiB6DiAFLN1a
         TbYW5EuwqROJOuMHXwbIRfg3R0y7rieHt2yujju+rZEMaCaqQbleQUmmAH0MgjgT3KP7
         ldVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date;
        bh=FcyQcUXi9xALQQ6Lm7VNXiWYStBjH/LCUTADg6v4m+k=;
        b=IpKtjXc9yaxHriLCNBVQAWMG18NCJ93aXm1XdRFDTF+pooPdzOb0acfjucy9OkEn12
         vO+8rcdJ9sv8E+dM1y3zp4cAVtLtwQJ1O+tcZQrBMMoW41wIqqCJ3gh2Cq1oudFo+Rtu
         EAkL4nag5QlvHpZ4Q75hfgCfE3oci7TfNYNIWaTvnGfH/J3rPqpFyD4YZCwKVH4g/JxN
         pD5o3RhM9Bly34oSZvrSKMEl2OF3mMS75WnAL4Y2WsdNLEDvtK+iDraf6TIuKw5w6pEs
         KpIXB+h/gQCtAKRgdDxnwOEBnwABIzcZvUxOWw6KSfrbyTRPU0Ott89EPgPEnJuZe4qR
         Zi1g==
X-Gm-Message-State: ACgBeo2Z0XvaX7hZa5PIEF6DA0tGMWHDqu9wEkoTH4v6ab5niyjAdael
        TAjvK43TExJSSN3Iu4w2KwjUWzLULHX3uNTBTxI=
X-Google-Smtp-Source: AA6agR6T+72dsn0FfxvAX2O9VRoLsccr1GMEYeLcL/jHMoM41EcjO09DtdYSTlI4yuJFRH3EJ2GGh1hx0TSqKqmPOAY=
X-Received: by 2002:a17:906:8a65:b0:770:7e4b:89cf with SMTP id
 hy5-20020a1709068a6500b007707e4b89cfmr3608075ejc.489.1662584947379; Wed, 07
 Sep 2022 14:09:07 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:906:7051:b0:738:3d0c:8413 with HTTP; Wed, 7 Sep 2022
 14:09:06 -0700 (PDT)
Reply-To: maryalbert00045@gmail.com
From:   Mary Albert <maryyalbert98@gmail.com>
Date:   Wed, 7 Sep 2022 22:09:06 +0100
Message-ID: <CAHCHywEzMso4EHDbLFmgdbirAxiJDX7dpEk8rmudKdPrB_z23Q@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.2 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:62b listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4944]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [maryyalbert98[at]gmail.com]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [maryalbert00045[at]gmail.com]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [maryyalbert98[at]gmail.com]
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  3.1 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-- 
Hello,
how are you?
