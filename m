Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D41F54E663B
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 16:43:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351363AbiCXPoM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 11:44:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351343AbiCXPoL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 11:44:11 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48238A1447
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 08:42:39 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id p15so9967067ejc.7
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 08:42:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-transfer-encoding;
        bh=kZCJsDwuqFmPdGnVK+OvD0sFJ1NQAHf3rkQ/uko1Ypo=;
        b=TLgs+/f1fDU/asNFSeTTbfgjarvjKtaY7VH4v6LErCV5kTHXrowQmCYq+4ZwYBZ1k5
         L7DtOzlE30HO8bY0DShfaoOTFaobumChKR+E5mRqWzSrjrJQsNG4bJLwRQqSwxejBLfA
         R8B1oNJ32Xs4hsmgRL7crsc7hH5IIa+gMaTKeUYSZq++tzRI3Dxk5PxyHA9bE7bNBWuQ
         AdtT4WVvDon+nZLvjLoviTiD/LznDmH+itMDO73OCUUCXwZTN3ndBHAztu2kArqId9cj
         YSMP98LdTwuy1WuvppskGjKRUl9O9vDXstuP3g0sW8QSUmHz3pQKJhoLe1fcOzQdAVnP
         vpYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-transfer-encoding;
        bh=kZCJsDwuqFmPdGnVK+OvD0sFJ1NQAHf3rkQ/uko1Ypo=;
        b=nLOFVQVZnDP7Da+z386NE9SzRBO6fRBLdff3zFAZU8WiSnqlQQip2mSFySxvDOH1bC
         2YaNv3Kzi/YkAm5cboKANcrtcdRs9i0eGKkOeF5FFUbFvujPDGRMkJdlQB8FLkkHdZzA
         Nh38K09Jvs6ZyZ6H8d1Ya8ewzS3/L6xcjAZNvbE1B6ai/eq8PfcgS9rebfvGFkHSQdsy
         5G8tKt0U6LrMQnu0H6VlSfXmmrHX5iqvOCt+pNqz95pZBsEYnT3+7QBa25TQOz3mcMXs
         ZgDJIqAtP1+rR918Uz5RUd80dYSOPHLLwJjhSNjn8ouRs/mMut6Md3MsrWhrjwbNNCHU
         WUvw==
X-Gm-Message-State: AOAM532a2twpO7tuj7MFxyMYZi+ZEaVNt+eYvy3e/il+Vofb8u77ojPH
        Xk2HDJ2brrGOy94PEjvK8SM=
X-Google-Smtp-Source: ABdhPJzdC5QIuMVd73kQ1G9mQxF9Fvzi6kbhcWRNuv85/Ql+uKrgaDzkXDmNWSYf205OJ0D5ZZ1zEw==
X-Received: by 2002:a17:906:58cb:b0:6df:f696:9b32 with SMTP id e11-20020a17090658cb00b006dff6969b32mr6597382ejs.384.1648136557640;
        Thu, 24 Mar 2022 08:42:37 -0700 (PDT)
Received: from [109.186.89.7] (109-186-89-7.bb.netvision.net.il. [109.186.89.7])
        by smtp.gmail.com with ESMTPSA id u4-20020aa7db84000000b004136c2c357csm1549665edt.70.2022.03.24.08.42.35
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Thu, 24 Mar 2022 08:42:37 -0700 (PDT)
Message-ID: <623C9137.3000803@gmail.com>
Date:   Thu, 24 Mar 2022 17:41:43 +0200
From:   Eli Billauer <eli.billauer@gmail.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.12) Gecko/20100907 Fedora/3.0.7-1.fc12 Thunderbird/3.0.7
MIME-Version: 1.0
To:     Jakob Koschel <jakobkoschel@gmail.com>
CC:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, Mike Rapoport <rppt@kernel.org>,
        Brian Johannesmeyer <bjohannesmeyer@gmail.com>,
        Cristiano Giuffrida <c.giuffrida@vu.nl>,
        "Bos, H.J." <h.j.bos@vu.nl>
Subject: Re: [PATCH] char: xillybus: replace usage of found with dedicated
 list iterator variable
References: <20220324070939.59297-1-jakobkoschel@gmail.com>
In-Reply-To: <20220324070939.59297-1-jakobkoschel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks.

Acked-by: Eli Billauer <eli.billauer@gmail.com>

On 24/03/22 09:09, Jakob Koschel wrote:
> To move the list iterator variable into the list_for_each_entry_*()
> macro in the future it should be avoided to use the list iterator
> variable after the loop body.
>
> To *never* use the list iterator variable after the loop it was
> concluded to use a separate iterator variable instead of a
> found boolean [1].
>
> This removes the need to use a found variable and simply checking if
> the variable was set, can determine if the break/goto was hit.
>
> Link:https://lore.kernel.org/all/CAHk-=wgRr_D8CB-D9Kg-c=EHreAsk5SqXPwr9Y7k9sA6cWXJ6w@mail.gmail.com/
> Signed-off-by: Jakob Koschel<jakobkoschel@gmail.com>
> ---
>   drivers/char/xillybus/xillybus_class.c | 26 ++++++++++++--------------
>   1 file changed, 12 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/char/xillybus/xillybus_class.c b/drivers/char/xillybus/xillybus_class.c
> index 5046486011c8..0f238648dcfe 100644
> --- a/drivers/char/xillybus/xillybus_class.c
> +++ b/drivers/char/xillybus/xillybus_class.c
> @@ -174,18 +174,17 @@ void xillybus_cleanup_chrdev(void *private_data,
>   			     struct device *dev)
>   {
>   	int minor;
> -	struct xilly_unit *unit;
> -	bool found = false;
> +	struct xilly_unit *unit = NULL, *iter;
>
>   	mutex_lock(&unit_mutex);
>
> -	list_for_each_entry(unit,&unit_list, list_entry)
> -		if (unit->private_data == private_data) {
> -			found = true;
> +	list_for_each_entry(iter,&unit_list, list_entry)
> +		if (iter->private_data == private_data) {
> +			unit = iter;
>   			break;
>   		}
>
> -	if (!found) {
> +	if (!unit) {
>   		dev_err(dev, "Weird bug: Failed to find unit\n");
>   		mutex_unlock(&unit_mutex);
>   		return;
> @@ -216,22 +215,21 @@ int xillybus_find_inode(struct inode *inode,
>   {
>   	int minor = iminor(inode);
>   	int major = imajor(inode);
> -	struct xilly_unit *unit;
> -	bool found = false;
> +	struct xilly_unit *unit = NULL, *iter;
>
>   	mutex_lock(&unit_mutex);
>
> -	list_for_each_entry(unit,&unit_list, list_entry)
> -		if (unit->major == major&&
> -		    minor>= unit->lowest_minor&&
> -		    minor<  (unit->lowest_minor + unit->num_nodes)) {
> -			found = true;
> +	list_for_each_entry(iter,&unit_list, list_entry)
> +		if (iter->major == major&&
> +		    minor>= iter->lowest_minor&&
> +		    minor<  (iter->lowest_minor + iter->num_nodes)) {
> +			unit = iter;
>   			break;
>   		}
>
>   	mutex_unlock(&unit_mutex);
>
> -	if (!found)
> +	if (!unit)
>   		return -ENODEV;
>
>   	*private_data = unit->private_data;
>
> base-commit: f443e374ae131c168a065ea1748feac6b2e76613
>    

