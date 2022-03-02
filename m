Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52F744CA9D2
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 17:08:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240490AbiCBQJW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 11:09:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238457AbiCBQJS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 11:09:18 -0500
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6B8E69281;
        Wed,  2 Mar 2022 08:08:34 -0800 (PST)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4K7zYs2Xs1z9sSf;
        Wed,  2 Mar 2022 17:08:33 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id rxWtBRSv_3dy; Wed,  2 Mar 2022 17:08:33 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4K7zYs1qcGz9sSN;
        Wed,  2 Mar 2022 17:08:33 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 2E7F58B76D;
        Wed,  2 Mar 2022 17:08:33 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 3ADqIjmPOceC; Wed,  2 Mar 2022 17:08:33 +0100 (CET)
Received: from [172.25.230.108] (unknown [172.25.230.108])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id E66A98B763;
        Wed,  2 Mar 2022 17:08:32 +0100 (CET)
Message-ID: <4001045b-c404-763d-d1ba-41f6ed05ff8b@csgroup.eu>
Date:   Wed, 2 Mar 2022 17:08:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] arch: powerpc: kvm: remove unnecessary casting
Content-Language: fr-FR
To:     Nour-eddine Taleb <1337.noureddine@gmail.com>, paulus@ozlabs.org,
        mpe@ellerman.id.au, benh@kernel.crashing.org
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        kvm-ppc@vger.kernel.org
References: <CAJO4vZwtVrYoMPZ9XoEAUJYgo-rND21eGorPrRF5m6rW4WT76w@mail.gmail.com>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <CAJO4vZwtVrYoMPZ9XoEAUJYgo-rND21eGorPrRF5m6rW4WT76w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 09/05/2021 à 14:00, Nour-eddine Taleb a écrit :
> remove unnecessary castings, from "void *" to "struct kvmppc_xics *"
> 
> Signed-off-by: Nour-eddine Taleb <1337.noureddine@gmail.com>

This patch doesn't apply. Tabs are broken, they've been replaced by 4 
space chars.

> ---
>   arch/powerpc/kvm/book3s_xics.c        | 2 +-
>   arch/powerpc/kvm/book3s_xive.c        | 2 +-
>   arch/powerpc/kvm/book3s_xive_native.c | 2 +-
>   3 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/powerpc/kvm/book3s_xics.c b/arch/powerpc/kvm/book3s_xics.c
> index 303e3cb096db..9ae74fa551a6 100644
> --- a/arch/powerpc/kvm/book3s_xics.c
> +++ b/arch/powerpc/kvm/book3s_xics.c
> @@ -1440,7 +1440,7 @@ static int kvmppc_xics_create(struct kvm_device
> *dev, u32 type)
> 
>   static void kvmppc_xics_init(struct kvm_device *dev)
>   {
> -    struct kvmppc_xics *xics = (struct kvmppc_xics *)dev->private;
> +    struct kvmppc_xics *xics = dev->private;
> 
>       xics_debugfs_init(xics);
>   }
> diff --git a/arch/powerpc/kvm/book3s_xive.c b/arch/powerpc/kvm/book3s_xive.c
> index e7219b6f5f9a..05bcaf81a90a 100644
> --- a/arch/powerpc/kvm/book3s_xive.c
> +++ b/arch/powerpc/kvm/book3s_xive.c
> @@ -2242,7 +2242,7 @@ static void xive_debugfs_init(struct kvmppc_xive *xive)
> 
>   static void kvmppc_xive_init(struct kvm_device *dev)
>   {
> -    struct kvmppc_xive *xive = (struct kvmppc_xive *)dev->private;
> +    struct kvmppc_xive *xive = dev->private;
> 
>       /* Register some debug interfaces */
>       xive_debugfs_init(xive);
> diff --git a/arch/powerpc/kvm/book3s_xive_native.c
> b/arch/powerpc/kvm/book3s_xive_native.c
> index 76800c84f2a3..2703432cea78 100644
> --- a/arch/powerpc/kvm/book3s_xive_native.c
> +++ b/arch/powerpc/kvm/book3s_xive_native.c
> @@ -1265,7 +1265,7 @@ static void xive_native_debugfs_init(struct
> kvmppc_xive *xive)
> 
>   static void kvmppc_xive_native_init(struct kvm_device *dev)
>   {
> -    struct kvmppc_xive *xive = (struct kvmppc_xive *)dev->private;
> +    struct kvmppc_xive *xive = dev->private;
> 
>       /* Register some debug interfaces */
>       xive_native_debugfs_init(xive);
