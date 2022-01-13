Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D917448DA5E
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 16:02:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235919AbiAMPCl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 10:02:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233641AbiAMPCj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 10:02:39 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A813C06173F
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jan 2022 07:02:39 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id k30so10612613wrd.9
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jan 2022 07:02:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=NjQ5CckMH/FqJHfWgmyb7DQKMb+OQO1cEac1mm0zNp0=;
        b=yt160kvam3HJdDmZb3vsgy1B/f68cJyCqRxHQGpeUER/bpnSaBG7Qh/n9igDWSpKlW
         lMQHT+qDXxcH3Ji+D24uEeHoEGgFn9vwppBCwpbmCI00TJsAxYE/zuzhspFjriUt3zIO
         xO1kYIHSoT7TdChA2VswjVnPZ7zaQG20FDT4WB+SdrPYYjW7k+3dbRvf+geNvagAYkpq
         AMr5RBx28EPYCSqhT8++9pqwwsSMEFhlsEOhqs2BGtwAJqEMVFDO3V26YtGLQ8Pu/OqL
         ga6ApEUefApiDfHc9WqxWYwCOHyKMnDIWJPL/5ETrgBEebfweJNEM0UEZko1ivBtaQjx
         zw3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NjQ5CckMH/FqJHfWgmyb7DQKMb+OQO1cEac1mm0zNp0=;
        b=hJ9iQeLBZYveDkLR7KYTXCQIA8ppeLGmrF/CJUMlD7BdBlEsQHreacGeK8JoPuytDw
         5U29PtgtVySt4qX0/ZoPwwgBr6Q+MsZ6DEnAahrR93SqRTtiK7Yj0qqV8oyBcuGTat8w
         wCD1kh8WygvJ13C1Nnh/G99zQAOQd+kxe1253iPMB+KZwyRc+6hhkxiJxjvCtE00q/P0
         lT9YIYth75+sg/dI+j7iOQ9FuLUTVIgrcsAUIFmmkjYFduTAVc3RRxhxZfy6lHxgQeVF
         N3Oj9Eta9VXPvE1fvwujFCFHvG7jcXUsWhnXWP4Gb/C3phwTex+xIipcLHJnjB3m+XJv
         0q6g==
X-Gm-Message-State: AOAM531BjUIrm866oga9XDYlSqPLs4dvi2MnP91KvdlriQT492S+2EjM
        CBt3UlblEgJ5gbfwcNfyn8oSuA==
X-Google-Smtp-Source: ABdhPJxel8Y0oxv14BbumdD74ugMJ5nF6Wawn+vNlK5AtA4I45AJGBMjljCF4xkTlJ3wYfJ8vpqPrQ==
X-Received: by 2002:a05:6000:1563:: with SMTP id 3mr1836447wrz.395.1642086157839;
        Thu, 13 Jan 2022 07:02:37 -0800 (PST)
Received: from maple.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id h14sm2682335wrz.31.2022.01.13.07.02.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jan 2022 07:02:37 -0800 (PST)
Date:   Thu, 13 Jan 2022 15:02:35 +0000
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Xu Wang <vulab@iscas.ac.cn>
Cc:     lee.jones@linaro.org, jingoohan1@gmail.com,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] backlight: lm3630a_bl: Remove redundant
 'flush_workqueue()' calls
Message-ID: <20220113150235.fyzee7bhx7uceiwk@maple.lan>
References: <20220113084806.13822-1-vulab@iscas.ac.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220113084806.13822-1-vulab@iscas.ac.cn>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 13, 2022 at 08:48:06AM +0000, Xu Wang wrote:
> 'destroy_workqueue()' already drains the queue before destroying it, so
> there is no need to flush it explicitly.
> 
> Remove the redundant 'flush_workqueue()' calls.
> 
> Signed-off-by: Xu Wang <vulab@iscas.ac.cn>

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>


Daniel.
