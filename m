Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97F9658AF0B
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 19:43:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241343AbiHERnq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 13:43:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241017AbiHERno (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 13:43:44 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 335276C125
        for <linux-kernel@vger.kernel.org>; Fri,  5 Aug 2022 10:43:44 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id h132so3224597pgc.10
        for <linux-kernel@vger.kernel.org>; Fri, 05 Aug 2022 10:43:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc;
        bh=VLncDyNQnKXtwizJBnIi5g+tK5Hl5K0IdbsONcQheqY=;
        b=Ia5E2N9lo3e3VNUJBLBL/XUus7hq9yyVKvQogYyyTe+fbiIddlmUKknsS47SFeFDT5
         /6fSsiijbYer1OR7lXl02xU4E4ipbUj+cUkHdVqRQl5WROGg3fZZC9wPgCI9xHp05Jwq
         ojBQP9VrmFhi39Y95SilvdolmdDKqvCgy5Iq6icE6KehFAPaq/3L7Sy0OtxOWs5pMdvg
         fyjeJhfDkvF/aAXKZ8Pcy8q3hSWonZ6Gwb/B3SO2+KUIxew5BdsF9GI0O3S21d/PF0BU
         k+qiZyI/66KSr+zgDBaO+Yclv6MaUCGrxTDl08rJPKsoQ3/B0Xmf4/rdAz8dHSVb0rBR
         bVcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc;
        bh=VLncDyNQnKXtwizJBnIi5g+tK5Hl5K0IdbsONcQheqY=;
        b=Lxdo25YIyI0aH6mgrC2S6rTQJUyurPEruKrF0exejJ3pkU1bXQ5IbmU5CI020r5670
         wmOL5QYbfm3DkLAfWCMwU9x/QrWEJWlhQAY6hG62k+c6FaSE32WY3QzFh0SboGKUTm6f
         euFj1jA9tGgSiKzX6BOqTfndSpiQLDj0zzRh0ysS7YCaxbnaJH7xHqy/vs4VbgTzdK/+
         jH75K3aZztq2r8Je8QaPI4uhHvKWSGr24turrSEmK1xT32BfQP2trzpo+qASJwabLR88
         lilPEusY42l+w+NrRj2bpzjVIgPXCdshr+E2OvOWFCxGy+uUA0kzCTQQYMVcvF7K/L6+
         8yCA==
X-Gm-Message-State: ACgBeo0TELxARra4fMkskhteyXGpVQ4F/LegskewsEQIYnpb0ZFhXcy5
        JXwzlWj+N80toOnR462Q09cAi3HeY+P4IbYRf9RwxH+JtR3R7g==
X-Google-Smtp-Source: AA6agR6Odg0lmIqIrkE3dBvkrgmGry+7tNcK2j2+qErYmm+5ap/DAxQatvcuEkKV3MHJ0UkLcj2wrpiy4Bq1VyLvk+w=
X-Received: by 2002:a65:56ca:0:b0:41c:b7f6:78d7 with SMTP id
 w10-20020a6556ca000000b0041cb7f678d7mr6694301pgs.414.1659721423260; Fri, 05
 Aug 2022 10:43:43 -0700 (PDT)
MIME-Version: 1.0
From:   Mahendra SP <mahendra.sp@gmail.com>
Date:   Fri, 5 Aug 2022 23:13:31 +0530
Message-ID: <CADDGra2dyKsd8cODUpJ0O3+kCKLzwSHf7QFsOkXVpv3Q2tmgnw@mail.gmail.com>
Subject: TAHI IPv6 test failures on 4.19 LTS
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

We are seeing a total 18 failures when TAHI IPv6 conformance test tool
is run against kernel version 4.19 ( specifically 4.19.29 )

Here are  the tests that are failing:
Section 1
13 tests failed out of 54 tests <test numbers:
16,17,42,43,44,45,46,47,48,49,50,51, 53>

Section 2
1 test failed out of 236 tests <test number 138>

Section 5
4 tests failed out of 25 tests <test numbers 12,17,20,24>

Is anyone else seeing similar kinds of failures ?
Could you please let me know if these are addressed in any of the
latest kernel versions?
If yes, please point me to commits/ fixed versions.

Please let me know if you need any additional information regarding
the above failures.

Thanks
Mahendra
