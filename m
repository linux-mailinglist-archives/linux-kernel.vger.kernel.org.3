Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5269450EBAE
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 00:21:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235654AbiDYWYr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 18:24:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343684AbiDYWLi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 18:11:38 -0400
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF1291D33F;
        Mon, 25 Apr 2022 15:08:32 -0700 (PDT)
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-e656032735so16313938fac.0;
        Mon, 25 Apr 2022 15:08:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4Vl1OROUqlthzjOaEFjMsGx8YqO64AcME2u3EpueJzI=;
        b=i9TuOkhlARCl9aQMcUo2cNwDgMZDh+roFOsuc9+UA7BQeZkh41lb1lBUtGC35vjgMW
         FuRxctK2JgC9Pg85sJLT4FBqblKCSurU3VKs271n64sJlyWAonGOrAzWIYM2Nm+ZsgjY
         6EiwHlGAmaRxE6gh9pnRQVIG43XEdCfm+CSF+0TXt4lfmVQLg75deWD7EH3YAivM1xr3
         yN5GBlWk1Jk8CuNbV88/eIakMz88QXrvhXQ7s9xPoCLpnAVt64MLoXvnqpPyRWnykBg9
         OUK5dJjH0+O9JLjNtx7HIY2ShzOWha13u/V0VlOmpayDouzOwmBErwugsfJWLxORflaj
         75qQ==
X-Gm-Message-State: AOAM5320+DfbHHmqYHfikhGkbkeJOfbPoGaP/T8qAoNlPLPWw4h3mU0E
        SOhFyiX2S8BcTjWuMZaM5h2D2VD8zA==
X-Google-Smtp-Source: ABdhPJyEkoJ3W+F7gZoppYO+zKCee+EKuyTwdZtAmqesCu0jqESilGtI7Ik+vQ0WiitU87F9sIdNGA==
X-Received: by 2002:a05:6870:9596:b0:d6:d3ea:1d92 with SMTP id k22-20020a056870959600b000d6d3ea1d92mr8110457oao.6.1650924511817;
        Mon, 25 Apr 2022 15:08:31 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id g1-20020a056870340100b000e686d1386bsm161602oah.5.2022.04.25.15.08.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Apr 2022 15:08:31 -0700 (PDT)
Received: (nullmailer pid 383119 invoked by uid 1000);
        Mon, 25 Apr 2022 22:08:30 -0000
Date:   Mon, 25 Apr 2022 17:08:30 -0500
From:   Rob Herring <robh@kernel.org>
To:     Andrea Merello <andrea.merello@gmail.com>
Cc:     jic23@kernel.org, mchehab+huawei@kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, lars@metafoo.de,
        andy.shevchenko@gmail.com, matt.ranostay@konsulko.com,
        ardeleanalex@gmail.com, jacopo@jmondi.org,
        Andrea Merello <andrea.merello@iit.it>
Subject: Re: [v4 11/14] dt-bindings: iio: imu: add documentation for Bosch
 BNO055 bindings
Message-ID: <Ymcb3sODr0j6zFHF@robh.at.kernel.org>
References: <20220415130005.85879-1-andrea.merello@gmail.com>
 <20220415130005.85879-12-andrea.merello@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220415130005.85879-12-andrea.merello@gmail.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 15, 2022 at 03:00:02PM +0200, Andrea Merello wrote:
> From: Andrea Merello <andrea.merello@iit.it>

For the subject:

dt-bindings: iio/imu: Add Bosch BNO055

> 
> Introduce new documentation file for the Bosch BNO055 IMU
> 
> Signed-off-by: Andrea Merello <andrea.merello@iit.it>
> ---
>  .../bindings/iio/imu/bosch,bno055.yaml        | 59 +++++++++++++++++++
>  1 file changed, 59 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/imu/bosch,bno055.yaml

With the subject fixed:

Reviewed-by: Rob Herring <robh@kernel.org>
