Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3906B4ACB46
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 22:28:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239393AbiBGV2E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 16:28:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232695AbiBGV2C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 16:28:02 -0500
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19930C06173B;
        Mon,  7 Feb 2022 13:28:02 -0800 (PST)
Received: by mail-oi1-f179.google.com with SMTP id u3so2611695oiv.12;
        Mon, 07 Feb 2022 13:28:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=n9pAeqwk/+hM83DMbi7HFjbGQbsE/DtiBYjgwQKfGtg=;
        b=JYWycLwV/li88/WY+jQoa2wWevfuXcNJPZn5TDs6ln0IbXMV/h5nz36llCzRhRForr
         1nJGJuSNnlHAIIA54/LxRC9/1bjEWTs7uzMUtNGAY13qKk0njUzro+7MX8hjocHrYKoQ
         PsvkZ+Z81WotpajudZOLRlWpMCFulLLpkrhCvGuqgFY1bzVvNJAumufWrqyoEYjuE+R6
         RfkxfdFFc0nO48P4CNOFHtQOE/c3d7rAuFpkoDo6rfT4WJk6aL0lsiuILUcWNS6oTmVq
         kITlkwsNfYwSg/J/cBqefkiPEAHHKk7DdcISsJ8WdqCjF0W42l5ptYh5fLHHwWpvtwiR
         8Ywg==
X-Gm-Message-State: AOAM531Z78lBARqvl3KwaTet/ssCFg0kEBWD+U0wI//n2GmMZYsySmo5
        Z+7vr3GNGbLBTNIwqEhJdg==
X-Google-Smtp-Source: ABdhPJxXLUuMcr12LFMDdmrB3gIOlRDQH/trqcAdajudte+rbKkJCKUyVVrNilUiqqIvgor/GUiohw==
X-Received: by 2002:a05:6808:1154:: with SMTP id u20mr418567oiu.169.1644269281308;
        Mon, 07 Feb 2022 13:28:01 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id bg10sm248465oib.33.2022.02.07.13.28.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Feb 2022 13:28:00 -0800 (PST)
Received: (nullmailer pid 953189 invoked by uid 1000);
        Mon, 07 Feb 2022 21:27:59 -0000
Date:   Mon, 7 Feb 2022 15:27:59 -0600
From:   Rob Herring <robh@kernel.org>
To:     Sean Anderson <sean.anderson@seco.com>
Cc:     linux-usb@vger.kernel.org,
        Balaji Prakash J <bjagadee@codeaurora.org>,
        Rob Herring <robh+dt@kernel.org>,
        Felipe Balbi <balbi@kernel.org>,
        Robert Hancock <robert.hancock@calian.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devicetree@vger.kernel.org, Baruch Siach <baruch@tkos.co.il>,
        linux-kernel@vger.kernel.org,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Subject: Re: [PATCH v3 1/7] dt-bindings: usb: dwc3: Deprecate
 snps,ref-clock-period-ns
Message-ID: <YgGO3zsusqNv2RGD@robh.at.kernel.org>
References: <20220127200636.1456175-1-sean.anderson@seco.com>
 <20220127200636.1456175-2-sean.anderson@seco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220127200636.1456175-2-sean.anderson@seco.com>
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

On Thu, 27 Jan 2022 15:06:30 -0500, Sean Anderson wrote:
> This property is redundant because we can determine the correct value for
> REFCLKPER based on the "ref" clock. Deprecate it, and encourage users to
> provide a clock instead. This also restricts the minimum and maximum to the
> values documented in the register reference [1].
> 
> [1] https://www.xilinx.com/html_docs/registers/ug1087/usb3_xhci___guctl.html
> 
> Signed-off-by: Sean Anderson <sean.anderson@seco.com>
> ---
> 
> (no changes since v1)
> 
>  Documentation/devicetree/bindings/usb/snps,dwc3.yaml | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
