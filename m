Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A09BB4B26CA
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 14:07:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350372AbiBKNHZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 08:07:25 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244052AbiBKNHX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 08:07:23 -0500
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B737FF43;
        Fri, 11 Feb 2022 05:07:22 -0800 (PST)
Received: by mail-io1-f46.google.com with SMTP id 9so11292554iou.2;
        Fri, 11 Feb 2022 05:07:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=N1qRUmipcdDvpt9C5NYp9d7NWGG0ZyGLcJiXryEwpdc=;
        b=chsQkIJrOcpR5C9hsqvFkasirYt8dQgABcdSxKC/hJKuRUyjdhfEKcvzkiOCERJOF2
         ud5r4lw2rqk+hPGT3Pw6hO2NgrqMQ1QaeMSBHeIU4ToPOrWLH45+7apJkCbVKE8EJmch
         L9MAGjDTFON9mwpyIgW3HYa60vCE8lZivwWZ22dhqga6puK2rDiZ7RLxFV2YLAb599PS
         j/W2Tr9Uw1HIq3uuJSeNIHSJWTQW8KByJgVvIhEPch+4QQNfKKjzdw+aQqPIEjAwPFlR
         R2TDRvm20jWGvWuImAo0c/2Zq3RbDngYqLRvKi82qK+rl3v0YcdDtMsgPMmgN3DOX/li
         5lMQ==
X-Gm-Message-State: AOAM5300mvUb5509rsoqjEHZFsBXvL3St7xszeAFCJwHKtal3Dnisah1
        fSXjUCm8HGTPzWwsv14U9Q==
X-Google-Smtp-Source: ABdhPJyBXOpVW7E9SyHEbD8si+3vMq0RKj0SJqPTLTYBDRorD8Y+cy9tDDMvSGsMw77DoqQoGpC9ww==
X-Received: by 2002:a02:ce32:: with SMTP id v18mr790617jar.66.1644584842011;
        Fri, 11 Feb 2022 05:07:22 -0800 (PST)
Received: from robh.at.kernel.org ([172.58.139.71])
        by smtp.gmail.com with ESMTPSA id q5sm13162625ilu.64.2022.02.11.05.07.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Feb 2022 05:07:21 -0800 (PST)
Received: (nullmailer pid 224799 invoked by uid 1000);
        Fri, 11 Feb 2022 13:07:18 -0000
Date:   Fri, 11 Feb 2022 07:07:18 -0600
From:   Rob Herring <robh@kernel.org>
To:     Samuel Holland <samuel@sholland.org>
Cc:     Ondrej Jirman <megous@megous.com>,
        Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] dt-bindings: trivial-devices: Add Injoinic power
 bank ICs
Message-ID: <YgZfhgYc/tgluUGc@robh.at.kernel.org>
References: <20220129222424.45707-1-samuel@sholland.org>
 <20220129222424.45707-2-samuel@sholland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220129222424.45707-2-samuel@sholland.org>
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

On Sat, 29 Jan 2022 16:24:23 -0600, Samuel Holland wrote:
> Some Injoinic power bank ICs feature an I2C interface which allows
> monitoring and controlling the battery charger and boost converter.
> 
> Signed-off-by: Samuel Holland <samuel@sholland.org>
> ---
> 
>  Documentation/devicetree/bindings/trivial-devices.yaml | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
