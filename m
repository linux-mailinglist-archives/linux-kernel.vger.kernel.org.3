Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5242952DCC9
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 20:29:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243343AbiESS3o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 14:29:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232209AbiESS3l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 14:29:41 -0400
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com [IPv6:2001:4860:4864:20::2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE3C4EBE92
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 11:29:40 -0700 (PDT)
Received: by mail-oa1-x2e.google.com with SMTP id 586e51a60fabf-f1d5464c48so7785417fac.6
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 11:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=CebFhyYrHA9qyenphvt66UOHmXFE+xmKVw8/99ZVMrI=;
        b=BbEcvDyVv+Ydj5Curj0uOZzUm7Y2C3b1AoRxnMmnho5SbVkNnLXCW75iaiBllx0pC9
         9JfRUk7l8DPJxhocFrgzSX6+M7XEbWvgjPMrVaEgx2mX//tpwj6Bk3xq17A3/sEBTAuD
         VcBBQCt3M+AVOp4aNNUGhEvl8lCpIODBpGqn2chRmfvMHONRqIxQeE/XHp2A5A3lawzB
         WKMJ1UKmfn798brfXuF+cuuo7c/bC7Z0DMpbGIjSUh/4Leb9jUHt284UganttTbXyeKF
         BaClhqgexI0GkPcI/fU6zLgUc3uIwpfY5Sms1ODpeTt9ghi7c0+Hp1ilSOzr00nyjRrs
         FzQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition;
        bh=CebFhyYrHA9qyenphvt66UOHmXFE+xmKVw8/99ZVMrI=;
        b=nJ99bNkJThY7LnmtqaNWXQ+iL8iUVUGnFwmZqZQIGd84/K7mG2cbdx3VpRMFVjvjk1
         xxfg/wDxevuK2N4prKqG2O8TWI4C8zvRgMNH4qsDRRjWmh/byJxhFmALgKUAigLRw1Fc
         Re7JyZQt92sYqj2Jq341+tkFp2iAinzAIWj+Xg+2qXCKs0DFnD19RtnFL+ToAuDDbzhO
         jXjhSGurDF51Zt2uqP68WTNV8PPpyPhBpMeNLTSt5+7RcFd0PHTaic1T0sZ7APuWm/OF
         8I0jJDqS/V431Mh5gMMn/NhhIGuuAIXif1V7HMMvcHf6id7whUmLPbIR1aFVuHeQfhTs
         SqTw==
X-Gm-Message-State: AOAM532J/pQzRZkBw75LgHHtlUo+apR5pg15rhV7CbzWh9q59Gy2t7sY
        fQxW7Dj6Pk4V+iXQHf5yeps=
X-Google-Smtp-Source: ABdhPJwV1DyKvn/eltAGDpEdsrre6oNgNJic/9ukILKyeBUu0/8OT0Jalw7WF7viVMdnavsUkifHgg==
X-Received: by 2002:a05:6870:23a8:b0:e9:85b0:83e9 with SMTP id e40-20020a05687023a800b000e985b083e9mr3931630oap.65.1652984980287;
        Thu, 19 May 2022 11:29:40 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id z11-20020a056870e14b00b000f1a2378a12sm1892oaa.37.2022.05.19.11.29.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 May 2022 11:29:39 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Thu, 19 May 2022 11:29:37 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc/fsl_book3e: Don't set rodata RO too early
Message-ID: <20220519182937.GA80472@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 19, 2022 at 07:24:15PM +0200, Christophe Leroy wrote:
> On fsl_book3e, rodata is set read-only at the same time as
> init text is set NX at the end of init. That's too early.
> 
> As both action are performed at the same time, delay both
> actions to the time rodata is expected to be made read-only.
> 
> It means we will have a small window with init mem freed but
> still executable. It shouldn't be an issue though, especially
> because the said memory gets poisoned and should therefore
> result to a bad instruction fault in case it gets executer.

executed

> 
> mmu_mark_initmem_nx() is bailing out before doing anything when
> CONFIG_STRICT_KERNEL_RWX is not selected or rodata_enabled is false.
> 
> mmu_mark_rodata_ro() is called only when CONFIG_STRICT_KERNEL_RWX
> is selected and rodata_enabled is true so this is equivalent.
> 
> Move code from mmu_mark_initmem_nx() into mmu_mark_rodata_ro() and
> remove the call to strict_kernel_rwx_enabled() which is not needed
> anymore.
> 
> Reported-by: Guenter Roeck <linux@roeck-us.net>
> Fixes: d5970045cf9e ("powerpc/fsl_booke: Update of TLBCAMs after init")
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>

Tested-by: Guenter Roeck <linux@roeck-us.net>

Guenter
