Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D8B558B583
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Aug 2022 14:32:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231767AbiHFMcy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Aug 2022 08:32:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230288AbiHFMcw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Aug 2022 08:32:52 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19CEA3BD
        for <linux-kernel@vger.kernel.org>; Sat,  6 Aug 2022 05:32:51 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id k29-20020a9d701d000000b0061c99652493so3533513otj.8
        for <linux-kernel@vger.kernel.org>; Sat, 06 Aug 2022 05:32:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=pf5w2nSThK6HvjxZrN1hYdPc9sFZGsfLSeUOEfSqm2h/2zTm6ffbUqpS2lSCRnIy/5
         fAbqeuFBJEGHvoBnpbB0hOB7nbHsTGYD1sFyLC1yniODVlDROb2w2xakEUwIOyuzD8Wx
         st50gcMLtcgsFPt0kaim1Z88VNtL25zJdLhLhW3bcAAWWSMQAnHeLFT0+yxf/iZRDm8d
         m99V2y1TWvP7GrxOMC0hS2vNbYyZuwGOjJQ48RtGw8vdoLiT1DE86Ge3Sn214XFsoaW9
         KWOGpMsRD1mGpxdjClEMD6UpJt8C0qkScKgtHbj/MJv881OVCn7RSkV0I4NN6iGoiS+O
         JBVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:in-reply-to:references
         :from:date:message-id:subject:to;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=KlYdk/ZjzYqJbmYCCEYrmFNc0cqix/YMeMGPPiEuH9dwxr6yY6DIzfepZBGR0X8KcK
         2nmcNebEnI+RhODnx+MRdeXuCl05lQG9LmpRqqIyRkOFwp9HrI2Njjs16CVJ8OF2qK7V
         1ksq4xfB1+blFV+JUcnkKlWZ7gHvwouxfacw4hLyjPJxvuNd1Yb4mS44VaDrcoyIG4a9
         LOJ4P4KJ2t1jeOOfgTJg8u6FC76tZDHmppNGVPO4QEiks3r5tq3xnGGcSIyZb0Bz8DWh
         6rt+5kt1YiJZhkWhGohTEfkgBdqTDHhVnwsvfAGuq/g5WymG3c0igcrj8u9h0/XRahiJ
         FGbA==
X-Gm-Message-State: ACgBeo0ev8nb5pv9BaP/St4FAeOHaCoVcQcdnKxdj2aHun3pOcy5uLRQ
        YrN9Gc9QvbI+xuERGEh1irZ5326u435jd777ix4=
X-Google-Smtp-Source: AA6agR5nZh63flQnDDUBSDKuBx0eGlWMhPLVfjg9cCSnWNT1iCWgBbYgEQuitnGhlTmBk4jzTipaFRTOTePWxIaREQA=
X-Received: by 2002:a9d:7cc4:0:b0:61c:acaa:1c67 with SMTP id
 r4-20020a9d7cc4000000b0061cacaa1c67mr4261768otn.311.1659789170322; Sat, 06
 Aug 2022 05:32:50 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6830:43:b0:61c:bb08:ec2 with HTTP; Sat, 6 Aug 2022
 05:32:49 -0700 (PDT)
Reply-To: buffettwarrenusa@gmail.com
In-Reply-To: <CAOMgKwfycMuFzV-==0NA1oOkS-d07NGdBXF6Ub719iTtjiqhrQ@mail.gmail.com>
References: <CAOMgKwdhbfnnsaFmbo-Z44pbPtQkmAy_YNO_CJ9es6psXVg8uw@mail.gmail.com>
 <CAOMgKwfycMuFzV-==0NA1oOkS-d07NGdBXF6Ub719iTtjiqhrQ@mail.gmail.com>
From:   Warren Buffett <cissedjibril300@gmail.com>
Date:   Sat, 6 Aug 2022 05:32:49 -0700
Message-ID: <CAOMgKweK_KDGWFLMeLGETuyH6KrqdKEQGqW_+YeNCED7D=fTBg@mail.gmail.com>
Subject: Fwd: I was wondering if you received my email a couple of Days ago?
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.0 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4995]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [cissedjibril300[at]gmail.com]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [cissedjibril300[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:343 listed in]
        [list.dnswl.org]
        *  3.2 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


