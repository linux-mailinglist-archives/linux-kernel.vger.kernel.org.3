Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A08A4BAD02
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 00:03:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbiBQXEC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 18:04:02 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:37542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbiBQXD7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 18:03:59 -0500
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BACB253BDE;
        Thu, 17 Feb 2022 15:03:43 -0800 (PST)
Received: by mail-io1-f54.google.com with SMTP id m185so5538087iof.10;
        Thu, 17 Feb 2022 15:03:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cXwKh/9CERUWQzafEBvH8quGFF+AIPTjaXQ+Ht8FN28=;
        b=t0ANkiS0/g63Vo0UD2mNd21w2WkYL0hP7BiIYBNr5rvZwsiaboZmWKvsV8JIWAN63G
         KumHTVveY2CwzgJMnABq9qqZfkYaPDVT/qElUSIZoA66eYa0E8pMxQnKePeQ7Ok3oaVa
         h1Wq2udkJ3YNbxE8Ijo3X6yxtWSWHB6xF9QbsBmLWHzI3qQJECe8pgUvwB1VZuHGTJnf
         jVaGEIYRRJKdxtdDXIuzc5Y3rflswXRJJkWNWqb98bfmi8oWRZDVS4ErBHw/4+2lj+h+
         KUIAj5OtMc4cHMex7X+ydBbuCCJP281AUvOaGKfvy5KecAHzg358n+rVeLl6AuAFBzgE
         +jeA==
X-Gm-Message-State: AOAM5328fJY3JDzcXFfRJmD2kQjeim6sKwjZxcNYMpscwjS3aaOtQEfD
        120drR4h530e3fLzk/eonw==
X-Google-Smtp-Source: ABdhPJyDuLbj+TqrTCKZDV1eaRuubmnZMZUBK2sSsq6HilQsAH7UjMWyqCzkmU+l5AY0rxYEJlpLeg==
X-Received: by 2002:a6b:7f45:0:b0:5ed:686c:7807 with SMTP id m5-20020a6b7f45000000b005ed686c7807mr3512614ioq.191.1645139022551;
        Thu, 17 Feb 2022 15:03:42 -0800 (PST)
Received: from robh.at.kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id d12sm2655211ilv.42.2022.02.17.15.03.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Feb 2022 15:03:41 -0800 (PST)
Received: (nullmailer pid 3935734 invoked by uid 1000);
        Thu, 17 Feb 2022 23:03:39 -0000
Date:   Thu, 17 Feb 2022 17:03:39 -0600
From:   Rob Herring <robh@kernel.org>
To:     LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org, jic23@kernel.org,
        tomas.melin@vaisala.com, andy.shevchenko@gmail.com,
        lars@metafoo.de, bsp-development.geo@leica-geosystems.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 1/5] dt-bindings: iio: accel: sca3300: Document
 murata,scl3300
Message-ID: <Yg7US2LIBFRWq4OA@robh.at.kernel.org>
References: <20220217062705.2867149-1-Qing-wu.Li@leica-geosystems.com.cn>
 <20220217062705.2867149-2-Qing-wu.Li@leica-geosystems.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220217062705.2867149-2-Qing-wu.Li@leica-geosystems.com.cn>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Feb 2022 06:27:01 +0000, LI Qingwu wrote:
> Add DT bindings for Murata scl3300 inclinometer.
> 
> Signed-off-by: LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
> ---
>  Documentation/devicetree/bindings/iio/accel/murata,sca3300.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 


Please add Acked-by/Reviewed-by tags when posting new versions. However,
there's no need to repost patches *only* to add the tags. The upstream
maintainer will do that for acks received on the version they apply.

If a tag was not added on purpose, please state why and what changed.

