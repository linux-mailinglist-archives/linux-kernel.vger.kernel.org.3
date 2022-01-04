Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 116104846F7
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 18:27:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235488AbiADR1G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 12:27:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232884AbiADR1F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 12:27:05 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5CDEC061784
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jan 2022 09:27:04 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id l4so23728144wmq.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jan 2022 09:27:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=FkvEoZ+f1KklL29+roJfQw/3hslNdGuWFi/qt4fzI8M=;
        b=R899uS41/RNeFFNpSnGxelyhgwPPMfXksBO72coQY7q6dqkyhx3hjShQ/aZvkwwHbd
         6hO5XmIxz0mDI644+u1/1qDCDf3LrknftqzZa/B9l1SqcPAFYuTadf10B7Odh2voElbe
         7X325pv1hQLekivXePmdeQCu9W8v/qiDYbiriGnagbZGEuT9AH70SkXXruldHvcjgf2C
         ZbZ2Syg1iLg9CqKf2Eqod2C2/XNIWn46Z1FPr+ylBJgPMLE0ffpTRIy2u7cH8qo2vKDB
         DuVCAKWSs+o2h6kWQYnzX1oeJzqcAlkmH9+qkbtIiVnUnMHagR+tM/WrmjlBpkh932FT
         I/+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=FkvEoZ+f1KklL29+roJfQw/3hslNdGuWFi/qt4fzI8M=;
        b=cX0Zb6h5mzXFNPlooXzOds9K/7qVQPMxpqAa43RebzFBXM9BJ98YoNL0rTZA4fnK5D
         NOYkg54dyWVtLA6C+7uOb8kIhVTIgjqGoGvqNlad9yT4V1p79RMaxL3a6BNOHjll2pUk
         eEOc8W+SnXMix0gNuDwG9e6gIWiBWCvgYlB90w8QXC4W1zRCTDGMdeQaBGF8IwOTWGHo
         yw6PbLMquOGHC87rcCkEuukpfswE3dk/fegFNcrMKzN7sAqkZ11K1ceiz5BDfI2GqOnu
         +4I5DpLm54QZ243Ipb0NjATFVHz3zJUYeS8Z7JlxvJ4JMlee9zzL7vScYmBko9bFdvHL
         pFSQ==
X-Gm-Message-State: AOAM532YkKzXvZHR7EuRj2OKOq3NNbTAbvjStLaX9lqnd0uUGv4Ba5Eu
        GflZi+9yMaKOqc3YrgOf2YBhpg==
X-Google-Smtp-Source: ABdhPJz5YFm5a05QEukbkxkYHFV4Q3kslnLu7Nlf+0vhzDrdejKouDenOe8oqoMDNNfTGkOd/4eeJQ==
X-Received: by 2002:a05:600c:2904:: with SMTP id i4mr41957999wmd.61.1641317223293;
        Tue, 04 Jan 2022 09:27:03 -0800 (PST)
Received: from maple.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id i8sm7945wmq.4.2022.01.04.09.27.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jan 2022 09:27:02 -0800 (PST)
Date:   Tue, 4 Jan 2022 17:27:01 +0000
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Christian =?utf-8?B?TMO2aGxl?= <CLoehle@hyperstone.com>
Cc:     "jason.wessel@windriver.com" <jason.wessel@windriver.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dianders@chromium.org" <dianders@chromium.org>,
        "corbet@lwn.net" <corbet@lwn.net>
Subject: Re: [PATCH] Documentation: kgdb: Replace deprecated remotebaud
Message-ID: <20220104172701.7ychluvlcts4anab@maple.lan>
References: <13287b7914344c7995de27224cd2fa73@hyperstone.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <13287b7914344c7995de27224cd2fa73@hyperstone.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 04, 2022 at 04:56:51PM +0000, Christian Löhle wrote:
> The gdb remotebaud to set baudrate has been replaced in favor of
> set serial baud many years ago.

I'd prefer to have a little more historical info in the patch header
so that anyone still running gdb-7.6 has a better shot at finding out
what is going on (some folks in the embedded world end up relying on
surprisingly old cross-toolsets).

In other words something more like:

  Using set remotebaud to set the baud rate was deprecated in
  gdb-7.7 and completely removed from the command parser in gdb-7.8
  (released in 2014). Adopt set serial baud instead.

Other than that the change looks good to me so with an improved
description containing the above versions and dates this can be:
Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>


Thanks

Daniel.


> 
> Signed-off-by: Christian Loehle <cloehle@hyperstone.com>
> ---
>  Documentation/dev-tools/kgdb.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/dev-tools/kgdb.rst b/Documentation/dev-tools/kgdb.rst
> index 43456244651a..7c90e111b364 100644
> --- a/Documentation/dev-tools/kgdb.rst
> +++ b/Documentation/dev-tools/kgdb.rst
> @@ -557,7 +557,7 @@ Connecting with gdb to a serial port
>     Example (using a directly connected port)::
> 
>             % gdb ./vmlinux
> -           (gdb) set remotebaud 115200
> +           (gdb) set serial baud 115200
>             (gdb) target remote /dev/ttyS0
> 
> 
> --
> 2.34.1
> Hyperstone GmbH | Reichenaustr. 39a  | 78467 Konstanz
> Managing Director: Dr. Jan Peter Berns.
> Commercial register of local courts: Freiburg HRB381782
> 
