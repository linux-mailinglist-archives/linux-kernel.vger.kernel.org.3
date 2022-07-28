Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE0FD5836D3
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 04:23:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234638AbiG1CXp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 22:23:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231327AbiG1CXl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 22:23:41 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EB4526AEC;
        Wed, 27 Jul 2022 19:23:41 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id f65so394485pgc.12;
        Wed, 27 Jul 2022 19:23:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:to:cc:references:subject
         :content-language:from:in-reply-to:content-transfer-encoding;
        bh=xyw7j0g2KRT16wsuVZKE8r3rotsnuHRNHRCOngZhLXo=;
        b=UuFF+xMdty8ykiTDHXKEc0pvwioDzU/J5Y/+J3y4u2ZH0nwXhxMEfAbj6iepDH5rfU
         0NFIwCcyCV1+qmQDjo8ZRKkLvx9U8hdKG222UuzRehSkjt7gez5fEpNYLYaBYYL+Jvob
         WY7/P8YoE6/0qnZafIQ7nU9aVSaTt+qYF/Y3OORMVfWsHl7HlbXMQFYzt91oc5fzFCb4
         cXuIMR7kVawoeYYYHko+oKhyTyY41ZE/lK5lc8uUi3KVmceaxE06AeBuptuxftol1kwa
         x8Syy2KlZEmb7ZziIMT+4XrLLJP0mvBOMHWqBh8ttq1Xy4net91tGv0SzctLDhyEed8d
         DDIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:to:cc
         :references:subject:content-language:from:in-reply-to
         :content-transfer-encoding;
        bh=xyw7j0g2KRT16wsuVZKE8r3rotsnuHRNHRCOngZhLXo=;
        b=BJneVChgG6kJJ7GUKPcclEgTtPaMQgqskJ3UEKKAu6seF54t5X2zL/u4D9LO6Y7UCf
         myTCY6vQzOAACdDAixmURlKrQ0EUq4lCKXJLABdDgYWXQ6FaDLIO2G4XkRervk6PikY0
         R0dYORrRtunX0J5xfl2361HzV0eLuKVPmN9ApXBjWGjkzvyfxol6u6xjnlb+IX8r8IW9
         KHY5o2IZ85NapqZpI9dUVij1jAXFocAbWI+j6Ty1JWJb4GYl6Y2+FqrX8o7f51P3eJHI
         K4GUYQs0/8/DTnfZWuH7pqOSn4MgTuWwWXwbj0LeINfuN9mk7YJoghDnFH4YCRNmQnp4
         tcIw==
X-Gm-Message-State: AJIora8bVjPflfKLx5SB3BQh7Sg2ris836tRI9/ArEL7P6Cuv26Jhhzs
        9MHFBOuQthiPD2eGzYgUzHY=
X-Google-Smtp-Source: AGRyM1sT9SvPu5Of46GAV94gca362Ake5Nh/hXddYEM8VgjL+CZlsIT8OZcWUqoiaUo8whNZKLaIBA==
X-Received: by 2002:a05:6a00:bc5:b0:52b:49c9:d26c with SMTP id x5-20020a056a000bc500b0052b49c9d26cmr24551795pfu.73.1658975020400;
        Wed, 27 Jul 2022 19:23:40 -0700 (PDT)
Received: from [192.168.11.9] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id cp17-20020a170902e79100b0016c0c82e85csm14310373plb.75.2022.07.27.19.23.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Jul 2022 19:23:39 -0700 (PDT)
Message-ID: <8a3a24b5-1f2f-d2bd-f2c9-2bda9298e23c@gmail.com>
Date:   Thu, 28 Jul 2022 11:23:34 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     corbet@lwn.net, hch@lst.de, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-next@vger.kernel.org,
        sfr@canb.auug.org.au
References: <838314fe-a85d-19be-71b6-264cad7e83c9@deltatee.com>
Subject: Re: linux-next: build warning after merge of the dma-mapping tree
Content-Language: en-US
From:   Akira Yokosawa <akiyks@gmail.com>
In-Reply-To: <838314fe-a85d-19be-71b6-264cad7e83c9@deltatee.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 27 Jul 2022 12:32:12 -0600, Logan Gunthorpe wrote:
> On 2022-07-27 05:48, Stephen Rothwell wrote:
>> Hi all,
>> 
>> After merging the dma-mapping tree, today's linux-next build (htmldocs)
>> produced this warning:
>> 
>> Documentation/driver-api/infrastructure:50: kernel/dma/mapping.c:258: WARNING: Option list ends without a blank line; unexpected unindent.
>> 
>> Introduced by commit
>> 
>>   7c2645a2a30a ("dma-mapping: allow EREMOTEIO return code for P2PDMA transfers")
> 
> 
> Oh, hmm, I thought I addressed this when I added the extra line at the
> end of the comment, but it seems the htmldocs is a bit fussier than that
> with the white space. 
> 
> The only way I can seem to suppress that error is by adding another tab
> character in the list; see below.

I think all you need is to see the reference at:
https://docutils.sourceforge.io/docs/ref/rst/restructuredtext.html#option-lists

There are examples for long options.

        Thanks, Akira

> 
> I'll send a full patch shortly.
> 
> Logan
> 
> --
> 
> diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
> index 746d46825d08..99e1e0c9a295 100644
> --- a/kernel/dma/mapping.c
> +++ b/kernel/dma/mapping.c
> @@ -249,15 +249,15 @@ EXPORT_SYMBOL(dma_map_sg_attrs);
>   * Returns 0 on success or a negative error code on error. The following
>   * error codes are supported with the given meaning:
>   *
> - *   -EINVAL	An invalid argument, unaligned access or other error
> - *		in usage. Will not succeed if retried.
> - *   -ENOMEM	Insufficient resources (like memory or IOVA space) to
> - *		complete the mapping. Should succeed if retried later.
> - *   -EIO	Legacy error code with an unknown meaning. eg. this is
> - *		returned if a lower level call returned DMA_MAPPING_ERROR.
> - *   -EREMOTEIO	The DMA device cannot access P2PDMA memory specified in
> - *		the sg_table. This will not succeed if retried.
> - *
> + *   -EINVAL		An invalid argument, unaligned access or other error
> + *			in usage. Will not succeed if retried.
> + *   -ENOMEM		Insufficient resources (like memory or IOVA space) to
> + *			complete the mapping. Should succeed if retried later.
> + *   -EIO		Legacy error code with an unknown meaning. eg. this is
> + *			returned if a lower level call returned
> + *			DMA_MAPPING_ERROR.
> + *   -EREMOTEIO		The DMA device cannot access P2PDMA memory specified
> + *			in the sg_table. This will not succeed if retried.
>   */
>  int dma_map_sgtable(struct device *dev, struct sg_table *sgt,
>  		    enum dma_data_direction dir, unsigned long attrs)

