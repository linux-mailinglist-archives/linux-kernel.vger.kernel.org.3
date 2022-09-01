Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 055E95A8C00
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 05:45:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231873AbiIADp0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 23:45:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232357AbiIADpR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 23:45:17 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BCC3193CD
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 20:45:09 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id j9-20020a17090a3e0900b001fd9568b117so1277115pjc.3
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 20:45:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date;
        bh=Gd606AZnons4cjLyy1xBHjT09B3G6R66SB4dvzam21g=;
        b=P3E1UMhVu/jHWRgbH5LxvPn+VV//jrCh7jj2BbYkifd9ZgZ4nigpVupBhFarTyhYg+
         XQkS+Q58rQrGPAGxLcBDNFhEOSc4Ppv2j7XLvA0h993lfV3b+x/TY04SAoeppl/MEAhU
         DnM9elvvW9/korznvJpd85A8VJ5AQL/hU2D0N2ttMjklTN+h5EQFf/n4NnyGSBTTBRa+
         sRCvYU1ATZUinJt8FeZkaD3uSntXzTacmSt9BDvFpJ1RCevs2edDlOcikNyc/i6MwCqm
         RHBXtxxAh5oZ5BhiRv3vwdc2tsUgwN7KT+9o2O8s+YEf2x/KSoCk6N7pgUcvJcn4sbVm
         iyOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date;
        bh=Gd606AZnons4cjLyy1xBHjT09B3G6R66SB4dvzam21g=;
        b=KAEJ+PHA/yvJMpKAAiZ3S2ARK0ZCqLyiU3dPwdETx0oM8ZivDBzIUCQ68i2tRyK9J1
         8JJVrGumJYVaGDsYzYVuH/L0cDVuEsH+S44NH0WkHbEVA4rVfhMphNynlcZYnhBXm/2z
         pY1xmycyu9N7/iD+JkhuQlUIYHxgek+JzW0drNvgsMy+9i9qFWfTypdgRef+HQ5f+lEK
         4RswN3ncPaEHZ15B+psXGI3oNulxGM0Fg31S+9oL9jFIrr057TozfKph5NHdfmVQIo8A
         kNuAb84B3cIsMJ/9S8oS/qbgO6wptCfskdCPcAbL630brk82Rs7k7r+xBcLTLSH6oK+b
         T1BA==
X-Gm-Message-State: ACgBeo02OX1Wf42LAI131U3z6c8yK81yWFjPb9gONv6hMSuxlGVI9p5T
        UqVk8Gcw4XWKacWsJtDYriGxQQ==
X-Google-Smtp-Source: AA6agR7qZWYNWPW9qs159uxIZYgIjTgEKv8m7O0Pki8ZXnMfq2abz6acCEojmE2cAMHurt52TF94jA==
X-Received: by 2002:a17:903:2302:b0:175:376c:ba5a with SMTP id d2-20020a170903230200b00175376cba5amr8366411plh.160.1662003908438;
        Wed, 31 Aug 2022 20:45:08 -0700 (PDT)
Received: from [10.76.37.214] ([61.120.150.76])
        by smtp.gmail.com with ESMTPSA id 66-20020a620645000000b00536431c6ae0sm12064657pfg.101.2022.08.31.20.45.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Aug 2022 20:45:07 -0700 (PDT)
Message-ID: <8097af66-f39d-e197-5a47-a62e731c598a@bytedance.com>
Date:   Thu, 1 Sep 2022 11:45:01 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.13.0
Subject: Re: [External] Re: [RFC PATCH 1/5] erofs: add 'domain_id' mount
 option for on-demand read sementics
To:     linux-erofs@lists.ozlabs.org, xiang@kernel.org, chao@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        yinxin.x@bytedance.com, jefflexu@linux.alibaba.com,
        huyue2@coolpad.com
References: <20220831123125.68693-1-zhujia.zj@bytedance.com>
 <20220831123125.68693-2-zhujia.zj@bytedance.com>
 <YxAnqC8pYf75epr1@B-P7TQMD6M-0146.local>
