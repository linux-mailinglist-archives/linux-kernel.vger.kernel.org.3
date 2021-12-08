Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1905946D60B
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 15:47:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235420AbhLHOuo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 09:50:44 -0500
Received: from mail-ot1-f51.google.com ([209.85.210.51]:39771 "EHLO
        mail-ot1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232932AbhLHOun (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 09:50:43 -0500
Received: by mail-ot1-f51.google.com with SMTP id r10-20020a056830080a00b0055c8fd2cebdso2940546ots.6;
        Wed, 08 Dec 2021 06:47:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=buknLEPiljUfS2B22B7J//dmCPA4Jy3FaQSdKUP3e+w=;
        b=gfvODuoQki5aiZbfhpFM8QiFHci1kTE4vAjObHKO+ogc+2aht340k2DokX/Owfwz9I
         mFr4prjj/b02YSOOXLYm7XSIg/Hf+R79tDv3sQrrm3gplPHfj4RRWW5t5fD5CvDoIriB
         WAWkdOScjtxrrXQ7Rpa7yrOesEroj/SbgS2+eB0vwdeCwY2FdNAbAmxKuvdlfmVeFv7N
         +h1PK6ifRnRRDOGLekIJPa+s28G+Q8MgeNK5Ynkv46+ATO5M+QYZ3NwSblShORHpmpam
         6Sp6xaZJBr03jdfuNKHCSJv9oxSFuhoORGS9yib7JWwgm6ooGx9wjOw8LGC0oH0NImMU
         YGRw==
X-Gm-Message-State: AOAM533uiEiKn+FzCCahnZ1bPx/sOZ03L1BogLoLZR0NsEgK0a+tNjk1
        EuUZ2cvCexm9PU3BxSaE7KtqzUyZ9Q==
X-Google-Smtp-Source: ABdhPJxs1ghPJ4vN60wkuCNrY9iCYpx7WoaP2dDzxeFkG8VpKJqgcGyVDbMM4iv3QvIYNW/hskCkrA==
X-Received: by 2002:a9d:4f0e:: with SMTP id d14mr41842978otl.137.1638974831552;
        Wed, 08 Dec 2021 06:47:11 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id v12sm502385ote.9.2021.12.08.06.47.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Dec 2021 06:47:10 -0800 (PST)
Received: (nullmailer pid 3986422 invoked by uid 1000);
        Wed, 08 Dec 2021 14:47:09 -0000
Date:   Wed, 8 Dec 2021 08:47:09 -0600
From:   Rob Herring <robh@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>,
        Felipe Balbi <balbi@kernel.org>, devicetree@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: usb: Add missing properties used in examples
Message-ID: <YbDFbTQW8Cv38fON@robh.at.kernel.org>
References: <20211206174113.2295616-1-robh@kernel.org>
 <Ya5VhX8TA0LBn4Qd@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ya5VhX8TA0LBn4Qd@kroah.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 06, 2021 at 07:25:09PM +0100, Greg Kroah-Hartman wrote:
> On Mon, Dec 06, 2021 at 11:41:12AM -0600, Rob Herring wrote:
> > With 'unevaluatedProperties' support implemented, the following warnings
> > are generated in the usb examples:
> > 
> > Documentation/devicetree/bindings/usb/intel,keembay-dwc3.example.dt.yaml: usb: usb@34000000: Unevaluated properties are not allowed ('reg' was unexpected)
> > Documentation/devicetree/bindings/usb/snps,dwc3.example.dt.yaml: usb@4a030000: Unevaluated properties are not allowed ('reg' was unexpected)
> > 
> > Add the missing property definitions.
> > 
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Cc: Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>
> > Cc: Felipe Balbi <balbi@kernel.org>
> > Cc: linux-usb@vger.kernel.org
> > Signed-off-by: Rob Herring <robh@kernel.org>
> > ---
> >  .../devicetree/bindings/usb/intel,keembay-dwc3.yaml         | 3 +++
> >  Documentation/devicetree/bindings/usb/snps,dwc3.yaml        | 6 ++++++
> >  2 files changed, 9 insertions(+)
> 
> Do you want me to take these in my tree?  If not, you can take them in
> yours:
> 	Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
> Which ever is easier for you.

I'll take them.

Rob
