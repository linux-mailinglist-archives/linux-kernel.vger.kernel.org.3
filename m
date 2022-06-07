Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9299A540338
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 17:59:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344639AbiFGP7K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 11:59:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344674AbiFGP67 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 11:58:59 -0400
Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C74ED5DE4E
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 08:58:56 -0700 (PDT)
Received: from relayfre-01.paragon-software.com (unknown [172.30.72.12])
        by relayaws-01.paragon-software.com (Postfix) with ESMTPS id 5FA5B255B;
        Tue,  7 Jun 2022 15:58:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1654617497;
        bh=gyeTbiR+uUhE29A+RGuh6i8rdvYUlUvUGCn1xr1k4cs=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=E9D9zVOYRdWoge0CnkXB7UdtfsA3h/RovelUsR30YXMLNOThcmNY5zWXcevyMIw/Q
         3eCOD2nG2R+3aLqY8ZGWKCJx+9DiwE0RBwNrdkR2D3GjubNIVFOvyxH48FP0tMAON3
         Uv+Gj6A4iEawWW7EDTGe4C0v6StfNftJ4zYbhw8s=
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
        by relayfre-01.paragon-software.com (Postfix) with ESMTPS id 6C7481D0B;
        Tue,  7 Jun 2022 15:58:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1654617534;
        bh=gyeTbiR+uUhE29A+RGuh6i8rdvYUlUvUGCn1xr1k4cs=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=pqBlGqW6xS6n3BWqW/81M589K6ALyy85JH0UEAahiZxABf8Z0GwvzPioqJXHZnbLI
         clBXZyjEH412XG3NHfnqLNEBpR0dpNBqqz6lBPwotKWopecHCbnZ1gcz+qxKBVFj/o
         QvS+0J5c+2tkBgkcEFk+AsJMy1fcsjBc5QCxwimE=
Received: from [172.30.8.65] (172.30.8.65) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Tue, 7 Jun 2022 18:58:54 +0300
Message-ID: <4f66239a-2209-6375-95ad-e8be0d28cf85@paragon-software.com>
Date:   Tue, 7 Jun 2022 18:58:53 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH] fs/ntfs3: Remove a useless test
Content-Language: en-US
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
CC:     <ntfs3@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>
References: <ade97ac1a1506fd322b008bdf8c24f0fb01b02a0.1640261993.git.christophe.jaillet@wanadoo.fr>
From:   Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
In-Reply-To: <ade97ac1a1506fd322b008bdf8c24f0fb01b02a0.1640261993.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.30.8.65]
X-ClientProxiedBy: vdlg-exch-02.paragon-software.com (172.30.1.105) To
 vdlg-exch-02.paragon-software.com (172.30.1.105)
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/23/21 15:20, Christophe JAILLET wrote:
> 'new_free' has just been allocated by kmalloc() and is known to be not
> NULL.
> So this pointer can't be equal to a previous memory allocation, or there
> would be trouble in paradise.
> 
> Axe the always true test and make the code more readable.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
>   fs/ntfs3/bitmap.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/fs/ntfs3/bitmap.c b/fs/ntfs3/bitmap.c
> index aa184407520f..e3b5680fd516 100644
> --- a/fs/ntfs3/bitmap.c
> +++ b/fs/ntfs3/bitmap.c
> @@ -1333,9 +1333,7 @@ int wnd_extend(struct wnd_bitmap *wnd, size_t new_bits)
>   		if (!new_free)
>   			return -ENOMEM;
>   
> -		if (new_free != wnd->free_bits)
> -			memcpy(new_free, wnd->free_bits,
> -			       wnd->nwnd * sizeof(short));
> +		memcpy(new_free, wnd->free_bits, wnd->nwnd * sizeof(short));
>   		memset(new_free + wnd->nwnd, 0,
>   		       (new_wnd - wnd->nwnd) * sizeof(short));
>   		kfree(wnd->free_bits);

Thanks for patch, applied!
