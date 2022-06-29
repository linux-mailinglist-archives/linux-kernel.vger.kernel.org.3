Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5F6F5603CA
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 17:04:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233541AbiF2PCw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 11:02:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231345AbiF2PCv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 11:02:51 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2704525280
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 08:02:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=Yj19dHn+0JPxtmJoU7+beQ32yhgR5L1tVwNWJFwVA+k=; b=BxwxfdkiTSsmAbf43BF+dePH/x
        xWOxxBLrYRgVSUvSmy9/AMgOP+9jcWTbXAkv9tKtxNsKPQhwjhAPlbuNa9YxR/Pl6DSafRhJBKv4L
        SzBCCzjlqsnguL1roqjsm5C2dJoZG7ShGhTqNW5JpfLsT9kcUgHEqyJhgde8+cacCojLycA7rlzM5
        N9BA627gjB/z+/jSAqNoFrNZ+HEuPWtnDkUpO76+cMn0XLhd0GCQdCybNF0b0K5B6mTnbnFRSB5pI
        UmzuX+Zn/EysKRf4tGngaONOMnhQnPM8oanQWkn8P6NwU/mtwmVpsrj3I78ufye5AEqt99Ivofl0n
        abyiZ/kw==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o6ZDC-00Ccys-4v; Wed, 29 Jun 2022 15:02:38 +0000
Message-ID: <b42c5d4f-5e9c-8f35-798e-b5ac2ad730a6@infradead.org>
Date:   Wed, 29 Jun 2022 08:02:36 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] UAPI: fix a spelling mistake
Content-Language: en-US
To:     Zhang Jiaming <jiaming@nfschina.com>, mpe@ellerman.id.au,
        benh@kernel.crashing.org, paulus@samba.org
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        liqiong@nfschina.com, renyu@nfschina.com
References: <20220629062717.23027-1-jiaming@nfschina.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20220629062717.23027-1-jiaming@nfschina.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi--

On 6/28/22 23:27, Zhang Jiaming wrote:
> Change 'informations' to 'information'.
> 
> Signed-off-by: Zhang Jiaming <jiaming@nfschina.com>
> ---
>  arch/powerpc/include/uapi/asm/bootx.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/include/uapi/asm/bootx.h b/arch/powerpc/include/uapi/asm/bootx.h
> index 6728c7e24e58..eb0769e50e93 100644
> --- a/arch/powerpc/include/uapi/asm/bootx.h
> +++ b/arch/powerpc/include/uapi/asm/bootx.h
> @@ -60,7 +60,7 @@ typedef struct boot_info_map_entry
>  } boot_info_map_entry_t;
>  
>  
> -/* Here are the boot informations that are passed to the bootstrap
> +/* Here are the boot information that are passed to the bootstrap

I would say:

/* Here is the boot information that is passed to the bootstrap.

I.e., use "is" instead of "are" and add a period at the end.

>   * Note that the kernel arguments and the device tree are appended
>   * at the end of this structure. */
>  typedef struct boot_infos

-- 
~Randy
