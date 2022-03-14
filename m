Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A10AD4D79BA
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 04:44:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236097AbiCNDpp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Mar 2022 23:45:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234516AbiCNDpn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Mar 2022 23:45:43 -0400
Received: from mail-yb1-xb41.google.com (mail-yb1-xb41.google.com [IPv6:2607:f8b0:4864:20::b41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8472FD19
        for <linux-kernel@vger.kernel.org>; Sun, 13 Mar 2022 20:44:32 -0700 (PDT)
Received: by mail-yb1-xb41.google.com with SMTP id e186so28223629ybc.7
        for <linux-kernel@vger.kernel.org>; Sun, 13 Mar 2022 20:44:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:sender:from:date:message-id:subject:to;
        bh=vIF0HCtULT8/Hj4oEOKhM3wVM2dbK4vAQWbMA06NHEs=;
        b=jqClPlgke8l9WWcexP+1WKKP4EBqhXVihQ/T4svO8iQHVWT++SEcslkdyIqrbhZ/Mn
         DKQcyw6waQLfcKYpQ/HMfofQ45SS1KiFZWTbGRIP2HXK2ck6bLcMpcbRNOxyd5qEuFvs
         rdL/+ebxznbSnQmo3+dmVkVLfCUR80qci78EXID4Wwq3sW0F5Kvfcv/04EN3ZUeTRrSB
         GwxViU61nyAs07K8gzHnQyyFSt0rs0UC9WIp+Y++VKzz5VrbJKM/5LLoC3MqUSrYVxsW
         Gj1a2mvSrXg/DldVw+CHrtoJNYsLjiZiyzl/M6KGZo34sY4l2S5dl1YpgLf7AhMX/nSt
         AQJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:sender:from:date
         :message-id:subject:to;
        bh=vIF0HCtULT8/Hj4oEOKhM3wVM2dbK4vAQWbMA06NHEs=;
        b=daqVAD5bmQ5rWxu0sqPbj1F448Fz5PBF6FE7zMh/mJlrLUnquppFXUzCx54kUtlTr9
         gpiXcyvQQ2FByN8ABr6zXlsB+xcup+dyd/BiFDPArpCJGcD8o8NeyubwvGlnlyAfsMmo
         aGpTWp+7RNOPLiPcUM2VgJtO+uSeWkTb4dc/oZXn3ybU2KFCNwleSAHmXZithk9uLZiE
         Tlf74CHXHHG2ylab/RCbAlHv0QbWD8nqMFHCXQNgkkGnz07q9JcxVNMvrhqv3WkKYCh/
         vvnMic/igZV8wbUAbbJY+wzsBotl/23ff+sUITdN+iweec/zV5Nl1e7qQRlLr81mj/7N
         HBjg==
X-Gm-Message-State: AOAM531ZUvhczTeBhQoFYLv21xy2OwQw9f/GyISGa7hqZhznbwBAgS48
        I9pI7kwq6YkJgvwBZ0tdcykhBqqb/4p/ZPW+shY=
X-Google-Smtp-Source: ABdhPJyJMjCCjMNGlhLILO6yPKbqArZdyDSvrkSE+nuDL99ZW4PMOg1b9Zxy1kj+pj7XrPxGMOd0kBWxUSjCmIhqx9o=
X-Received: by 2002:a25:7347:0:b0:624:a5e8:9762 with SMTP id
 o68-20020a257347000000b00624a5e89762mr16357000ybc.279.1647229471531; Sun, 13
 Mar 2022 20:44:31 -0700 (PDT)
MIME-Version: 1.0
Reply-To: salkavar2@gmail.com
Sender: iqbalfarrukh60@gmail.com
Received: by 2002:a05:6918:7a89:b0:a4:b177:26e2 with HTTP; Sun, 13 Mar 2022
 20:44:31 -0700 (PDT)
From:   "Mr.Sal kavar" <salkavar2@gmail.com>
Date:   Mon, 14 Mar 2022 04:44:31 +0100
X-Google-Sender-Auth: PnQxaNe3qAdZtkjmTVPth5WMYz4
Message-ID: <CAL3Nt6iEya7Z4NrLGu-YWMpj4kLJmPN7tpG80fR9wfG3R5bjHA@mail.gmail.com>
Subject: Yours Faithful,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=3.7 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO_END_DIGIT,LOTS_OF_MONEY,MILLION_HUNDRED,
        MONEY_FRAUD_8,MONEY_FREEMAIL_REPTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_HK_NAME_FM_MR_MRS,T_MONEY_PERCENT,T_SCC_BODY_TEXT_LINE,
        UNDISC_MONEY autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ***
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
