Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E00AD477D41
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 21:19:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241242AbhLPUTG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 15:19:06 -0500
Received: from mail-ot1-f45.google.com ([209.85.210.45]:44568 "EHLO
        mail-ot1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233571AbhLPUTE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 15:19:04 -0500
Received: by mail-ot1-f45.google.com with SMTP id u18-20020a9d7212000000b00560cb1dc10bso256065otj.11;
        Thu, 16 Dec 2021 12:19:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=EP8i59lgz1RbahhTqKaKddO50DWDUxCElpVM84quxuw=;
        b=5B3o+bNsntoMQsC4P0fF8nDE4UA1x9FFfAxZcH3pdB5/++TIJLVBm3u5w0T5YO1IGE
         DCfOykSL3vBrGB/HPcx8R5xlE3BeA24I+x6WrLFcLdRHRnIBdgivXS69kDpctdswK+H7
         QDWPqPlIPvCIgtB+PT0WBnqb1t/9Q4CVwFuMtkASoJ3rn3yYSMfKh/BVUvchYwXQhksf
         GTbnc4xJKaNAWc3fUEqBZE9BSbMYACAQtP9B3h4zyKYVz1ug7Lutt7aYhg0YriYgreXA
         Z4AdgJfX9yu92j4rEeiJtV86SP/45/RAAz2JrsSo3YpbDxPKGctLsO2InyugojOXUPen
         jilQ==
X-Gm-Message-State: AOAM533MjlNdK5x5+c4x9P3DzJnJYY1dc766uLfj1fnJ4woD5p/Z85Or
        zWxgKiHnCJcUlW8YyoI4EQ==
X-Google-Smtp-Source: ABdhPJxGzTaxROIp6OiBxmHuoDVdzp0kHtMPkrp4yRm4C+zENNV9wjGntcWJ3rP4Wr/eQRjmPg8Xaw==
X-Received: by 2002:a05:6830:449e:: with SMTP id r30mr14320962otv.120.1639685943759;
        Thu, 16 Dec 2021 12:19:03 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id k17sm1200037oom.6.2021.12.16.12.19.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Dec 2021 12:19:03 -0800 (PST)
Received: (nullmailer pid 687171 invoked by uid 1000);
        Thu, 16 Dec 2021 20:19:02 -0000
Date:   Thu, 16 Dec 2021 14:19:02 -0600
From:   Rob Herring <robh@kernel.org>
To:     Sergey Shtylyov <s.shtylyov@omp.ru>, Yaqin Pan <akingchen@vivo.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@vivo.com
Subject: Re: [PATCH 2/2] dt-bindings: usb: document snps,dis_split_quirk
 property in dwc3
Message-ID: <YbufNsBtiIzbm+9k@robh.at.kernel.org>
References: <20211215130325.19017-1-akingchen@vivo.com>
 <20211215130325.19017-3-akingchen@vivo.com>
 <abede066-43a2-b61b-d152-c95ef3785934@omp.ru>
 <5eb92897-1ef9-3c1c-c068-7fef759ec9ad@omp.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5eb92897-1ef9-3c1c-c068-7fef759ec9ad@omp.ru>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 16, 2021 at 06:59:27PM +0300, Sergey Shtylyov wrote:
> On 12/16/21 11:26 AM, Sergey Shtylyov wrote:
> 
> >> Add snps,dis_split_quirk property for dwc3 controller
> >>
> >> Signed-off-by: Yaqin Pan <akingchen@vivo.com>
> >> ---
> >>   Documentation/devicetree/bindings/usb/snps,dwc3.yaml | 6 ++++++
> >>   1 file changed, 6 insertions(+)
> >>
> >> diff --git a/Documentation/devicetree/bindings/usb/snps,dwc3.yaml b/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
> >> index 41416fbd92aa..e9615ca8f447 100644
> >> --- a/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
> >> +++ b/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
> >> @@ -226,6 +226,12 @@ properties:
> >>         avoid -EPROTO errors with usbhid on some devices (Hikey 970).
> >>       type: boolean
> >>   +  snps,dis_split_quirk:

I'm tired of the never ending DWC3 quirks. Imply this from the 
compatible unless it varies by board.

Also, don't use '_' in DT names.

> >> +    description:
> >> +      When set, change the way host controller schedules transations for a Control transfer.
> > 
> >    Transactions.
> > 
> >> +      Needed to avoid emurate some devices fail.
> > 
> >    Avoid failing to enumerating some devices?
> 
>    Sorry. enumarate. :-)

Or enumerate

