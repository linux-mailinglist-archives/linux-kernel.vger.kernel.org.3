Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 581B9594E9A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 04:21:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233491AbiHPCV1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 22:21:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232420AbiHPCVG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 22:21:06 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8266025AA46;
        Mon, 15 Aug 2022 15:34:13 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id pm17so8131971pjb.3;
        Mon, 15 Aug 2022 15:34:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc;
        bh=RIRgbOfmnMxz3+lha/dyKocjcfm0idLPDlwhRmwh3o4=;
        b=ZWp3Wr4rnHKazFw6TyQh3esqxfaP20y34f8wp+a5nQUJp3cGBgMK89CzF6gIxgocrs
         dLyXmFM1SpWVYDBLEbd99RceoQk7KAWE2lVhuN96FD/A7UD6I/z8rf3Uh9UCdOcVR/oD
         FPpWrfG0qouk6xCtpRUpeMsw9MasdyhgWbk63m4eNwpjIULb3Cl3NSDpwQ9S+oO/npKg
         XCRx4IwhE6o7M2U9hyzE3LfsxvAhu2YJaEZ+IjAmsR+pUN3qtZYsywPJiF1LUTn7bRur
         YLDO/bl0LRpJQEiP/y4VeQA49jUBGdB42EC/8C/1Uyf5v2URU3rgzHhLCbkkH9g5o/b9
         v9Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc;
        bh=RIRgbOfmnMxz3+lha/dyKocjcfm0idLPDlwhRmwh3o4=;
        b=YMrEA37zH3sZPmPTrmvDU8bimyEBCCo3ruoRTChT4tCQJNP6M0EYRWmo4/T5FC9NTx
         bJyaCFo7/oEKCWVn/7hynui7OHsKKk6JtgQ6lQMzYa77Bc8YGE/aZ9L6ZvUw+tUCcJkx
         CfUPX3dJwgYSp/FH9dn0GcSpQEhdkNiQ8hlbNtgXdXrew5SRlQUVm0c66mhcbRbmfW1i
         2yTJ94S5UPyWQmfjOjOG2O+/dEwxENG8jKtD90S/NWcOVd0Uvp13ax7OMLlCJY1uma1+
         VK54xsltggnLLj7AlwUAv80/yvbYTrkr9oWVFam1BcAfIaYwWasM8UxOgtQ5vmulmHhC
         QU3w==
X-Gm-Message-State: ACgBeo3xPwdxtHiXCY4eB0vfG3tEOhIM6T9DTXtpA8tjnPM2DE/2Cjnw
        ops6KPcPUxZmDkPJwxjfxPY=
X-Google-Smtp-Source: AA6agR568ZXgAQRnpf/PgTylaDaCeITV2FSj7U3ur/+1N+e2+H7/bIzmlxTz4+9cG9xmpYnfNR5LKg==
X-Received: by 2002:a17:902:e750:b0:16f:3f32:6f5c with SMTP id p16-20020a170902e75000b0016f3f326f5cmr19105668plf.106.1660602848140;
        Mon, 15 Aug 2022 15:34:08 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:3a69])
        by smtp.gmail.com with ESMTPSA id p4-20020a1709026b8400b001712c008f99sm7502732plk.11.2022.08.15.15.34.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Aug 2022 15:34:07 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 15 Aug 2022 12:34:06 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Hao Jia <jiahao.os@bytedance.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: Fixes tag needs some work in the cgroup tree
Message-ID: <YvrJ3lk/caqJ4Zkf@slm.duckdns.org>
References: <20220816083238.0aa28080@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220816083238.0aa28080@canb.auug.org.au>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Stephen.

On Tue, Aug 16, 2022 at 08:32:38AM +1000, Stephen Rothwell wrote:
> Hi all,
> 
> In commit
> 
>   6d73ba7928c0 ("sched/psi: Zero the memory of struct psi_group")
> 
> Fixes tag
> 
>   Fixes: commit 5f69a6577bc3 ("psi: dont alloc memory for psi by default")
> 
> has these problem(s):
> 
>   - leading word 'commit' unexpected.

Oops, lemme fix up the tree.

Thanks.

-- 
tejun
