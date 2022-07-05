Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB0F0566395
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 09:09:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230174AbiGEG6i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 02:58:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbiGEG6g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 02:58:36 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 105A5306
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 23:58:34 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id i18so18957517lfu.8
        for <linux-kernel@vger.kernel.org>; Mon, 04 Jul 2022 23:58:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:sender:from:date:message-id:subject:to;
        bh=YZ9RSD4GkXXb1AnXdw0TQaCmfDAK9A/BZfdbsenu9is=;
        b=nDnvBuPJG8+rYzR6fDfPks1jzzTdU9DgyBpJ7pHLpLN6ax66oq+GavScDnjZJokliD
         Nb34jXC/9upOoA1vc+tQSXKSGK0N/ABgjEuuTtR2oXD/UqwNSf4yN9FuZ6gAeowmDBOK
         3bGg+MxLnnEnLrZDxlvweC7m5S4n6v8NW0ZlXxvrUPni+Yhl3gVdk3qx3hQeTGMuH+xb
         FdJfS9aZtgp8biJefmIqw3jIPVd5m6yWQMymzW6exEeIsHCqRa+qlVohXxgbdp0V+Up5
         vKTDGzvW5bPRxNny1dbAdFeSyiKZgKcAJFcKrLzgZF5r/9Yyn4QhLHJebf0fCFbc8MH5
         rKUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to;
        bh=YZ9RSD4GkXXb1AnXdw0TQaCmfDAK9A/BZfdbsenu9is=;
        b=rm2JY4rM2yjQ0taHBuLADUiEXEtoffRUYA3a9zzvgedQOQvB3SDK87rAtGvff0cMyZ
         Lk7qQJc69uT5FQy2pXpCRS9dfTjceMER/0YR7T9qPMKzd1ptBeDJHqkhzf0Hh8XsU60o
         rfPYFSPck4scf57vf09sb7HT9fkyQob7q7N9E6f0/ju1XGsVWVPxt9MRB6TDISpTndqR
         /CRo8THchanVUn6fTmgY5OjWRjRUQdtOZ45VQwiBI658rJ8DCnNVzsbu/owJ3xSY7mTG
         C7T196kvcuqtkzGOEN/y4MoroA1bvuPMmqTu5B1BHLW7XVSOfsbtXfi/UdNz1SgH9QLS
         Ityg==
X-Gm-Message-State: AJIora9IqOI/O3txs7Z3olPt9HqE+3t3npokvnU/84r4nCJOFjUJr55j
        B9KziOW1Qt48fxqMRT4Y05uTCgc4DfEXYIad5+Y=
X-Google-Smtp-Source: AGRyM1uADNSq87ICgJcJqOa4Fry+UQ1YG8vWJClMrkoXlYvXSCb8ZlLheZc33V1704PQlLsUNeQlKPy2Kvd/IYN9oGM=
X-Received: by 2002:a05:6512:114e:b0:47f:5f76:22bb with SMTP id
 m14-20020a056512114e00b0047f5f7622bbmr22081330lfg.648.1657004312410; Mon, 04
 Jul 2022 23:58:32 -0700 (PDT)
MIME-Version: 1.0
Sender: nakodegbe@gmail.com
Received: by 2002:a05:651c:508:0:0:0:0 with HTTP; Mon, 4 Jul 2022 23:58:31
 -0700 (PDT)
From:   Bella Williams <bellawilliams9060@gmail.com>
Date:   Tue, 5 Jul 2022 06:58:31 +0000
X-Google-Sender-Auth: Ybm-7FCsjgxu4OMsbmIbFvX_n18
Message-ID: <CANBqjYaDOGs+s9gx6vLCVYC+ij8-J+SX_3scki57GF8LEZqjsQ@mail.gmail.com>
Subject: Hello
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_40,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-- 
Hello
Nice to meet you,
????
