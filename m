Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DF09495F06
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 13:30:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350426AbiAUMaY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 07:30:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350396AbiAUMaW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 07:30:22 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E85FC06173F
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jan 2022 04:30:22 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id p27so33582422lfa.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jan 2022 04:30:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=waldekranz-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=YwcThLdlhL/acDqGxChjAoRxCxuywSm7GL8Fia6HAAY=;
        b=ySnOroNO9xli0+2k17L1168iInpPz4ixK2cuSnQtNuYAbCMF2YYG62nyQm01mHvGc6
         9Sj6Yc0Tlkps5SrWH1j8DvaUX3h9uWCBVSd3Esb8XpBmgdQa7DY85g0LkJ64Um5lzGrH
         ublYhM6kITFbK9NcakHRjTdPKK9K7wSfbnieuEqIdMd900aeMyHBZUdV2V6dP/E4anna
         aOLT4CKxZrIzCYMxukk4J9CNAtMwiweblEEfX6SUNBtChGRWmK4GF5JpIxA3sEwdfaMC
         Hhk4L2ObszGNc1OmueH7N9moWR/XnFDjn6hs7bcK4sjjlQ3ZVass3SSCzhxDbRmSDglC
         QthA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=YwcThLdlhL/acDqGxChjAoRxCxuywSm7GL8Fia6HAAY=;
        b=w3lU04oZXkiTstT3r0JB+sY+kWS25wvTb7Z2dD5TmATN2R8rb0P6t2wWAmz/rvovg1
         3yDqAb7BNDZqHu0onH1PxLn1zclyCwhypyp/qNkEA4NSvzM06JAm2nNi7qzrtFNuVbRW
         z4/qA2YebvjHYvmtECDWu2laj3QFf7f5O417cEfJMdzRfKH78BDhqEtn1ISzx7JtlH51
         GfAxSMrRSUee3dPhDulWwOBuX0LavyuTmoEGAsWOZ1PgIsrr8kI2r1vQPosqU2VvPufr
         KmgNLi63RkdO3yTVsvZGURJu75ZfBOzxunJ6cQ/kYEEiSNp+abujwV/4gEkH8Xt0QYex
         Scbw==
X-Gm-Message-State: AOAM531VCHWcmBPQbl/uCr29sPKDIA0Rk5JUmTyVC/AvohWFlZuA0fU9
        HoJ+PyYfCiNehtFfZ8sxyRrbk/DPjPaTDQ==
X-Google-Smtp-Source: ABdhPJzoD4T1mExSQoYsN2C9hUqgVQ+CqEwH4fI7C7dM01AnGWkZ5V6sm+5MoSZtz7PLEqHVNKyqgQ==
X-Received: by 2002:a05:6512:40e:: with SMTP id u14mr3594745lfk.133.1642768220179;
        Fri, 21 Jan 2022 04:30:20 -0800 (PST)
Received: from wkz-x280 (static-193-12-47-89.cust.tele2.se. [193.12.47.89])
        by smtp.gmail.com with ESMTPSA id d21sm238569lfi.217.2022.01.21.04.30.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jan 2022 04:30:19 -0800 (PST)
From:   Tobias Waldekranz <tobias@waldekranz.com>
To:     Rob Herring <robh@kernel.org>
Cc:     davem@davemloft.net, kuba@kernel.org, netdev@vger.kernel.org,
        Andrew Lunn <andrew@lunn.ch>,
        Madalin Bucur <madalin.bucur@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 net 2/4] dt-bindings: net: Document fsl,erratum-a009885
In-Reply-To: <YeoVlBEWWlqDf7NG@robh.at.kernel.org>
References: <20220118215054.2629314-1-tobias@waldekranz.com>
 <20220118215054.2629314-3-tobias@waldekranz.com>
 <YeoVlBEWWlqDf7NG@robh.at.kernel.org>
Date:   Fri, 21 Jan 2022 13:30:17 +0100
Message-ID: <871r11cluu.fsf@waldekranz.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 20, 2022 at 20:08, Rob Herring <robh@kernel.org> wrote:
> On Tue, Jan 18, 2022 at 10:50:51PM +0100, Tobias Waldekranz wrote:
>> Update FMan binding documentation with the newly added workaround for
>> erratum A-009885.
>> 
>> Signed-off-by: Tobias Waldekranz <tobias@waldekranz.com>
>> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
>> ---
>>  Documentation/devicetree/bindings/net/fsl-fman.txt | 9 +++++++++
>>  1 file changed, 9 insertions(+)
>> 
>> diff --git a/Documentation/devicetree/bindings/net/fsl-fman.txt b/Documentation/devicetree/bindings/net/fsl-fman.txt
>> index c00fb0d22c7b..020337f3c05f 100644
>> --- a/Documentation/devicetree/bindings/net/fsl-fman.txt
>> +++ b/Documentation/devicetree/bindings/net/fsl-fman.txt
>> @@ -410,6 +410,15 @@ PROPERTIES
>>  		The settings and programming routines for internal/external
>>  		MDIO are different. Must be included for internal MDIO.
>>  
>> +- fsl,erratum-a009885
>
> Adding errata properties doesn't work because then you have to update 
> your dtb to fix the issue where as if you use the compatible property 
> (specific to the SoC) you can fix the issue with just a (stable) kernel 
> update.
>
> Yes, I see we already have some, but doesn't mean we need more of them.

I agree. Unfortunately all users of the driver also use the same
compatible string, so there was no way I could think of that would not
involve rebuilding DTBs anyway. Given that situation, I chose to just
extend what was already there.
