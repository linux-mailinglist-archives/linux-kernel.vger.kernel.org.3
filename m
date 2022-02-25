Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E14C4C412F
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 10:20:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238998AbiBYJUP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 04:20:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238986AbiBYJUM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 04:20:12 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5987254544
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 01:19:40 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id i20so1259390wmc.3
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 01:19:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:mime-version:content-transfer-encoding
         :content-description:subject:to:from:date:reply-to;
        bh=RJ68TeqInk+TVbxgDvO8h5StnFiK/1aAUXR3+oOBLqU=;
        b=Ve5BgLqDSD/pURw9xbkE8nnOImT4eYJvx+S0Bu6H2wW8hatq63UBuRNbE2dZwxFhow
         98oFAeu1QFBg8iWuONcAmanSBHJ6sQJM6RRa6+unj4BqiAtNfsjlGlMedpW28yL8licR
         rMwoAiPjJoZtT5ZoGfaXrOkOr5R2CptPWiEWB9+gZLNRZfZl+pxuaYSw5bjpe/oojL+2
         vGCI6fg1ndF16HHw68o44TV0KR+yPcA4Hw/iFTGyaN3IEh550ev0vTwdrx88ko5o1FXj
         +h6Kpyx0aYmQA2N4wtKZRtV61pqsXhBMBBKOXe3u6gzc/PFYM56LXnQyzr6CiR2kjvm4
         jZJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:content-description:subject:to:from:date
         :reply-to;
        bh=RJ68TeqInk+TVbxgDvO8h5StnFiK/1aAUXR3+oOBLqU=;
        b=UbG2OKQ4WxYHMGmYzTOPFFSz7Ch8y8ls+WhmbZzlT54/5ZUFzQ7Llx5lZVoohJ8VS5
         zSPj0fOJd5etbuMWEXidUO1P7vE7jdH+zcKIzg1m381ZtwjN1yDoaerrzFpizS4xI7Fw
         4E8yIFdDxL6VlnJhM+RwcFtksifhQpo7p3okZ1mWuJ9J2LvMMS9Sw8ADOysUQcciW2cK
         VuTTyGb1546SsqS4vs/NrUwU0LFCSa9TJ0i1VjdNWQdfgSdM2hls2PPOxt+zqmtjb8dm
         m56Wi0l+h50vEt+nvz8edLBWfsUB+DHv2eWIaVLPdPTZyeui+dTMn9xfdF3QGhZmnSMJ
         vvkQ==
X-Gm-Message-State: AOAM5327b7WnAeTf2OiXQ6uREWk80DezhyVSQwy5UECI1/uAx7iJLAop
        2ISTf1QznSLk/EHN95lJ7BQ=
X-Google-Smtp-Source: ABdhPJwOUNdod3gI1wcSuKSyxaZI1c8eVsBwhVyPoz8Rg60l1/vNkzJ+tnROEHeq1FU1Yidq3hltUQ==
X-Received: by 2002:a1c:2bc3:0:b0:381:3dd5:5707 with SMTP id r186-20020a1c2bc3000000b003813dd55707mr410777wmr.31.1645780779290;
        Fri, 25 Feb 2022 01:19:39 -0800 (PST)
Received: from [192.168.0.18] ([47.62.107.23])
        by smtp.gmail.com with ESMTPSA id z5-20020adfdf85000000b001e713f774d3sm1686476wrl.61.2022.02.25.01.19.37
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Fri, 25 Feb 2022 01:19:38 -0800 (PST)
Message-ID: <62189f2a.1c69fb81.29647.5adf@mx.google.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Description: Mail message body
Subject: UNCLAIMED PAYMENT
To:     Recipients <kellyjulius49@gmail.com>
From:   kellyjulius49@gmail.com
Date:   Fri, 25 Feb 2022 10:19:37 +0100
Reply-To: masayohara21@aol.com
X-Antivirus: AVG (VPS 220225-0, 25/2/2022), Outbound message
X-Antivirus-Status: Clean
X-Spam-Status: Yes, score=6.0 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,REPTO_419_FRAUD_AOL,SPF_HELO_NONE,SPF_PASS,
        SUBJ_ALL_CAPS,T_SCC_BODY_TEXT_LINE,UNCLAIMED_MONEY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:331 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4975]
        *  1.0 REPTO_419_FRAUD_AOL Reply-To is known advance fee fraud
        *      collector mailbox
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [kellyjulius49[at]gmail.com]
        *  0.5 SUBJ_ALL_CAPS Subject is all capitals
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [masayohara21[at]aol.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [kellyjulius49[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  2.4 UNCLAIMED_MONEY BODY: People just leave money laying around
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: ******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

UNCLAIMED PAYMENT
You have pending funds on your SURENAME. kindly connect with masayohara001@=
gmail.com
 for details

-- 
This email has been checked for viruses by AVG.
https://www.avg.com

