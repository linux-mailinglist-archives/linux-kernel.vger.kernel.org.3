Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2C44477E77
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 22:09:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241613AbhLPVJn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 16:09:43 -0500
Received: from mail-oi1-f170.google.com ([209.85.167.170]:33732 "EHLO
        mail-oi1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbhLPVJT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 16:09:19 -0500
Received: by mail-oi1-f170.google.com with SMTP id q25so801610oiw.0;
        Thu, 16 Dec 2021 13:09:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=OS/sucy8NbtpflVnkHVNg7NehaU6O8L89FOZlphTY1s=;
        b=d0VkMCQe6STR4tr7BwB5usnt0kcvH91PbR2r765TaHejP55D0rx0jVC2KektJafwC9
         84dABBpHJVWYeoYMTxDGoGSqG7FSiZVrfivAaLIF2Zs8bJmfWmpUlSZUp5WdPnQtRjxw
         MHU4avwzqcZP+F2QLLDrp9OcsMqrIK5DDlpvd0npWhCLZvHjVxDVChj5RZoM7M/EL5iC
         39EpAVHgpJJ7ZDzFImzU+q10NHVjH2DQNambnmlnX480WbAgyTiZdQePEkXsFisDgpjU
         mxlNgbm6DBeTQT+PmB24PybZ5a+T9u/thfPre0hkMMtfmMkZQwDsltJ8KlDGvm4LmVMR
         psZg==
X-Gm-Message-State: AOAM532T3rYamtdhRHf9ZnYbMczNH4cH0bCqmqOY75UIuJkzf9sC4fdL
        ghddhU+EkT1vI9WapPw+B3qnzAeCTw==
X-Google-Smtp-Source: ABdhPJyyMGhiLWXkVVOwkZcyEhZGW4Fe/iwsRS5HdesRaYQ+6daPAj0X1Xw3SrpCTlL4beb0xpR1zg==
X-Received: by 2002:aca:100f:: with SMTP id 15mr5675384oiq.82.1639688959036;
        Thu, 16 Dec 2021 13:09:19 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id p10sm1219585otp.53.2021.12.16.13.09.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Dec 2021 13:09:18 -0800 (PST)
Received: (nullmailer pid 766740 invoked by uid 1000);
        Thu, 16 Dec 2021 21:09:18 -0000
Date:   Thu, 16 Dec 2021 15:09:18 -0600
From:   Rob Herring <robh@kernel.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Manu Gautam <mgautam@codeaurora.org>,
        Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: usb: qcom,dwc3: add binding for SM8450
Message-ID: <Ybuq/lWQOAfMbXAD@robh.at.kernel.org>
References: <20211216113849.659856-1-vkoul@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211216113849.659856-1-vkoul@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Dec 2021 17:08:49 +0530, Vinod Koul wrote:
> Add the compatible string for USB controller for Qualcomm SM8450 SoC.
> 
> Signed-off-by: Vinod Koul <vkoul@kernel.org>
> ---
>  Documentation/devicetree/bindings/usb/qcom,dwc3.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
