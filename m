Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92E494D2A2A
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 09:00:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230026AbiCIIBX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 03:01:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229845AbiCIIBP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 03:01:15 -0500
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A43F149B99
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 23:59:42 -0800 (PST)
Received: by mail-wm1-x344.google.com with SMTP id k29-20020a05600c1c9d00b003817fdc0f00so925512wms.4
        for <linux-kernel@vger.kernel.org>; Tue, 08 Mar 2022 23:59:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:sender:from:date:message-id:subject:to;
        bh=vIF0HCtULT8/Hj4oEOKhM3wVM2dbK4vAQWbMA06NHEs=;
        b=jPnFXYg9XlFwqigV13Py1UHCzOf2iEvBVeTy6zM3wB+F7+ZVcTXkuc4hDQY06nKHN2
         p1VTcR16JlSxllmlXqe6SMgEW6cjvQh7PR/fMmdJHr568MxdNhTIYq6ZhGPpVuEpD1LY
         ZWyxkwI99mTpt/Zy86jPElOYiVq5taVkCKHWd/G5l9K9MvDou5K8t8Jn/1bBooUkckjX
         vXY312NnIrXwvmqsApVe8CCyQJwBMf/4BR1XA09GdYcMJHmHJ4LBY0MQQB2FI6FycUUx
         YmRCinCPfuUX0bdJ8hiWyLyeeVRTtkDeQNAgifz09fokwWnDouZhe2wNrUfsYYqjG9rr
         yf9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:sender:from:date
         :message-id:subject:to;
        bh=vIF0HCtULT8/Hj4oEOKhM3wVM2dbK4vAQWbMA06NHEs=;
        b=LXc050X3IA++sW8iJIx3noCYAroIU4LtCmf7X3bqzPi5ng8CDv1C9CktI5qnr37teR
         ptaIV9T8+5CQkjWC2BrOLamGbv4OjJ4XaD1zNmBsR3iYjTHRRxsCq1pVGsG1uCOhWuCJ
         zdsyXrp4bLIqntAHXtZfz/3TgrVkgqXPHKk6rKRKWmw6zZnjMNWqC7EXEQHNRUWg50B+
         qXAcBDbhuvY0y7rd5CeQLfvliJ0jq1KkXyJpLH3PQZkjS8L1nBaYQmqgOinZzf/lSeAB
         ZAH4TdXSnjIP6pZscbWczka7T9hk7Fd9Lo4IKW20dS2/EtVZEsbSBcMkkOzelEvPf+oV
         vzZw==
X-Gm-Message-State: AOAM531Jm1drCCux8T2t/6Uheqf2UkYRA1Mpb1DRNxWL1kM2n41dmIf6
        Z784Ef0k7hwsImnqL9YAkaDe7L9NC4Pb60ORrrM=
X-Google-Smtp-Source: ABdhPJx6btLZtKSbc+qVrr7+EA4OxokZafIomOswm4WQzAxk3PR8oMeQR31Et7v+jlGLsLrZm2+nGwKf9kL9jW3elNU=
X-Received: by 2002:a05:600c:1c9f:b0:389:cf43:eafb with SMTP id
 k31-20020a05600c1c9f00b00389cf43eafbmr2257065wms.204.1646812779453; Tue, 08
 Mar 2022 23:59:39 -0800 (PST)
MIME-Version: 1.0
Reply-To: salkavar2@gmail.com
Sender: revjgeorge3@gmail.com
Received: by 2002:a05:6020:a8c8:b0:1a5:69f7:d4d7 with HTTP; Tue, 8 Mar 2022
 23:59:38 -0800 (PST)
From:   "Mr.Sal kavar" <salkavar2@gmail.com>
Date:   Wed, 9 Mar 2022 08:59:38 +0100
X-Google-Sender-Auth: PfkTid3G6JDN1QXv0lkJ4NVZJtA
Message-ID: <CAOvqe1CXSNH0DE=cz=MrOKa+2jYRvabL4-DzMSg1KavQ=iWngQ@mail.gmail.com>
Subject: Yours Faithful,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO_END_DIGIT,HK_NAME_FM_MR_MRS,
        LOTS_OF_MONEY,MILLION_HUNDRED,MONEY_FRAUD_8,MONEY_FREEMAIL_REPTO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_MONEY_PERCENT,
        T_SCC_BODY_TEXT_LINE,UNDISC_MONEY autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I assume you and your family are in good health. I am the foreign
operations Manager

This being a wide world in which it can be difficult to make new
acquaintances and because it is virtually impossible to know who is
trustworthy and who can be believed, i have decided to repose
confidence in you after much fasting and prayer. It is only because of
this that I have decided to confide in you and to share with you this
confidential business.

overdue and unclaimed sum of $15.5m, (Fifteen Million Five Hundred
Thousand Dollars Only) when the account holder suddenly passed on, he
left no beneficiary who would be entitled to the receipt of this fund.
For this reason, I have found it expedient to transfer this fund to a
trustworthy individual with capacity to act as foreign business
partner.

Thus i humbly request your assistance to claim this fund. Upon the
transfer of this fund in your account, you will take 45% as your share
from the total fund, 10% will be shared to Charity Organizations in
both country and 45% will be for me.

Yours Faithful,
Mr.Sal Kavar.
