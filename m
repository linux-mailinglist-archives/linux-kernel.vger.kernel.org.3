Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C38A4AA2DB
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 23:08:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345124AbiBDWIc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 17:08:32 -0500
Received: from mail-oo1-f51.google.com ([209.85.161.51]:35463 "EHLO
        mail-oo1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233137AbiBDWIa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 17:08:30 -0500
Received: by mail-oo1-f51.google.com with SMTP id p4-20020a4a8e84000000b002e598a51d60so6209942ook.2;
        Fri, 04 Feb 2022 14:08:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JQ7WYZ4Zqg4HCtyNEPmfKDttwiehHxrZDO82/S7zZVE=;
        b=jnQhOSC0FhFR83UKDiozz7nYJNNRJEWCOltmX0HUQ4lsxvBnT/imsUvhBm3kRdFNL2
         0H2q7mVYe+8E4zzPmXel85gKHdffB9IR5wf0tlcEesZfGqGkeANPYNIZYaYyZcATZN0l
         jFKVQBoPf/5pjgnAHcByYekT8SCA8DV+jgIerSQwSdJnK3SWe+9bB9i5HADpIT7oRFbj
         +65/v0xyjYR1sZui3bxqciOdYkNcjDlFe8BGn9DyOnnh6LMjKH8dPQ1GmabSHbmEoJJW
         UE2I8m2qV3JVwLEDYvFV3UBafHs+Dh7qcCkad5v/Fut54cdfNTBeUzQ/aV1YpzcuFACi
         xJpQ==
X-Gm-Message-State: AOAM5326sOqab8cFYDu9K7DPSV34yPT3a/wi9VNi8aZi7un8mUQt1IuG
        h1j7Bk4dgV6n594k/M0I90iP5IQbow==
X-Google-Smtp-Source: ABdhPJzCR5b4do+sC8vu/Kn5Ig8ZQCwMphWuSpBEn7uPBasp5qvvVQX+Sgl9UoFUkOwZhnxHZ1k+PQ==
X-Received: by 2002:a4a:ca98:: with SMTP id x24mr322821ooq.43.1644012509912;
        Fri, 04 Feb 2022 14:08:29 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id cv13sm1005610oab.7.2022.02.04.14.08.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Feb 2022 14:08:29 -0800 (PST)
Received: (nullmailer pid 3267244 invoked by uid 1000);
        Fri, 04 Feb 2022 22:08:27 -0000
Date:   Fri, 4 Feb 2022 16:08:27 -0600
From:   Rob Herring <robh@kernel.org>
To:     Iwona Winiarska <iwona.winiarska@intel.com>
Cc:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>,
        David Muller <d.mueller@elsoft.ch>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Billy Tsai <billy_tsai@aspeedtech.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-aspeed@lists.ozlabs.org,
        Zev Weiss <zweiss@equinix.com>,
        Andrew Jeffery <andrew@aj.id.au>,
        Tony Luck <tony.luck@intel.com>, devicetree@vger.kernel.org,
        Olof Johansson <olof@lixom.net>,
        Dan Williams <dan.j.williams@intel.com>,
        Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Jean Delvare <jdelvare@suse.com>, linux-doc@vger.kernel.org,
        Randy Dunlap <rdunlap@infradead.org>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        openbmc@lists.ozlabs.org, Joel Stanley <joel@jms.id.au>,
        linux-hwmon@vger.kernel.org
Subject: Re: [PATCH v7 02/13] dt-bindings: Add bindings for peci-aspeed
Message-ID: <Yf2j2+QbO9kg0E1E@robh.at.kernel.org>
References: <20220202144838.163875-1-iwona.winiarska@intel.com>
 <20220202144838.163875-3-iwona.winiarska@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220202144838.163875-3-iwona.winiarska@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 02 Feb 2022 15:48:27 +0100, Iwona Winiarska wrote:
> Add device tree bindings for the peci-aspeed controller driver.
> 
> Co-developed-by: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
> Signed-off-by: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
> Signed-off-by: Iwona Winiarska <iwona.winiarska@intel.com>
> Reviewed-by: Joel Stanley <joel@jms.id.au>
> ---
>  .../devicetree/bindings/peci/peci-aspeed.yaml | 72 +++++++++++++++++++
>  1 file changed, 72 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/peci/peci-aspeed.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
