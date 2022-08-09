Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B234058DF8D
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 20:57:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343861AbiHIS5Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 14:57:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348666AbiHIS4r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 14:56:47 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2251D33401
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 11:28:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=09pFjKjYwkYQqB1IyTImm6ka5abGU9alMVjAe/qx3Mc=; b=kbuZJX6j7rQ/VQMU2C18Ft2vYJ
        5k35U8ek35VZUQ3hRRuf3mfGLsJFoDL21FzQadEQBplksFab9YcAbORm0YKvlzItrrHKWJJ3gdBTD
        AAEQgCa6ztbDnQDqpmXHwaNSkUeQ29paTR+Zbn2rAjT8hfMiuaoaLaY9ipgFA9Y+qsPcDeg5rMlJr
        kWh6i9udbqDYw2w0hslEaq89izo/XZKxdhqzWh8T3H9uzH/+t7HnYlH6SRg4Y7eAbCCQOFZVM+rYQ
        ADyKzTB0PPIpFhf98AvnNH+OUrUzX3TOaqLqcy7WKKUkiuq1dLf7LA+Xi4THxKAe6yBLQjkoVnI2I
        O9hjLDfg==;
Received: from [2601:1c0:6280:3f0::a6b3]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oLTyE-005XPO-Di; Tue, 09 Aug 2022 18:28:50 +0000
Message-ID: <98fe1c6d-9528-05b5-c603-fb4ae028a19c@infradead.org>
Date:   Tue, 9 Aug 2022 11:28:47 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] Doc fix for dget_dlock
Content-Language: en-US
To:     Anup K Parikh <parikhanupk.foss@gmail.com>,
        skhan@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org
References: <Yu1HwVoTYOeaCh4v@autolfshost>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <Yu1HwVoTYOeaCh4v@autolfshost>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi--

On 8/5/22 09:39, Anup K Parikh wrote:
> Removes the warning for dget_dlock in include/linux/dcache.h and
> enables generation of its API documentation
> 
> Signed-off-by: Anup K Parikh <parikhanupk.foss@gmail.com>
> ---
>  include/linux/dcache.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/dcache.h b/include/linux/dcache.h
> index f5bba5148..ce0b36f72 100644
> --- a/include/linux/dcache.h
> +++ b/include/linux/dcache.h
> @@ -297,7 +297,7 @@ extern char *dentry_path(const struct dentry *, char *, int);
>  /* Allocation counts.. */
>  
>  /**
> - *	dget, dget_dlock -	get a reference to a dentry
> + *	dget_dlock -	get a reference to a dentry
>   *	@dentry: dentry to get a reference to
>   *
>   *	Given a dentry or %NULL pointer increment the reference count

Someone was trying to document both dget() and get_dlock() with the same
kernel-doc comment block.
I suppose that you could duplicate the comments for dget() also.

It would be nice to know the difference(s) in the functions as well.

thanks.
-- 
~Randy
