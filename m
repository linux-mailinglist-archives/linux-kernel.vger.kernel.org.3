Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C1265A82E7
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 18:18:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231737AbiHaQSa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 12:18:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231281AbiHaQS1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 12:18:27 -0400
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57B7ECEB36;
        Wed, 31 Aug 2022 09:18:26 -0700 (PDT)
Received: by mail-ej1-f50.google.com with SMTP id fy31so29012353ejc.6;
        Wed, 31 Aug 2022 09:18:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=hs27A97tiJvrzqLEY67+ba99paoViVve8c+DJ3f+Pqg=;
        b=7ZPyPyl13zsz6s+xdxlE3K2N0aCnxorUz/wVknrzi6UaziyKlsS9cJXprgkWfU5zFL
         KrE7J7K+FEcPiPxC1sa86frQv+5H0zIOpwjoZb2JzxPh1z0k3eeLaDbWhlV+1UdKCI6G
         6nQIXXXsmrp5E8tSJUGscVi/9GG2Fin1QVwL1ExdjX2UwKV+R6apktPQ/pEcp4HziAhm
         i0ecyLjsYH1ybPDfR8KrJDNFrPm3bDWfeTDjr2V1Fm/E3pfOxAy2LFfTYfFj48R8+4PB
         gQTOMwPhdgVdKIxQJrQ0ILNMSHqTBS8iqQJbIu6oE/vFSjznxn3IUoa6qqkTNjqj6H5E
         6aNw==
X-Gm-Message-State: ACgBeo23Yt8tGLvhfaR3vj4Uo6xnh6yAs854OTMvEtk9wB191uf7qWam
        Jrp3DLC3cj4wNDPl7F1j8uuEUNUe0x773w==
X-Google-Smtp-Source: AA6agR4HjXreg6GyPP2faOYPhvdwYt88YzaoF1YZO04ge0M4cM8Jr+yewDGui8ztp5XOVATFMO0Dpg==
X-Received: by 2002:a17:907:2cd1:b0:730:a980:d593 with SMTP id hg17-20020a1709072cd100b00730a980d593mr20741096ejc.48.1661962704855;
        Wed, 31 Aug 2022 09:18:24 -0700 (PDT)
Received: from gmail.com (fwdproxy-cln-022.fbsv.net. [2a03:2880:31ff:16::face:b00c])
        by smtp.gmail.com with ESMTPSA id z63-20020a509e45000000b004478fdbe190sm9242412ede.10.2022.08.31.09.18.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Aug 2022 09:18:24 -0700 (PDT)
Date:   Wed, 31 Aug 2022 09:18:18 -0700
From:   Breno Leitao <leitao@debian.org>
To:     cgel.zte@gmail.com
Cc:     nayna@linux.ibm.com, pfsmorigo@gmail.com, mpe@ellerman.id.au,
        npiggin@gmail.com, christophe.leroy@csgroup.eu,
        herbert@gondor.apana.org.au, davem@davemloft.net,
        linux-crypto@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org,
        Jinpeng Cui <cui.jinpeng2@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: Re: [PATCH linux-next] crypto: nx: remove redundant variable rc
Message-ID: <Yw+JysFvbmW0yJL8@gmail.com>
References: <20220831140248.303940-1-cui.jinpeng2@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220831140248.303940-1-cui.jinpeng2@zte.com.cn>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 31, 2022 at 02:02:48PM +0000, cgel.zte@gmail.com wrote:
> From: Jinpeng Cui <cui.jinpeng2@zte.com.cn>
> 
> Return value directly from set_msg_len() instead of
> getting value from redundant variable rc.
> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Jinpeng Cui <cui.jinpeng2@zte.com.cn>
Reviewed-by: Breno Leitao <leitao@debian.org>

> ---
>  drivers/crypto/nx/nx-aes-ccm.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/crypto/nx/nx-aes-ccm.c b/drivers/crypto/nx/nx-aes-ccm.c
> index 3793885f928d..c843f4c6f684 100644
> --- a/drivers/crypto/nx/nx-aes-ccm.c
> +++ b/drivers/crypto/nx/nx-aes-ccm.c
> @@ -134,7 +134,6 @@ static int generate_b0(u8 *iv, unsigned int assoclen, unsigned int authsize,
>  		       unsigned int cryptlen, u8 *b0)
>  {
>  	unsigned int l, lp, m = authsize;
> -	int rc;
>  
>  	memcpy(b0, iv, 16);
>  
> @@ -148,9 +147,7 @@ static int generate_b0(u8 *iv, unsigned int assoclen, unsigned int authsize,
>  	if (assoclen)
>  		*b0 |= 64;
>  
> -	rc = set_msg_len(b0 + 16 - l, cryptlen, l);
> -
> -	return rc;
> +	return set_msg_len(b0 + 16 - l, cryptlen, l);
>  }
>  
>  static int generate_pat(u8                   *iv,
> -- 
> 2.25.1
> 
