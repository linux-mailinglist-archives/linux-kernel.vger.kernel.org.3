Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8CDE465901
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 23:19:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353536AbhLAWWB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 17:22:01 -0500
Received: from mail-ot1-f43.google.com ([209.85.210.43]:34401 "EHLO
        mail-ot1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353541AbhLAWVW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 17:21:22 -0500
Received: by mail-ot1-f43.google.com with SMTP id x19-20020a9d7053000000b0055c8b39420bso37327217otj.1;
        Wed, 01 Dec 2021 14:18:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kXwYki9C7SCtlqO4/jeETUKBsjz0PzUf21ILjNiLQyw=;
        b=gYWhosJqV7aqLqlJv9eGzMA8bs+ZcYrwTpCNCA6kTE2/6z3awWWNcjGG/Rr5+Ghhal
         +gbUTUuwFrEJhyNELlgy4M49KzPUsLm9RIvddHy9LZaX2IAQEmsNWqVNaHrwrt+aOp6K
         +HmCQRX+5SKyfiX/8krIyK2jZVkH1h5mfTGYxSMOMjKiTfRcKDdKIqJrJSP/Kp3MNd42
         DpqYLbORrgA4eDs2A+8Rul+JmW8/3JzQNKL3Z2o54EnJpj5nww+tvcnG0TlXOgxfYVQ8
         sXJSs6/0GgodyF6F9F/olD0iXocAFMiWSlkYw1xbPwJKcQrEYLQM6Bv95DKQpZN1HEAr
         jMOA==
X-Gm-Message-State: AOAM533cedSEpKEf4vDZDo4U2tPafwA2cS6Y6xNfqOkNcQNgfaYuDurs
        2aPBewLGrv2+hGzTcg0AmDqYGKODnw==
X-Google-Smtp-Source: ABdhPJxQpKy6n45A0momIwrGcdNliZN06piz12sLj7hj8nwCyjvva9k8SOh7LE9u/aPRWKEU86CANQ==
X-Received: by 2002:a9d:4702:: with SMTP id a2mr8286254otf.262.1638397080344;
        Wed, 01 Dec 2021 14:18:00 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id bq5sm601787oib.55.2021.12.01.14.17.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Dec 2021 14:17:59 -0800 (PST)
Received: (nullmailer pid 2829751 invoked by uid 1000);
        Wed, 01 Dec 2021 22:17:58 -0000
Date:   Wed, 1 Dec 2021 16:17:58 -0600
From:   Rob Herring <robh@kernel.org>
To:     Ivan Bornyakov <i.bornyakov@metrotek.ru>
Cc:     system@metrotek.ru, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2 2/2] dt-bindings: bus: imx-weim: add words about
 continuous bclk
Message-ID: <Yaf0lvD3H5ylZY8d@robh.at.kernel.org>
References: <20211124175542.2772-1-i.bornyakov@metrotek.ru>
 <20211124175542.2772-3-i.bornyakov@metrotek.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211124175542.2772-3-i.bornyakov@metrotek.ru>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 24, 2021 at 08:55:42PM +0300, Ivan Bornyakov wrote:
> Document continuous Burst Clock option. With this option Burst Clock, if
> enabled, will output continuous clock, otherwise Burst Clock will output
> clock only when necessary.

Missing S-o-b. checkpatch.pl will tell you this.

> ---
>  Documentation/devicetree/bindings/bus/imx-weim.txt | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/bus/imx-weim.txt b/Documentation/devicetree/bindings/bus/imx-weim.txt
> index 1b1d1c5c21ea..e7f502070d77 100644
> --- a/Documentation/devicetree/bindings/bus/imx-weim.txt
> +++ b/Documentation/devicetree/bindings/bus/imx-weim.txt
> @@ -48,6 +48,11 @@ Optional properties:
>  			devices, the presence of this property indicates that
>  			the weim bus should operate in Burst Clock Mode.
>  
> + - fsl,continuous-burst-clk	Make Burst Clock to output continuous clock.
> +			Without this option Burst Clock will output clock
> +			only when necessary. This takes effect only if
> +			"fsl,burst-clk-enable" is set.
> +
>  Timing property for child nodes. It is mandatory, not optional.
>  
>   - fsl,weim-cs-timing:	The timing array, contains timing values for the
> -- 
> 2.32.0
> 
> 
> 
