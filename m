Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A58147358C
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 21:02:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241848AbhLMUB5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 15:01:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229897AbhLMUBz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 15:01:55 -0500
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91756C061574
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 12:01:55 -0800 (PST)
Received: by mail-io1-xd2f.google.com with SMTP id p65so20139766iof.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 12:01:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ieee.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=3iSNR3ejvooF9vq0Obv4fgL6xUSCQ0TFvXQZX/GtFkc=;
        b=SVHjXXfQaaDzN7wXth1wyGOaMQxNfL1z0B+Chg1iOUIWWUcxNx2pFt5vFlYrgEp1yy
         xOZ/Zqoc7U992FYO4cRVGWJyiataCj0GfX3IuBrfxdN6uG10ojbadbWW4uDmFy1Gu3Yd
         rXGi7PVF+o8oMfIZ7wWXjqiSmCKCDXF3EMDGs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=3iSNR3ejvooF9vq0Obv4fgL6xUSCQ0TFvXQZX/GtFkc=;
        b=gJ8xXPtPoFDa71KNVwQzhrgtJTv12lZ56Accbfi2h83SD8RCWl4yPp4Y9IJ1RwLQz3
         zx0sepcb+1Nt2Id253M9g/O20sQLiT4XHHXU984rXaHohGO1HqriJdl6o0j3aP/JrNPQ
         bFmiRKr5ORkm3Hzei+fUeDdBUIU7/rlpJVTeFigwC9k+06pxQqVhrRvetNSgRhckqo03
         qZH94ouT/NdpENQxEkstE0jvBn5MVD74kMkl4rVgkpoVkVlO1juGZulXKgZ67H4uhQOa
         aaf3xklv4171Vi8lj1jhTISR/TokEHYCEkVEWfQ1kO8ssdqlDfPF/dcMcb7nuhxce0GE
         axuw==
X-Gm-Message-State: AOAM533a1Bb91XcAhXgcPUYY9eEqlfi975txCe9tEp7kVxNWWn0YYmq7
        1jUnOUPBW5JjQ6vS46KSraty7Q==
X-Google-Smtp-Source: ABdhPJyFBMFxUOUIPIbjlZyG/ZSu4VqoYZES+FW9ZhxkEwdbgUXjZCkFd37nP9KY24vozOVaiaCCqQ==
X-Received: by 2002:a05:6602:2c83:: with SMTP id i3mr682865iow.54.1639425714638;
        Mon, 13 Dec 2021 12:01:54 -0800 (PST)
Received: from [172.22.22.4] (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.googlemail.com with ESMTPSA id 8926c6da1cb9f-2faa6b4da5dsm42295173.96.2021.12.13.12.01.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Dec 2021 12:01:48 -0800 (PST)
Message-ID: <bf148212-3030-9ed9-2ff0-5cff0b2e727e@ieee.org>
Date:   Mon, 13 Dec 2021 14:01:46 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH] greybus: es2: fix typo in a comment
Content-Language: en-US
To:     Jason Wang <wangborong@cdjrlc.com>, elder@kernel.org
Cc:     johan@kernel.org, gregkh@linuxfoundation.org,
        greybus-dev@lists.linaro.org, linux-kernel@vger.kernel.org
References: <20211212031657.41169-1-wangborong@cdjrlc.com>
From:   Alex Elder <elder@ieee.org>
In-Reply-To: <20211212031657.41169-1-wangborong@cdjrlc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/11/21 9:16 PM, Jason Wang wrote:
> The double `for' in the comment in line 81 is repeated. Remove one
> of them from the comment.

This looks fine.  But it's so trivial...  Are you aware
of *any* other similar trivial problems in comments that
could be fixed together with this?  If so, I would prefer
that.

If you've looked, and there are no others:

Reviewed-by: Alex Elder <elder@linaro.org>


> Signed-off-by: Jason Wang <wangborong@cdjrlc.com>
> ---
>   drivers/greybus/es2.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/greybus/es2.c b/drivers/greybus/es2.c
> index 15661c7f3633..e89cca015095 100644
> --- a/drivers/greybus/es2.c
> +++ b/drivers/greybus/es2.c
> @@ -78,7 +78,7 @@ struct es2_cport_in {
>    * @hd: pointer to our gb_host_device structure
>    *
>    * @cport_in: endpoint, urbs and buffer for cport in messages
> - * @cport_out_endpoint: endpoint for for cport out messages
> + * @cport_out_endpoint: endpoint for cport out messages
>    * @cport_out_urb: array of urbs for the CPort out messages
>    * @cport_out_urb_busy: array of flags to see if the @cport_out_urb is busy or
>    *			not.
> 

