Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8E6559535C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 09:06:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231475AbiHPHFz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 03:05:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231302AbiHPHFL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 03:05:11 -0400
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com [IPv6:2001:4860:4864:20::2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3427C1365EB
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 19:49:08 -0700 (PDT)
Received: by mail-oa1-x2b.google.com with SMTP id 586e51a60fabf-10e615a36b0so10294965fac.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 19:49:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=cxMDFjlVAIsMplX9GGCc7NA6ZP2O0NcOzKWi0pdLS4g=;
        b=zamFrHdR+WKezFywKVabhtF/lwkSjPdh4z2tSNVvSyE+2kv+gz17130d7ubjdZfKhO
         YaBuRyDFXeQO9hT0vM6nxEAqproCbV79nMtM4RuqggRehPL3vS9aPCuygmSr7SnnnUxU
         sHMJbAXiutqBjO7/Ap9ekj0frLep0prwBMUO4fgO3lxptuEVBdb9KDDq3lLYm4W1sDsd
         e42lg57vU9eITevRONyHlqAYcRwE2ap5LNYtqjGZ6CM6DDzM7yDw4XFejViujOcEI0sl
         NGXvRfXjyyiRN5RZe1GzLaWEZHE9KTecCw1kz3HfJdg1e4ysrgpsrAtrv4lP3SJNfEwo
         TcuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=cxMDFjlVAIsMplX9GGCc7NA6ZP2O0NcOzKWi0pdLS4g=;
        b=i1LU82ythbvNJ9jtDCGM6J3HLQokIrLUZbbFgUN2ncgMFscweGSunSU+DMfa9DGz+x
         Id0lbqsaWPG2vbGnI2cxhM5CKPdNzeAvUXtkdAAXPhEzh3ROosJzrVLzGptm2CiPBUk7
         u+8WjbCpOP2Uhur0xW7XdlcdagBOX2ekrThRuEeyGb2OQsnHJFc3kRhpUiUtfYwGIQbe
         c3ePeHQOcjgk8X+tv3TyY2Y5vB0bze2tt5EEg7bYGurphLOm8EQtcxiKRi3pE6jPze+d
         COMShMvn9Q6T59+k0QCn+iJelGCWZcBLNWL29mo8uILdaYqH+zX6lu7CB9d2idLQ/SiB
         zG4g==
X-Gm-Message-State: ACgBeo2J74JDmCzj7TGudiL39YNSRkSPoFvoZ1TfAdUzhrVhQvOb/NZa
        GtlNuGbFiCCz9nZbncRZqlHvXjB/sMh19l7BM2PU
X-Google-Smtp-Source: AA6agR5LsUiYtIaQsMdlDSE4SSKzkwLYDD2lERcJlrRGgG8a7Ur+HvCYoofeJXzmJbdDtUmtSw2NYfPFdU9ljnkhrgg=
X-Received: by 2002:a05:6870:9588:b0:101:c003:bfe6 with SMTP id
 k8-20020a056870958800b00101c003bfe6mr12430779oao.41.1660618147570; Mon, 15
 Aug 2022 19:49:07 -0700 (PDT)
MIME-Version: 1.0
References: <20220814093941.63227-1-yuanjilin@cdjrlc.com>
In-Reply-To: <20220814093941.63227-1-yuanjilin@cdjrlc.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 15 Aug 2022 22:48:56 -0400
Message-ID: <CAHC9VhRLqXUeje-yBy3+1SoB-JrtfCPUBwx7wKdQmCDDs=W5pQ@mail.gmail.com>
Subject: Re: [PATCH] kernel: fix repeated words in comments
To:     Jilin Yuan <yuanjilin@cdjrlc.com>
Cc:     eparis@redhat.com, linux-audit@redhat.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 14, 2022 at 5:40 AM Jilin Yuan <yuanjilin@cdjrlc.com> wrote:
>
>  Delete the redundant word 'doesn't'.
>
> Signed-off-by: Jilin Yuan <yuanjilin@cdjrlc.com>
> ---
>  kernel/auditsc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Merged into audit/next.

-- 
paul-moore.com
