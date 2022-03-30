Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DD584EC6F9
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 16:45:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347043AbiC3Oqw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 10:46:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347135AbiC3Oqq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 10:46:46 -0400
Received: from out203-205-221-210.mail.qq.com (out203-205-221-210.mail.qq.com [203.205.221.210])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 456A02261DB
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 07:44:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1648651492;
        bh=lTgajV11zNpM7mAdZ1h28DYUbBkTePOXWgji2CQAO54=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=DjKyToN9tSHkgyfG4Z3OYrIAUNYU4ECzw5wTmgjWZcW0HCWqRUvNQB7cl8KnPOh99
         53YCEwl+3LhWkcEGEvgPTSWBVFQBNIyNcg5uTWGlNgrwYJhgA3K3BhzkbxsP0mOmxo
         YpVBI8c1sggO7buueVtFUEurMWeJaP25vnGnikgo=
Received: from [192.168.31.6] ([120.245.132.52])
        by newxmesmtplogicsvrszb7.qq.com (NewEsmtp) with SMTP
        id B3296492; Wed, 30 Mar 2022 22:44:50 +0800
X-QQ-mid: xmsmtpt1648651490tjisbgjpr
Message-ID: <tencent_508F9F7681360F657D131FF97D2C53506208@qq.com>
X-QQ-XMAILINFO: NKv2G1wnhDBnP95dw+5kBstDP0nV5i/NtDG7Z4JJhAuzH/sjD+aYjQgMRzFY+S
         Hhtv51RgLTojdgDD+gPhDyvSoPCtG0+NluQ/Lc+/BXGkdGHENL3ksnfBwRGCVZc3Wb1FnaFC+hPn
         fC4MAl0+UGdHFC0oUIWo4IyJkygyHl0ZDSyqaZprWVw4/e5RCpZYSUkZ5Tm57BewTYTtNhH2Zgf8
         Mh340U6eAjqaHl8N9FR0K2brOILGxTjR/jc0xeMWzfZw28mV7RCcrjsgcx79y6aAkEAJc3D1134c
         xXx60RVclkQ7mdCJecUTkE3LRTIQ7zkIa92XegT/P7uY9xvfSs9qNSbYabGNqlVmeCTkzisiL7eh
         WjCH49ixXZnNRz7M6dMHPJH0cjdX3CruTSydnGOnkatZlULyeSwPaIdRiKSZcyG0so1YzQ8Hzrug
         q75Bx/nUJtPll8ZzVrESJnmo2Lbxo2j+hnGQNz+naHrr7R8zL+ldiYXvq6TW6lwDu4/37zBup97J
         mOzFG2L8A0G5zYSpGnMLl5h1dYYfor9AojvHzl2dxDhL0xzEn8Qv1s2utwHp6xo3IOnALbfMBGjl
         fdxBqKjZFJjXLh+Z8UnyKRSuVjBkDNVuYvOARuYd2MAJih6L+nobGVRpECiHP3gquqmRV0an6Bd2
         pM9BsHoRlC5djX37EOQK8lgFhZ0b079oGrNdOcESRsYGBDGVBFuUUv+jv8Sf2H2FIh0YiNZelPst
         nKlyEofVOR1TiVnVXEDRgsfpO0mOTAiS8xUCqV4herV/lPaOirfzN82tCifmpyVbVc39QOWUV9Ow
         5L4dvJJnJN1fQeASPaApnk4boeGQGzeEfa91dhhfREcElG1+N5JDDp2p8+gxHlQ+vQSPFZwXejLe
         5g9Q3/BL+LaCGAXK2TI6M4ZmT+7ZU5p8YnMvD+lZFxvcOXTx/8Rzq0Dsehbnje3mVQMq3bj69d
X-OQ-MSGID: <261ebec9-bb27-1ab0-b2d7-d2a26274cd95@foxmail.com>
Date:   Wed, 30 Mar 2022 22:44:50 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 2/4] ipmi: Limit the number of message a user may have
 outstanding
Content-Language: en-US
To:     minyard@acm.org
Cc:     openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Corey Minyard <cminyard@mvista.com>
References: <20220329183340.471474-1-minyard@acm.org>
 <20220329183340.471474-3-minyard@acm.org>
From:   chenchacha <chen.chenchacha@foxmail.com>
In-Reply-To: <20220329183340.471474-3-minyard@acm.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_MUA_MOZILLA,
        FREEMAIL_FROM,HELO_DYNAMIC_IPADDR,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,RDNS_DYNAMIC,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> @@ -2298,6 +2309,14 @@ static int i_ipmi_request(struct ipmi_user     *user,
>   	struct ipmi_recv_msg *recv_msg;
>   	int rv = 0;
>   
> +	if (user) {
> +		if (atomic_add_return(1, &user->nr_msgs) > max_msgs_per_user) {
> +			atomic_dec(&user->nr_msgs);
> +			rv = -EBUSY;
> +			goto out;
> +		}
> +	}
> +
> @@ -2369,6 +2388,8 @@ static int i_ipmi_request(struct ipmi_user     *user,
>   	rcu_read_unlock();
>   
>   out:
> +	if (rv && user)
> +		atomic_dec(&user->nr_msgs);
>   	return rv;
>   }

If the number of msg is greater than the limit, the nr_msgs will be 
decrease twice.

Should it be returned directory?

--
Chen Guanqiao
