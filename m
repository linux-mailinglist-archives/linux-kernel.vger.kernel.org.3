Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C95F24FFDCD
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 20:29:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237700AbiDMSbH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 14:31:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236313AbiDMSbD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 14:31:03 -0400
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0011A517C4;
        Wed, 13 Apr 2022 11:28:41 -0700 (PDT)
Received: by mail-oi1-f169.google.com with SMTP id e189so2957544oia.8;
        Wed, 13 Apr 2022 11:28:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5SWSELfeWa5DmOzvc6fSLXMlhJprFBxcF+xYsyulMiQ=;
        b=PnR+yKHKfAu4DYhMjJSwjqawAgciT1X/SOGn6t2xnkMkSGzQHaRbkUMst8U5Chfump
         QJUSdDJ7/rkDYlGHxmt2Lxup+ZgMM4zI9vPA6ChYfh4jMb9ZfIsswK5dk5twwuytJbVw
         xc/DR1XIkz6ZXsw8eICDyLwq9zRAdd3zwUk9TxwhsRfoIht9IBA0PgdfIyxrp5vOZjP4
         cqDugWHOo276qj4qyt/iFQ99AJiP2Z9uGUkM7F9Uwtloivzrogm2GB0Or7h7cmxH1DSe
         Hj/8h1jb9tRMfw+XfFlz3psh6u5eDKXO/VL/2vDmSQoXws/PdJL5iVmfrxAHLT0G5b3Z
         /QkA==
X-Gm-Message-State: AOAM532bWQIFKMyjGEHXRTCe5XfaVMm+Pg5u6lt78udhw26XL1XL4nXp
        X1r36FVjQkHhsvGjKjbjJg==
X-Google-Smtp-Source: ABdhPJxrB+xyAwGoK50FDp8/Bpf1gaWPjyG9igkAc4ADUhJd3bjMrwiFnpPxDcEpNSAUEARe3qs7QA==
X-Received: by 2002:a05:6808:209e:b0:2da:4de9:e632 with SMTP id s30-20020a056808209e00b002da4de9e632mr66327oiw.214.1649874521279;
        Wed, 13 Apr 2022 11:28:41 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id bd32-20020a056870d7a000b000d43d4d2de1sm14458027oab.5.2022.04.13.11.28.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 11:28:41 -0700 (PDT)
Received: (nullmailer pid 3601957 invoked by uid 1000);
        Wed, 13 Apr 2022 18:28:40 -0000
Date:   Wed, 13 Apr 2022 13:28:40 -0500
From:   Rob Herring <robh@kernel.org>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Jarrett Schultz <jaschultzms@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mark Gross <markgross@kernel.org>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        Felipe Balbi <balbi@kernel.org>,
        Jarrett Schultz <jaschultz@microsoft.com>
Subject: Re: [PATCH v5 0/4] platform: surface: Introduce Surface XBL Driver
Message-ID: <YlcWWPqGzc4Zk9R+@robh.at.kernel.org>
References: <20220405210750.619511-1-jaschultzMS@gmail.com>
 <d648629e-2339-449f-f63c-41af85ba35b5@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d648629e-2339-449f-f63c-41af85ba35b5@redhat.com>
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

On Mon, Apr 11, 2022 at 02:13:42PM +0200, Hans de Goede wrote:
> Hi Jarrett,
> 
> On 1/1/70 01:00, Jarrett Schultz wrote:
> > After v4, there were some suggestions to change the driver again to use
> > nvmem that would include some other changes to the sm8150 dtsi. While
> > the suggestions make sense, this driver was supposed to remain simple
> > for the introduction in order to get it into the tree and I think that
> > it would be best to implement those and any other suggestions in a future
> > patch. Hopefully this patch is now in a state where it can be accepted.
> > Thanks to all who have helped and been patient along the way, this was
> > my first patch :)
> I appreciate your efforts to get this upstream, but this is not
> how upstream development typically works. We usually iterate a patch
> until all stakeholders are happy and then merge it.
> 
> So unless Rob changes its mind and gives his Reviewed-by for the
> devicetree bits from this v5, then this cannot be merged as is.

This is dependent on the QCom folks. We can't really define the child 
without first defining the parent binding.

Rob
