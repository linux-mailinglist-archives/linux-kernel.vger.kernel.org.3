Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15CAB590714
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 21:44:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235881AbiHKTon (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 15:44:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231131AbiHKTol (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 15:44:41 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 801B39AFA2
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 12:44:40 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id k26so35284024ejx.5
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 12:44:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc;
        bh=gTeX9fcMILulN/R2lCkK6WL9eh85Yf+eJQ1WCtejHFA=;
        b=pfmqsGOW1yd/2SpYx6MnOQ59nJkYq79lmlSGGxtLi6fR49hKJD/9UEOBfvSinksTad
         xNTlYZbiZkoXA/7VG9FiPjCuBSR/rb+sxQE8fULw93DndRDEuF8HqrQI3TwxjfbX341p
         R1r2/5prEd6rFOeoHT1C4HT0B1sOqa2lUSS/6e3rkvKKP/6cSV2Rf0mdVXiOro+nDK55
         NLtReVmtAeK2IAPFBQX9vYeDsowJYtliONMz5UryxcWO/EGtwxsyuXyeOLi9RY04+DTr
         q1nSWUSNWtXxsMzW1atfXbgxROsNZHuEj4Ft18XynznVbKSWlcgTJPrulys+Wze6i11+
         5qgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc;
        bh=gTeX9fcMILulN/R2lCkK6WL9eh85Yf+eJQ1WCtejHFA=;
        b=QomT3Z8XnHJjH99jEnzxLf7YNppCA2oYNupbfzcMpiWBhfumaYLahbS71mrrGrH+k1
         LyzGfEaANEfgf2dRFg6HSgOvLnBSk1iF87F1sR+4V158ieOMpL8suBPCc9E2DiF8e+ND
         BYcTqspZPA3WE+jISffKAGMXnSp6H0cIW5jmE6fY2o2dTAYLyiaM+l9pDGaw0+jkpBqT
         L3QygssNtzFR0k5HAM/fJnXNDRUsdk8ZerxhA/+HkPWasThTsbPg39Pefo49T7Z2GUEI
         7EdXbX2ReTese3EUfJuWiYT5QVyT1lisbj277lzniLMs+cVfPZRode0O7g4tr4fp1Pa5
         kR4g==
X-Gm-Message-State: ACgBeo3DbSAcdIDNOA4UIR6Q8CEjuiQ24Gd2a6g/+EfD54E/rEsrCW53
        h9TH9QcNcXZkKyy3ES38tv/q50rFwTOcbAFKEMI=
X-Google-Smtp-Source: AA6agR5z1MTDDJMb7hNbPIyyPYOMl17R/63UDKZqIwaDxTADEXpFfF9EXggVB22A5CV+boPtZsou3MeUThJChlPOTyY=
X-Received: by 2002:a17:907:a218:b0:734:ca71:966e with SMTP id
 qp24-20020a170907a21800b00734ca71966emr426371ejc.480.1660247079111; Thu, 11
 Aug 2022 12:44:39 -0700 (PDT)
MIME-Version: 1.0
Sender: mr.mostafa.ahmed899@gmail.com
Received: by 2002:a50:3442:0:0:0:0:0 with HTTP; Thu, 11 Aug 2022 12:44:38
 -0700 (PDT)
From:   Miss Amanda Kipkalya <amandakipk@gmail.com>
Date:   Thu, 11 Aug 2022 21:44:38 +0200
X-Google-Sender-Auth: OJXLf4QSMUWi_BJ_yTFsaH3xw94
Message-ID: <CAMBkNG1R9RidkpvHE6qtNdDT-FXNYkCaHrBKFPAVXyi6GX0eFw@mail.gmail.com>
Subject: Re: Re
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=6.1 required=5.0 tests=BAYES_95,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_HK_NAME_FM_MR_MRS,T_SCC_BODY_TEXT_LINE,UNDISC_MONEY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:633 listed in]
        [list.dnswl.org]
        *  3.0 BAYES_95 BODY: Bayes spam probability is 95 to 99%
        *      [score: 0.9635]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [mr.mostafa.ahmed899[at]gmail.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [mr.mostafa.ahmed899[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  0.0 T_HK_NAME_FM_MR_MRS No description available.
        *  3.0 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: ******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Dear

How are you doing I hope all is well. My name is Miss Amanda Kipkalya
Kones, I am 24 years old, I am a girl. Please i have a business
proposal that is why am seeking for your help because of my present
condition and I have the Mind you could be a good person, I think, and
there are good people who can appreciate the value of friendship. I
will tell you more about me as soon as I hear from you, well I will
say that my mind convinced me that you may be the true person to help
me out in this my present condition i am now in a refugee camp in
Burkina Faso.

Please reply me back for more confidential discussions about me and my
proposal okay, i am living now in a refugee camp, here is my WhatsApp
number +226 55641872 and you can also call me direct call on the phone
number as well, I will be waiting to hear from you,

Kisses and warmest regards
Yours,
Miss Amanda Kipkalya Kones.
