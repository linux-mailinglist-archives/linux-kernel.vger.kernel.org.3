Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22D3E508181
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 08:55:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350626AbiDTG6N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 02:58:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244258AbiDTG6K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 02:58:10 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28CE4140D2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 23:55:25 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id i20so835361wrb.13
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 23:55:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=/rL+TycpMQLfB5P4Zn9xgGfUWg8yPCNTwrE46ZNldMM=;
        b=XRlGw7SPOK3dzSuyCTmq+OHcSlRqjAvmsNUlHREj2nTrSTRLEe64D+AlIICfKbbY/4
         XScgWsfNV8nJPU3O34gN8XBcjfogx0LO22KdoLZ1nlRrQ/pmvqoIZiif1XRdWI0M4eS9
         sklIjs53wa8VXq2uGSjs5YykQquFuPk4kkdtuto8gPG67CNNKgnX9m+YB4IKcM4/DdCD
         hsargPscnIVXEAwtiQ8HHZd3eVhjk2x0uvBpg1PBLUO3o2MxpW1iHDWeT92/LiXCPyb6
         y1tth0EKmCIISM6O5AaTIcWa+tmqCMT+wF/k4d4GhIy4JLBem66ye3iA6xT7c4e21pL7
         63qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=/rL+TycpMQLfB5P4Zn9xgGfUWg8yPCNTwrE46ZNldMM=;
        b=XU1Cp365XaD5Cn9dG1PEfYKlDJF6kAuUrnIeClC/YThURfooID2jTOqfYavwRVGA4s
         8PW3e4kreLTUmoUjpOdzKdmoUZvxTGlL5lOBH66xxZp8OQCKPcn5CFCKnh7FC1cOabF7
         ALihjgqrjuqE08yAhW24u8h9XcEUPha4x8ShR/xN8jY3+oy55PiOzleubL9q1PJSoFNa
         U3avqR+aTwAkplJ1auGvq698A/AzKDyJGQrag14CuhYgdz3pEZISm+11aLT3fQrFXgkE
         Piglv7fImQbY6efyXlK/3m0rIu6HP/qqf3lrSK+SdKJ3KKb5iLsqf2L0h2AroSduA1N8
         c0Lg==
X-Gm-Message-State: AOAM532tyzyZqxGCSZzAMJCx9kzISGfRo+VttZH0bDxtq4tp1ipCUA8B
        evE5apGb5YRniDAtx9S4OwmzzGT5ZAQxerOETPk=
X-Google-Smtp-Source: ABdhPJzuFt77oOJKllTaNFQ+yYOPQgUbTYzQXr1egruQmAZwzZUh2Y8afaaBL7Qmh7EdyBqU6XEX5wLJksN/mI7eCxg=
X-Received: by 2002:a5d:64eb:0:b0:20a:8d83:7d31 with SMTP id
 g11-20020a5d64eb000000b0020a8d837d31mr12134814wri.160.1650437723486; Tue, 19
 Apr 2022 23:55:23 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6000:1cc:0:0:0:0 with HTTP; Tue, 19 Apr 2022 23:55:22
 -0700 (PDT)
Reply-To: dravasmith27@gmail.com
From:   Dr Ava Smith <abaulkarimbanneth24@gmail.com>
Date:   Tue, 19 Apr 2022 23:55:22 -0700
Message-ID: <CAFOX5LbjzsZ8xPNSxdwrNfpUagbo8djQFSitiQoHU8t_0g0EwQ@mail.gmail.com>
Subject: GREETINGS FROM DR AVA SMITH
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.4 required=5.0 tests=BAYES_40,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,SUBJ_ALL_CAPS,
        T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:42a listed in]
        [list.dnswl.org]
        * -0.0 BAYES_40 BODY: Bayes spam probability is 20 to 40%
        *      [score: 0.3785]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [dravasmith27[at]gmail.com]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [abaulkarimbanneth24[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.5 SUBJ_ALL_CAPS Subject is all capitals
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [abaulkarimbanneth24[at]gmail.com]
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  3.6 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-- 
Hello Dear,
how are you today?hope you are fine
My name is Dr Ava Smith ,Am an English and French nationalities.
I will give you pictures and more details about me as soon as i hear from you
Thanks
Ava
