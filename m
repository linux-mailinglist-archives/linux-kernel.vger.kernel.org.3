Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CFAA4A538F
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 00:51:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229820AbiAaXvJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 18:51:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229798AbiAaXvI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 18:51:08 -0500
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1E17C061714
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 15:51:07 -0800 (PST)
Received: by mail-oi1-x229.google.com with SMTP id m10so4965741oie.2
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 15:51:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=N66B/zUeupRdiK6j9+YxGVkqTJzroVbLV/gi+PEAAqs=;
        b=VeQ6g7VBzwMDAzOx55SBs8lPKj2ZcqyklN0g5Q+AqJ8BXmXJ8ARuAkn6yzDkrfvDmo
         uu2u7qNcVTkMr0pQDFfPsMzVNsEfZdi9Fvno+92OsK+ZvlBDDjwbeJlmqTZssnaHfcR8
         6O8vJ9ZdsPgLqhbLITnMe63oJE1shxt4rKXm1h9Yj0qnV0hRf9wKPRW/jeoIj2ypqhVu
         I0ilaSmvBI8/6e5QUL//rb5GDmlnW9/VeTy96+WL+61Iy1rb0ohYDfeE61s1H0636oux
         9KbS7DYwUB+AJoaYAw1oVq88jWyPn7OftXqqhAitDUoGX7byO9oAn8MJLuhfUAWX/Gjg
         x90A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=N66B/zUeupRdiK6j9+YxGVkqTJzroVbLV/gi+PEAAqs=;
        b=aJNxLscsl/TTyKeIlDuMB5Q086+fh6n6NwuZ3miChsbwD6dnVCc5QAxKN0mrlzwjN7
         sbUyIZgAYcmbKaMnDSO1L6CmGZlRe4iD0WWB18A0bmrvduxPB3tgUmPZAExR1VG2/O4y
         2YoxrH74gIdXZO1yRnE3wDj1KOZn5AZVZBI5NZHLWNP7iu2RKxnM+dN/79Nt4BZmuF+z
         bMD7oic6Rhu8yDLZJaaQNWOI7l+Rx6hF+fsY2Iw+gWYO0rev5rmgfcJNlUR+//H1y7t/
         ZRgFx8alK2ST9Jvkwt2Y4pHhuJCZs6qGfdScfm84NceOX0flYdBNDP+ESQI7xyQ/CjsT
         53ng==
X-Gm-Message-State: AOAM532Ur/6R4amSknW1viL7K7mkiFthBgeLa/tTs5N5TX3sgpiRd+wx
        P90VffYpQxy6qbVPQwbd++vyBQ==
X-Google-Smtp-Source: ABdhPJyZpgTgyRdq3gRjlMkwnuIEQyi6iWY7bf98FclX26jW8k/kO0JDKNafceTbQdkAH9+tcMWjRQ==
X-Received: by 2002:aca:f102:: with SMTP id p2mr18083052oih.325.1643673066964;
        Mon, 31 Jan 2022 15:51:06 -0800 (PST)
Received: from builder.lan ([2600:1700:a0:3dc8:3697:f6ff:fe85:aac9])
        by smtp.gmail.com with ESMTPSA id f20sm9297496ooh.10.2022.01.31.15.51.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jan 2022 15:51:06 -0800 (PST)
Date:   Mon, 31 Jan 2022 17:51:04 -0600
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Rayyan Ansari <rayyan@ansari.sh>
Cc:     linux-arm-msm@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: pinctrl: qcom,pmic-mpp: Document PM8226
 compatible
Message-ID: <Yfh16GWpkjOOLpQZ@builder.lan>
References: <20220124171538.18088-1-rayyan@ansari.sh>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220124171538.18088-1-rayyan@ansari.sh>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 24 Jan 11:15 CST 2022, Rayyan Ansari wrote:

> Document the Device Tree binding for PM8226 MPPs.
> 
> Signed-off-by: Rayyan Ansari <rayyan@ansari.sh>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

> ---
>  Documentation/devicetree/bindings/pinctrl/qcom,pmic-mpp.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,pmic-mpp.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,pmic-mpp.yaml
> index 35c846f59979..df79274d0ec3 100644
> --- a/Documentation/devicetree/bindings/pinctrl/qcom,pmic-mpp.yaml
> +++ b/Documentation/devicetree/bindings/pinctrl/qcom,pmic-mpp.yaml
> @@ -21,6 +21,7 @@ properties:
>            - qcom,pm8019-mpp
>            - qcom,pm8038-mpp
>            - qcom,pm8058-mpp
> +          - qcom,pm8226-mpp
>            - qcom,pm8821-mpp
>            - qcom,pm8841-mpp
>            - qcom,pm8916-mpp
> -- 
> 2.34.1
> 
