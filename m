Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AED0572D73
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 07:36:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232939AbiGMFg3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 01:36:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230261AbiGMFf5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 01:35:57 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC56CE1926;
        Tue, 12 Jul 2022 22:31:30 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id o12so9652668ljc.3;
        Tue, 12 Jul 2022 22:31:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=qhbBCVv4kC2WNldsWLi1sTj6ekjdYfnRPW7jzl7wFJ0=;
        b=dqv0Y98t6ze5VJfH71HcYpzY3jJOyznzkga+5Xb8xvLEFLBON8tDJhTauJNGX8BH4M
         m4UD+DgrtLe0rL9xU/Sd9/hQj+Mv/j2kbjgHUhJO9cJe/I3uGrsAfykLTxa/U/p/kfvL
         fSzJ3KStlQaCYASrsjjbQOK0KCwKA9iU35P/+oI2rrMFAjd5Fm4VGbgFG7oVeaJZJqie
         b7WJCIBJF2Gm9aEU0boME7iYSkFRLv9Hpme4ivg8HmYXpWvgfo6o5JtQiMGZoA9bzvGn
         FBeZu3EYagxQcKL6VTgpwFFGWlrXIH/CFI5LrUaMFz16iC5lBk5CoOgoYIQGpN4EQJy2
         NIUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qhbBCVv4kC2WNldsWLi1sTj6ekjdYfnRPW7jzl7wFJ0=;
        b=xNwjGE2+V+HdMaCJpIfCs4Bv7pm4GaQ+kMJ1GWClb8ZEks5VU23Jrh0ZuRI4j3qlpn
         Fj+xMHX6NdfjFNEsn8uCAeilYuYK7Xk8dUqz8Jf27G6NEZE8MRIkc9HJGKk8Px2ed0WQ
         379fwXRIC+OaX8EwNLdAipcdmFoucbaZYmCK0ANJ2eRlwXky6i8P8bJL+Cw4Q5uPMBa3
         faLGNsUVn2Zv1WYyZLswXek3zi3xnOHfaKPBik1DIEC5faKojspT+y9vLE0cWUw3Ifqu
         zyWoEJUQiBCd124mhf43Jqv1brFtr/0PS0sA/LghWICZy/yi37NbiB7PX2+jEfmz4aPo
         flCg==
X-Gm-Message-State: AJIora8pVOWptZQHW2+OmEi+mEa/Xqe6IpVG/4QdKzDkHwV9Y68bDGtd
        85CCyVb+OwZOF6OXGsX1RRg=
X-Google-Smtp-Source: AGRyM1v8aRAtO7EjEb3OYFyEWXxxm9ImkeHxALOjHL57Osg81zp1r94MYE0W7dNNKTTKlHe1gyAyIA==
X-Received: by 2002:a2e:8954:0:b0:25d:6936:849a with SMTP id b20-20020a2e8954000000b0025d6936849amr800389ljk.370.1657690288733;
        Tue, 12 Jul 2022 22:31:28 -0700 (PDT)
Received: from mobilestation ([95.79.140.178])
        by smtp.gmail.com with ESMTPSA id t11-20020a056512208b00b00489dbecbd0csm1862644lfr.189.2022.07.12.22.31.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 22:31:28 -0700 (PDT)
Date:   Wed, 13 Jul 2022 08:31:26 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     nandhini.srikandan@intel.com
Cc:     broonie@kernel.org, robh+dt@kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        mgross@linux.intel.com, kris.pan@intel.com,
        kenchappa.demakkanavar@intel.com, furong.zhou@intel.com,
        mallikarjunappa.sangannavar@intel.com, mahesh.r.vaidya@intel.com,
        rashmi.a@intel.com
Subject: Re: [PATCH v6 1/4] spi: dw: Fix IP-core versions macro
Message-ID: <20220713053126.ykirnx5cqo4etrh7@mobilestation>
References: <20220713042223.1458-1-nandhini.srikandan@intel.com>
 <20220713042223.1458-2-nandhini.srikandan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220713042223.1458-2-nandhini.srikandan@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 13, 2022 at 12:22:20PM +0800, nandhini.srikandan@intel.com wrote:
> From: Nandhini Srikandan <nandhini.srikandan@intel.com>
> 
> Add the missing underscore in IP version macro to avoid compilation issue.
> The macro is used for IP version comparison in the current patchset.
> 
> Fixes: 2cc8d9227bbb ("spi: dw: Introduce Synopsys IP-core versions interface")
> Signed-off-by: Nandhini Srikandan <nandhini.srikandan@intel.com>

Thanks.
Acked-by: Serge Semin <fancer.lancer@gmail.com>

-Sergey

> ---
>  drivers/spi/spi-dw.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/spi/spi-dw.h b/drivers/spi/spi-dw.h
> index d5ee5130601e..79d853f6d192 100644
> --- a/drivers/spi/spi-dw.h
> +++ b/drivers/spi/spi-dw.h
> @@ -23,7 +23,7 @@
>  	((_dws)->ip == DW_ ## _ip ## _ID)
>  
>  #define __dw_spi_ver_cmp(_dws, _ip, _ver, _op) \
> -	(dw_spi_ip_is(_dws, _ip) && (_dws)->ver _op DW_ ## _ip ## _ver)
> +	(dw_spi_ip_is(_dws, _ip) && (_dws)->ver _op DW_ ## _ip ## _ ## _ver)
>  
>  #define dw_spi_ver_is(_dws, _ip, _ver) __dw_spi_ver_cmp(_dws, _ip, _ver, ==)
>  
> -- 
> 2.17.1
> 
