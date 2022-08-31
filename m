Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A72305A735A
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 03:32:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230036AbiHaBb6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 21:31:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiHaBb4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 21:31:56 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9270B9C1DC
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 18:31:55 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id 130so2114631ybw.8
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 18:31:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=RCIdrG6LDAedhSE42XN+4y6hSNrTwRm5e11e8nEVmVw=;
        b=o/DzT/t1E+SKAXpwyeV62gGY8v+nnAOI+imh6LKznUbwYgPJnZ7usmfUjF56ADeMFT
         UQCovwXYvmvjoi1XoqjRR4Y1Uy2KrliU01AyXFnOGRcvqBpR8eKHhPBFEbiQV2uu+yCG
         6RO2up7zaOjrCd6NyQ7cI4MVXuTtaBjveGzeZ3sKROO1HWBmxO9Z0Qwqfv2Oi1RhoJlk
         PH2a9qhdxZe7IbSfkbCkKy2L7d8m+ESqYgjuaYP+FFHSOgOE6JVdK8q1xKETfb3G0EXh
         MOFvFtnUuT3ZGO/UadQlGRTuyZErvIIKcugSaJSMoHl4mSgfvSrQOex1rIt34YDxqT0u
         +xrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=RCIdrG6LDAedhSE42XN+4y6hSNrTwRm5e11e8nEVmVw=;
        b=APUA6cgtVi6DGLkD1K8pRcICZcvk86Aet7mLJLdm6mDnVCqlrn336tf7aXlBMEFf01
         wD1rywNhYcigyFV+8gb00d8n06ApNADunElqfwAPnU1XtQBKB9bTlWPhfK2VER6pWXbw
         GJiTKhjfbLnNtzR3IpsNrG1+/kvvcm+gE8f9teYdv7S9NPoudtkGsNoiZmcqYCUODJR9
         0ajf1yEkAfqZpPIjPGg+WkqP4wrEBuB1nTSE8EgbPEJFD5w4e1MMvfl0fzvm33VMHCih
         7ZjdS1GzZyewZFkkSU77U4cOzsU1u31qx9bZkTDfAjSK1Iv0yR6zbWz9EEhjbpFhS7Bj
         CwYg==
X-Gm-Message-State: ACgBeo1vR7/70BO27wybZB1ujNGz0KuBy9MCJfjZdgSfmm/6Q+LQjG6E
        VMpT7i2Tn50XwoB7E6VCRjKKsGwtpAgPMzNezYs=
X-Google-Smtp-Source: AA6agR5tfdxpD7NSTdOmGADKdDM2vXuDkbEF19oNMZAG+sN77hZcjLzupSv0Pb2cpPirHqDLwx2TwxtzqIqJj+fLtwI=
X-Received: by 2002:a25:24b:0:b0:696:4e87:7cec with SMTP id
 72-20020a25024b000000b006964e877cecmr13659265ybc.202.1661909514331; Tue, 30
 Aug 2022 18:31:54 -0700 (PDT)
MIME-Version: 1.0
References: <CAM7-yPTdihLsPjDKM-0OEszxNd8n0bgeRseiEkCsSZW-uuaRvw@mail.gmail.com>
 <20220830092839.3197-1-ppbuk5246@gmail.com> <Yw49m7Hpq+NIZYWw@arm.com>
 <CAM7-yPQjjwM_fCgojYHbrhE4GFCX22VLoCiTVkorNG6hQDj9EQ@mail.gmail.com> <Yw62//C+LmH+BcEh@MiWiFi-R3L-srv>
In-Reply-To: <Yw62//C+LmH+BcEh@MiWiFi-R3L-srv>
From:   Yun Levi <ppbuk5246@gmail.com>
Date:   Wed, 31 Aug 2022 10:31:42 +0900
Message-ID: <CAM7-yPRKC8hGSoSe34+RbCuRDdv88QsFzD=VznM2v9yu0YZMWA@mail.gmail.com>
Subject: Re: [PATCH v2] arm64/kexec: Fix missing extra range for crashkres_low.
To:     Baoquan He <bhe@redhat.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>, will@kernel.org,
        nramas@linux.microsoft.com, thunder.leizhen@huawei.com,
        linux-arm-kernel@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kexec@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> No, I don't think the Fixes commit is right. It should fix the commit
> where crashkernel,low is introduced. Before that, no issue caused.
> So the tags should be:
>
> Fixes: 944a45abfabc ("arm64: kdump: Reimplement crashkernel=X")
> Cc: stable@vger.kernel.org

Thanks! I'will resend the patch with fixed commit message and the tags
including Fixes, Cc, Review-By and Acked-by.
