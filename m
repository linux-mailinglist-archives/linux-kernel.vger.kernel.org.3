Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75263467F8C
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 22:50:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353824AbhLCVxl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 16:53:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236017AbhLCVxl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 16:53:41 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66360C061751;
        Fri,  3 Dec 2021 13:50:16 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id p18so3394344wmq.5;
        Fri, 03 Dec 2021 13:50:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to;
        bh=9jtClrULvTGpFGVv6Tss6OWx+M/rF9ZeEbmO23QbeiU=;
        b=MhwAVE49PC2q1qfbDADV6lYmE2HDby2K7GYYDSCWu/nJOC44XbSl6HZTyFMurS3xYY
         IldRZexRppYD9kuuqhjwr+Bjrx3pPA7Y++YmkkfHmVmND3a2vPwBaDnojDyYmBAQorVU
         sYner35gY4L0tMI1u4DSFxvE/0KhuaQ9R0m0lE6EVihKqVjwiGYTwpqzT+46H1LvKgSV
         265Ow/VAr0jLzSyHCYeuM9uZu0bARIYeHQ93ishEph34d4+ts8ob06byncBRTiFYgllJ
         UFzC2B8IbWhXfOvlR2misEtMb1hukeUj5ytJm+OKTZB/wRXgRHu8QjU66NSwLglYwaHv
         lNEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to;
        bh=9jtClrULvTGpFGVv6Tss6OWx+M/rF9ZeEbmO23QbeiU=;
        b=PC9W+bNZo/C+RkCGN9E+yf3rjZy9ZDzMqLqw7cV5UJDOjcRb3kgAxzQmLnZ5DNvU8n
         XHv+t6RAJDJQSqZYAn2d0HgRh3zusElDMGbM0hqHNrTBI+uT+j6wGErWFtuuTo0oUppI
         Q1q7IuRzycZ3dOFO+zuf4+cUz1b0T9U+vgLMtmimJiNamQw2/bdV/5WXs9AoyoTDBGgf
         zGfYM8EhqN22+ixGjh8nFyA5pF3x/aw9Jz2B5gvQirTVqF/UNGf8I1cqVF2VtOM5DX5V
         wt7RaNC4/9NgqF4GOzBxE9jwAicBKHVynhdfu/y2pqn8OdZFQv8mrWZmdGgGexdLcqxD
         orjg==
X-Gm-Message-State: AOAM53208XOLn9kmrE6FzlIhNGCfle+Wk+SXNWtCeCJ3IbKPqcUWfpJh
        +MWsGSrOdXn6CBjm6FN4jN4qxSlfHWoM+A==
X-Google-Smtp-Source: ABdhPJyos5bFLkEVC/9MKXs5ngZCT+GprItQOoHO28LQXgM8eiqc6zks4Y0CKtP+H6AbM7CseMhyDA==
X-Received: by 2002:a05:600c:190c:: with SMTP id j12mr18356473wmq.117.1638568215019;
        Fri, 03 Dec 2021 13:50:15 -0800 (PST)
Received: from pevik (gw1.ms-free.net. [185.243.124.10])
        by smtp.gmail.com with ESMTPSA id k27sm6413239wms.41.2021.12.03.13.50.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Dec 2021 13:50:14 -0800 (PST)
Date:   Fri, 3 Dec 2021 22:50:12 +0100
From:   Petr Vorel <petr.vorel@gmail.com>
To:     Jean THOMAS <virgule@jeanthomas.me>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, konradybcio@gmail.com
Subject: Re: [PATCH v2 1/2] arm64: dts: msm8992-lg-bullhead: Place LG
 Bullhead generic code into a DTSI file
Message-ID: <YaqRFCvx5r3sgXzA@pevik>
Reply-To: Petr Vorel <petr.vorel@gmail.com>
References: <20211201231832.188634-1-virgule@jeanthomas.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211201231832.188634-1-virgule@jeanthomas.me>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jean,

> This patch puts the generic code common across all hardware revisions
> into a DTSI file.

> It also prefixes the DTS filename with the vendor name, to follow the
> naming convention used by other DTS files.

> Changes since v1:
>  - Added "model" property to the DTS file
Not sure if model should stay also in msm8992-lg-bullhead.dtsi, probably yes.

Reviewed-by: Petr Vorel <petr.vorel@gmail.com>

Kind regards,
Petr
