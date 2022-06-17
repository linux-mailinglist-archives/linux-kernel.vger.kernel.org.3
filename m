Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FEAD54F488
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 11:42:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381388AbiFQJmW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 05:42:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380854AbiFQJmS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 05:42:18 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FA24692A1
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 02:42:17 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id c21so5052406wrb.1
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 02:42:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=NZv4CkZhHVjo2WiQVeulQzBHOA+fH2nS6TIJym/u7XA=;
        b=wLK3Z+5OFc/0E1XIc8LL/90johcd6W+wkAsVUSfrxaeVlkEj5UFZwBP2SaBBFcbiPe
         6QKWfAPioSFs0mHG+8JuRvpGfRDKCgIFzTUEVw9uHqHPYkGRH5KnW4y2uDattFW0Elew
         pzUUf42e2Io/lRgJ1ixs9Fylh9BnDtEZeF1JZhjq57BfG1ZyuMW5XrbOGaoob7/uJGCd
         3Yzn2c12Ct7hssXOTZAFvBv5HNuHC9b1euSSBEmjQkeIp2VJkY7+XJ5V1bWE0EzKPBfH
         BB3TcU1l/sKeEQAmOLDERw8nz1OLScdt7frEllsap+9Z0ZQ8zDC2l2VZ2wTuGDqEDREf
         /ZKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=NZv4CkZhHVjo2WiQVeulQzBHOA+fH2nS6TIJym/u7XA=;
        b=QvasmyvKMTDPKUerbNr3PZsdLMeN67rpBgPQzE4vmZM58kd5meOeo0ZKFkVF+s5NFj
         +nqRrGVHpOWiFwxAc75UanbZkx8c96JTAEzYIAlOdqBNBTcR+OsMYJ7dRexoQAMu8qt5
         kv2hpmUQ29dRVhVJjp09fq2KsItl9ax18yKEjAhuq9S2oQxHSDtpZ7odhRoIAtwoy9jp
         0G+V1pKJgJVaKhA2SYw1d2MMeC8mThZQfnBuQ5K/qToYZOn66NkJ8X47d2p4MWv4nGu3
         d15KFSanR5iqT1LrqzvcsIF+uXwZS7V8m41pwl50ziUq23bpZFCbVNSEUFt1gGl/XYXp
         j+gw==
X-Gm-Message-State: AJIora8OncWFBS3gbkco3jdwW7mj44WrmkblbHl/Wk6eqtOBRI0ZPnyT
        /ssOHsW+FHly0hFb1+k9rNwk8Q==
X-Google-Smtp-Source: AGRyM1t5CBxs8rFvCtjdn/6EoixNlpinrPqzTAfs/Ix5emh/N76GE+n4QqBBCNqRUjnO9yVIrSBzMQ==
X-Received: by 2002:a5d:4108:0:b0:213:b585:66c7 with SMTP id l8-20020a5d4108000000b00213b58566c7mr8373386wrp.335.1655458935880;
        Fri, 17 Jun 2022 02:42:15 -0700 (PDT)
Received: from localhost ([109.180.234.132])
        by smtp.gmail.com with ESMTPSA id m13-20020a5d4a0d000000b0021a2c923c72sm4213296wrq.69.2022.06.17.02.42.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jun 2022 02:42:15 -0700 (PDT)
From:   Punit Agrawal <punit.agrawal@bytedance.com>
To:     Riwen Lu <luriwen@hotmail.com>
Cc:     rafael@kernel.org, lenb@kernel.org, rui.zhang@intel.com,
        robert.moore@intel.com, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, devel@acpica.org,
        punit.agrawal@bytedance.com, Riwen Lu <luriwen@kylinos.cn>
Subject: Re: [PATCH v2] ACPI/processor: Remove unused function
 acpi_processor_get_limit_info()
References: <20220617025152.1908638-1-luriwen@hotmail.com>
        <TYWP286MB2601A75D517AE71EE569CE15B1AF9@TYWP286MB2601.JPNP286.PROD.OUTLOOK.COM>
Date:   Fri, 17 Jun 2022 10:42:14 +0100
In-Reply-To: <TYWP286MB2601A75D517AE71EE569CE15B1AF9@TYWP286MB2601.JPNP286.PROD.OUTLOOK.COM>
        (Riwen Lu's message of "Fri, 17 Jun 2022 10:51:52 +0800")
Message-ID: <87v8szoccp.fsf@stealth>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Riwen Lu <luriwen@hotmail.com> writes:

> From: Riwen Lu <luriwen@kylinos.cn>
>
> Commit 22e7551eb6fd ("ACPI / processor: Remove acpi_processor_get_limit_info()"),
> left behind this, remove it.
>
> Signed-off-by: Riwen Lu <luriwen@kylinos.cn>
>
> ---
> v1 -> v2:
>  - Make this patch base on ("ACPI: Split out processor thermal register
>    from ACPI PSS").

For such changes, it is better to send all the related patches as a
series so it's easy to see the dependencies . In a series the easy /
obvious fixes should be earlier so it's easier for them to be merged
while the more significant changes are still being discussed.

Hopefully in this case Rafael too agrees with the dependency patch -
otherwise, it's just extra churn on the lists.

But don't resend just yet - give some time for others to add their
feedback.

> ---
>  include/acpi/processor.h | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/include/acpi/processor.h b/include/acpi/processor.h
> index ba1e3ed98d3d..9fa49686957a 100644
> --- a/include/acpi/processor.h
> +++ b/include/acpi/processor.h
> @@ -441,7 +441,6 @@ static inline int acpi_processor_hotplug(struct acpi_processor *pr)
>  #endif /* CONFIG_ACPI_PROCESSOR_IDLE */
>  
>  /* in processor_thermal.c */
> -int acpi_processor_get_limit_info(struct acpi_processor *pr);
>  int acpi_processor_thermal_init(struct acpi_processor *pr,
>  				struct acpi_device *device);
>  void acpi_processor_thermal_exit(struct acpi_processor *pr,

Fwiw,

Reviewed-by: Punit Agrawal <punit.agrawal@bytedance.com>
