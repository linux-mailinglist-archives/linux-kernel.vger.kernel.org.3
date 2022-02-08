Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D085D4AD11A
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 06:38:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241223AbiBHFiT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 00:38:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347193AbiBHFh6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 00:37:58 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B14C4C02B670
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 21:34:13 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id e6so16969261pfc.7
        for <linux-kernel@vger.kernel.org>; Mon, 07 Feb 2022 21:34:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=/rL+TycpMQLfB5P4Zn9xgGfUWg8yPCNTwrE46ZNldMM=;
        b=MdQJomWtaDqVcTFXrMYXkeJfc2Obdsm07SSfH7XaxQx+LLFKfKFbXkAxylSqgKnIwV
         Yjuj/G2ymp39dVrIHcii/Kdv+M1D8QK+sQbRj7cPNkGF45Jpa1dN53yf7lwAY+Pj6xC/
         FRAkWpATSQsJSWwxAQkvxhIeuBSKI8bqQE9MKoARalBNRC/KDRwsSgxM4WXsyLf/Bwpf
         PBVhapPrM6rrS6mjcW0/fqNK2vvo9JAMls6xPFayODpUR+aPSrfPHRUYU8Nc2nni1BF9
         5K1BtTsyFEbK7IsKNBx/dC7z7HiTuVWX05wWmsKYRX2d4WmgicJN5ED8B16zAt6bgxra
         NtvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=/rL+TycpMQLfB5P4Zn9xgGfUWg8yPCNTwrE46ZNldMM=;
        b=BKe/w3QkWg36lL86yqp07h5NQNIl6YxSXtaDuXmS7zCXzhD1IAyYfY7FcLZBF6PXJc
         IGbdxbp8ohoCynixj4iYWmliqXt5TdD2X1wmi1+BCdrEutOs0b4i1L8OTLUFI8I3fAau
         FCVP6w0LhalMDmq7QNGUWIBwrkgZiiSQLERRdkdF51KOp/kZ/GWIjMCjL6YSgWCN7g/a
         59Xu/QSnNQSf/H+rH2Ewgxwd+ZmrH9PsQJCKShbrx6zbsCXkbDnzSkRni19MiKwZ1Y0b
         eqm53/xyGO+2dXaTbAG44Cc1ZiVWvJ6I+tQXQDygOXyFgJXbWd4ykp6WPADtjyR3GHIW
         1hrA==
X-Gm-Message-State: AOAM531NON+pqs1JkldMCetIXsE8f8XMt34u4vSYykJUH7RebHEjsL8W
        QfcI5Wp25v4bxwjcnaW2yBrwFQWljeZiSWtmbAI=
X-Google-Smtp-Source: ABdhPJyyzgEA1fTxScqxlnjNhHRsU7J4UYdnwDDvnQc4sKJYJQtfQ1tPa6C1MIXWw/yjIqd6D7NGf/7KxNSf3Y6fXaw=
X-Received: by 2002:a63:1043:: with SMTP id 3mr2252143pgq.16.1644298442816;
 Mon, 07 Feb 2022 21:34:02 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6a06:1791:b0:496:9424:180 with HTTP; Mon, 7 Feb 2022
 21:33:59 -0800 (PST)
Reply-To: avamedicinemed3@gmail.com
From:   Dr Ava Smith <bonarikan3@gmail.com>
Date:   Mon, 7 Feb 2022 21:33:59 -0800
Message-ID: <CABdGGoDsrtBDLxF_r9-g3uNyzb9krN8=PgKf393jiW3-SdKOWw@mail.gmail.com>
Subject: From Dr Ava Smith from United States
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.7 required=5.0 tests=BAYES_20,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
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
