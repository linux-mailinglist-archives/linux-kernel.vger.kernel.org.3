Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BAB74CFACD
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 11:24:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242161AbiCGKVl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 05:21:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240477AbiCGKBD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 05:01:03 -0500
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63583A1AB
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 01:48:57 -0800 (PST)
Received: by mail-lj1-x233.google.com with SMTP id 25so5923414ljv.10
        for <linux-kernel@vger.kernel.org>; Mon, 07 Mar 2022 01:48:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=wR7uUmbbvzhrVgB5o+Q2sMAbGJGY4qZBiplWhLQEv1c=;
        b=YOpecoJFuATb/PO3KJQdDdeR4s7tDdXf9G9ddUQLCIrj/u73k9Jea10hbSfBesdLZ8
         iOLaiYNN3RrPc64eKGtbH4wHiY607ktZPlME4faTIExmeFTE6Rwnm6bsazkkfH2wujI2
         uDp3aMnb1x0ocMxd78sz93bQ/cyz6VywQVcjUJaYOk3nSOBPWeR8tes8qqf7zMEUDVSN
         in5rn/REV4IZPkZuUs/WOjxH4m5SlqlF8noSIGPpY44pRDDJBxsY2c5RTnl+sUq94gSv
         QsS1cdOgLH2xznilWoqSyNzZ1lXtUyHWK3ciRqAAKb9uUZ330hl1gAMFnBuStmLtLlw6
         xMTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=wR7uUmbbvzhrVgB5o+Q2sMAbGJGY4qZBiplWhLQEv1c=;
        b=Gq7cZjkCMxaTN60rppRe/950Q8RBWGH0o2zW5PWDAODkA/zj04U7KW997xzQKGNjWJ
         VvYqUaFPnfOaVZaF5Kr05g7YBQZLGWNe8/PB4fEuOrmRgs8MBjv5eG3rIFwNcKhTon56
         wcJmRUBNZZprzP0CdAEmXDCIoeYu+jZo+psszlSfOqyps3v0NC8C0ZO1YM5HGYwAVT7O
         Tpn3kVxKRfai93IyfqRmpOuhZIIv1b0kW3WzZEJ2DArCUdWpG7A2McVPcNgWQ9Uqz7q5
         R5WZHvQtiyuENy1d7L9rcpqQDpiy7V57+T7SYiC3uQ1o48rTur6aPoNmrye4pDCl4DVp
         nsqw==
X-Gm-Message-State: AOAM531jdM2vPCD5bIOrX7gG5N95QxtsE0dG4hpt6N0oFkx5AkXApYEG
        OQCbwA5ay1B3dnj/IY5p0bpmmNMiadzah4BPVOo=
X-Google-Smtp-Source: ABdhPJysx9GAqaT8JDVChkC19/A1nVzm37pP9X9ONHYsY87xZZ65MwjksNfDC7PoU+jhxxbsQoVwX/ue5jvTrgDd3QY=
X-Received: by 2002:a05:651c:54d:b0:247:b65e:7018 with SMTP id
 q13-20020a05651c054d00b00247b65e7018mr6948380ljp.362.1646646535624; Mon, 07
 Mar 2022 01:48:55 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a2e:8098:0:0:0:0:0 with HTTP; Mon, 7 Mar 2022 01:48:55 -0800 (PST)
Reply-To: edsonbaafi@yahoo.com
From:   edsonbaafi@gmail.com
Date:   Mon, 7 Mar 2022 09:48:55 +0000
Message-ID: <CAF9Z-82aQXXTso1f44R5L9b0chvXqtzb4037EgH9_RSR7ZiXLQ@mail.gmail.com>
Subject: =?UTF-8?B?5YaZ?=
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=4.4 required=5.0 tests=BAYES_20,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

5oiR5oOz55+l6YGT5L2g5piv5ZCm5pS25Yiw5oiR55qE6YKu5Lu2DQo=
