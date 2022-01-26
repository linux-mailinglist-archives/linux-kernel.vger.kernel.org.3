Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E23149C29A
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 05:21:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230307AbiAZEVb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 23:21:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbiAZEVZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 23:21:25 -0500
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D00B5C061747
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 20:21:24 -0800 (PST)
Received: by mail-oi1-x232.google.com with SMTP id w133so8459177oie.7
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 20:21:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=3uEzXru1aVjcz+4fGY3MVB7ne8nDGQnWDlx0JVNEeNo=;
        b=diZxZvwkryVBxCaRjJ/ESOcZUM3TH+0Bb8JxNd6nl5w7Rae0MhONSDnteFUEJZ9DD6
         Yjlad2PnqbXKRvqULn/D0LuIMSjv+Yy6djZ6hIWsMypfAZoy6kweZpJ3CXjNCww5ejbI
         I9DpxE7CSgMCl4KSWbT7tibudfCiGR8cmsF8vriMJv78QMsPZcR7IzACyWwBZeM8+B+8
         ZIgSCcdChAQtj70OPkVRyoOu5/Vy7UmyjKZGEy5zHcOHowWp1uPOJA63HfzvQK0Z90TY
         fhnoVcuXdcNPOFiilkeuuBqHqekVFqehlTpCCsCnpkhumbJL/1yU6MagOuonZCijrtY1
         QqKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3uEzXru1aVjcz+4fGY3MVB7ne8nDGQnWDlx0JVNEeNo=;
        b=I1ImAbrsptaJxTRzx/FvUIZ8/37GtR1sO8Hr6kM3vAB9dELClgJTvF8yf8Bbhxy9kk
         c4Ogr/MOjiYucBsh1GtIfaHQs9Im09Aq/4zs0gLOK11L+2bgWFasF3Wmfa6p52TSEINd
         uLzOCpoSjm3be4PwphzVNeLNKgPrAjjZbDT71KZgJiyY+dvzQ4aeYCHlqqGJy4Fgye8Y
         /4d0lYiFkh/kKVQ1mcRkg4Yzq1mub2EszvByE4oY62YJ1/xwK8EiDuhevkzkKk94xcOQ
         Sm7qN+c0QfEQEztJ+xZFvI47isBscYGqhaktnNvkPiyDIHpLQrLBAxa0crAscnCBcBlD
         ui8g==
X-Gm-Message-State: AOAM530vJpOCP/o4nKvot7QQQoo1rT1QA8GaF/iQ5GDDWY2TUvJbTUDI
        BbLN33TnNwNaLJUYAxQPTWm7Fw==
X-Google-Smtp-Source: ABdhPJzK+igNuzFGovAUpthveXQM50iDfQqJS50K+sxTX/tydF5dsfORPSyNqPwGh+tOIGh+lXBDJA==
X-Received: by 2002:a05:6808:199e:: with SMTP id bj30mr2829220oib.261.1643170884118;
        Tue, 25 Jan 2022 20:21:24 -0800 (PST)
Received: from builder.lan ([2600:1700:a0:3dc8:3697:f6ff:fe85:aac9])
        by smtp.gmail.com with ESMTPSA id l63sm2612475oia.2.2022.01.25.20.21.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jan 2022 20:21:23 -0800 (PST)
Date:   Tue, 25 Jan 2022 22:21:20 -0600
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Souradeep Chowdhury <quic_schowdhu@quicinc.com>
Cc:     linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, pure.logic@nexus-software.ie,
        greg@kroah.com, robh@kernel.org, linux-kernel@vger.kernel.org,
        quic_tsoni@quicinc.com, quic_psodagud@quicinc.com,
        quic_satyap@quicinc.com, quic_pheragu@quicinc.com,
        quic_rjendra@quicinc.com, quic_sibis@quicinc.com,
        quic_saipraka@quicinc.com
Subject: Re: [PATCH V4 2/6] bindings: usb: dwc3: Update dwc3 properties for
 EUD connector
Message-ID: <YfDMQIFiCfzQy91y@builder.lan>
References: <cover.1642768837.git.quic_schowdhu@quicinc.com>
 <7ddaf7dc192c5f03f70d27297551e758a39a4ab5.1642768837.git.quic_schowdhu@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7ddaf7dc192c5f03f70d27297551e758a39a4ab5.1642768837.git.quic_schowdhu@quicinc.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 21 Jan 07:53 CST 2022, Souradeep Chowdhury wrote:

> Add the ports property for dwc3 node. This port can be used
> by the Embedded USB Debugger for role switching the controller
> from device to host mode and vice versa.
> 
> Signed-off-by: Souradeep Chowdhury <quic_schowdhu@quicinc.com>
> ---
>  Documentation/devicetree/bindings/usb/snps,dwc3.yaml | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/usb/snps,dwc3.yaml b/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
> index d29ffcd..ccb1236 100644
> --- a/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
> +++ b/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
> @@ -332,6 +332,16 @@ properties:
>      items:
>        enum: [1, 4, 8, 16, 32, 64, 128, 256]
>  
> +  ports:
> +    $ref: /schemas/graph.yaml#/properties/ports
> +    description:
> +      This port is to be attached to the endpoint of the Embedded USB Debugger.

More generally this is used together with the already documented
usb-role-switch property to connect the dwc3 to the Type-C connector.

Which makes me feel that we don't actually need ports/port, but could do
with just port? Perhaps I'm missing some usecase?


I'm somewhat confused to why this isn't already documented...

Regards,
Bjorn

> +
> +    properties:
> +      port@0:
> +        $ref: /schemas/graph.yaml#/properties/port
> +        description: Connector endpoint of Embedded USB debugger.
> +
>  unevaluatedProperties: false
>  
>  required:
> -- 
> 2.7.4
> 
