Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 390D24C388F
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 23:13:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235314AbiBXWNR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 17:13:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232144AbiBXWNO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 17:13:14 -0500
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A0A4223201;
        Thu, 24 Feb 2022 14:12:44 -0800 (PST)
Received: by mail-oi1-f174.google.com with SMTP id l25so5300133oic.13;
        Thu, 24 Feb 2022 14:12:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=AwrpQE4LJn3t0vwAwhao+3qHyp6bWGUtHRIdv9zUR3A=;
        b=Wirx9IUDLLoFcCBgGbkiDDeK6x2YjeYg3uT39YDdU7RH297yN1a6A3cJbJtPOMp/YY
         7dn9nGiEf9+88Qd3hPavgq83YIdf4wSuBUEMM1rjoj6fr9/TZKS9J36D5Hw/bkFUVzt6
         veZ+Ps+48MF7k2H8j92FNv34qXTKluDJHbdfj/SKqNVvhUxZWDsaKu/vV41oTjc0CUrM
         bTVsf9nvbr30mnss7Nfnjbny/2HngC/SmC2pF3urIJRB62ZzhUskyKUXLl59kNJ/I1i1
         1yzTmckZCd+rO+L4qtwf2CSHVW6wFL+uTS6JJgVNSkU5OCinZaZwt+zzm0G4YBqfRdoW
         9l6w==
X-Gm-Message-State: AOAM531Gxp7LinsIfnic1myEM4Io2VSLqHRglHVDmUh2kmFf8gUGnZjk
        R0xvzNUGBs7Y0hu+1pmmpg==
X-Google-Smtp-Source: ABdhPJx8ZE9fbvxfnrwEKrYV4Ec4weHW2WZEMcIuFMfTxiJpMIT63JPWl/TeZ/ky7d/LhoFPzArzdg==
X-Received: by 2002:a05:6870:780f:b0:d6:e266:e13f with SMTP id hb15-20020a056870780f00b000d6e266e13fmr112087oab.44.1645740763380;
        Thu, 24 Feb 2022 14:12:43 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id u3-20020a056808114300b002d51f9b3263sm424053oiu.28.2022.02.24.14.12.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 14:12:42 -0800 (PST)
Received: (nullmailer pid 3682256 invoked by uid 1000);
        Thu, 24 Feb 2022 22:12:41 -0000
Date:   Thu, 24 Feb 2022 16:12:41 -0600
From:   Rob Herring <robh@kernel.org>
To:     Marcello Sylvester Bauer <sylv@sylv.io>
Cc:     Guenter Roeck <linux@roeck-us.net>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        linux-hwmon@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Patrick Rudolph <patrick.rudolph@9elements.com>
Subject: Re: [PATCH v2 1/3] dt-bindings: trivial-devices: Add xdpe11280
Message-ID: <YhgC2RTyDmzdowzh@robh.at.kernel.org>
References: <cover.1645108566.git.sylv@sylv.io>
 <cbef5619ca8bb1edef32532ac22a5803248036ee.1645108566.git.sylv@sylv.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cbef5619ca8bb1edef32532ac22a5803248036ee.1645108566.git.sylv@sylv.io>
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

On Thu, 17 Feb 2022 15:41:33 +0100, Marcello Sylvester Bauer wrote:
> Add Infineon Multi-phase Digital Controller XDPE11280.
> 
> Signed-off-by: Marcello Sylvester Bauer <sylv@sylv.io>
> ---
>  Documentation/devicetree/bindings/trivial-devices.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
