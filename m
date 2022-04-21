Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C2C350A76B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 19:53:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1390983AbiDURyb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 13:54:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383260AbiDURy3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 13:54:29 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9875D4A90F;
        Thu, 21 Apr 2022 10:51:39 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id x18so7771873wrc.0;
        Thu, 21 Apr 2022 10:51:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=7lWJD4Cehmg0sq4G4syNiHxZE4IXa2IBfkB5ulYDQ9g=;
        b=Y/Bfgwcks3FeuHavXLrNU9YgsQnYmdJug3PPRV1aNbqMkqPY/N1XJeqVJ0K1Z6qWXU
         X+ZLl9Kx7FRJ7Ed+BACJeZQAZHurG358B3ap61neI8yCKiGL+5XT+lXKIg4GSYi8f8nx
         JcPYutFKjjZWYSrC0ZPxBSs1wWcw7P5YY0ATa6RX50uIMmI61viWXGfeTT++mc0Vde6e
         grfflOGhjPtQrs1OiDinFtoJOglagYzaNAl1kV+OZri28nNqQKNNfIL4iIVN1w/lcT/0
         fJnkG9RLU1OS7ECJaefX6yMm7XdNXFTtfMCjWmV3dauPdNr6Xm4jBYBHbQ9uoPunCsuC
         w5mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7lWJD4Cehmg0sq4G4syNiHxZE4IXa2IBfkB5ulYDQ9g=;
        b=J64A7gkFKDnf3Ul8xE3ln0EUUgBvTR6slUsBg0tqhFIeBaI/KHsq/lkZFwONDr/RQD
         X22tGmRSn8fyfNE7cc+meUBnWIg7ZaEkfcpaw9+3pEloYxHSqyggN2FOJ4hEoIIfiETH
         PVG/qbgzTjPVEQvXSyFvsPRkyC0y6s7L9QAOdY4NxbswDagZiniaXfuOpmhNKwUjH+J4
         SyrQgQi9wUD8gKn12JJ9IGoqVYCfKifUBiWn0+YjfPn1Cc7rNac2MgW1JW2sOtPikh2z
         /QbIKvtM4TifJaXpJg4YEjxB9QgVkD6AsrilvozTxXO/YAxfczG4IVOrq074Uau90cxl
         RhvA==
X-Gm-Message-State: AOAM5322UtgY1N7YtnS70g4es+8liAc93RBVV0zlc0jsotmxM6zcdXfE
        70ijgDsoSNY45dAvzApyuI8=
X-Google-Smtp-Source: ABdhPJwvv3EYK2rogJiUsH2tIFVInFv0qLt1cMsaHQcuicUtecwSnDJgWj7vT+U46Dic3Eu6zvR3+g==
X-Received: by 2002:adf:e586:0:b0:20a:c729:dfc6 with SMTP id l6-20020adfe586000000b0020ac729dfc6mr359739wrm.686.1650563498233;
        Thu, 21 Apr 2022 10:51:38 -0700 (PDT)
Received: from leap.localnet (host-79-50-86-254.retail.telecomitalia.it. [79.50.86.254])
        by smtp.gmail.com with ESMTPSA id ay41-20020a05600c1e2900b0038e75fda4edsm2569764wmb.47.2022.04.21.10.51.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 10:51:36 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        SeongJae Park <sj@kernel.org>,
        Jiajian Ye <yejiajian2018@email.szu.edu.cn>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ira Weiny <ira.weiny@intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Peter Zijlstra <peterz@infradead.org>,
        outreachy@lists.linux.dev, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/2] Documentation/vm: Rework and extend highmem.rst
Date:   Thu, 21 Apr 2022 19:51:35 +0200
Message-ID: <1938696.zToM8qfIzz@leap>
In-Reply-To: <20220415231917.25962-1-fmdefrancesco@gmail.com>
References: <20220415231917.25962-1-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On sabato 16 aprile 2022 01:19:15 CEST Fabio M. De Francesco wrote:
> Extend and rework the "Temporary Virtual Mappings" section of the 
highmem.rst
> documentation.
> 
> Do a partial rework of the paragraph related to kmap() and add a new 
paragraph
> in order to document the set of kmap_local_*() functions. Re-order 
paragraphs
> in decreasing order of preference of usage.
> 
> Include kerneldoc comments from include/linux/highmem.h and remove
> redundant and obsolete section about kmap_atomic().
> 
> v1-v2:
> 	1/2 - According to comments on v1 by Matthew Wilcox and Ira 
Weiny,
> 	      correct a mistake in text, format paragraphs to stay within 
> 	      the 75 characters limit, re-order the flow of the same 
> 	      paragraphs in decreasing order of preference of usage.
> 	2/2 - No patch.
> 
> v2->v3:
> 	1/2 - No changes.
> 	2/2 - Added patch to include kernel-doc to highmem.rst and
> 	      remove the now redundant section about kmap_atomic().
> 
> Fabio M. De Francesco (2):
>   Documentation/vm: Extend "Temporary Virtual Mappings" section in
>     highmem.rst
>   Documentation/vm: Include kernel-doc to highmem.rst
> 
>  Documentation/vm/highmem.rst | 96 +++++++++++++++++++++---------------
>  1 file changed, 56 insertions(+), 40 deletions(-)
> 
> -- 
> 2.34.1
> 
Dear Maintainers,

Please drop this patch because it has been reworked and inserted as part of 
a new series whose subject is "Extend and reorganize Highmem's 
documentation" and which is about to be submitted.

Thanks,

Fabio M. De Francesco




