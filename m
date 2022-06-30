Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4736A5612B3
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 08:45:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232828AbiF3GpK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 02:45:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232717AbiF3GpI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 02:45:08 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3185E2F679
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 23:45:07 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id sb34so36957475ejc.11
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 23:45:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=SEHHtXscQPdl7vov2HttOhjl2K/3hLOdoodmcl4p85o=;
        b=mQ8uWCg/PjD7TkytMn5/9PSoSY+uzqsmvzu6MKlaoFW2UBG9jlRSyZNBDFwgxl1o5h
         u/atKVC4jvPDnRdAntXL+Mq50nCBCjjSPtAxbAKCuEr8x8m2fGesiLBcUbJca9f1nbcF
         u2HRZey4syVKo6v3KVGPHa3AYnKcc7nq3KPLmjm9C2VFoE9AGA7ng1OoLhZ6LHAk08yl
         gM59AFVkk2/sqq35ZOvl4efbz0JcyVJZq0q2LQV9H89k422mnVBkNG66wKob2hgpXSiD
         SsiGDUJAULf1fYw6SbNLHNHOhLg3v5cuBMUMh+dMQbo0T6i4mHgwS5P65jQn4ffaDgGM
         PV8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=SEHHtXscQPdl7vov2HttOhjl2K/3hLOdoodmcl4p85o=;
        b=s5dO+2mn5LpS1hOvTBh6CQGLtWvg9kj8mopegfHXLlMlgieqIJQozaHSZVFzg1JPYr
         fyoLMys4EtSTeuln9B1he3J8EpjpWA8byR7whiGhjS6jhD+uSflWDJYSvz3LnvIOHGt6
         CKDoXdEm/PBYTyUsedaWuPqwp7zAUu6wEYdaOfIY1smbxnfBFBP1HF2E/YrdCzWhYd1d
         sqIlrZvSo/wh2gr5mM2vDZR9X+Oq159D0sOZPPb0/le3hGsiuXMcNg4THH3ZvrMXUgzK
         Qi68VjgKKlyTOYEXtNKa126otaynpU8PgHNRCFVuzUxCBONTC0S00LNdFLz6KS3ctgtx
         +XGQ==
X-Gm-Message-State: AJIora+ynrnhFAmo+ApPHxtNfbR3Z5H/pX6A0IIjgxFvcYrlyMgsA/BM
        qOzHYDpjjcRd18oNA6Bs4MBgNww4/I8=
X-Google-Smtp-Source: AGRyM1tl8g3NYtHoVMp383h2kVsFbxVBbWuRR3STVIr08Pz8c9Q8oFzLEaghSp/mRcK1qvE/Ucq67Q==
X-Received: by 2002:a17:907:9483:b0:726:bea5:7a87 with SMTP id dm3-20020a170907948300b00726bea57a87mr7276684ejc.629.1656571505579;
        Wed, 29 Jun 2022 23:45:05 -0700 (PDT)
Received: from [192.168.0.12] (nborisov.ddns.nbis.net. [85.187.217.137])
        by smtp.gmail.com with ESMTPSA id s2-20020a170906454200b006fe9ec4ba9esm8763471ejq.52.2022.06.29.23.45.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jun 2022 23:45:05 -0700 (PDT)
Message-ID: <feb7d93c-76bc-a7fc-0714-ed71495a16b9@gmail.com>
Date:   Thu, 30 Jun 2022 09:45:04 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v3 5/7] fs: remove no_llseek
Content-Language: en-US
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk
References: <20220629130702.954310-1-Jason@zx2c4.com>
 <20220629130702.954310-6-Jason@zx2c4.com>
From:   Nikolay Borisov <n.borisov.lkml@gmail.com>
In-Reply-To: <20220629130702.954310-6-Jason@zx2c4.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 29.06.22 г. 16:07 ч., Jason A. Donenfeld wrote:
> Now that all callers of ->llseek are going through vfs_llseek(), we
> don't gain anything by keeping no_llseek around. Nothing compares it or
> calls it.
> 
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> ---
>   fs/read_write.c    | 17 +++--------------
>   include/linux/fs.h |  1 -
>   2 files changed, 3 insertions(+), 15 deletions(-)
> 
> diff --git a/fs/read_write.c b/fs/read_write.c
> index b1b1cdfee9d3..69cd8d72d91e 100644
> --- a/fs/read_write.c
> +++ b/fs/read_write.c
> @@ -227,12 +227,6 @@ loff_t noop_llseek(struct file *file, loff_t offset, int whence)
>   }
>   EXPORT_SYMBOL(noop_llseek);
>   
> -loff_t no_llseek(struct file *file, loff_t offset, int whence)
> -{
> -	return -ESPIPE;
> -}
> -EXPORT_SYMBOL(no_llseek);
> -
>   loff_t default_llseek(struct file *file, loff_t offset, int whence)
>   {
>   	struct inode *inode = file_inode(file);
> @@ -290,14 +284,9 @@ EXPORT_SYMBOL(default_llseek);
>   
>   loff_t vfs_llseek(struct file *file, loff_t offset, int whence)
>   {
> -	loff_t (*fn)(struct file *, loff_t, int);
> -
> -	fn = no_llseek;
> -	if (file->f_mode & FMODE_LSEEK) {
> -		if (file->f_op->llseek)
> -			fn = file->f_op->llseek;
> -	}
> -	return fn(file, offset, whence);
> +	if (!(file->f_mode & FMODE_LSEEK) || !file->f_op->llseek)

Is it not sufficient here to just check for the presence of FMODE_LSEEK? 
NULL  llseek shall result in FMODE_LSEEK not being set when the file is 
opened?

> +		return -ESPIPE;
> +	return file->f_op->llseek(file, offset, whence);
>   }
>   EXPORT_SYMBOL(vfs_llseek);
>   
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 9ad5e3520fae..0cb5a1706e1f 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -3022,7 +3022,6 @@ extern long do_splice_direct(struct file *in, loff_t *ppos, struct file *out,
>   extern void
>   file_ra_state_init(struct file_ra_state *ra, struct address_space *mapping);
>   extern loff_t noop_llseek(struct file *file, loff_t offset, int whence);
> -extern loff_t no_llseek(struct file *file, loff_t offset, int whence);
>   extern loff_t vfs_setpos(struct file *file, loff_t offset, loff_t maxsize);
>   extern loff_t generic_file_llseek(struct file *file, loff_t offset, int whence);
>   extern loff_t generic_file_llseek_size(struct file *file, loff_t offset,
