Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1184E4AE728
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 03:45:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344012AbiBICob (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 21:44:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234845AbiBICcy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 21:32:54 -0500
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EE35C0613CC;
        Tue,  8 Feb 2022 18:32:53 -0800 (PST)
Received: by mail-oo1-f53.google.com with SMTP id v17-20020a4ac911000000b002eac41bb3f4so879486ooq.10;
        Tue, 08 Feb 2022 18:32:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yQbx4MHeZRD33kwyi5HCwAlvR2kVY0Ape2Km175nhWU=;
        b=w/Gyayegz52BbiX8peuYyLmRVf19XjGwI7F7DT6wQF6q9aZrwU5O9jwP2CSeuv9/7l
         uw/hGd+pOAAUFw9h1QFtVK3n72jmKpYGvzggwAEtDQT2JeYfo9uL3ilRjWXtJC1Pve6s
         u5dl8CF3xM5XtPouFVMk6/sFUqiIOinBwofalCjHi/Z1Jo+NvSAdhdlZnkTeg/gryxYt
         RnQwf6f7LXVsgZ9xZop6Jjj3hu3JBrOw3O2LbszB2jV3cKBDdrCGJJNJtuO8w9M1USzQ
         aMJVNooIIiOM0XD4kAN1mfJDjbcAQJYztxvgxJmP4RKXkipx8MdLNqtmLuxkwp4WzcQw
         HGcg==
X-Gm-Message-State: AOAM5322k6vIWsmQxJzGoJD/7WhwhHCwZmovrKDTSdOdM0jO4zIIjkNn
        se0ceiQd6obMQaxC4Oyh3A==
X-Google-Smtp-Source: ABdhPJz6E9fI5Swu/Pjd48wUsz/d3NM5d56huRHrQiD373+HYgWfbGvk/+Rkpw0JseVUdopwGTyzMQ==
X-Received: by 2002:a05:6870:45:: with SMTP id 5mr270401oaz.296.1644373972811;
        Tue, 08 Feb 2022 18:32:52 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id f20sm6297572ooh.10.2022.02.08.18.32.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 18:32:51 -0800 (PST)
Received: (nullmailer pid 3495248 invoked by uid 1000);
        Wed, 09 Feb 2022 02:32:51 -0000
Date:   Tue, 8 Feb 2022 20:32:51 -0600
From:   Rob Herring <robh@kernel.org>
To:     Michael Riesch <michael.riesch@wolfvision.net>
Cc:     Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        Rob Herring <robh+dt@kernel.org>,
        Niklas =?iso-8859-1?Q?S=F6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        linux-kernel@vger.kernel.org, Daniel Scally <djrscally@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Jacopo Mondi <jacopo@jmondi.org>
Subject: Re: [PATCH 1/2] dt-bindings: media: video-interfaces: add support
 for dual edge sampling
Message-ID: <YgMn01vcMWLo0sLo@robh.at.kernel.org>
References: <20220114105755.730200-1-michael.riesch@wolfvision.net>
 <20220114105755.730200-2-michael.riesch@wolfvision.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220114105755.730200-2-michael.riesch@wolfvision.net>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Jan 2022 11:57:54 +0100, Michael Riesch wrote:
> Some devices support sampling of the parallel data at both edges of the
> interface pixel clock in order to reduce the pixel clock by two.
> Use the pclk-sample property to reflect this feature in the device tree.
> 
> Signed-off-by: Michael Riesch <michael.riesch@wolfvision.net>
> ---
>  .../devicetree/bindings/media/video-interfaces.yaml          | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
