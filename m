Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F60156C00B
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 20:36:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239097AbiGHRta (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 13:49:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239058AbiGHRt2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 13:49:28 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B59341D320
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 10:49:25 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id m14so16933722plg.5
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jul 2022 10:49:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iaX4oMlkYQaiZNZlnSZLy4aO15Umt0DimrsKT0WBN94=;
        b=AOnrCKW4iRtrjhFIeI1XHMgJsdJUZJpyMRA6aXnS03bzhFgINeXZon8QLvblOR2zaa
         XxGtuFxfBPK5rsPIxtEeLP59wE9GyCGAsF/oRdYQrWE64LL4haYYlMJzMLL0gsIMqllC
         eft0gu3zpVh2JXhP3BVcHuNVBsF08pvH0PS0k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iaX4oMlkYQaiZNZlnSZLy4aO15Umt0DimrsKT0WBN94=;
        b=MOS06QU3q1Aru1POHYNttjCyprPV8S/wybXt9XG8/Gz/J5cih8OxQUVGW8Gok40YfD
         5G7lq9Ia3a2lcT3VyjMwxTQ47eVrLVIxiIf/aSrrJjSEuELbMz0XbYaEyywoeW6FVwlo
         0DhTcUXTQRBTrsbOUp+n+5Ly/ldS/5HK7KGfS3dNeiAe1ZmlLmcDiIxgHF5kW1S3C/Bx
         wJNCLSCIEwjrRFTYv78/JGxgLRmqB/EtSv2Dv9novrMICUuAYoAPwTcs1KjkO3xhubWy
         TIJxnZd5LLjtxuMafVdk3ax1SPJ+RR+rl1fdQsxc0NJFQ8Xe0PsOZrSRyJqeH7xucqgc
         pm5A==
X-Gm-Message-State: AJIora/AWT/t5pxBx2wBOreRqBWlfoD2CevNSbZQf6c4NqD2tJQ5CBdK
        AAVUacgNt5CigjZybE9v3mc8gg==
X-Google-Smtp-Source: AGRyM1vP2QB4szrzMUbieQDDUsxXoTfCV6IPBMycttXyZLt/UI3+U2cpbLeu9G0A2lhBL8CygjgDKw==
X-Received: by 2002:a17:903:185:b0:16a:6113:c01 with SMTP id z5-20020a170903018500b0016a61130c01mr4938266plg.113.1657302565221;
        Fri, 08 Jul 2022 10:49:25 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id m11-20020a170902768b00b001637997d0d4sm30099069pll.206.2022.07.08.10.49.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jul 2022 10:49:24 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     lukas.bulwahn@gmail.com, dave.hansen@linux.intel.com
Cc:     Kees Cook <keescook@chromium.org>, kernel-janitors@vger.kernel.org,
        bp@alien8.de, peterz@infradead.org, linux-kernel@vger.kernel.org,
        mingo@redhat.com, tglx@linutronix.de, x86@kernel.org,
        hpa@zytor.com, luto@kernel.org
Subject: Re: [PATCH RESEND] x86: mm: refer to the intended config STRICT_DEVMEM in a comment
Date:   Fri,  8 Jul 2022 10:49:20 -0700
Message-Id: <165730255765.3882379.9761346871433228288.b4-ty@chromium.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220707115442.21107-1-lukas.bulwahn@gmail.com>
References: <20220707115442.21107-1-lukas.bulwahn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Jul 2022 13:54:42 +0200, Lukas Bulwahn wrote:
> Commit a4866aa81251 ("mm: Tighten x86 /dev/mem with zeroing reads") adds a
> comment to the function devmem_is_allowed() referring to a non-existing
> config STRICT_IOMEM, whereas the comment very likely intended to refer to
> the config STRICT_DEVMEM, as the commit adds some behavior for the config
> STRICT_DEVMEM.
> 
> Most of the initial analysis was actually done by Dave Hansen in the
> email thread below (see Link).
> 
> [...]

Applied to for-next/hardening, thanks!

[1/1] x86: mm: refer to the intended config STRICT_DEVMEM in a comment
      https://git.kernel.org/kees/c/c09327d5673e

-- 
Kees Cook

