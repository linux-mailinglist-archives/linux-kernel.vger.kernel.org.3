Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49EA449294F
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 16:03:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346093AbiARPCS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 10:02:18 -0500
Received: from ip-94-112-206-30.net.upcbroadband.cz ([94.112.206.30]:49272
        "EHLO ixit.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1345950AbiARPBy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 10:01:54 -0500
Received: from [10.0.0.139] (_gateway [10.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by ixit.cz (Postfix) with ESMTPSA id 1EB272005E;
        Tue, 18 Jan 2022 16:01:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ixit.cz; s=dkim;
        t=1642518107;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mNusQwiI8GcX+4JOHZXHVMrQQalF8f+joTR1dl9wdAI=;
        b=J5axomeaNDvt65zgkc21EkHB3WGiFZrzLz0Ax1DMwiR2UmkZ0hkLk2emRiHZMqXzuH/Zj0
        mcg546+l6U+HcJ7ZtCKSrOQOhxcqG7C9begla7mvThTZFw8hYmsIp5EX/ZAksV8pZX4F7w
        AmwjEXaX7QothkMfEq0RP04RPSf3OuM=
Date:   Tue, 18 Jan 2022 16:01:42 +0100
From:   David Heidelberg <david@ixit.cz>
Subject: Re: [PATCH v4] dt-bindings: misc: fastrpc convert bindings to yaml
To:     Rob Herring <robh@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        ~okias/devicetree@lists.sr.ht, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <U2VW5R.K2NKZT1MORH03@ixit.cz>
In-Reply-To: <7A333484-F1D4-4D0E-97D5-6A40DEC44BFE@ixit.cz>
References: <20211208101508.24582-1-david@ixit.cz>
        <YbPIM9OXyuU5hfHY@robh.at.kernel.org>
        <7A333484-F1D4-4D0E-97D5-6A40DEC44BFE@ixit.cz>
X-Mailer: geary/40.0
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Should I pick different approach or keeping additionalProperties: true 
is suitable solution in this situation?

Thanks
David Heidelberg

On Sun, Dec 12 2021 at 13:03:40 +0000, David Heidelberg <david@ixit.cz> 
wrote:
> Well, since this is a subnode, some nodes are not converted yet and 
> at least know it'll bash about iommus, qcom,glink-channels and 
> qcom,smd-channels. I can change it to false, bit it'll print these 
> additional warnings, until other binding don't get converted.
> 
> David
> 
> 
>>  +    required:
>>  +      - compatible
>>  +      - reg
>>  +
>>  +    additionalProperties: true
> 
> Why? What other properties are present.
> 
>>  +
>>  +required:
>>  +  - compatible
>>  +  - label
>>  +  - '#address-cells'
>>  +  - '#size-cells'
>>  +
>>  +additionalProperties: true
> 
> Why? What other properties are present. This is generally never 
> correct.
> 
> Rob
> 


