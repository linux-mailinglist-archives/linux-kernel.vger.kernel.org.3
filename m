Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BF3D535D82
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 11:40:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350636AbiE0Jj7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 05:39:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350635AbiE0Jjx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 05:39:53 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 431BB95DCC
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 02:39:52 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id i9so5122610wrc.13
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 02:39:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=abd8yjEZxiUbKxhy4wsVTzuHEcsA1la2h6qwLb0c/ic=;
        b=HTKlS61Ax579RGlsk/4frkXxc+FqyXePt5J0kuONC9OfD+4fxOgs63gdeWz5mSXeHR
         U2QTeR0RTHc0ZXbnyEVsgpGAU4V/7dXAxTJtz1Mh28ALnGKkyuZyEDpVfVNaI2OwBROL
         U+zHpxAvRo1EOucivhgX5evREtV0SV4opPQSjTZv9IB1VofWgIPGaYdMbgDCUeb93zZo
         xlPMqKOnO2N0YVRi6mVvhYl4Qsr3mmdHHX2POqbkv+j9zcjqjvu02/W2A6BlO7S5acg9
         hm+HHjNdQqhLOcsnQownTNwyL0cBnrvYTc30/U6byqqqSFveGSdtMS034Kan2EWt+8JV
         PKEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=abd8yjEZxiUbKxhy4wsVTzuHEcsA1la2h6qwLb0c/ic=;
        b=KvUQPbd34FEyjyfnzV6xChO4JxF+ygr0kL9QXgZQnL6wdQUmsTRXfPf5xN1w/+l0V8
         Y26fRIoifU1OVBsxOyimcByZBCPiYn2Nc5ZFECUNHhjLzSsTeDFrWgoeFjShGFWffcC0
         JPCedXTZ+Tz3XvTgDy1d+GmJe/dA3VfWvVFQg1q9fY6lTxituBm2ryKDXdDPvFL1ix1o
         0zxAbQ7egr2brrJxquJbLPPJElbsss/4UnDcdErS0XEiVWUKn3FRFEj7JeZLrBqwfla1
         6JR4Urmf8jK1CJ9xl3UiiY1gAStooX37a7TXKpGw9rQAViFFRWwRwOOVa2G/qCmo7A4O
         lD7A==
X-Gm-Message-State: AOAM5303dwAeeAdrqZblGbaBA9Vh9aWXBvci3dFIOL2OtQ+cKDkqcmzS
        Nap7HimHUa4mQNlWyaz/qf0=
X-Google-Smtp-Source: ABdhPJxigqmz8ov6DWtLdt0wHzWV1T1NHoD5qp9Ga5Rqt7Ox+Djv34PJj+o63Adk7rwuGE0YabR2nQ==
X-Received: by 2002:a5d:4282:0:b0:210:1351:d307 with SMTP id k2-20020a5d4282000000b002101351d307mr3280997wrq.492.1653644390777;
        Fri, 27 May 2022 02:39:50 -0700 (PDT)
Received: from debian (host-2-98-37-191.as13285.net. [2.98.37.191])
        by smtp.gmail.com with ESMTPSA id r7-20020a05600c35c700b003973e8a227dsm1671849wmq.46.2022.05.27.02.39.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 May 2022 02:39:50 -0700 (PDT)
Date:   Fri, 27 May 2022 10:39:48 +0100
From:   Sudip Mukherjee <sudipm.mukherjee@gmail.com>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, Will Deacon <will@kernel.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: mainline build failure with arm64 defconfig and allmodconfig
Message-ID: <YpCcZFDik57tHkL2@debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

The latest mainline kernel branch fails to build for arm64 defconfig
and allmodconfig with the error:

  arch/arm64/mm/hugetlbpage.c: In function 'huge_ptep_clear_flush':
arch/arm64/mm/hugetlbpage.c:515:16: error: implicit declaration of function 'get_clear_flush'; did you mean 'ptep_clear_flush'? [-Werror=implicit-function-declaration]
  515 |         return get_clear_flush(vma->vm_mm, addr, ptep, pgsize, ncontig);
      |                ^~~~~~~~~~~~~~~
      |                ptep_clear_flush
arch/arm64/mm/hugetlbpage.c:515:16: error: incompatible types when returning type 'int' but 'pte_t' was expected
  515 |         return get_clear_flush(vma->vm_mm, addr, ptep, pgsize, ncontig);
      |                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
arch/arm64/mm/hugetlbpage.c:516:1: error: control reaches end of non-void function [-Werror=return-type]

git bisect could not find the offending commit.

But looking at the changes, I think its caused by:
fb396bb459c1 ("arm64/hugetlb: Drop TLB flush from get_clear_flush()")
which renamed get_clear_flush() to get_clear_contig().


--
Regards
Sudip
