Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83227461683
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 14:33:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377835AbhK2Ng7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 08:36:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244071AbhK2Ne6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 08:34:58 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 713D8C09B10F
        for <linux-kernel@vger.kernel.org>; Mon, 29 Nov 2021 04:12:07 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id c4so36266041wrd.9
        for <linux-kernel@vger.kernel.org>; Mon, 29 Nov 2021 04:12:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=WqdflxgI6arfq3UiFmee+a67c605Nu2WFMJ9FV+8d5M=;
        b=ursokyjSfnVUeueIoKmOB6gsYJu57AiJbwWwy95pfuUJcLkIEa5gXuXZmJAyyb0rKU
         NkGtPPZzdayWXDtt9FZjdB32IAUYzb2tjpRDVFQ1RADt/NyYPXhEjF24L1JCwAKLSro8
         HYUJB2NQIX0/AXnsjN9nqGwkNV8EqOy5Y9kCAAgkYU7YpMhJjZN0nrUo2fquYd/cWxGf
         qqYL25I0BNjU5PcVJWmbCwdCTR1FFDyU9jHDrYvxw7enBdTymJ/ZFy+ZoqtDruMdRu8r
         Y0IzXEMV/ipwMIaA18BYPdZjVnSnUZo1poleRivC6hsGdhGaZXWfK35cyqbBBBVZ2DLX
         eJaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=WqdflxgI6arfq3UiFmee+a67c605Nu2WFMJ9FV+8d5M=;
        b=rX2oqwv6ENk08v8PsuouCkc3S3JTWeAq2tqYB19nJUFwoBNprc5stZrPlqRfaP55jX
         pG2f2aTJYu+I09LGBc7vBt0dgr+foJLdPpl0fDKhFCQKqHVb3PoOWhbTUwiRET0rPkaD
         qcZfLDULlgRqUDj9ptLJ39xE6ou/DNLdWRv1V7e30f5QYSzNYfw5/ug0QEpo8Zkg2xf/
         QYyCp4IUGw0HbTLOR0PxsvyEgJGNPp1hogRf5SI4r07+MCMBG1UUbxmPtD5EX2aa8Vwl
         kblWKZaO47UwCsE9x9WxrWTL2dWENtXLGIqs4DgWfI/DQuYQCD0Mp98kepY6CJdHL7Yn
         R2VA==
X-Gm-Message-State: AOAM531hhxP6g6PL59Dv09BfiFM4zQIP2DIzpp7AsoPu5QsFTEpdgYYN
        pdkIPjUvXkt/kvHRkP2dNrWgHjRoFsE/8Q==
X-Google-Smtp-Source: ABdhPJyg3hEd7YFvnDNNdgx+/OnoUlXwmVvv7VxHbxEhNmMWA/F3ApmCWq8pYO2iQ7DsXqJR74iWVg==
X-Received: by 2002:adf:db04:: with SMTP id s4mr32588583wri.467.1638187925986;
        Mon, 29 Nov 2021 04:12:05 -0800 (PST)
Received: from google.com ([2.31.167.18])
        by smtp.gmail.com with ESMTPSA id o10sm16716162wri.15.2021.11.29.04.12.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Nov 2021 04:12:05 -0800 (PST)
Date:   Mon, 29 Nov 2021 12:12:03 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Andrej Picej <andrej.picej@norik.com>
Cc:     support.opensource@diasemi.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mfd: da9062: support SMBus and I2C mode
Message-ID: <YaTDk4rk4Af7kgvL@google.com>
References: <20211124065119.2514872-1-andrej.picej@norik.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211124065119.2514872-1-andrej.picej@norik.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Nov 2021, Andrej Picej wrote:

> Enable the I2C bus mode if I2C_FUNC_I2C is set. Based on da6093 commit:
> "586478bfc9f7 mfd: da9063: Support SMBus and I2C mode"
> 
> Signed-off-by: Andrej Picej <andrej.picej@norik.com>
> ---
>  drivers/mfd/da9062-core.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
