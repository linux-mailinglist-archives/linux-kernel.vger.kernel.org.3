Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49CBA486555
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 14:37:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239597AbiAFNhR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 08:37:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230323AbiAFNhP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 08:37:15 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 093E4C061245
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jan 2022 05:37:15 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id e5so1788541wmq.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jan 2022 05:37:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:cc;
        bh=7f0Bjb4CTA9sDf/RhNU0ViDB8ImucRrQA+jdH+nCegM=;
        b=TIvWYlh1phESZMM0lALa3HwKSwoFPrtr4+QY/3t1K4kqTIacC1iFv7DPt1lePF98zS
         E5XjkmYa/nrYcCUmGXRWfZRlPo3h4y977sl+PuVHsIcdmA82HEPOpb5D4nLaTmEv+Xpm
         obEIl/J0eU1D54Pzhn7C7Dbn8FhN67TbiqzZG6mQirsDQaBhLGfBNK+iJEPR/EJoELYy
         04WbxsIrrN77FWuC0rmedcfjXFvfy+9fYd/o8lUHlHOO8iCWuDBI659Y4tWIXNiKLJUQ
         PpFPIi3vFgJfgZ2/GjLXAq4KbVFEhvDdrLRwCmzvaRfjaiAkMYfMBbL5kj+SmiKHGEjc
         ZuQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:in-reply-to:references
         :from:date:message-id:subject:cc;
        bh=7f0Bjb4CTA9sDf/RhNU0ViDB8ImucRrQA+jdH+nCegM=;
        b=L34VO7s3x0iIQtTMqPoJKU9OyOP1YPD+a1pisVcluShwgMKX6jhrNWOJw+LWKLiQbw
         7Z7kWCbTxxukHttmLLif3EZzbykQWdXSNjNrARWq0fIp4TP+6oV/o5ur7JaWu2pEXnag
         i7wz4450/5WqG6aryJVw8+AZpu0FJmN6eV6HRG3TXDC+h8frwHAATaGKrX2ebB5beaqt
         1Qub5y79kW2bOSh6vnksTPaY9/pWRdo0g349FzhbSNAWo5x4/0W+NWuw6QK9u91OQGeR
         mp4VA1GO0fPN5rSxY5Mq9tXOmobPmBKIUMdhHHK28VCGUDTEDKfiJJ2HhhIMKN65rNno
         6yyg==
X-Gm-Message-State: AOAM531CrTptASEsavWYT91Z9ASBZnuQ+tZh1n6rRAwBy3bLFpR3IU4k
        jZ+lG6opYARcSf8t/kN0U1/4zjPczR+5ATTxeW0=
X-Received: by 2002:a05:600c:2283:: with SMTP id 3mt4452804wmf.182.1641476233659;
 Thu, 06 Jan 2022 05:37:13 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a5d:6382:0:0:0:0:0 with HTTP; Thu, 6 Jan 2022 05:37:12 -0800 (PST)
Reply-To: israelbarney287@gmail.com
In-Reply-To: <CAO8vqiu=hMVSfBZa3zi+KkdTgBqqnL_cZt-8kpKC82J1=ZNMiQ@mail.gmail.com>
References: <CAO8vqityU3QRarO6GVUQSjk2_tj065p7md8KUYgzq3EswiQ67g@mail.gmail.com>
 <CAO8vqiv5aMPQ3a-KSYYMTBBAV8CB4uOBT9998X6gJ2ULH--71g@mail.gmail.com>
 <CAO8vqitQRBoksaatq0MXMGLitUuaVmA8B1ZqrkN33vyabV5QnQ@mail.gmail.com>
 <CAO8vqivYJvVTNBF-w1RrKwmxtiTB53C1pE-fZBMqgmQoAmPWnw@mail.gmail.com>
 <CAO8vqisXoOOJ-5u5Dr6-WdEqHwDZp=U7Hs8NBDgZ0djMZ4x69Q@mail.gmail.com>
 <CAO8vqitpPbzs53zC27iS2QQjbxSwYEYKXwKoh_xh88-qOaVr1A@mail.gmail.com> <CAO8vqiu=hMVSfBZa3zi+KkdTgBqqnL_cZt-8kpKC82J1=ZNMiQ@mail.gmail.com>
From:   israel barney <lmuna521@gmail.com>
Date:   Thu, 6 Jan 2022 14:37:12 +0100
Message-ID: <CAO8vqiuhq5pAj9mnmbyP2DemT+k91xG+kQvx14T+Cia2d-NfSA@mail.gmail.com>
Subject: hi
Cc:     israelbarney287@gmail.com
Content-Type: text/plain; charset="UTF-8"
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Permit I talk with you please, is about Mrs. Anna.
