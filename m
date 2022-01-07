Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 181C9486F27
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 01:54:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344714AbiAGAyB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 19:54:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344587AbiAGAyA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 19:54:00 -0500
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45F65C061201
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jan 2022 16:54:00 -0800 (PST)
Received: by mail-ot1-x330.google.com with SMTP id g79-20020a9d12d5000000b0058f08f31338so5016172otg.2
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jan 2022 16:54:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ZaO37rktJawAGRVJ7BAS8tiuBiMt1OmvNN9i/ri29DQ=;
        b=RAdm6DZWQ5g2F/aBBCCkg01lbWhvNrtc9vED4F1Ho0UmIKwjLv2uzDQ3qEEeU+Yk3f
         4ShJeZ0Ppl9m1op1RlTSkmVs+p0Ov6F44AR9mBUThQPSxDd2zixogB3uD4yOcLYqI9u9
         9vIALNx/Yr5NS4hAJw4dfF7puBne5wGydpzt6dPsjA3OXiQ39vla/wBepsEQDiXeIjlK
         Ui85JKjV5h0mpGSVdk8V6Pdri8cHQt/rwuodsuwlmtPfPk0VrpIQ6xInqo/mVI3xDTcM
         d9xLWun6sxJliEwxCB1yqDVoRhiPweHw3AT2JYlDelHEwGvRpa7eYDG19YagGVGJuN3q
         rzeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZaO37rktJawAGRVJ7BAS8tiuBiMt1OmvNN9i/ri29DQ=;
        b=35I2KlDxt1uveurZCsZIkskGZxb7pr2s5ypvqKBXPzgOUXrJ3pwXsA+2wcQRESUkND
         TlAVlR3PpUmUyFLDQx7DQuuH/w9kquz/bKx5afE3gvZBAIx70S2m20xR0kadXNBKAe2f
         DJhMCerQOA11oJ02THrXqw5IiSw6V01mhrZT65Vj3QWp283+ns9t2VaYZnqsGOiYJw8y
         cMcifymSm42RKrWakZyVxW/9A3lM62RwceQHItPVoQjKl/Psvdzeq3vODFuCHMnrK/6Z
         8Tuy7HgvvSitdX+LZVbT6fZbvH1AREKw7fdBHivi/xsL7ETt9UGS1/qHgFwCJd9FC3jX
         rUZw==
X-Gm-Message-State: AOAM532GifZ9Tcc5W1oUV0kRhZDICIUFTtOC1lTQ9+jD27SuFPRuf5QM
        0ME5yu2DitkrC/8EKEfrcTzOnw==
X-Google-Smtp-Source: ABdhPJyZVteF1NkP4Sbb0U2jo9U56E4id3LLp773JFeCV+mN6jG2FiJXPenLnEUwPvvVJya5XkNUFg==
X-Received: by 2002:a05:6830:2:: with SMTP id c2mr44776634otp.341.1641516839647;
        Thu, 06 Jan 2022 16:53:59 -0800 (PST)
Received: from ripper (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id g22sm630920otj.0.2022.01.06.16.53.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jan 2022 16:53:59 -0800 (PST)
Date:   Thu, 6 Jan 2022 16:54:49 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Souradeep Chowdhury <quic_schowdhu@quicinc.com>
Cc:     linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, pure.logic@nexus-software.ie,
        greg@kroah.com, linux-kernel@vger.kernel.org, tsoni@codeaurora.org,
        psodagud@codeaurora.org, satyap@codeaurora.org,
        pheragu@codeaurora.org, rnayak@codeaurora.org,
        sibis@codeaurora.org, saiprakash.ranjan@codeaurora.org
Subject: Re: [PATCH V3 2/7] dt-bindings: connector: Add property for EUD
 type-C connector
Message-ID: <YdePWXEwfk50S+P2@ripper>
References: <cover.1641288286.git.quic_schowdhu@quicinc.com>
 <8194777786be70073a5364fe45ba7ec684019a71.1641288286.git.quic_schowdhu@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8194777786be70073a5364fe45ba7ec684019a71.1641288286.git.quic_schowdhu@quicinc.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 04 Jan 03:58 PST 2022, Souradeep Chowdhury wrote:

> Added the property for EUD(Embedded USB Debugger) connector. EUD
> is a mini usb hub with debug and trace capabilities and it has a
> type C connector attached to it for role-switching. This connector
> is attached to EUD via port.
> 

Per my feedback on the dts patch, I don't think this binding is needed.

Regards,
Bjorn

> Signed-off-by: Souradeep Chowdhury <quic_schowdhu@quicinc.com>
> ---
>  Documentation/devicetree/bindings/connector/usb-connector.yaml | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/connector/usb-connector.yaml b/Documentation/devicetree/bindings/connector/usb-connector.yaml
> index 7eb8659..417d39a 100644
> --- a/Documentation/devicetree/bindings/connector/usb-connector.yaml
> +++ b/Documentation/devicetree/bindings/connector/usb-connector.yaml
> @@ -30,6 +30,10 @@ properties:
>            - const: samsung,usb-connector-11pin
>            - const: usb-b-connector
>  
> +      - items:
> +          - const: qcom,usb-connector-eud
> +          - const: usb-c-connector
> +
>    label:
>      description: Symbolic name for the connector.
>  
> @@ -179,7 +183,8 @@ properties:
>      properties:
>        port@0:
>          $ref: /schemas/graph.yaml#/properties/port
> -        description: High Speed (HS), present in all connectors.
> +        description: High Speed (HS), present in all connectors. Also used as a
> +                     port to connect QCOM Embedded USB Debugger(EUD).
>  
>        port@1:
>          $ref: /schemas/graph.yaml#/properties/port
> -- 
> 2.7.4
> 
