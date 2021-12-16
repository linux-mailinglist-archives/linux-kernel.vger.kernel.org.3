Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 566E94768F6
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 05:08:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231680AbhLPEIc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 23:08:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231303AbhLPEIb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 23:08:31 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECA45C061574;
        Wed, 15 Dec 2021 20:08:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
        :In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=tfRydSG9UvslEfDaf+mltZ2vp8UyubsrzsjWaUyNOdQ=; b=MeE7Jb2LioOmOnHPBRtEgJO9xb
        awtEVX5KC8x0c9K06Es1tt1udMIB1Yr03WLuRawFzv0TrQNOnSh6yVC/u4QvZaTg8z2hCvWs/6CiZ
        BcffeAHQnukzxHfKchGT8iCg/09HP1DID45VvLT+Tfqy/kmmNv2hCys32BTBfkzd3vng+UhMc5jCS
        chmrdZpquLWq19E5mEfz9gGgxx/jqyoHomlBIl/sNj57QLhWblZ6yyqTtJpMLFOeRbifKlE7zH1OW
        cINxzdO1dnax4V47wOJGn/emuOz4jKumMzBpfTBRIhBB0gBIJP5iWAGyd1ilMSoIudNsaeyvvrKZ5
        oP+OF7yA==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mxi3t-001d8z-1q; Thu, 16 Dec 2021 04:08:09 +0000
Message-ID: <42b7c12f-659b-409a-f4e3-c7a0560b3ce6@infradead.org>
Date:   Wed, 15 Dec 2021 20:08:04 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH -next] HID: intel-ish-hid: ishtp-fw-loader: Fix a
 kernel-doc formatting issue
Content-Language: en-US
To:     Yang Li <yang.lee@linux.alibaba.com>,
        srinivas.pandruvada@linux.intel.com
Cc:     jikos@kernel.org, benjamin.tissoires@redhat.com,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Abaci Robot <abaci@linux.alibaba.com>
References: <20211216040146.89075-1-yang.lee@linux.alibaba.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20211216040146.89075-1-yang.lee@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 12/15/21 20:01, Yang Li wrote:
> This function had kernel-doc that not used a hash to separate

                               that did not use a dash or hyphen to separate

Patch looks good. Thanks.

> the function name from the one line description.
> 
> The warning was found by running scripts/kernel-doc, which is
> caused by using 'make W=1'.
> 
> drivers/hid/intel-ish-hid/ishtp-fw-loader.c:271: warning: This comment
> starts with '/**', but isn't a kernel-doc comment. Refer
> Documentation/doc-guide/kernel-doc.rst
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
> ---
>  drivers/hid/intel-ish-hid/ishtp-fw-loader.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/hid/intel-ish-hid/ishtp-fw-loader.c b/drivers/hid/intel-ish-hid/ishtp-fw-loader.c
> index 0e1183e96147..e24988586710 100644
> --- a/drivers/hid/intel-ish-hid/ishtp-fw-loader.c
> +++ b/drivers/hid/intel-ish-hid/ishtp-fw-loader.c
> @@ -268,7 +268,8 @@ static int get_firmware_variant(struct ishtp_cl_data *client_data,
>  }
>  
>  /**
> - * loader_cl_send()	Send message from host to firmware
> + * loader_cl_send() - Send message from host to firmware
> + *
>   * @client_data:	Client data instance
>   * @out_msg:		Message buffer to be sent to firmware
>   * @out_size:		Size of out going message
> 

-- 
~Randy
