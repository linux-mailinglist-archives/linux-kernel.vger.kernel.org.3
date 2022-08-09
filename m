Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA46458DB21
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 17:29:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244926AbiHIP3v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 11:29:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244418AbiHIP3r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 11:29:47 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F12AE14D24
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 08:29:46 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id j66-20020a9d17c8000000b00636b0377a8cso7754280otj.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Aug 2022 08:29:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc;
        bh=77DFp6vXGFNW199M6Wh6MVRMRkiBgpVGAtUlWscT6q4=;
        b=SpLKWbBLfJfJyHe2IFwBjUy3iDddbJ104PmqFy1iwKDGJ09kY6iWvtZ9kqKSBS46LU
         MSbvpXS30CRTy4jUvjaOcdCosdh+ELz5mE7WufDyg4UK85Y88bDn3aF99PR9hYuN1cep
         E7nM0nGdZ2ZHdJ84KvrIxR1ruTtZWhDzG3Lbs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc;
        bh=77DFp6vXGFNW199M6Wh6MVRMRkiBgpVGAtUlWscT6q4=;
        b=7uREila4s2x2ZTm3M5X5MKAkkuVzzbljIS1U0qDFnLvC8BZ/+hj/EqD6Yrc/Zsa9BI
         fLPZgDIMR6algh73SIB/8yE2/UUtuA1V2D0oan2fOvtghBrQbObf1hJMrtHZnPNCKsQK
         sL/SkaWrnda15Johr5BKp9/o0uljVC+Ol8m3Yht+x3bMuKYE4bnAQh/U0KzDKpedfW6/
         MREHQIt2NcV4DZQXxGbsCPllsOpUzYIHHCSbDiROy7Adp9Ez7tFi7Ub5R2OaMQ4P4VpH
         x7Nd9hXkMnu4TMqF074DX0T+ZgBWQFfzhljK/JS/McKAJr7V25vuPhum2ALU9yPqjEGX
         mvoA==
X-Gm-Message-State: ACgBeo0P+Nt5TvwNe5j/gkDj1OBVwxwtd+AN+kkmm9bdyknMKvTDVrFe
        3C+FWUaasm4B2oTzDwNMZ9teuA1ypczIuQ==
X-Google-Smtp-Source: AA6agR5c/64w7zPDFFoMzIPI4vrPJbbBJW+ZWtLqbpSUDIH9An8HEZLSzzmbnlg1+ahxrfU4FqnW3Q==
X-Received: by 2002:a9d:6394:0:b0:61d:19ff:b8cf with SMTP id w20-20020a9d6394000000b0061d19ffb8cfmr9050946otk.16.1660058984898;
        Tue, 09 Aug 2022 08:29:44 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id t4-20020a9d5904000000b0061c80e20c7dsm3043220oth.81.2022.08.09.08.29.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Aug 2022 08:29:44 -0700 (PDT)
Subject: Re: [PATCH] Doc fix for dget_dlock
To:     Anup K Parikh <parikhanupk.foss@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <Yu1HwVoTYOeaCh4v@autolfshost>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <a7d3882f-5a70-e168-14f5-14795cff8119@linuxfoundation.org>
Date:   Tue, 9 Aug 2022 09:29:42 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <Yu1HwVoTYOeaCh4v@autolfshost>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/5/22 10:39 AM, Anup K Parikh wrote:
> Removes the warning for dget_dlock in include/linux/dcache.h and
> enables generation of its API documentation
> 
> Signed-off-by: Anup K Parikh <parikhanupk.foss@gmail.com>
> ---
>   include/linux/dcache.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/dcache.h b/include/linux/dcache.h
> index f5bba5148..ce0b36f72 100644
> --- a/include/linux/dcache.h
> +++ b/include/linux/dcache.h
> @@ -297,7 +297,7 @@ extern char *dentry_path(const struct dentry *, char *, int);
>   /* Allocation counts.. */
>   
>   /**
> - *	dget, dget_dlock -	get a reference to a dentry
> + *	dget_dlock -	get a reference to a dentry
>    *	@dentry: dentry to get a reference to
>    *
>    *	Given a dentry or %NULL pointer increment the reference count
> 

Please include all the maintainers - run get_maintainers.pl for a
complete list.

thanks,
-- Shuah
