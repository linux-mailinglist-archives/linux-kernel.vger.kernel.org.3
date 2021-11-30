Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF394462A30
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 03:08:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237315AbhK3CL0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 21:11:26 -0500
Received: from mail-oi1-f178.google.com ([209.85.167.178]:40920 "EHLO
        mail-oi1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231473AbhK3CLX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 21:11:23 -0500
Received: by mail-oi1-f178.google.com with SMTP id bk14so38302094oib.7;
        Mon, 29 Nov 2021 18:08:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yR94RCo3gWAh8xXvoz+CMBZNUSHxHpjJ7gx2/RB6Q2w=;
        b=3xwz04ZaKw+HJIh/bKbYtiKUjALvuwimRIJ6z26BITrLFKOE9VdIX+7ywh7pbmlmDf
         r15+Naaqwbt4XjGAJjyUcbCbq72AmPV6PSdvcJ9LFu5B3oL9dLfN1GIOJQhCpPG2gZMz
         hUHbmny3FsaXanUOpKzZhI7ciq6Wd6n8mn7ThCdWeXMg90uypQvRYajgfOBsfaaKOL9W
         +A9B3GeEs2Eez+B5cXoy8oJcr7mNbEXUr5opPP80o+55La6cp+765yU9eVHCF2yhmKXv
         FQL+ZtOA2ciBdNrpVMQkxmUREdPeVp7ESGmMDCsQhogSd54OAQAiQyWniIHJwr0SYfbb
         pouQ==
X-Gm-Message-State: AOAM530ViQ6+qDVrdiZaid4nZEXjzl0VHjUBTe74ArXiausAktqwn/sl
        nmTsuW4W4md27xGGY3h1sfjrJpPaxg==
X-Google-Smtp-Source: ABdhPJzBdyW3N05naAg7PmtQJTsaqY1AM6q6r+o+8skQiz0YSe1buTCoqP3UkYsDWjf3nkSGS19x9g==
X-Received: by 2002:a05:6808:485:: with SMTP id z5mr1678511oid.96.1638238084922;
        Mon, 29 Nov 2021 18:08:04 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id b1sm2961449otj.5.2021.11.29.18.08.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Nov 2021 18:08:04 -0800 (PST)
Received: (nullmailer pid 1031391 invoked by uid 1000);
        Tue, 30 Nov 2021 02:08:03 -0000
Date:   Mon, 29 Nov 2021 20:08:03 -0600
From:   Rob Herring <robh@kernel.org>
To:     David Mosberger-Tang <davidm@egauge.net>
Cc:     Jiri Kosina <trivial@kernel.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH] Update trivial-devices.yaml with Sensirion,sht4x
Message-ID: <YaWHgz1xGwZRZuHD@robh.at.kernel.org>
References: <20211121161320.2312393-1-davidm@egauge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211121161320.2312393-1-davidm@egauge.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 21 Nov 2021 16:13:40 +0000, David Mosberger-Tang wrote:
> Add Sensirion SHT4x, a precision temperature and humidity sensor, to
> trivial-devices.yaml.
> 
> Signed-off-by: David Mosberger-Tang <davidm@egauge.net>
> ---
>  Documentation/devicetree/bindings/trivial-devices.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Applied, thanks!
