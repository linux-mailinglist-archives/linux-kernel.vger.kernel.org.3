Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2ADDD47BA81
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 08:12:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234742AbhLUHM0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 02:12:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234737AbhLUHMZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 02:12:25 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99FF1C06173F
        for <linux-kernel@vger.kernel.org>; Mon, 20 Dec 2021 23:12:25 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id j6-20020a17090a588600b001a78a5ce46aso1700724pji.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Dec 2021 23:12:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Pd57JPrq9wLZuPMxLEz3oLDEgN+l/LTIJFa/r5cmmFU=;
        b=cAsgRiosMdXwEBHecB9MTUOyJ7JlmAzz4yCKMtYZw0aSo0OvF42q12VSuYiGkvc5xz
         erIQviIa5baFD9QVUATp9X7E3FHM1MZAFDhkZ/BYcpDewq48MJXFYfe3x1grgPIwy5GR
         cK+h5Far/XTLBoNKbGUUbsd0CvXhxB+et1q5eXqMSfvzLrOgfChgqFZmYpATDZjD/T2e
         +HJdixKurMFUuU3NpDo6wvU6jmklZL0wqMjCfB2sJfe43CFeW9P+qKjtr/o4xAdv+ULW
         jQL/zY3WAU6bYWYbEMGcFdXgtGSqB7kYWs2tifJhP+ExS8h3TuTqk4zhZiReMU4PQn2+
         m4Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Pd57JPrq9wLZuPMxLEz3oLDEgN+l/LTIJFa/r5cmmFU=;
        b=INuU7hAxzEkabqxpMBk9vwyEg87NON9GerWS88xPZnnE/8AaSTmZkqk+j+oJ5wu2Sy
         2s93zQoCFy6FcNYSzjjINtwac5wKmjubLnUl3L08o4c894b+CMfqSGmPwyEkVrJto8fb
         IoqX6TDRZq8YJKf65wNMqk0s6CsXTxLZPHtZT5HUJoSzSMRnFboUgIshQDk6xYgdqlmG
         RZAVxxTSK6SYJPcwodxZ/Qo73MJqsq4tuaiKlcg6GoM0wYF04gselGRpHiT7mstdiWX2
         jpR80Z6gDzMcIGB+MYrbQ4moet8paJRBD1qkU7IryYGCaZBYr5zqlCmx77KttY1KHzFf
         sCgQ==
X-Gm-Message-State: AOAM530SQZu04QB9T45zYJIFUrTNosa5Puk74vM0XBVfwwZ3CVmOxUgL
        wZj23Z526w5dJqTtGBa6j+GN
X-Google-Smtp-Source: ABdhPJybKrTGTOw0sgXIk5MIpSXv/WBkmVaI8tHNqNxfUyfz+MejcF4YzSJI7jlVYqN8df1pRwCz6w==
X-Received: by 2002:a17:902:8693:b0:148:a2e7:fb5a with SMTP id g19-20020a170902869300b00148a2e7fb5amr2038733plo.155.1640070745085;
        Mon, 20 Dec 2021 23:12:25 -0800 (PST)
Received: from thinkpad ([117.193.215.70])
        by smtp.gmail.com with ESMTPSA id ls7sm1568772pjb.11.2021.12.20.23.12.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Dec 2021 23:12:24 -0800 (PST)
Date:   Tue, 21 Dec 2021 12:42:19 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     20210106125322.61840-14-manivannan.sadhasivam@linaro.org
Cc:     Rob Herring <robh@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        agross@kernel.org, bjorn.andersson@linaro.org
Subject: Re: Question about node naming in [PATCH v3 13/18] ARM: dts: qcom:
 sdx55: Add spmi node
Message-ID: <20211221071219.GD26872@thinkpad>
References: <HTKF4R.5S1PY4MCM4QS@ixit.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <HTKF4R.5S1PY4MCM4QS@ixit.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 20, 2021 at 09:27:17PM +0100, David Heidelberg wrote:
> Hello Manivannan,
> 
> I'd like to ask, if you had any particular reason to name node `qcom,spmi@`
> instead of basic `spmi@`.
> 

"spmi" node label was not documented by devicetree spec at that time. So I was
using "qcom,spmi" but it was not correct either.

I've submitted a PR now to devicetree-spec repo [1] for listing it as the
generic node name. So once it got accepted, we can use "spmi@" for the node
name.

Thanks,
Mani

[1] https://github.com/devicetree-org/devicetree-specification/pull/50

> I'm currently converting binding for
> Documentation/devicetree/bindings/spmi/qcom,spmi-pmic-arb and I'm
> considering adding qcom,spmi into qcom,spmi-pmic-arb or just rename this and
> arch/arm64/boot/dts/qcom/msm8996.dtsi `qcom,spmi@` occurences to `spmi@`.
> 
> Ideas, inputs?
> 
> Thank you
> David
> 
> 