From:   Jia Zhu <zhujia.zj@bytedance.com>
In-Reply-To: <YxAnqC8pYf75epr1@B-P7TQMD6M-0146.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2022/9/1 11:31, Gao Xiang 写道:
> On Wed, Aug 31, 2022 at 08:31:21PM +0800, Jia Zhu wrote:
>> Introduce 'domain_id' mount option to enable shared domain sementics.
>> In which case, the related cookie is shared if two mountpoints in the
>> same domain have the same data blob. Users could specify the name of
>> domain by this mount option.
>>
>> Signed-off-by: Jia Zhu <zhujia.zj@bytedance.com>
>> ---
>>   fs/erofs/internal.h |  1 +
>>   fs/erofs/super.c    | 17 +++++++++++++++++
>>   2 files changed, 18 insertions(+)
>>
>> diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
>> index cfee49d33b95..fe435d077f1a 100644
>> --- a/fs/erofs/internal.h
>> +++ b/fs/erofs/internal.h
>> @@ -76,6 +76,7 @@ struct erofs_mount_opts {
>>   #endif
>>   	unsigned int mount_opt;
>>   	char *fsid;
>> +	char *domain_id;
>>   };
>>   
>>   struct erofs_dev_context {
>> diff --git a/fs/erofs/super.c b/fs/erofs/super.c
>> index 3173debeaa5a..fb5a84a07bd5 100644
>> --- a/fs/erofs/super.c
>> +++ b/fs/erofs/super.c
>> @@ -440,6 +440,7 @@ enum {
>>   	Opt_dax_enum,
>>   	Opt_device,
>>   	Opt_fsid,
>> +	Opt_domain_id,
>>   	Opt_err
>>   };
>>   
>> @@ -465,6 +466,7 @@ static const struct fs_parameter_spec erofs_fs_parameters[] = {
>>   	fsparam_enum("dax",		Opt_dax_enum, erofs_dax_param_enums),
>>   	fsparam_string("device",	Opt_device),
>>   	fsparam_string("fsid",		Opt_fsid),
>> +	fsparam_string("domain_id",	Opt_domain_id),
>>   	{}
>>   };
>>   
>> @@ -568,6 +570,16 @@ static int erofs_fc_parse_param(struct fs_context *fc,
>>   			return -ENOMEM;
>>   #else
>>   		errorfc(fc, "fsid option not supported");
>> +#endif
>> +		break;
>> +	case Opt_domain_id:
>> +		kfree(ctx->opt.domain_id);
>> +		ctx->opt.domain_id = kstrdup(param->string, GFP_KERNEL);
>> +		if (!ctx->opt.domain_id)
>> +			return -ENOMEM;
>> +#ifdef CONFIG_EROFS_FS_ONDEMAND
>> +#else
>> +		errorfc(fc, "domain_id option not supported");
> 
> Just one question, why not write as below?
> 
> #ifdef CONFIG_EROFS_FS_ONDEMAND
> 		kfree(ctx->opt.domain_id);
> 		ctx->opt.domain_id = kstrdup(param->string, GFP_KERNEL);
> 		if (!ctx->opt.domain_id)
> 			return -ENOMEM;
> #else
> 		errorfc(fc, "domain_id option not supported");
> #endif
> 
> Thanks,
> Gao Xiang
> 
Thanks for catching this. Maybe something went wrong when I split the
patch. I'll fix it in next version.

Thanks,
Zhu Jia
>>   #endif
>>   		break;
>>   	default:
>> @@ -695,6 +707,7 @@ static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
>>   	sb->s_fs_info = sbi;
>>   	sbi->opt = ctx->opt;
>>   	ctx->opt.fsid = NULL;
>> +	ctx->opt.domain_id = NULL;
>>   	sbi->devs = ctx->devs;
>>   	ctx->devs = NULL;
>>   
>> @@ -838,6 +851,7 @@ static void erofs_fc_free(struct fs_context *fc)
>>   
>>   	erofs_free_dev_context(ctx->devs);
>>   	kfree(ctx->opt.fsid);
>> +	kfree(ctx->opt.domain_id);
>>   	kfree(ctx);
>>   }
>>   
>> @@ -892,6 +906,7 @@ static void erofs_kill_sb(struct super_block *sb)
>>   	erofs_fscache_unregister_cookie(&sbi->s_fscache);
>>   	erofs_fscache_unregister_fs(sb);
>>   	kfree(sbi->opt.fsid);
>> +	kfree(sbi->opt.domain_id);
>>   	kfree(sbi);
>>   	sb->s_fs_info = NULL;
>>   }
>> @@ -1044,6 +1059,8 @@ static int erofs_show_options(struct seq_file *seq, struct dentry *root)
>>   #ifdef CONFIG_EROFS_FS_ONDEMAND
>>   	if (opt->fsid)
>>   		seq_printf(seq, ",fsid=%s", opt->fsid);
>> +	if (opt->domain_id)
>> +		seq_printf(seq, ",domain_id=%s", opt->domain_id);
>>   #endif
>>   	return 0;
>>   }
>> -- 
>> 2.20.1
