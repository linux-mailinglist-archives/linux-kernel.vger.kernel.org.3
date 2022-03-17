Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 483D34DCFE0
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 22:03:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230003AbiCQVEW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 17:04:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229966AbiCQVET (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 17:04:19 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18F6239141;
        Thu, 17 Mar 2022 14:03:02 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id bg31-20020a05600c3c9f00b00381590dbb33so3811729wmb.3;
        Thu, 17 Mar 2022 14:03:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=sWH98ePusS475I2YzPAj3+F+ANc8EoUJlmN7RbnIJpg=;
        b=WTUveGQ4vnKmfY2iG6powMUX4vafmrzDKbZzR6eX4C6YRScgRbWi0o3CpXnzIAuejm
         rLAvTO7oT1s8kPXUE3USxOU7Zvs5jU27f7XmWfYzV92NGbUYxBDQMES3cKdKF3ao9k3H
         XOzC7gwPLfJEfvj0ERNn1MMab1Ipr3KvJF9V7ZUEZoh9H5UI+C91F3xhbM5YvwB1T8Hj
         XoEz9gS7SFy2se/i1uqbPsU37ZdjvXtW/grkdADlILHe7GMMt51hux1DD2VTF7ahQXXl
         ZKB3uy1JRVnvKZt5BINxzbKNqe4gsRKWEuyTQkQHdWtTvDce6xIiiOXUXrc8DLawAwd8
         XcMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=sWH98ePusS475I2YzPAj3+F+ANc8EoUJlmN7RbnIJpg=;
        b=Bl8Hbg2mTqh+6ePsyw6xIvRovZiiu3IBA+g42My8Q1UJWa6cXrtDXMVAaiKgoaP962
         DzvGtkGdo5dWi4XNhxavM0NkQa5CYJgDyp1KY3DKQ547QnslcRG4nxFFVWHqwksHMGnB
         lco0IDopAVC8qwIhbwWaYocKmLkKfaXBzGTq04HJM0R2JwcM2+Ugg/9v4vPRKpcevZlO
         fxmAqggvtec+KKb3NC1w7iINHyKhjJx0QRzO/X81hlEx+PCBD/if10Xu92LU32OmYGd/
         KkBxdSRgZKzYRMdzBc3BwiPVNu1+Jia7agFGyWj1LLlvTyvHPAt353Vr0JY4SzDW+VNV
         2Gwg==
X-Gm-Message-State: AOAM531ya0/zAnKHVxkYTr9qd5NiLbCNcz+X+kbplyswqosz0sJFbEEW
        aFi0P8Guse3lh7TVQfbVnes=
X-Google-Smtp-Source: ABdhPJwjAPc3j2I0qZweqm2xtyZgAsjXy1JlQLeuhzU9G50LDOw14+eNFsX7sH7K8XUSBjfPnpt9Tw==
X-Received: by 2002:a7b:c341:0:b0:37b:ed90:7dad with SMTP id l1-20020a7bc341000000b0037bed907dadmr5499035wmj.138.1647550980565;
        Thu, 17 Mar 2022 14:03:00 -0700 (PDT)
Received: from [192.168.0.160] ([170.253.36.171])
        by smtp.gmail.com with ESMTPSA id 189-20020a1c02c6000000b0038c57df82aasm5314242wmc.20.2022.03.17.14.02.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Mar 2022 14:03:00 -0700 (PDT)
Message-ID: <bebd3a92-0828-9e7e-d6b0-51b75e45a124@gmail.com>
Date:   Thu, 17 Mar 2022 22:02:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH] madvise.2: update EINVAL return info
Content-Language: en-US
To:     Charan Teja Reddy <quic_charante@quicinc.com>
Cc:     linux-man@vger.kernel.org, linux-kernel@vger.kernel.org,
        minchan@kernel.org, nadav.amit@gmail.com, mtk.manpages@gmail.com
References: <1647442320-7261-1-git-send-email-quic_charante@quicinc.com>
From:   "Alejandro Colomar (man-pages)" <alx.manpages@gmail.com>
In-Reply-To: <1647442320-7261-1-git-send-email-quic_charante@quicinc.com>
Content-Type: text/plain; charset=UTF-8
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

Hellp Charan,

On 3/16/22 15:52, Charan Teja Reddy wrote:
> MADV_COLD and MADV_PAGEOUT advises on an address range which includes
> locked, Huge TLB pages or VM_PFNMAP pages can return EINVAL. Update the
> man pages accordingly.
> 
> Reported-by: Nadav Amit <nadav.amit@gmail.com>
> Signed-off-by: Charan Teja Reddy <quic_charante@quicinc.com>

Patch applied.

Thanks,

Alex

> ---
>  man2/madvise.2 | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/man2/madvise.2 b/man2/madvise.2
> index f1f384c..ab98a87 100644
> --- a/man2/madvise.2
> +++ b/man2/madvise.2
> @@ -505,6 +505,16 @@ is not a valid.
>  .B EINVAL
>  .I advice
>  is
> +.BR MADV_COLD
> +or
> +.BR MADV_PAGEOUT
> +and the specified address range includes locked, Huge TLB pages, or
> +.B VM_PFNMAP
> +pages.
> +.TP
> +.B EINVAL
> +.I advice
> +is
>  .B MADV_DONTNEED
>  or
>  .BR MADV_REMOVE

-- 
Alejandro Colomar
Linux man-pages comaintainer; https://www.kernel.org/doc/man-pages/
http://www.alejandro-colomar.es/
