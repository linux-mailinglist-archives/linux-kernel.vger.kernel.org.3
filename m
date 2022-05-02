Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25D865174E5
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 18:46:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386369AbiEBQuO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 12:50:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229768AbiEBQt4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 12:49:56 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B8FB2AE
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 09:46:03 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id x18so1719491plg.6
        for <linux-kernel@vger.kernel.org>; Mon, 02 May 2022 09:46:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=YRbcsSAPo9bhXajIIUww8EAH5YwyqTIjfy+cpzYtpl4=;
        b=YckMkgioHTc6TfI6sMn4/05MN8JxPWVpQF8JQjsd7bThfk6uSXvp4urSddb56T7BNE
         rYWv5iRnQltwWodzwN1IIOPadzIvY4z+QT0sL+7jaSEZLsV8p8T0HWL3XkMK5n4/NlVI
         F3+GOZ0wg8hw+jttv1wbafgmAaaXx7a4dRlvyW9OZ/ET5oqEu9LLwati6zq4jf3xDoQy
         gXJJZGz5sZ7RXZYz63xdvZ784/HgfFAqETSb+4AU4JQIoHpzBXLbJeZ17B2muuaNBWAi
         QBrAMJuGZw/ghgqbsCDjGEbKNelT22oV9b9MawMzCoHc/iyDbtGG+tvQvYJPSTrmDjDD
         Tp1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=YRbcsSAPo9bhXajIIUww8EAH5YwyqTIjfy+cpzYtpl4=;
        b=omoPM0zFZ+epbH7nZ/WtbNVU5+8smK7n/TbnYb4UAzgN+QWUtD4QflUpF0GvfSlNkv
         5Bgxcr1BBEf1GcZJ5uhSvHf83Vc8ymxx5zBbQtPDuTYg3Rc8DSAmY8k7H+CeEHr36Df0
         enKeaKjY+I5zQcu7F3vUZj6hMMc8iSG9oih6OgeTKPFHHnHyQC1Kz+Uu3GH5X4qzzfa1
         5O03eQTorCU76cPEleoiwlOgpeLepr78U9yT0RUcUzX0yI/HDdYIXDPxmEUzEdjG4YUG
         /bOIo8i8gnnQ+Rv100QUw8kSz88Nev+PrbY5y9wBK8RAtr8jn3lQdwpMfR2fM2/TO3S+
         n4zg==
X-Gm-Message-State: AOAM532wBA2c6kohilma3ykOutzVtHPNKwZ7XFPlrzhRxmRtTo1DoXBJ
        BIh/b9uEvXSxfhMdg0ew7s4v1Q==
X-Google-Smtp-Source: ABdhPJyUAnnG5mya69E8evpVFWpjwm2Vp9Z/wqLfenLGWqrhuwGJMDnSH/JqkspxoYfBRzSlQdIFFw==
X-Received: by 2002:a17:90a:730c:b0:1d9:3f5:9a00 with SMTP id m12-20020a17090a730c00b001d903f59a00mr13620pjk.109.1651509962595;
        Mon, 02 May 2022 09:46:02 -0700 (PDT)
Received: from p14s (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id n9-20020a170903110900b0015e8d4eb1cfsm4859354plh.25.2022.05.02.09.46.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 May 2022 09:46:01 -0700 (PDT)
Date:   Mon, 2 May 2022 10:45:59 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     German Gomez <german.gomez@arm.com>
Cc:     coresight@lists.linaro.org, suzuki.poulose@arm.com,
        james.clark@arm.com, leo.yan@linaro.org, mike.leach@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] coresight: etm4x: docs: Add documentation for
 'ts_source' sysfs interface
Message-ID: <20220502164559.GA2498226@p14s>
References: <20220429123100.268059-1-german.gomez@arm.com>
 <20220429123100.268059-3-german.gomez@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220429123100.268059-3-german.gomez@arm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 29, 2022 at 01:31:00PM +0100, German Gomez wrote:
> Sync sysfs documentation pages to include the new ts_source (timestamp
> source) interface.
> 
> Signed-off-by: German Gomez <german.gomez@arm.com>
> ---
>  .../ABI/testing/sysfs-bus-coresight-devices-etm4x  |  8 ++++++++
>  .../trace/coresight/coresight-etm4x-reference.rst  | 14 ++++++++++++++
>  2 files changed, 22 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-coresight-devices-etm4x b/Documentation/ABI/testing/sysfs-bus-coresight-devices-etm4x
> index 8e53a32f81505..19ac9d6d2f504 100644
> --- a/Documentation/ABI/testing/sysfs-bus-coresight-devices-etm4x
> +++ b/Documentation/ABI/testing/sysfs-bus-coresight-devices-etm4x
> @@ -516,3 +516,11 @@ Contact:	Mathieu Poirier <mathieu.poirier@linaro.org>
>  Description:	(Read) Returns the number of special conditional P1 right-hand keys
>  		that the trace unit can use (0x194).  The value is taken
>  		directly from the HW.
> +
> +What:		/sys/bus/coresight/devices/etm<N>/ts_source
> +Date:		April 2022
> +KernelVersion:	5.18

This would be 5.19 and a (likely) date of July 2022.

> +Contact:	Mathieu Poirier <mathieu.poirier@linaro.org>

Suzuki's name should also be added.

Thanks,
Mathieu

> +Description:	(Read) When FEAT_TRF is implemented, value of TRFCR_ELx.TS used for
> +		trace session. Otherwise -1 indicates an unknown time source. Check
> +		trcidr0.tssize to see if a global timestamp is available.
> diff --git a/Documentation/trace/coresight/coresight-etm4x-reference.rst b/Documentation/trace/coresight/coresight-etm4x-reference.rst
> index d25dfe86af9bf..f016c7c29429b 100644
> --- a/Documentation/trace/coresight/coresight-etm4x-reference.rst
> +++ b/Documentation/trace/coresight/coresight-etm4x-reference.rst
> @@ -71,6 +71,20 @@ the ‘TRC’ prefix.
>  
>  ----
>  
> +:File:            ``ts_source`` (ro)
> +:Trace Registers: None.
> +:Notes:
> +    When FEAT_TRF is implemented, value of TRFCR_ELx.TS used for trace session. Otherwise -1
> +    indicates an unknown time source. Check trcidr0.tssize to see if a global timestamp is
> +    available.
> +
> +:Example:
> +    ``$> cat ts_source``
> +
> +    ``$> 1``
> +
> +----
> +
>  :File:            ``addr_idx`` (rw)
>  :Trace Registers: None.
>  :Notes:
> -- 
> 2.25.1
> 
