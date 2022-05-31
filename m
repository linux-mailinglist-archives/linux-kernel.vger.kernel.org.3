Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B4695397F9
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 22:32:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347738AbiEaUbt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 16:31:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240755AbiEaUbp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 16:31:45 -0400
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com [IPv6:2001:4860:4864:20::32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C3A11108
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 13:31:43 -0700 (PDT)
Received: by mail-oa1-x32.google.com with SMTP id 586e51a60fabf-f2e0a41009so18505198fac.6
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 13:31:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=AN+Ko66d9Yo5Ua3h+9nJbgsd8+nb3+CXOXYHCdIP1go=;
        b=OrYfkpTBDytfSR3lV5xOMd65xYbn9Z1CEFjz3b83PHZHkDxJUrkZKTxhig1LqVqi5i
         wHTs5iS63snDqmnhzHYGNfa4JaajUWXKih/ig8x1hNVJzt+8tYveQEjd59QWP9czHHW3
         9jQE0Qm6+9kJgY/3oastPjY+nApf5qjoXwW/F5M460Kizio5W8JtcBUI43vnLon1HdNG
         bV/28AmfZ/xMd6Tjr9b59ks15kjiXojFKfQEXu8GbWjjtwOas4suinfhzqn9kb0nNVmf
         XxY81UXCbXRpBpzOLD/R7jllkKHCFb61W7dDt7SmjmzAIwKPgZ6RmEo+5DDmSM6+GHui
         YBkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=AN+Ko66d9Yo5Ua3h+9nJbgsd8+nb3+CXOXYHCdIP1go=;
        b=JxOWUsWU61b0i2iWvoI4rAA19VwUA/RVtKCAqU4y62Q8oMX4fQvP/LAEqq1M0cZDv5
         4qascHRpwLVQB69MmL8pUmNwqsLXS+gkmoZJueVyUomiiOCPGXrS81uTQlpu0ezoNNkK
         rCuPw49E2+/0vMkadwG46GqVPvkyzHF0gZbXq9oit9L4lWFGzEkAKq/GjGvYWoaSZ+D1
         VR9EUymI0HGi6BUFowRoDCEECC6jPcXiJ7QSSFfVipWz/J5P7D+yPK6GrNJGt8319Wv5
         vi42BXZOLlrP5gzZiH+8jfHD1wKwEyBpEigdFGVmm7+q8R/Kg5FDBajLbA+zzyyWywxc
         lu6g==
X-Gm-Message-State: AOAM5313tkfJVkA8Rph5OaTUMvrV+onqrNDFtnjSlnDmgxlf1HU9KaFp
        4MjIKo8wSReyi84jnk3Uxpb5qVXGMMaNTQ779wM=
X-Google-Smtp-Source: ABdhPJxB+/DScEugLMVqyUMyFsSMkpd4QYZZHdBrh/PKm9TOMEFle9WQ6mlWcEtazZtE+lXv1KcusIdx4Onm9A+aQZM=
X-Received: by 2002:a05:6870:340b:b0:ee:37af:2722 with SMTP id
 g11-20020a056870340b00b000ee37af2722mr14262607oah.91.1654029102904; Tue, 31
 May 2022 13:31:42 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6838:2f88:0:0:0:0 with HTTP; Tue, 31 May 2022 13:31:42
 -0700 (PDT)
From:   Debora Jay <deborajay372@gmail.com>
Date:   Tue, 31 May 2022 20:31:42 +0000
Message-ID: <CAHUR393N+MmWHf0APtOnB2oWYsTKVFHy5dZddEDw3i4UEDG0SA@mail.gmail.com>
Subject: HELP
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=3.9 required=5.0 tests=ADVANCE_FEE_5_NEW,BAYES_60,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNDISC_MONEY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Good day

I sent this mail praying for it to reach you in good health since I
myself are in a very critical health condition in which I sleep every
night without knowing if I Maybe alive to see the next day., I am a
widow suffering from a long-time illness. I have some funds I
inherited from my late husband; my

Doctor told me recently that I would not last due to the illness.
Having known my condition, I need you to claim this money and use it
for Charity work or any profitable venture that can help the poor and

street children especially, I accept this decision because I do not
have any child who will inherit this money after I die.

Thank you, Debora
