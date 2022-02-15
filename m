Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4082B4B7B67
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 00:51:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244877AbiBOXwC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 18:52:02 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244879AbiBOXv5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 18:51:57 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA0D614099
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 15:51:41 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id z17so616865plb.9
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 15:51:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eOQl//KosZ4qvPRlYricOYzhur4w9CDxToybs/1HwUw=;
        b=n0fGEseKpeTJVBRLcU6aOW671FkkrGG1F12nn1nnKRlJSzRZlYdwGVuHrmkdAKwDsH
         2cgJ5x2nv5213DNiH3E5nWepZkSaeaQKiuoAqOILeyvtCV8UCAoqLCu7atcHC0pXWnJR
         x2tovGc4IH5J1oixDaAKekf3001ZtzDQDBFHrtmqFm1lHS1VVhV9AE4yNHV++T1KOkrq
         iIMPbPYw42SG+YdhpVwAMKgFAfvopVFbd2r/lUHxnzCyTokFTZHp7i43RcoioymXx936
         ywuUZN1RyKYYOnf6usErLJkp+q/V3IzojWctav49gN1CbN8yk8vRuUOmjEtrZfhnAGYx
         UYTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eOQl//KosZ4qvPRlYricOYzhur4w9CDxToybs/1HwUw=;
        b=aF6QkSh60ASM0k1szv8RpfJlnkvA5yHsAK6wZS74ZbNkxvc1rOULeqHUBUGKzbAqwm
         zR4GJVVJm7bzIH2NYBVxLm7AGfdkcRdR9V2/aYIkE1B7a4VMZtTPa/0HG6Pd+l3td8UA
         tj/q0t+rFD16/ihBpsiIzeCe90H2uiw0fp6W7Y56g2LS3CkVM/RD99JyPvAFlJYuTHfm
         atxnQAEbl/YzeMTOqUqPzTVJBygR3R8ZbzKz4oFwR6KzfJ/VG5M2cx7a7Z4BDLanaxWC
         Dw+dE/kITfWR2+rPSBMA60+WxJkLNVK5yBz7uvseS2oqGRcVb3ZR+44yQx+qkbgD0chw
         lBCg==
X-Gm-Message-State: AOAM533+d0Ylf1Lqc8k0GY7rH369/8fJovG3Vuo8NLcVH3u3LRFt92kq
        7Jz8xXGih+bFDR8niS/PoeTnKofws8g2K5empaydAQ==
X-Google-Smtp-Source: ABdhPJzxjD3vKy3YyT+OCGwXU78ebjUah2EKpMfMibU0VWDXa+asOUJ5+9r/BPJajQyQWY0zQRe+xjGaYgcQFwMYr/U=
X-Received: by 2002:a17:902:7296:b0:14b:4bc6:e81 with SMTP id
 d22-20020a170902729600b0014b4bc60e81mr251082pll.132.1644969101356; Tue, 15
 Feb 2022 15:51:41 -0800 (PST)
MIME-Version: 1.0
References: <20220127124058.1172422-1-ruansy.fnst@fujitsu.com>
 <20220127124058.1172422-5-ruansy.fnst@fujitsu.com> <YfqBTDp0XEbExOyy@infradead.org>
In-Reply-To: <YfqBTDp0XEbExOyy@infradead.org>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 15 Feb 2022 15:51:35 -0800
Message-ID: <CAPcyv4jFMf_YSSgxoHJk=-0UMZeNO+PHP1sjkvXUmKfXvGaw1A@mail.gmail.com>
Subject: Re: [PATCH v10 4/9] fsdax: fix function description
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Shiyang Ruan <ruansy.fnst@fujitsu.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        Linux NVDIMM <nvdimm@lists.linux.dev>,
        Linux MM <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>, david <david@fromorbit.com>,
        Jane Chu <jane.chu@oracle.com>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 2, 2022 at 5:04 AM Christoph Hellwig <hch@infradead.org> wrote:
>
> Dan, can you send this to Linus for 5.17 to get it out of the queue?

Sure.
