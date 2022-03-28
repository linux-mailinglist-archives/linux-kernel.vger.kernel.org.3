Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43FD24E8F44
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 09:46:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236701AbiC1HsF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 03:48:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238932AbiC1HsE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 03:48:04 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B48D52E38;
        Mon, 28 Mar 2022 00:46:24 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id x2so14094011plm.7;
        Mon, 28 Mar 2022 00:46:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=UUGs7NfPknNjnP5jCgmZr4i/5kdZ8T8lluTC77iESeA=;
        b=pGB1XQ2xgJ565xgWHPM86WjBPm0Lt996wPbI/0QZlHmpJeFNzH+EHAIrPO5I4zmCln
         isdEtMUpktmwkgxhsY1EkgRRFv4zl56dn8SUfaix3VMnLOE8+e1CKhT9D2bIMcZpxDea
         PBiBaqA1KI6F1SiDVddHK+y7b/g1tbnvgoErVDjZhYx31NpagmkHK5D/TZ0uuAuyHnxk
         LOBG/ZxePYk2T68ZvoL3I8urv2ykYC5k7ti1/zFD1JET4d0VxtsdeQcvqQrSoBv3zCL+
         4fAnvxXC2SRkYtK84H/pdX9LayMrnJciBYRIin9f8ORHF5ogi4WP6DxaQlQ2XMhGSsYU
         HhaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=UUGs7NfPknNjnP5jCgmZr4i/5kdZ8T8lluTC77iESeA=;
        b=wXNQQoeqLEpiHzbSlnLSnIinwFYyGi6WPaxTR8wRrl7bL8ZbFF/lUPywOFcKKWNEZV
         jYsoSdIYeus3VonWM9nNqU0xrWh6dBoIZtOAlar+1wy7BCPABUzGgw+kMEGm8Y1jjGaR
         fI78qF+nyVkB7XzQ1D1R7lpvXAjq88bMUGkyfKlr93BN9Khgkbi8mGbWwjTq8VqncLRM
         RwjKzTvV0cuS+4u/tuITVmWG08I8twuR5wOWYTETPvwbTtJLbFrZg3Ky8nHz9PIsGRrV
         3HF+bQh2f8FwvEsqAun07K3VwFiXg9ppYYI4VcThcIHoocmYjgaaHn/3q/8vVgco0O48
         2uVg==
X-Gm-Message-State: AOAM533YKR8/5YC1jEcgBg+EVEQtDpPP9biPdXCN0GVEgh0EEjzlO8Mq
        6pWa0PXLi6tUiXalubuRPXE=
X-Google-Smtp-Source: ABdhPJwmadm8JhIfIAooCaf1RF76zUjIQH1s2IWFwwOfZKGrgW+OCSBJZ8UTXGuaYo+TlbXp9tLCRA==
X-Received: by 2002:a17:90a:a593:b0:1c9:b837:e77d with SMTP id b19-20020a17090aa59300b001c9b837e77dmr1876668pjq.205.1648453583984;
        Mon, 28 Mar 2022 00:46:23 -0700 (PDT)
Received: from [192.168.11.5] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id ip1-20020a17090b314100b001c7b10fe359sm13896861pjb.5.2022.03.28.00.46.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Mar 2022 00:46:23 -0700 (PDT)
Message-ID: <6a5ce717-cc0a-9b7c-ba08-88e3b9f760bb@gmail.com>
Date:   Mon, 28 Mar 2022 16:46:16 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v3 1/2] Documentation: kernel-doc: Promote two chapter
 headings to page title
Content-Language: en-US
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        Vinod Koul <vkoul@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, Akira Yokosawa <akiyks@gmail.com>
References: <20220328065030.24936-1-bagasdotme@gmail.com>
 <20220328065030.24936-2-bagasdotme@gmail.com>
From:   Akira Yokosawa <akiyks@gmail.com>
In-Reply-To: <20220328065030.24936-2-bagasdotme@gmail.com>
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

On Mon, 28 Mar 2022 13:50:30 +0700,
Bagas Sanjaya wrote:
> Promote two chapter headings, named "Writing kernel-doc comments" and
> "Including kernel-doc comments" to page title. These titles deserve
> their own chapters in PDF output, although these will also appear as two
> separate titles in table of contents in HTML output.

As Mauro and I have pointed out, this change won't have any effect
in the resulting HTML and PDF docs.  No difference *at all*.

Why do you think this change is worthwhile.

Please convince us!

> 
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Tony Nguyen <anthony.l.nguyen@intel.com>
> Cc: Vinod Koul <vkoul@kernel.org>
> Cc: Daniel Borkmann <daniel@iogearbox.net>
> Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> Cc: Akira Yokosawa <akiyks@gmail.com>
> Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> Cc: Jens Axboe <axboe@kernel.dk>
> Cc: linux-kernel@vger.kernel.org
> Suggested-by: Akira Yokosawa <akiyks@gmail.com>

Please don't put this Suggested-by: at the moment.

        Thanks, Akira

> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
> ---
>  Documentation/doc-guide/kernel-doc.rst | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/doc-guide/kernel-doc.rst b/Documentation/doc-guide/kernel-doc.rst
> index 79aaa55d6bcf2b..a7cb2afd799007 100644
> --- a/Documentation/doc-guide/kernel-doc.rst
> +++ b/Documentation/doc-guide/kernel-doc.rst
> @@ -1,3 +1,4 @@
> +===========================
>  Writing kernel-doc comments
>  ===========================
>  
> @@ -436,6 +437,7 @@ The title following ``DOC:`` acts as a heading within the source file, but also
>  as an identifier for extracting the documentation comment. Thus, the title must
>  be unique within the file.
>  
> +=============================
>  Including kernel-doc comments
>  =============================
>  
